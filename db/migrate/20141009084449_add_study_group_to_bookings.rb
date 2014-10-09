class AddStudyGroupToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :study_group, index: true
  end
end
