class AddLikesToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :likes, :integer, null: false, default: 0
  end
end
