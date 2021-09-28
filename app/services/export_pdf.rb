# frozen_string_literal: true

# processing pdf from post data
class ExportPdf
  def initialize(post:)
    @post = post
  end

  def export
    save_path = Rails.root.join('public/pdf', "#{@post.id}.pdf")
    if File.exist?(save_path)
    # send pdf data
    else
      # kick off the job and render the default template for this action
      AddPdfJob.new(post: @post).perform_now
    end
    save_path
  end
end
