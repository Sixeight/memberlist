require 'spec/rake/spectask'

desc 'Run all specs'
task :default => 'spec'

desc 'Run all specs'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.spec_opts = ['-c']
end
