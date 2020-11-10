class CreateReviewsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :reviews do |t|
        t.integer :user_id
        t.integer :app_id
        t.string :content
        t.integer :rating
      end
    end
  end
  