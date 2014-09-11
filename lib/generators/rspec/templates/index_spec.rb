require 'spec_helper'

describe "<%= ns_table_name %>/index.json.jbuilder" do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = create(:<%= ns_file_name %>)
<% else -%>
    @<%= ns_file_name %> = <%= class_name %>.create(<%= attributes.empty? ? ')' : '' %>
<% attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == attributes.length - 1 ? '' : ','%>
<% end -%>
    )
<% end -%>
    assign :<%= table_name %>, [@<%= ns_file_name %>, @<%= ns_file_name %>]
  end

  attributes = %w[
    id
<% for attribute in attributes -%>
    <%= attribute.name %>
<% end -%>
    url
  ]

  it "renders a list of <%= table_name %> as json with following attributes: #{attributes.join(', ')}" do
    render

    hash = JSON.parse(rendered)
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
<% for attribute in attributes -%>
    expect(hash['<%= attribute.name %>']).to eq @<%= ns_file_name %>.<%= attribute.name %>.to_s
<% end -%>
    expect(hash['url']).to eq <%= ns_file_name %>_url(@<%= ns_file_name %>, format: 'json')
  end
end
