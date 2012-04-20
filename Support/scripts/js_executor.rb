require 'open3'

module JSLINT
  
  JS_RUNTIME = "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
  
  class JSExecutor
    
    attr_reader :runtime
    
    def initialize theJSRuntime=nil
      @runtime = theJSRuntime || JS_RUNTIME
    end
    
    def execute script_path, options=[]
      optionsString = ""
      options.each { |option|
        if option.kind_of? Hash
          option = option.to_json
        end
        optionsString << " \"#{option.to_s.gsub('"', '\"')}\""
      }
      command = <<CMD
#{@runtime} "#{script_path}" -- #{optionsString}
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
  end
  
end