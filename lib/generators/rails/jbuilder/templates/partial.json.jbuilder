json.extract! <%= singular_table_name %>, <%= attributes_list_with_timestamps %>
json.url <%= "api_" if options[:with_api] %><%= "#{options[:api_version]}_" if options[:with_api] and options[:api_version].present? %><%= singular_table_name %>_url(<%= singular_table_name %><%= ", format: 'json'" unless options[:with_api] %>)
