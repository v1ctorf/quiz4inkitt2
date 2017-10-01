class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :ip
      t.integer :question
      t.integer :option

      t.timestamps null: false
    end
  end
end
