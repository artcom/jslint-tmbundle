require 'rake'
require "rspec/core/rake_task"

desc "Run Specs"
task :default => :spec

desc "Run specs - Accepts argument 'js_runtime=[rhino|jsc]' default is jsc"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end