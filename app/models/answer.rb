class Answer < ApplicationRecord
  belongs_to :question
  has_many :attachments, as: :attachable
  validates :body, presence: true

  accepts_nested_attributes_for :attachments
end
