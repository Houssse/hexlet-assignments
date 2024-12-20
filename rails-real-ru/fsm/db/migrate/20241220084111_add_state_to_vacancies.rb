class AddStateToVacancies < ActiveRecord::Migration[7.2]
  def change
    add_column :vacancies, :state, :string
  end
end
