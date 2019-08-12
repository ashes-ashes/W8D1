class Sub < ApplicationRecord

  validates :title, :description, :moderator, presence: true


  belongs_to :moderator,
    foreign_key: :moderator_id,
    class_name: "User"

  has_many :postsubs,
    foreign_key: :sub_id,
    class_name: "PostSub",
    dependent: :destroy,
    inverse_of: :sub

  has_many :posts,
    through: :postsubs,
    source: :post

end
