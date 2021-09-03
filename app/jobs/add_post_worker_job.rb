class AddPostWorkerJob < ApplicationJob
  queue_as :default

  def perform(posts_import)
    # Do something later
    puts "Prepare to upload"
    import = PostsImport.new(posts_import)
    import.save

    if import.save
      puts "Data uploaded"
      return true    
    else
      puts "Data not uploaded"
      return false
    end
  end
end
