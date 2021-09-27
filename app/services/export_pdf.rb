class ExportPdf
	def initialize(post:)
		@post = post
	end
	
	def export
		save_path = Rails.root.join('public', "#{@post.id}.pdf")
	    if File.exist?(save_path)
	      # send pdf data
	      return save_path
	    else
	      # kick off the job and render the default template for this action
	      AddPdfJob.perform_now(@post)
	      return save_path
	    end
	end
end