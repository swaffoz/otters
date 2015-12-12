## This is the Image class, it ties into paperclip for image upload
class Image < ActiveRecord::Base
  has_attached_file :attached_file,
                    styles: { large: '1000x1000>',
                              medium: '500x500>',
                              small: '200x200>',
                              thumb: '100x100>' }
  validates_attachment_content_type :attached_file,
                                    content_type: %r{\Aimage\/.*\Z}
end
