require 'spec_helper'

describe Services::Wordpress do
  
  before do
    @user = alice
    @post = @user.post(:status_message, 
                       :text => "hello", 
                       :to => @user.aspects.first.id)
                       
    @service = Services::Wordpress.new(:nickname => "andrew", 
                                       :access_token => "abc123", 
                                       :uid => "123")
    @user.services << @service
  end
  
  describe "#post" do
    
    it 'posts a status message to wordpress' do
      stub_request(:post, "https://public-api.wordpress.com/rest/v1/sites/123/posts/new").with(:body => {:title => "hello", :content => "hello"}.to_json).to_return(:status => 200, :body => {:ID => 68}.to_json, :headers => {})
      @service.post(@post)
    end
    
  end
  
end