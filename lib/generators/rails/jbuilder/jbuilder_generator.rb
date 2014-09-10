require 'generators/rails/jbuilder_generator'

module Rails
  module Generators
    class JbuilderGenerator < NamedBase # :nodoc:
      hook_for :test_framework
    end
  end
end
