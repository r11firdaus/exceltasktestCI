# frozen_string_literal: true

class AddIndexToUsernameColumnOnUser < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :username
  end
end
