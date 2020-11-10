class CreateAppsTable < ActiveRecord::Migration[6.0]
    def change
      create_table :apps do |t|
        t.string :name
        t.string :app_function
      end
    end
  end
  