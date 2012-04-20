require 'spec_helper'

require 'jslint'

describe "JsLint" do

  it "can be instantiated" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js"
    
    myJsLint.jslint_result.should_not be_nil
  end
  
  it "can validate a valid javascript" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js"
    
    myJsLint.jslint_result.should be_a_kind_of(Hash)
    myJsLint.jslint_result["result"].should be_true
  end

  it "can report errors on invalid javascript" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/invalid.js"
    
    myJsLint.jslint_result["result"].should be_false
    myJsLint.jslint_result['data']['errors'].should have(5).items
  end

end