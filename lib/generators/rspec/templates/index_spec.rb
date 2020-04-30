<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% open_attributes = attributes.reject(&:password_digest?) -%>
<% links = open_attributes.select{|a| [:belongs_to, :references].include? a.type} -%>

describe "<%= ns_table_name %>/index.json.jbuilder", type: :view do
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_bot -%>
<% factory = true -%>
  let(:<%= ns_file_name %>) { create :<%= ns_file_name %> }

<% end -%>
  before(:each) do
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    allow(controller).to receive(:can?).and_return(true)
<% end -%>
<% unless factory -%>
    @<%= ns_file_name %> = <%= class_name %>.create(<%= open_attributes.empty? ? ')' : '' %>
<% open_attributes.each_with_index do |attribute, attribute_index| -%>
      <%= attribute.name %>: <%= value_for(attribute) %><%= attribute_index == open_attributes.length - 1 ? '' : ','%>
<% end -%>
    )
<% end -%>
    assign :<%= table_name %>, [<% unless factory -%>@<% end -%><%= ns_file_name %>, <% unless factory -%>@<% end -%><%= ns_file_name %>]
    render
  end

  attributes = %w[
    id
<% for attribute in open_attributes -%>
    <%= attribute.name %>
<% end -%>
    created_at
    updated_at
    url
  ]
<% if links.present? -%>
  complex = %w[
<% for attribute in links -%>
    <%= attribute.name %>
<% end -%>
  ]
<% for attribute in links -%>
  <%= attribute.name %>_attributes = %w[
    id
    name
    url
  ]
<% end -%>
<% end -%>

  it "renders a list of <%= table_name %> as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
<% if links.present? -%>
    expected = <% unless factory -%>@<% end -%><%= ns_file_name %>.attributes.slice *(attributes - complex)
<% else -%>
    expected = <% unless factory -%>@<% end -%><%= ns_file_name %>.attributes.slice *attributes
<% end -%>
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = <%= "api_" if options[:with_api] %><%= "#{options[:api_version]}_" if options[:with_api] and options[:api_version].present? %><%= ns_file_name %>_url(<% unless factory -%>@<% end -%><%= ns_file_name %><%= ", format: 'json'" unless options[:with_api] %>)
<% if links.present? -%>
    expect(hash.except! *complex).to eq expected
<% else -%>
    expect(hash).to eq expected
<% end -%>
  end
<% for attribute in links -%>

  it "renders <%= attribute.name %> of the <%= table_name %> with the following attributes: #{<%= attribute.name %>_attributes.join(', ')}" do
    hash = MultiJson.load(rendered).last
    hash = hash['<%= attribute.name %>']
    expect(hash.keys.sort).to eq <%= attribute.name %>_attributes.sort
    expected = <% unless factory -%>@<% end -%><%= ns_file_name %>.<%= attribute.name %>.attributes.slice *<%= attribute.name %>_attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = <%= "api_" if options[:with_api] %><%= "#{options[:api_version]}_" if options[:with_api] and options[:api_version].present? %><%= attribute.name %>_url(<% unless factory -%>@<% end -%><%= ns_file_name %>.<%= attribute.name %><%= ", format: 'json'" unless options[:with_api] %>)
    expect(hash).to eq expected
  end
<% end -%>
end
