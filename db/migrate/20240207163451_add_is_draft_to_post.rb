class AddIsDraftToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :is_draft, :boolean, default: false
  end
end
