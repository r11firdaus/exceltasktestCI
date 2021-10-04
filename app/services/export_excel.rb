# frozen_string_literal: true

# processing excel file for user request
class ExportExcel
  def initialize(page:, role:, type:, id:)
    @role = role
    @type = type
    @id = id
    @page = page
  end

  def export
    @role == 1 ? excel_admin : excel_writer
  end

  def excel_admin
    @type == 'all' ? Post.all : Post.order('created_at DESC').limit(10).offset(@page * 10 || 1)
  end

  def excel_writer
    if @type == 'all'
      Post.all.where('user_id = ?', @id)
    else
      Post.order('created_at DESC').limit(10)
          .offset(@page * 10 || 1).where('user_id = ?', @id)
    end
  end
end
