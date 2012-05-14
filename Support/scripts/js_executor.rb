require 'open3'

module JSLINT
  
  module RuntimeSpecs
    
    DEFAULT_JSC = {
      :js_runtime_path => "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc",
      :arguments_separator => '--'
    }

    RHINO = {
      :js_runtime_path => "/usr/local/bin/rhino",
      :arguments_separator => ''
    }
    
  end
  
  class JSExecutor
    
    attr_reader :runtime, :arguments_separator
    
    def initialize options = RuntimeSpecs::DEFAULT_JSC
      @runtime = options[:js_runtime_path]
      @arguments_separator = options[:arguments_separator]
    end
    
    def execute script_path, options=[]
      command = <<CMD
cd "#{File.dirname(script_path)}" && #{@runtime} "#{script_path}" #{@arguments_separator} #{prepare_options(options)}
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
          "\"#{option.to_s.gsub('"', '\"').gsub('$', '\$').gsub('`', '\\\`')}\""
        }.join(" ")
      end
  end
  
end