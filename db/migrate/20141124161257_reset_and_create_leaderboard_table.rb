class ResetAndCreateLeaderboardTable < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :name
      t.string :hashtag, default: 'popular'
      t.integer :score
      t.timestamps
    end
  end
end
