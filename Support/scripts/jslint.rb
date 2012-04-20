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

class JsLint
  
  JS_RUNTIME = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
  
  attr_reader :javascript, :file, :selection, :jslint_result
  
  def initialize filePath=nil
    @javascript = nil
    @file_path = filePath || ENV['TM_FILEPATH']
    @selection = ENV['TM_SELECTED_TEXT']
    @jslint_result = nil
    @executor = JSLINT::JSExecutor.new
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
      :adsafe => false
    }
#    options = <<OPTIONS_JSON
#{"adsafe" : true}
#OPTIONS_JSON
    
    result = @executor.execute "#{SUPPORT_PATH}/javascripts/jslint_full.js",
                               [@javascript, options]
    Logger.trace("result '#{result.inspect}'")
    raise Exception.new("jslinting error: #{result[:error]}") if result[:error] != ''
    @jslint_result = JSON::parse(result[:response])
  rescue Exception => e
    Logger.error("jslint.rb (jslint_full) - An Error Occured while validating:: <br>'#{e}' <br>#{e.backtrace.join('<br>')}");
    Logger.error("command used: #{result[:command]}")
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