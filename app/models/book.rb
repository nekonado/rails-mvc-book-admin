class Book < ApplicationRecord
  scope :costly, -> { where("price > ?", 3000)}
  scope :written_about, ->(theme) { where("name like ?", "%#{theme}%")}

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # 以下のカスタムのバリデーションがうまく機能していないが理由がよくわからない
  validate do |book|
    if book.name.include?("cat")
      book.errors[:name] << "I love cat so much."
    end
  end
end
