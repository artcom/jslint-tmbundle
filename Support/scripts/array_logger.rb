require 'log_entry'

class ArrayLogger
  
  attr_reader :log
  
  def initialize
    @log = []
  end
  
  def info payload
    perform_logging :INFO, payload
  end
  
  def error payload
    perform_logging :ERROR, payload
  end
  
  def warn payload
    perform_logging :WARN, payload
  end
  
  def trace payload
    perform_logging :TRACE, payload
  end
  
  def html_dump
    html = ""
    @log.each do |log_entry|
      html += "<code class=\"logger_#{log_entry.level}\">#{log_entry}</code><br/>"
    end
    html
  end
  
  private
  
    def perform_logging log_level, log_payload
      @log << LogEntry.new((log_level || :INFO), log_payload)
    end
  
end