class CreateStudyGroups < ActiveRecord::Migration
  def change
    create_table :study_groups do |t|
      t.string :name
    end
  end
end
