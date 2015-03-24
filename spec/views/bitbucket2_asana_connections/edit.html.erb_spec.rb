require 'rails_helper'

RSpec.describe "bitbucket2_asana_connections/edit", :type => :view do
  before(:each) do
    @bitbucket2_asana_connection = assign(:bitbucket2_asana_connection, Bitbucket2AsanaConnection.create!(
      :b2a_code => "MyString",
      :asana_api_key => "MyString"
    ))
  end

  it "renders the edit bitbucket2_asana_connection form" do
    render

    assert_select "form[action=?][method=?]", bitbucket2_asana_connection_path(@bitbucket2_asana_connection), "post" do

      assert_select "input#bitbucket2_asana_connection_b2a_code[name=?]", "bitbucket2_asana_connection[b2a_code]"

      assert_select "input#bitbucket2_asana_connection_asana_api_key[name=?]", "bitbucket2_asana_connection[asana_api_key]"
    end
  end
end
