require 'jslint'

describe "JsLint" do

  it "can be instantiated" do
    myJsLint = JsLint.new "#{RSpec.configuration.fixtures}/valid_min.js"
    
    myJsLint.jslint_result.should_not be_nil
  end

end