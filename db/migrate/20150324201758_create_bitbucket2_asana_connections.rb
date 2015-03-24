class CreateBitbucket2AsanaConnections < ActiveRecord::Migration
  def change
    create_table :bitbucket2_asana_connections do |t|
      t.string :b2a_code
      t.string :asana_api_key

      t.timestamps
    end
  end
end
