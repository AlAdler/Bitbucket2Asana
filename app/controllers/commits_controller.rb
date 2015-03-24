require 'net/http'

class CommitsController < ApplicationController
    
    def post
        @b2aConnection = Bitbucket2AsanaConnection.find_by_b2a_code(params['b2acode'])
        return render :nothing => true, :status => 200, :content_type => 'text/html' if @b2aConnection.nil?
        push = JSON.parse params['payload']
        logger.info push
        push['commits'].each do |commit|
            has_asana = false
            if commit['message'].include?('#')
                taskid = get_taskid_from_message_with_numsign(commit['message'])
                has_asana = true
            elsif commit['message'].include?('app.asana.com')
                taskid = get_taskid_from_message_with_url(commit['message'])
                has_asana = true
            end
            if has_asana
                asana_url = "https://app.asana.com/api/1.0/tasks/#{taskid}/stories"
                comment = create_comment_string(push, commit)
                send_comment_to_asana(asana_url, comment)
            end
        end
        render json: push
    end
    
    def send_comment_to_asana(asana_url, comment)
        uri = URI.parse(asana_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
        request.basic_auth(@b2aConnection.asana_api_key, '')
        request.body = { "data" => { "text" => comment }}.to_json
        http.request(request) 
    end
    
    def get_taskid_from_message_with_numsign(message)
       return message.partition("#").last.partition(" ").first.gsub(/\n/, '')
    end
    
    def get_taskid_from_message_with_url(message)
        splitted = message.partition("app.asana.com").last.partition(" ").first.split("/")
        return (splitted.last != 'f' ? splitted.last : splitted[splitted.length - 2]).gsub(/\n/, '')
    end
    
    def create_comment_string(push, commit)
       return push['user'] + " pushed to branch " + commit['branch'] + " of " + push['repository']['name'] + "\n- " + commit['message'] + "\nCommit URL: https://bitbucket.org" + push['repository']['absolute_url'] + "commits/" + commit['raw_node'] 
    end
    
end
