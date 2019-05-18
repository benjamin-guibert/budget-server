class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :month_budgets do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.decimal :initial_balance, precision: 10, scale: 2, null: false

      t.timestamps
    end

    create_table :budget_records do |t|
      t.string :label, null: false
      t.integer :record_type, null: false
      t.integer :category
      t.date :date_from, null: false
      t.date :date_to, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.belongs_to :month_budget, foreign_key: true

      t.timestamps
    end
  end
end
