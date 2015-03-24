require 'rails_helper'

RSpec.describe "bitbucket2_asana_connections/show", :type => :view do
  before(:each) do
    @bitbucket2_asana_connection = assign(:bitbucket2_asana_connection, Bitbucket2AsanaConnection.create!(
      :b2a_code => "B2a Code",
      :asana_api_key => "Asana Api Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/B2a Code/)
    expect(rendered).to match(/Asana Api Key/)
  end
end
