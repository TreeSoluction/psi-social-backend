class AddUserRefInPsi < ActiveRecord::Migration[7.2]
  def change
    add_reference :psis, :user, null: false, foreign_key: true
  end
end
