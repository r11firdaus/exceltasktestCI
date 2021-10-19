# frozen_string_literal: true

# for CRUD role
class Role < ApplicationRecord
  belongs_to :user, optional: true
end
