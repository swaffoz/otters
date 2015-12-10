class XmlrpcController < ApplicationController
  #before_filter :disable_xss_protection, only: :xe_index
  protect_from_forgery :except => :xe_index 
  
  # XML-RPC for MarsEdit
  exposes_xmlrpc_methods :method_prefix => "metaWeblog."
  
  def getPost(postid, username, password)
    if User.find_by(name: username).try(:authenticate, password)
      article = Article.find(postid.to_i)
      hash = { title: article.title, 
            description: article.text,
            link: 'http://otters.io/' + article.id.to_s,
            post_status: if article.is_published then 'published' else 'draft' end,
            date_created: article.created_at.utc.iso8601,
            date_modified: article.updated_at.utc.iso8601,
            categories: '' }
      hash
    end
  end
  
  def newPost(blogid, username, password, content, publish) 
    if User.find_by(name: username).try(:authenticate, password) 
      article = Article.new( title: content["title"], 
                             text: content["description"], 
                             is_published: publish)
      
      if article.save
        article.id
      end
    end
  end
  
  def getRecentPosts(blogid, username, password, numberOfPosts)
    if User.find_by(name: username).try(:authenticate, password)
      numberOfArticles ||= 10
      articles = Article.order('created_at DESC, updated_at DESC').limit(numberOfPosts)
      arr = []
      articles.each do |article|
        hash = { 
              postid: article.id.to_s, 
              title: article.title, 
              description: article.text,
              link: 'http://otters.io/' + article.id.to_s,
              post_status: if article.is_published then 'published' else 'draft' end,
              date_created: article.created_at.utc.iso8601,
              date_modified: article.updated_at.utc.iso8601,
              categories: '' }
        arr.push hash
      end
      
      arr
    end
  end
  
  def editPost(postid, username, password, content, publish)
    if User.find_by(name: username).try(:authenticate, password) 
      Article.update(postid.to_i, 
              title: content["title"], 
              text: content["description"],
              is_published: publish)
      true
    end
  end
    
  # Dave Winer's MetaWeblog does not define deletePost 
  # We need to defer to the Blogger API it builds on
  # So we use blogger.deletePost instead of metaWeblog.deletePost
  # See: http://xmlrpc.scripting.com/metaWeblogApi.html
  add_method 'blogger.deletePost' do |appkey, postid, username, password, publish|
    if User.find_by(name: username).try(:authenticate, password) 
      Article.delete(postid.to_i)
      true
    end
  end
    
  def getCategories(blogid, username, password) 
    if User.find_by(name: username).try(:authenticate, password)
      # Categories are not available
      []
    end
  end
  
  def newMediaObject(blogid, username, password, data) 
    if User.find_by(name: username).try(:authenticate, password)
      file_name = data["name"].to_s.split("/").last
      image = Image.new(name: file_name, 
                        attached_file: StringIO.new(data["bits"]))
      
      if image.save
        { file: image.attached_file_file_name, 
          url: image.attached_file.url, 
          type: image.attached_file_content_type }
      end
    end
  end
  
  def getUsersBlogs(appkey, username, password) 
    if authenticate_xml_rpc(username, password) 
      [{ blogid: "1", 
         url: "http://otters.io", 
         blogName: "Otters" }]
    end
  end
  
end
