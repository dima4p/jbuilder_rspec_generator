require 'generators/rspec'
require 'rails/generators/resource_helpers'

module Rspec
  module Generators
    class JbuilderGenerator < Base
      include ::Rails::Generators::ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      def generate_view_specs
        source_paths << File.expand_path("../templates", __FILE__)
        copy_view :index
        copy_view :show
      end

      protected

      def copy_view(view)
        template "#{view}_spec.rb",
                 File.join("spec/views", controller_file_path, "#{view}.json.jbuilder_spec.rb")
      end

       # support for namespaced-resources
      def ns_file_name
        ns_parts.empty? ? file_name : "#{ns_parts[0].underscore}_#{ns_parts[1].singularize.underscore}"
      end

      # support for namespaced-resources
      def ns_table_name
        ns_parts.empty? ? table_name : "#{ns_parts[0].underscore}/#{ns_parts[1].tableize}"
      end

      def ns_parts
        @ns_parts ||= begin
                        matches = ARGV[0].to_s.match(/\A(\w+)(?:\/|::)(\w+)/)
                        matches ? [matches[1], matches[2]] : []
                      end
      end

   end
  end
end

