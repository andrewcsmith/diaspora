require 'spec_helper'
require 'xmlrpc/client'

describe Services::Wordpress do
  
  before do
    @user = alice
    @post = @user.post(:status_message, :text => "hello", :to => @user.aspects.first.id)
    @service = Services::Wordpress.new(:username => "admin", :password => "password", :host => "www.myblog.com", :path => "/wordpress/xmlrpc.php")
    @user.services << @service
  end
  
  describe "#post" do
    
    it 'posts a status message to wordpress' do
      stub_request(:post, @service.url).to_return(:status => 200, :body => XMLRPC::Create.new.methodResponse(true, {:post_id => "42"}))
      @service.post(@post)
    end
    
  end
  
end