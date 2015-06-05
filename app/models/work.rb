class Work < ActiveRecord::Base
  validates :team, :title, :introduction, presence: true

  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON
end
