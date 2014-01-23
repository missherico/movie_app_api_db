class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb
      t.string :title
      t.string :year
      t.string :full_plot
      t.string :pic_link

      t.timestamps
    end
  end
end
