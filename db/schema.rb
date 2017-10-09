ActiveRecord::Schema.define(version: 20171001021321) do

  create_table "answers", force: :cascade do |t|
    t.string   "ip"
    t.integer  "question"
    t.integer  "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
