require 'spec_helper'

require 'js_executor'
require 'json'

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
    #result[:command].should eq("#{JSLINT::JS_RUNTIME} \"#{RSpec.configuration.fixtures}/hello_world.js\" -- \n")
  end
  
  it "can pass options into javascript" do
    myJsExecutor = JSLINT::JSExecutor.new
    result = myJsExecutor.execute "#{RSpec.configuration.fixtures}/arguments.js",
                                  ['var foo = "bar";', 2, {:foo => 'bar'}.to_json]
    result[:response].should eq("3")
    result[:error].should eq("")
  end

  it "passed options which are hashes are correctly converted to json" do
    myJsExecutor = JSLINT::JSExecutor.new
    result = myJsExecutor.execute "#{RSpec.configuration.fixtures}/hash.js",
                                  [{:foo => 'bar'}.to_json]
    result[:response].should eq("bar")
    result[:error].should eq("")
  end

  it "passed options which are javascript are evalable" do
    myJsExecutor = JSLINT::JSExecutor.new
    result = myJsExecutor.execute "#{RSpec.configuration.fixtures}/eval_option.js",
                                  ['name = "peter";']
    result[:response].should eq("peter")
    result[:error].should eq("")
  end

  it "our environment allows loading of other js files (currently only with jsc)" do
    myJsExecutor = JSLINT::JSExecutor.new
    result = myJsExecutor.execute "#{RSpec.configuration.fixtures}/load.js"
    result[:response].should eq("bar")
    result[:error].should eq("")
  end

end