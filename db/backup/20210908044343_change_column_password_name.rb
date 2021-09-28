# frozen_string_literal: true

class ChangeColumnPasswordName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password, :password_digest
  end
end
