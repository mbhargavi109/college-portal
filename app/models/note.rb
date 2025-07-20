class Note < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :subject


  has_many_attached :files

  validates :title, :semester, presence: true
  validate :acceptable_file_types

  def self.ransackable_attributes(auth_object = nil)
    %w[title description department_id subject_id semester user_id]
  end

  # Custom validation for file types
  def acceptable_file_types
    return unless files.attached?

    allowed = %w[
      application/pdf
      application/msword
      application/vnd.openxmlformats-officedocument.wordprocessingml.document
      application/vnd.ms-powerpoint
      application/vnd.openxmlformats-officedocument.presentationml.presentation
      text/plain
    ]

    files.each do |file|
      unless allowed.include?(file.content_type)
        errors.add(:files, "#{file.filename} is not a supported format.")
      end
    end
  end

  # Replace files with same name
  def attach_or_replace_files(new_files)
    files_to_attach = Array(new_files).reject(&:blank?)
    files_to_attach.each do |new_file|
      files.each do |existing|
        if existing.filename.to_s == new_file.original_filename
          existing.purge
        end
      end
    end
    files.attach(files_to_attach)
  end
end
