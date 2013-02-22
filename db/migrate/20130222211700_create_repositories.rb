class CreateRepositories < ActiveRecord::Migration
  def up
    create_table :repositories do |t|
      t.string  :name,         null: false
      t.string  :url,          null: false
      t.string  :timezone
      t.integer :workday_start
      t.integer :workday_end
    end
  end

  def down
    drop_table :repositories
  end
end
