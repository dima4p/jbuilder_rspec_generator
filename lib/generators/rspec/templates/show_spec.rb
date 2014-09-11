require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/show.json.jbuilder" do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, create(:<%= ns_file_name %>))
<% else -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, stub_model(<%= class_name %><%= output_attributes.empty? ? '))' : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
    ))
<% end -%>
<% end -%>
  end

  attributes = %w[
    id
<% for attribute in output_attributes -%>
    <%= attribute.name %>
<% end -%>
    created_at
    updated_at
  ]

  it "renders the following attributes of <%= ns_file_name %>: #{attributes.join(', ')} as json" do
    render

    hash = JSON.parse(rendered)
    expect(hash.keys.sort).to eq attributes.sort
<% for attribute in output_attributes -%>
    expect(hash['<%= attribute.name %>']).to eq @<%= ns_file_name %>.<%= attribute.name %>
<% end -%>
  end
end
