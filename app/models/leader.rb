class Leader < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 3 }
  validates :score, presence: true

  after_initialize :check_hashtag

  private

  def check_hashtag
    update(hashtag: 'popular') unless hashtag
    save
  end
end
