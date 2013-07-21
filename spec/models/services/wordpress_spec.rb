require 'spec_helper'

describe Services::Wordpress do
  
  before do
    @user = alice
    @post = @user.post(:status_message, :text => "hello", :to => @user.aspects.first.id)
    @service = Services::Wordpress.new(:username => "admin", :password => "password")
    @user.services << @service
  end
  
  describe "#post" do
    it 'posts a status message to wordpress' do
      stub_request(:post, "http://www.myblog.com/wordpress/xmlrpc.php").to_return(:status => 200, :body => "42", :headers => {})
      @service.post(@post).should_match "42"
    end
  end
  
end