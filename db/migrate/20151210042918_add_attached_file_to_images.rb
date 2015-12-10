class AddAttachedFileToImages < ActiveRecord::Migration
  def up
    add_attachment :images, :attached_file
  end
  
  def down
    remove_attachment :images, :attached_file
  end
end
