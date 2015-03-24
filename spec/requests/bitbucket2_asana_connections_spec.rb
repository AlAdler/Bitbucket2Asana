require 'rails_helper'

RSpec.describe "Bitbucket2AsanaConnections", :type => :request do
  describe "GET /bitbucket2_asana_connections" do
    it "works! (now write some real specs)" do
      get bitbucket2_asana_connections_path
      expect(response).to have_http_status(200)
    end
  end
end
