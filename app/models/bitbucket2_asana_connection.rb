class Bitbucket2AsanaConnection < ActiveRecord::Base
    
    validates :asana_api_key, presence: true
    validates :b2a_code, presence: true
    
    def to_param
        asana_api_key
    end
end
