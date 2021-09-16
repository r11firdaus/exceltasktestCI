# frozen_string_literal: true

class AddPdfJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Do something later
    puts 'Starting generate PDF on background'

    save_path = Rails.root.join('public', "#{post.id}.pdf")

    return if File.exist?(save_path)

    pdf_contents = ApplicationController.render(
      pdf: post.id.to_s,
      template: 'posts/show.pdf',
      layout: 'pdf',
      # locals: {post: post},
      assigns: { post: post }
    )   # Excluding ".pdf" extension.

    File.open(save_path, 'wb') do |file|
      file.write(pdf_contents)
    end

    puts 'Finish generate PDF on background'
  end
end
