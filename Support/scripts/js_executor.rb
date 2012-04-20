require 'open3'

module JSLINT
  
  JS_RUNTIME = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
  
  class JSExecutor
    
    attr_reader :runtime
    
    def initialize theJSRuntime=nil
      @runtime = theJSRuntime || JS_RUNTIME
    end
    
    def execute script_path, options=[]
      command = <<CMD
cd "#{File.dirname(script_path)}" && #{@runtime} "#{script_path}" -- #{prepare_options(options)}
CMD

      stdin, stdout, stderr = Open3.popen3(command)
      raw_stdout = stdout.read.strip
      raw_stderr = stderr.read
      stdin.close
      stdout.close
      stderr.close
      {
        :response => raw_stdout,
        :error  => raw_stderr,
        :command => command
      }
    end
    
    private
    
      def prepare_options options
        options.map { |option|
          option = option.to_json if option.kind_of? Hash
          "\"#{option.to_s.gsub('"', '\"')}\""
        }.join(" ")
      end
  end
  
end