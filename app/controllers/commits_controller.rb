class CommitsController < ApplicationController
    
    def post
        push = JSON.parse params['payload']
        
        push['commits'].each do |commit|
            if (commit['message'].include?('#') || commit['message'].include?('app.asana.com'))
                logger.debug 'commit has asana'
                taskid = commit['message'].partition("#").last.partition(" ").first
                asana_url = "https://app.asana.com/api/1.0/tasks/#{taskid}/stories"
                logger.debug asana_url
                comment = push['user'] + " pushed to branch " + commit['branch'] + " of " + push['repository']['name'] + "\n- " + commit['message']
                uri = URI.parse(asana_url)
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_PEER
                request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
                request.basic_auth(ENV['ASANA_API_KEY'], '')
                request.body = { "data" => { "text" => comment }}.to_json
                logger.debug request.body
                response = http.request(request)
                logger.debug response.body
            end
        end
        
        render json: push
    end
end
