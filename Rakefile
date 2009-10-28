require 'rubygems'
require 'rake'
 
task :default => [:test]

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end

desc 'Run Roodi'
task :roodi do
  puts %x[find . -name "*.rb" | xargs roodi]
end
