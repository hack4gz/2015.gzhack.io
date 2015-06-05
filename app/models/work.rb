class Work < ActiveRecord::Base
  LIMIT_FILE_SIZE_IN_HUMAN_MEGABYTES = 10
  PER_MEGABYTE = 1000 * 1000

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  validates :team, :title, :introduction, presence: true
  validate :validate_attachments_size

  private
  def validate_attachments_size
    attachments.each do |attachment|
      if attachment.file.size.to_f / PER_MEGABYTE > LIMIT_FILE_SIZE_IN_HUMAN_MEGABYTES
        errors.add(:attachments, "#{attachment.file.filename}文件大小超过限定值：#{LIMIT_FILE_SIZE_IN_HUMAN_MEGABYTES}MB")
        break
      end
    end
  end
end
