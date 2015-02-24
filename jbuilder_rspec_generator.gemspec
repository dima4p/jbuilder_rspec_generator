# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: jbuilder_rspec_generator 1.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "jbuilder_rspec_generator"
  s.version = "1.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dmitri Koulikoff"]
  s.date = "2015-02-24"
  s.description = "Generates RSpecs for jbuilder templates"
  s.email = "dima@koulikoff.ru"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "jbuilder_rspec_generator.gemspec",
    "lib/generators/rails/jbuilder/jbuilder_generator.rb",
    "lib/generators/rspec/jbuilder_generator.rb",
    "lib/generators/rspec/templates/index_spec.rb",
    "lib/generators/rspec/templates/show_spec.rb",
    "spec/jbuilder_rspec_generator_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/dima4p/jbuilder_rspec_generator"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "RSpecs for jbuilder templates"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.0"])
    else
      s.add_dependency(%q<multi_json>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<rdoc>, ["~> 4.1"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.0"])
    end
  else
    s.add_dependency(%q<multi_json>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<rdoc>, ["~> 4.1"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.0"])
  end
end

