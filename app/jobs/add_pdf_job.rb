# frozen_string_literal: true

# generate pdf on background
class AddPdfJob < ApplicationJob
  queue_as :default

  def initialize(post:)
    @post = post
    @save_path = Rails.root.join('public', "#{@post.id}.pdf")
  end

  def perform
    return if File.exist?(@save_path)

    render
  end

  def render
    pdf_contents = ApplicationController.render(
      pdf: @post.id.to_s,
      template: 'posts/show.pdf',
      layout: 'pdf',
      assigns: { post: @post }
    )   # Excluding ".pdf" extension.

    File.open(@save_path, 'wb') do |file|
      file.write(pdf_contents)
    end
  end
end
