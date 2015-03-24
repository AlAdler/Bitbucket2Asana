require "rails_helper"

RSpec.describe Bitbucket2AsanaConnectionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bitbucket2_asana_connections").to route_to("bitbucket2_asana_connections#index")
    end

    it "routes to #new" do
      expect(:get => "/bitbucket2_asana_connections/new").to route_to("bitbucket2_asana_connections#new")
    end

    it "routes to #show" do
      expect(:get => "/bitbucket2_asana_connections/1").to route_to("bitbucket2_asana_connections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bitbucket2_asana_connections/1/edit").to route_to("bitbucket2_asana_connections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bitbucket2_asana_connections").to route_to("bitbucket2_asana_connections#create")
    end

    it "routes to #update" do
      expect(:put => "/bitbucket2_asana_connections/1").to route_to("bitbucket2_asana_connections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bitbucket2_asana_connections/1").to route_to("bitbucket2_asana_connections#destroy", :id => "1")
    end

  end
end
