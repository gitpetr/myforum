class Attachment < ApplicationRecord
  belongs_to :attachable
  mount_uploader :file, FileUploader
end
