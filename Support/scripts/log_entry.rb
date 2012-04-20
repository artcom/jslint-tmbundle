require 'time'

class LogEntry
  
  attr_reader :level, :payload, :time
  
  def initialize log_level, log_payload
    @level = log_level
    @time = Time.now
    @payload = log_payload || ""
  end
  
  def to_s
    "#{@time} [#{@level}] - #{@payload}"
  end
  
end