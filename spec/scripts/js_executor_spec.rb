require 'spec_helper'

require 'js_executor'

describe "JSExecutor" do

  it "has a default runtime (which exists)" do
    myJsExecutor = JSLINT::JSExecutor.new
    myJsExecutor.runtime.should_not be_nil
    (File.exists?(myJsExecutor.runtime)).should be_true
  end

  it "can execute scripts and return results" do
    myJsExecutor = JSLINT::JSExecutor.new
    result = myJsExecutor.execute "#{RSpec.configuration.fixtures}/hello_world.js"
    result[:response].should eq("Hello World!")
    result[:error].should eq("")
  end

end