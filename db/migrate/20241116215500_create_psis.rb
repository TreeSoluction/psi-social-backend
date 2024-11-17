class CreatePsis < ActiveRecord::Migration[7.2]
  def change
    create_table :psis do |t|
      t.string "crp", null: false
      t.string "cnpj"
      t.string "image"
      t.timestamps
    end
  end
end
