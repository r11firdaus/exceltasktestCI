# frozen_string_literal: true

class RemoveRoleFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :role, :string
  end
end
