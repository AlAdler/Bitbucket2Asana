require 'rails_helper'

input = {"payload"=>"{\"repository\": {\"website\": \"\", \"fork\": false, \"name\": \"Bitbucket2Asana_Tester_Repo\", \"scm\": \"git\", \"owner\": \"AlAdler\", \"absolute_url\": \"/AlAdler/bitbucket2asana_tester_repo/\", \"slug\": \"bitbucket2asana_tester_repo\", \"is_private\": true}, \"truncated\": false, \"commits\": [{\"node\": \"fe4da7059c66\", \"files\": [{\"type\": \"added\", \"file\": \"stam.txt\"}], \"raw_author\": \"Alain Adler\", \"utctimestamp\": \"2015-01-05 22:33:38+00:00\", \"author\": \"AlAdler\", \"timestamp\": \"2015-01-05 23:33:38\", \"raw_node\": \"fe4da7059c6696f45a57ec7e062f69402dcbfa7d\", \"parents\": [], \"branch\": \"master\", \"message\": \"commit1n\", \"revision\": null, \"size\": -1}], \"canon_url\": \"https://bitbucket.org\", \"user\": \"AlAdler\"}"}
input_with_num = {"payload"=>"{\"repository\": {\"website\": \"\", \"fork\": false, \"name\": \"Bitbucket2Asana_Tester_Repo\", \"scm\": \"git\", \"owner\": \"AlAdler\", \"absolute_url\": \"/AlAdler/bitbucket2asana_tester_repo/\", \"slug\": \"bitbucket2asana_tester_repo\", \"is_private\": true}, \"truncated\": false, \"commits\": [{\"node\": \"fe4da7059c66\", \"files\": [{\"type\": \"added\", \"file\": \"stam.txt\"}], \"raw_author\": \"Alain Adler\", \"utctimestamp\": \"2015-01-05 22:33:38+00:00\", \"author\": \"AlAdler\", \"timestamp\": \"2015-01-05 23:33:38\", \"raw_node\": \"fe4da7059c6696f45a57ec7e062f69402dcbfa7d\", \"parents\": [], \"branch\": \"master\", \"message\": \"bla bla #123456 bla\", \"revision\": null, \"size\": -1}], \"canon_url\": \"https://bitbucket.org\", \"user\": \"AlAdler\"}"}
input_with_url = {"payload"=>"{\"repository\": {\"website\": \"\", \"fork\": false, \"name\": \"Bitbucket2Asana_Tester_Repo\", \"scm\": \"git\", \"owner\": \"AlAdler\", \"absolute_url\": \"/AlAdler/bitbucket2asana_tester_repo/\", \"slug\": \"bitbucket2asana_tester_repo\", \"is_private\": true}, \"truncated\": false, \"commits\": [{\"node\": \"fe4da7059c66\", \"files\": [{\"type\": \"added\", \"file\": \"stam.txt\"}], \"raw_author\": \"Alain Adler\", \"utctimestamp\": \"2015-01-05 22:33:38+00:00\", \"author\": \"AlAdler\", \"timestamp\": \"2015-01-05 23:33:38\", \"raw_node\": \"fe4da7059c6696f45a57ec7e062f69402dcbfa7d\", \"parents\": [], \"branch\": \"master\", \"message\": \"bla bla https://app.asana.com/123123/123456 bla\", \"revision\": null, \"size\": -1}], \"canon_url\": \"https://bitbucket.org\", \"user\": \"AlAdler\"}"}

RSpec.describe CommitsController do
    describe "get_taskid_from_message_with_numsign" do
       it "should return taskid from message with numsign" do
          controller = CommitsController.new 
          expect(controller.get_taskid_from_message_with_numsign("bla bla #123456 bla")).to eq("123456")
       end
    end
    describe "get_taskid_from_message_with_url" do
       it "should return taskid from message with numsign" do
          controller = CommitsController.new 
          expect(controller.get_taskid_from_message_with_url("bla bla https://app.asana.com/123123/123456 bla")).to eq("123456")
       end
    end
    describe "create_comment_string" do
        it "should create nice comment from push data" do
            controller = CommitsController.new 
            push = JSON.parse input_with_url['payload']
            expect(controller.create_comment_string(push, push['commits'].first)).to eq("AlAdler pushed to branch master of Bitbucket2Asana_Tester_Repo\n- bla bla https://app.asana.com/123123/123456 bla\nCommit URL: https://bitbucket.org/AlAdler/bitbucket2asana_tester_repo/commits/fe4da7059c6696f45a57ec7e062f69402dcbfa7d")
        end
    end
    describe "POST a commit" do
        before do
            allow_any_instance_of(CommitsController).to receive(:send_comment_to_asana).and_return(nil)
        end
        it "has a 200 status code" do
            post :post, input
            expect(response.status).to eq(200)
        end
        it "echos the bitbucket json" do
            post :post, input
            expect(response.body).to eq((JSON.parse "{\"repository\": {\"website\": \"\", \"fork\": false, \"name\": \"Bitbucket2Asana_Tester_Repo\", \"scm\": \"git\", \"owner\": \"AlAdler\", \"absolute_url\": \"/AlAdler/bitbucket2asana_tester_repo/\", \"slug\": \"bitbucket2asana_tester_repo\", \"is_private\": true}, \"truncated\": false, \"commits\": [{\"node\": \"fe4da7059c66\", \"files\": [{\"type\": \"added\", \"file\": \"stam.txt\"}], \"raw_author\": \"Alain Adler\", \"utctimestamp\": \"2015-01-05 22:33:38+00:00\", \"author\": \"AlAdler\", \"timestamp\": \"2015-01-05 23:33:38\", \"raw_node\": \"fe4da7059c6696f45a57ec7e062f69402dcbfa7d\", \"parents\": [], \"branch\": \"master\", \"message\": \"commit1n\", \"revision\": null, \"size\": -1}], \"canon_url\": \"https://bitbucket.org\", \"user\": \"AlAdler\"}").to_json)
        end
        it "should not call send_comment_to_asana with no asana input" do
            expect_any_instance_of(CommitsController).to_not receive(:send_comment_to_asana)
            post :post, input
        end
        it "should call send_comment_to_asana with numsign input" do
            expect_any_instance_of(CommitsController).to receive(:get_taskid_from_message_with_numsign).and_return("123456")
            expect_any_instance_of(CommitsController).to receive(:send_comment_to_asana)
            post :post, input_with_num
        end
        it "should call send_comment_to_asana with url input" do
            expect_any_instance_of(CommitsController).to receive(:get_taskid_from_message_with_url).and_return("123456")
            expect_any_instance_of(CommitsController).to receive(:send_comment_to_asana)
            post :post, input_with_url
        end
    end
end