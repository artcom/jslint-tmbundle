require 'spec_helper'

require 'jslint'

describe "JsLint" do
  
  before(:each) do
    @runtimeSpec = JSLINT::RuntimeSpecs::JSC
    if ENV['js_runtime'] == "rhino"
      @runtimeSpec = JSLINT::RuntimeSpecs::RHINO
    end
  end
  
  it "can be instantiated" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js", ".jslintrc", @runtimeSpec
    
    myJsLint.jslint_result.should_not be_nil
  end
  
  it "can validate a valid javascript" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js", ".jslintrc", @runtimeSpec
    
    myJsLint.jslint_result.should be_a_kind_of(Hash)
    myJsLint.jslint_result["result"].should be_true
  end

  it "can report errors on invalid javascript" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/invalid.js", ".jslintrc", @runtimeSpec
    
    myJsLint.jslint_result["result"].should be_false
    myJsLint.jslint_result['data']['errors'].should have(5).items
  end
  
  it "can evaluate options from a jslintrc" do
    # First an invalid javascript that can be made to pass with an
    # appropriate jslint option
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/fixable.js",
                          ".jslintrc",
                          @runtimeSpec
    myJsLint.jslint_result["result"].should be_false
    myJsLint.jslint_result['data']['errors'].should have(1).item
    
    # Use jslintrc with option to suppress the reported error
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/fixable.js",
                          "#{RSpec.configuration.fixtures}/jslintrc",
                          @runtimeSpec
    myJsLint.jslint_result["result"].should be_true
    myJsLint.jslint_result['data']['errors'].should be_nil
  end
  
  it "can render the result via a template" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js", ".jslintrc", @runtimeSpec
    myJsLint.to_html.should be_a_kind_of String
  end

end