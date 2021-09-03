class DeletePdfJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    path = Rails.root.join("public", "#{id}.pdf")
    File.delete(path) if File.exist?(path)
  end
end
