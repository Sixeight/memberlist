require 'spec/rake/spectask'
require 'cucumber/rake/task'

desc 'Run all specs'
task :default => 'spec'

desc 'Run all specs'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.spec_opts = ['-c']
end

desc 'Run all features'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = '--format pretty'
end

