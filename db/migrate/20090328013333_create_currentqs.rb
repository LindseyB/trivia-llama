class CreateCurrentqs < ActiveRecord::Migration
  def self.up
    create_table :currentqs do |t|
      t.integer :num

      t.timestamps
    end
  end

  def self.down
    drop_table :currentqs
  end
end
