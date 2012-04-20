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
require 'open3'
require 'json'

require 'js_executor'

class JsLint
  
  JS_RUNTIME = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
  
  attr_reader :javascript, :file, :selection, :jslint_result
  
  def initialize filePath=nil
    @javascript = nil
    @file_path = filePath || ENV['TM_FILEPATH']
    @selection = ENV['TM_SELECTED_TEXT']
    @jslint_result = nil
    load_javascript
    load_options
    validate
  end
  
  def load_options
    # TODO Determine location of .jslintrc and read/evaluate it
  end
  
  def load_javascript
    Logger.info "Loading file: '#{@file_path}'"
    @javascript = File.read @file_path
  end
  
  def validate
    options = {
      :adsafe => true
    }
#    options = <<OPTIONS_JSON
#{"adsafe" : true}
#OPTIONS_JSON
    
    
    # TODO generate jslint_full on demand so parts of that are easily upgradeable - maybe through an erb again?
    command = <<CMD
#{JS_RUNTIME} "#{SUPPORT_PATH}/javascripts/jslint_full.js" -- "#{@javascript.gsub('"', '\"')}" "#{options.to_json.gsub('"', '\"')}"
CMD
    
    stdin, stdout, stderr = Open3.popen3(command)
    raw_stdout = stdout.read.strip
    raw_stderr = stderr.read
    Logger.trace("raw_stdout: '#{raw_stdout}'")
    Logger.trace("raw_stderr: '#{raw_stderr}'")
    raise Exception.new("jslinting error: #{raw_stderr}") if raw_stderr != ''
    @jslint_result = JSON::parse(raw_stdout)
    stdin.close
    stdout.close
    stderr.close
  rescue Exception => e
    Logger.error("jslint.rb (jslint_full) - An Error Occured while validating:: <br>'#{e}' <br>#{e.backtrace.join('<br>')}");
    Logger.error("command used: #{command}")
    
    @jslint_result = nil
  end
  
  def to_html
    File.open("#{SUPPORT_PATH}/templates/jslint.html.erb") do |fd|
      template = ERB.new(fd.read)
      
      scope    = TemplateScope.new({
        :javascript   => @javascript,
        :file_path    => @file_path,
        :logger       => Logger,
        :SUPPORT_PATH => SUPPORT_PATH,
        :ENV          => ENV,
        :jslint_result => @jslint_result,
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