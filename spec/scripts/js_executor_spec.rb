require 'spec_helper'

require 'js_executor'
require 'json'

describe "JSExecutor" do

  before(:each) do
    myRuntimeSpec = JSLINT::RuntimeSpecs::JSC
    if ENV['js_runtime'] == "rhino"
      myRuntimeSpec = JSLINT::RuntimeSpecs::RHINO
    end
    @jsexecutor = JSLINT::JSExecutor.new myRuntimeSpec
  end
    
  it "has a default runtime (which exists)" do
    @jsexecutor.runtime.should_not be_nil
    (File.exists?(@jsexecutor.runtime)).should be_true
  end
  
  it "can execute scripts and return results" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/hello_world.js"
    result[:response].should eq("Hello World!")
    result[:error].should eq("")
    #result[:command].should eq("#{JSLINT::JS_RUNTIME} \"#{RSpec.configuration.fixtures}/hello_world.js\" -- \n")
  end
  
  it "can pass options into javascript" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/arguments.js",
                                 ['var foo = "bar";', 2, {:foo => 'bar'}.to_json]
    result[:response].should eq("3")
    result[:error].should eq("")
  end
  
  it "options are properly escaped" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/echo.js",
                                  ['$`']
    result[:response].should eq("$`")
    result[:error].should eq("")
  end
  
  it "passed options which are hashes are correctly converted to json" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/hash.js",
                                  [{:foo => 'bar'}.to_json]
    result[:response].should eq("bar")
    result[:error].should eq("")
  end
  
  it "passed options which are javascript are evalable" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/eval_option.js",
                                  ['var name = "peter";']
    result[:response].should eq("peter")
    result[:error].should eq("")
  end
  
  it "our environment allows loading of other js files (currently only with jsc)" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/load.js"
    result[:response].should eq("bar")
    result[:error].should eq("")
  end
  
  it "can convert passed options to be passable via command line" do
    myOptions = ['var foo = "bar";', 2, {:foo => 'bar'}.to_json]
    @jsexecutor.send(:prepare_options, myOptions).should eq('"var foo = \"bar\";" "2" "{\"foo\":\"bar\"}"')
  end

  # This is an indication i should really run the js differently and not via command line.
  # maybe do have a look at therubyracer or execjs... Problem is this texmate bundle should
  # not have mandatory gem dependencies
  it "can properly escapce escaped backslash characters" do
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/backslash.js"
    result[:response].should eq("\\")
    result[:error].should eq("")
    
    result = @jsexecutor.execute "#{RSpec.configuration.fixtures}/echo.js",
                                  ['\\']
    result[:response].should eq("\\")
    result[:error].should eq("")
  end

end