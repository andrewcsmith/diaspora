require 'xmlrpc/client'

class Services::Wordpress < Service
  include ActionView::Helpers::TextHelper
  include MarkdownifyHelper
  
  attr_accessor :username, :password, :host, :path
  
  def provider
    "wordpress"
  end
  
  def post(post, url='')
    s = XMLRPC::Client.new(@host, @path, 80)
    wp_post_options = {:post_content => post.text, :post_status => 'publish'}
    res = s.call('wp.newPost', 0, username, password, wp_post_options)
    res
  end
  
  def url
    "#{host}:80#{path}"
  end
end