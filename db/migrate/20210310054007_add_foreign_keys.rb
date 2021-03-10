class AddForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :guests, :hotels, column: :branch_id
    add_foreign_key :guests, :members, column: :member_id
    add_foreign_key :monthly_expenses, :hotels, column: :branch_id
  end
end
