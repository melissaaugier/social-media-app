class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  VISIBILITIES = %w[public private].freeze

  before_save :downcase_visibility
  
  validates :visibility, inclusion: { in: VISIBILITIES }
  validates :content, presence: true

  scope :public_posts, -> { where(visibility: 'public') }
  scope :private_posts, -> { where(visibility: 'private') }

  private

  def downcase_visibility
    self.visibility = visibility.downcase if visibility.present?
  end
end
