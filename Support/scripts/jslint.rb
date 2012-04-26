require 'array_logger'
Logger = ArrayLogger.new

require 'erb'
require 'rubygems'
@@coderay_loaded = false
begin
  require 'coderay'
  @@coderay_loaded = true
  Logger.info "Loaded gem 'coderay' - syntax highlighting will be enabled"
rescue LoadError
  Logger.warn "Cannot load gem 'coderay' - syntax highlighting will be disabled"
end
require 'json'
require 'js_executor'
require 'pp'

class JsLint
  
  attr_reader :javascript, :file, :selection, :jslint_result
  
  JSLINT_RUNNER = "#{ENV['TM_BUNDLE_SUPPORT']}/javascripts/run_jslint.js"
  JSLINT_RC     = "~/.jslintrc"
  
  def initialize filePath=nil, rc_file=JSLINT_RC
    @javascript = nil
    @file_path = filePath || ENV['TM_FILEPATH']
    @selection = ENV['TM_SELECTED_TEXT']
    @jslint_result = nil
    @executor = JSLINT::JSExecutor.new
    @jslintrc_path = rc_file
    @jslintrc = nil
    @parsed_jslintrc = nil
    load_javascript
    load_options
    validate
  end
  
  def load_options
    # TODO also load settings from pwd and where the file resides...
    Logger.info "Loading settings: '#{@jslintrc_path}'"
    if File.exists? File.expand_path(@jslintrc_path)
      @jslintrc = File.read File.expand_path(@jslintrc_path)
      @parsed_jslintrc = {}
      
      # The following does not feel nice.
      # Yes, i could simply prepend the jslintrc to the javascript
      # But this would shift the linenumbers and i could not report the settings
      # being used to perform the jslinting step
      @jslintrc[9..@jslintrc.size-4].split(",").each { |option|
        parts = option.split(":")
        @parsed_jslintrc[parts[0].strip] = parts[1].strip
      }
    end
  end
  
  def load_javascript
    Logger.info "Loading file: '#{@file_path}'"
    @javascript = File.read @file_path
  end
  
  def validate
    result = @executor.execute JSLINT_RUNNER, [@javascript, @parsed_jslintrc]
    #Logger.trace("Raw Jslinting result: \n'#{PP.pp(result, "", 79)}'")
    raise Exception.new("jslinting error: #{result[:error]}") if result[:error] != ''
    @jslint_result = JSON::parse(result[:response])
    Logger.trace("Json Jslinting result: \n'#{PP.pp(@jslint_result, "", 79)}'")
  rescue Exception => e
    Logger.error("jslint.rb (jslint_full) - An Error Occured while validating:: <br/>'#{e}' <br/>#{e.backtrace.join('<br/>')}");
    Logger.error("command used: #{result[:command]}")
    @jslint_result = nil
  end
  
  def to_html
    File.open("#{ENV['TM_BUNDLE_SUPPORT']}/templates/jslint.html.erb") do |fd|
      template = ERB.new(fd.read)
      
      scope    = TemplateScope.new({
        :javascript     => @javascript,
        :file_path      => @file_path,
        :logger         => Logger,
        :SUPPORT_PATH   => ENV['TM_BUNDLE_SUPPORT'],
        :ENV            => ENV,
        :jslint_result  => @jslint_result,
        :jslint_rc      => @parsed_jslintrc,
        :coderay_loaded => @@coderay_loaded
      }).get_binding
      html   = template.result(scope)
      return html
    end
  end
  
  private
  
    class TemplateScope
      
      def initialize(arguments)
        @arguments = arguments
      end
      
      def get_binding
        binding
      end
      
    end
  
end