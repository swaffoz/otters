## This controller ties into the XMLRPC gem to let us implement metaWeblog
class XmlrpcController < ApplicationController
  
  # disabled to allow XMLRPC to connect
  protect_from_forgery except: :xe_index

  # XML-RPC for MarsEdit
  # We'll use camelCase instead of snake_case for method names
  # Because that is what metaWeblog expects
  exposes_xmlrpc_methods method_prefix: 'metaWeblog.'

  def getPost(postid, username, password)
    return unless User.find_by(name: username).try(:authenticate, password)
    article = Article.find(postid.to_i)
    hash = { title: article.title,
            description: article.text,
            link: ENV["app_url"] + '/'  + article.id.to_s,
            date_created: article.created_at.utc.iso8601,
            date_modified: article.updated_at.utc.iso8601,
            categories: '' }
    hash
  end
  
  def newPost(_blogid, username, password, content, _publish)
    return unless User.find_by(name: username).try(:authenticate, password)
    article = Article.new(title: content['title'],
                          text: content['description'])

    return unless article.save
    article.id
  end

  def getRecentPosts(_blogid, username, password, number_of_articles)
    return unless User.find_by(name: username).try(:authenticate, password)
    number_of_articles ||= 10
    articles = Article.order('created_at DESC, updated_at DESC').limit(number_of_articles)
    arr = []
    articles.each do |article|
      hash = { postid: article.id.to_s,
        title: article.title,
        description: article.text,
        link: ENV["app_url"] + '/' + article.id.to_s,
        date_created: article.created_at.utc.iso8601,
        date_modified: article.updated_at.utc.iso8601,
        categories: '' }
      arr.push hash
    end

    arr
  end
  
  def editPost(postid, username, password, content, _publish)
    return unless User.find_by(name: username).try(:authenticate, password)
    Article.update(postid.to_i,
                    title: content['title'],
                    text: content['description'])
    true
  end
    
  # Dave Winer's MetaWeblog does not define deletePost
  # We need to defer to the Blogger API it builds on
  # So we use blogger.deletePost instead of metaWeblog.deletePost
  # See: http://xmlrpc.scripting.com/metaWeblogApi.html
  add_method 'blogger.deletePost' do |_appkey, postid, username, password, _publish|
    return unless User.find_by(name: username).try(:authenticate, password)
    Article.delete(postid.to_i)
    true
  end
    
  def getCategories(_blogid, username, password)
    return unless User.find_by(name: username).try(:authenticate, password)
    
    # Categories are not available
    []
  end
  
  def newMediaObject(_blogid, username, password, data)
    return unless User.find_by(name: username).try(:authenticate, password)

    file_name = data['name'].to_s.split('/').last
    image = Image.new(name: file_name,
                      attached_file: StringIO.new(data['bits']))

    return unless image.save

    { file: image.attached_file_file_name,
      url: image.attached_file.url,
      type: image.attached_file_content_type }
  end
  
  def getUsersBlogs(_appkey, username, password)
    return unless User.find_by(name: username).try(:authenticate, password)

    [{ blogid: '1',
       url: ENV["app_url"],
       blogName: 'Otters' }]
  end
end
