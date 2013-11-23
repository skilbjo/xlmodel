class AddProductToUser < ActiveRecord::Migration
  def change
    add_column :users, :product, :string
  end
end
