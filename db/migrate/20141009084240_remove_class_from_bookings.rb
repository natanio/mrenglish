class RemoveClassFromBookings < ActiveRecord::Migration
  def change
  	remove_column :bookings, :class_id
  end
end
