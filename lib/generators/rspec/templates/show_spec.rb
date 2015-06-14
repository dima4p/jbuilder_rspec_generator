<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% open_attributes = attributes.reject(&:password_digest?) -%>
describe "<%= ns_table_name %>/show.json.jbuilder", type: :view do
  before(:each) do
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    allow(controller).to receive(:can?).and_return(true)
<% end -%>
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, create(:<%= ns_file_name %>))
<% else -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, <%= class_name %>.create(<%= open_attributes.empty? ? '))' : '' %>
<% open_attributes.each_with_index do |attribute, attribute_index| -%>
      <%= attribute.name %>: <%= value_for(attribute) %><%= attribute_index == open_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !open_attributes.empty? -%>
    ))
<% end -%>
<% end -%>
  end

  attributes = %w[
    id
<% for attribute in open_attributes -%>
    <%= attribute.name %>
<% end -%>
    created_at
    updated_at
  ]

  it "renders the following attributes of <%= ns_file_name %>: #{attributes.join(', ')} as json" do
    render

    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @<%= ns_file_name %>.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expect(hash).to eq expected
    # expect(hash['id']).to eq @<%= ns_file_name %>.id.to_s
<% for attribute in open_attributes -%>
    # expect(hash['<%= attribute.name %>']).to eq @<%= ns_file_name %>.<%= attribute.name %>.to_s
<% end -%>
    # expect(hash['created_at']).to eq @<%= ns_file_name %>.created_at.to_s
    # expect(hash['updated_at']).to eq @<%= ns_file_name %>.updated_at.to_s
  end
end
