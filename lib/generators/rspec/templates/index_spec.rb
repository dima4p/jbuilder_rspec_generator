<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% open_attributes = attributes.reject(&:password_digest?) -%>
describe "<%= ns_table_name %>/index.json.jbuilder", type: :view do
  before(:each) do
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    allow(controller).to receive(:can?).and_return(true)
<% end -%>
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = create(:<%= ns_file_name %>)
<% else -%>
    @<%= ns_file_name %> = <%= class_name %>.create(<%= open_attributes.empty? ? ')' : '' %>
<% open_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == open_attributes.length - 1 ? '' : ','%>
<% end -%>
    )
<% end -%>
    assign :<%= table_name %>, [@<%= ns_file_name %>, @<%= ns_file_name %>]
  end

  attributes = %w[
    id
<% for attribute in open_attributes -%>
    <%= attribute.name %>
<% end -%>
    url
  ]

  it "renders a list of <%= table_name %> as json with following attributes: #{attributes.join(', ')}" do
    render

    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @<%= ns_file_name %>.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = <%= ns_file_name %>_url(@<%= ns_file_name %>, format: 'json')
    expect(hash).to eq expected
    # expect(hash['id']).to eq @<%= ns_file_name %>.id.to_s
<% for attribute in open_attributes -%>
    # expect(hash['<%= attribute.name %>']).to eq @<%= ns_file_name %>.<%= attribute.name %>.to_s
<% end -%>
    # expect(hash['url']).to eq <%= ns_file_name %>_url(@<%= ns_file_name %>, format: 'json')
  end
end
