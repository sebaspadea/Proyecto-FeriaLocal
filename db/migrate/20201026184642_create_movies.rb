class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :poster
      t.boolean :favorite, default: false
      t.boolean :pending, default: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
