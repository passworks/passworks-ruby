require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new :spec do |test|
  test.test_files = Dir['spec/**/*_spec.rb']
  test.verbose    = true
end

task default: :spec
