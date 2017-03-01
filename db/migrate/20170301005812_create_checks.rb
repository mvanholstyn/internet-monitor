class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.boolean :up

      t.timestamps
    end
  end
end
