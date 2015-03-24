require 'rails_helper'

RSpec.describe "bitbucket2_asana_connections/index", :type => :view do
  before(:each) do
    assign(:bitbucket2_asana_connections, [
      Bitbucket2AsanaConnection.create!(
        :b2a_code => "B2a Code",
        :asana_api_key => "Asana Api Key"
      ),
      Bitbucket2AsanaConnection.create!(
        :b2a_code => "B2a Code",
        :asana_api_key => "Asana Api Key"
      )
    ])
  end

  it "renders a list of bitbucket2_asana_connections" do
    render
    assert_select "tr>td", :text => "B2a Code".to_s, :count => 2
    assert_select "tr>td", :text => "Asana Api Key".to_s, :count => 2
  end
end
