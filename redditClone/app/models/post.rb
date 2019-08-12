class Post < ApplicationRecord

  belongs_to(:author, foreign_key: :author_id, class_name: :User)

  has_many :postsubs,
    foreign_key: :post_id,
    class_name: "PostSub",
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :postsubs,
    source: :sub

  has_many :comments,
    foreign_key: :post_id,
    class_name: "Comment"

  validates :title, presence: true
  validate :has_sub?

  def has_sub?
    self.subs.count > 0
  end

  def comments_by_parent_id
    commenthash = Hash.new { |h, k| h[k] = Array.new }
    self.comments.each do |comment|
      commenthash[comment.parent_comment_id] << comment
    end
    commenthash
  end

end
