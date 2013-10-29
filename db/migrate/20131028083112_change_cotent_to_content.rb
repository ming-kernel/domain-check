class ChangeCotentToContent < ActiveRecord::Migration
  def change
  	rename_column :posts, :cotent, :content 
  end
end
