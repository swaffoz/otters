## This is the User class. It uses Rails' has_secure_password with bcrypt
## The app will allow any user to be an author, so choose users wisely!
class User < ActiveRecord::Base
  has_secure_password
end
