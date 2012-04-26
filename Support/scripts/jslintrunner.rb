$:.unshift File.dirname(__FILE__)
require 'jslint'
puts JsLint.new.to_html