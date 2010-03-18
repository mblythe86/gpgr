require 'rubygems'
require 'rake'
require 'rake/testtask'
require "rake/rdoctask"
require "rake/gempackagetask"  

GPGR_VERSION = "0.0.2" 

task :default => [:test]
       
desc "Run all tests, test-spec, mocha, and pdf-reader required"
Rake::TestTask.new do |test|
  # test.ruby_opts  << "-w"  # .should == true triggers a lot of warnings
  test.libs       << "testrb"
  test.test_files =  Dir[ "test/test_*.rb" ]
  test.verbose    =  true
end

desc "genrates documentation"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_files.include( "README.markdown",
                           "COPYING",
                           "LICENSE", 
                           "HACKING", "lib/" )
  rdoc.main     = "README"
  rdoc.rdoc_dir = "doc/html"
  rdoc.title    = "Gpgr Documentation"
end     

spec = Gem::Specification.new do |spec|
  spec.name = "gpgr"
  spec.version = GPGR_VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = "A lightweight GPG CLI interface for encyrypting files"
  spec.files =  Dir.glob("{lib,spec,test}/**/**/*") +
                      ["Rakefile"]
  spec.require_path = "lib"

  spec.test_files = Dir[ "test/*_test.rb" ]
  spec.has_rdoc = true
  spec.extra_rdoc_files = %w{HACKING README.markdown LICENSE COPYING}
  spec.rdoc_options << '--title' << 'Gpgr Documentation' <<
                       '--main'  << 'README' << '-q'
  spec.author = "Ryan Stenhouse"
  spec.email = "  ryan@ryanstenhouse.eu"
  spec.rubyforge_project = "gpgr"
  spec.homepage = "http://ryanstenhouse.eu"
  spec.description = <<END_DESC
  gpgr is a very light interface to the command-line GPG (GNU 
  Privacy Guard) tool which is soley concerned with making it
  as easy as possible to encrypt files with one (or more) public
  keys.

  It does not provide any major key management tools and does not
  support decryption.   
END_DESC
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
