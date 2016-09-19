require 'generators/rails/jbuilder_generator'

module Rails
  module Generators
    class JbuilderGenerator < NamedBase # :nodoc:
      source_paths.unshift File.expand_path('../templates', __FILE__)

      hook_for :test_framework
    end
  end
end
