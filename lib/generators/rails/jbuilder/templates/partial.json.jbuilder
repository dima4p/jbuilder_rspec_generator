json.extract! <%= singular_table_name %>, <%= attributes_list_with_timestamps %>
json.url <%= "api_v1_" if Rails::Generators::ScaffoldControllerGenerator.class_options[:with_api] %><%= singular_table_name %>_url(<%= singular_table_name %>, format: :json)
