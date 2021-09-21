# frozen_string_literal: true

# app class root
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
