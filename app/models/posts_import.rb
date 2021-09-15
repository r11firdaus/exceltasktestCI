class PostsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    if attributes != nil
      attributes.each { |name, value| send("#{name}=", value) }
    else
      puts "Data empty"
    end
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_posts
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      post = Post.find_by_id(row["id"]) || Post.new
      post.attributes = row.to_hash
      post
    end
  end

  def imported_posts
    @imported_posts ||= load_imported_posts
  end

  def save
    if imported_posts.map(&:valid?).all?
      imported_posts.each(&:save!)
      true
    else
      imported_posts.each_with_index do |_item, index|
        post.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end