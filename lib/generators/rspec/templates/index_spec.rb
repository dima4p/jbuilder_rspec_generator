require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/index.json.jbuilder" do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = create(:<%= ns_file_name %>)
    assign(:<%= table_name %>, [@<%= ns_file_name %>, @<%= ns_file_name %>])
<% else -%>
    assign(:<%= table_name %>, [
<% [1,2].each_with_index do |id, model_index| -%>
      stub_model(<%= class_name %><%= output_attributes.empty? ? (model_index == 1 ? ')' : '),') : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
        :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
      <%= model_index == 1 ? ')' : '),' %>
<% end -%>
<% end -%>
    ])
<% end -%>
  end

  attributes = %w[
    id
<% for attribute in output_attributes -%>
    <%= attribute.name %>
<% end -%>
    url
  ]

  it "renders a list of <%= table_name %> as json with following attributes: #{attributes.join(', ')}" do
    render

    hash = JSON.parse(rendered)
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
<% for attribute in output_attributes -%>
    expect(hash['<%= attribute.name %>']).to eq @<%= ns_file_name %>.<%= attribute.name %>
<% end -%>
    expect(hash['url']).to eq <%= ns_file_name %>_url(@<%= ns_file_name %>, format: 'json')
  end
end
