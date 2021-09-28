# frozen_string_literal: true

class AddImageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image_url, :string
  end
end
