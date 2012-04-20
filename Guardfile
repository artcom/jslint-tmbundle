guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^Support/scripts/(.+)\.rb$})     { |m| "spec/scripts/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch('lib/kleac.rb')  { "spec" }
end
