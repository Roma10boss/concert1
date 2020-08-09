class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.belongs_to :artist
      t.datetime :concert_date
      t.string :location
      t.string :description
      t.float :ticket_price
    end
  end
end
