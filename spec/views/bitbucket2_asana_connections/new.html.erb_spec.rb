require 'rails_helper'

RSpec.describe "bitbucket2_asana_connections/new", :type => :view do
  before(:each) do
    assign(:bitbucket2_asana_connection, Bitbucket2AsanaConnection.new(
      :b2a_code => "MyString",
      :asana_api_key => "MyString"
    ))
  end

  it "renders new bitbucket2_asana_connection form" do
    render

    assert_select "form[action=?][method=?]", bitbucket2_asana_connections_path, "post" do

      assert_select "input#bitbucket2_asana_connection_b2a_code[name=?]", "bitbucket2_asana_connection[b2a_code]"

      assert_select "input#bitbucket2_asana_connection_asana_api_key[name=?]", "bitbucket2_asana_connection[asana_api_key]"
    end
  end
end
