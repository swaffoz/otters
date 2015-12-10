class Image < ActiveRecord::Base
  has_attached_file :attached_file, styles: { large: "1000x1000>", medium: "500x500>", small: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :attached_file, content_type: /\Aimage\/.*\Z/
end
