class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :month_budgets do |t|
      t.integer :year, null: false, index: true
      t.integer :month, null: false, index: true
      t.decimal :initial_balance, precision: 10, scale: 2, null: false

      t.timestamps
    end

    create_table :budget_records do |t|
      t.string :label, null: false
      t.integer :record_type, null: false, index: true
      t.integer :category
      t.date :date_from, null: false, index: true
      t.date :date_to, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.belongs_to :month_budget, foreign_key: true, index: true

      t.timestamps
    end
  end
end
