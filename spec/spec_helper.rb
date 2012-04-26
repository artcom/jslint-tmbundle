$:.unshift File.expand_path("../../Support/scripts", __FILE__)

# Simulate Textmate environment
ENV['TM_BUNDLE_SUPPORT'] = File.expand_path("../../Support", __FILE__)

RSpec.configure do |config|
  config.add_setting(
    :fixtures,
    :default => "#{File.dirname(__FILE__)}/fixtures",
    :alias_with => :fixtures
  )
end