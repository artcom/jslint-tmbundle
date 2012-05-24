require 'spec_helper'

require 'jslint'

describe "ArrayLogger" do
  
  before(:each) do
    @logger = ArrayLogger.new
  end
  
  it "starts with an empty log" do
    @logger.log.should be_empty
  end
  
  it "Collects log entries (as LogEntries) in sequence" do
    %w{1 2 3 4}.each_with_index { |entry, index|
      @logger.info entry
      @logger.log[index].should be_a_kind_of(LogEntry)
      @logger.log[index].payload.should eq(entry)
    }
    @logger.log.should have(4).items
  end
  
  it "has different log levels" do
    LEVELS = %w{info trace warn error}
    LEVELS.each { |level|
      @logger.send(level, level)
    }
    @logger.log.map { |entry|
      entry.level
    }.should eq(LEVELS.map{ |level| level.upcase.to_sym})
  end
  
  it "emits html" do
    testingRegexp = /^<code class="logger_INFO">([\d\s:+-]*) \[(.*)\] - (\w*)<\/code><br\/>$/
    @logger.info "TEST"
    myHtml = @logger.html_dump
    myHtml.should match(testingRegexp)
    myMatches = myHtml.match(testingRegexp)
    myMatches[1].should eq("#{@logger.log.first.time}")
    myMatches[2].should eq("#{@logger.log.first.level}")
    myMatches[3].should eq("#{@logger.log.first.payload}")
  end
  
end