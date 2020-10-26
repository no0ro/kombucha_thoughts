class RemoveBuyAgainFromKombuchas < ActiveRecord::Migration[6.0]
  def change
    remove_column :kombuchas, :buy_again, :boolean
  end
end
