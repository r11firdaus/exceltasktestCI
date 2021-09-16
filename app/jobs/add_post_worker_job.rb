# frozen_string_literal: true

class AddPostWorkerJob < ApplicationJob
  queue_as :default

  def perform(posts_import)
    # Do something later
    puts 'Prepare to upload'
    import = PostsImport.new(posts_import)
    import.save

    if import.save
      puts 'Data uploaded'
      true
    else
      puts 'Data not uploaded'
      false
    end
  end
end
