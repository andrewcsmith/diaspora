class Services::Wordpress < Service
  include ActionView::Helpers::TextHelper
  include MarkdownifyHelper
  
  MAX_CHARACTERS = 1000
  
  attr_accessor :username, :password, :host, :path
  
  # uid = blog_id
  
  def provider
    "wordpress"
  end
  
  def consumer_client_id
    AppConfig.services.wordpress.client_id
  end
  
  def consumer_secret
    AppConfig.services.wordpress.secret
  end
  
  def post(post, url='')
    access_key = self.access_token
    
    conn = Faraday.new(:url => "https://public-api.wordpress.com")
    res = conn.post do |req|
      req.url "/rest/v1/sites/#{self.uid}/posts/new"
      req.body = post_body(post)
      req.headers['Authorization'] = "Bearer #{access_key}"
      req.headers['Content-Type'] = 'application/json'
    end
    res_body = JSON.parse res.env[:body]
    res_body
  end
  
  def post_body(post, url='')
    post_text = strip_markdown(post.text(:plain_text => true))
    post_title = truncate(post_text, :length => 40, :separator => ' ')
    
    body = {
      :title => post_title,
      :content => post_text
    }
    body.to_json
  end
  
end