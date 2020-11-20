class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: { on_delete: :cascade }
      t.text :description, null: false
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
