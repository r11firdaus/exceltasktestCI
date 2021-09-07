class Search < ApplicationRecord
	self.inheritance_column = "not_sti"

    def search_post
        post = Post.all

        post = post.where(["title ILIKE ?","%#{title}%"]) if title.present?
        post = post.order("created_at #{body}") if body.present?

        return post
    end 
end
