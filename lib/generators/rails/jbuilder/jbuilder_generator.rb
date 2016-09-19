require 'generators/rails/jbuilder_generator'

module Rails
  module Generators
    class JbuilderGenerator < NamedBase # :nodoc:
      class_option :with_api, type: :boolean,
                         desc: "Generates also API controller in 'app/contorllers/api'"
      class_option :api_version, type: :string,
                         desc: "Adds specified path as version to 'app/contorllers/api'"

      source_paths.unshift File.expand_path('../templates', __FILE__)

      hook_for :test_framework
    end
  end
end
