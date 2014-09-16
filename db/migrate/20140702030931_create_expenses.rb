class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.text :description
      t.text :comment
      t.decimal :amount
      t.datetime :datetime
      t.references :user, index: true

      t.timestamps
    end
  end
end
