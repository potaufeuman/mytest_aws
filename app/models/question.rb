class Question < ApplicationRecord
  belongs_to :test
  has_many :selects, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true
  belongs_to :answer, optional: true
  mount_uploader :picture, PictureUploader
  validates :test_id, presence: true
  validates :Q, presence: true
  validate  :picture_size

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
