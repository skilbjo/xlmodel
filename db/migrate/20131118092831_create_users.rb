class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :payment_processor
      t.string :token

      t.timestamps
    end
  end
end
