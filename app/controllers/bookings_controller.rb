class BookingsController < ApplicationController
  respond_to :html, :xml, :json
  
  before_action :find_study_group

  def index
    @bookings = Booking.where("study_group_id = ? AND end_time >= ?", @study_group.id, Time.now).order(:start_time)
    respond_with @bookings
  end

  def new
    @booking = Booking.new(study_group_id: @study_group.id)
  end

  def create
    @booking =  Booking.new(params[:booking].permit(:study_group_id, :start_time, :length))
    @booking.study_group = @study_group
    if @booking.save
      redirect_to study_group_bookings_path(@study_group, method: :get)
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id]).destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to study_group_bookings_path(@study_group)
    else
      render 'index'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    # @booking.study_group = @study_group

    if @booking.update(params[:booking].permit(:study_group_id, :start_time, :length))
      flash[:notice] = 'Your booking was updated succesfully'

      if request.xhr?
        render json: {status: :success}.to_json
      else
        redirect_to study_group_bookings_path(@study_group)
      end
    else
      render 'edit'
    end
  end

  private

  def save booking
    if @booking.save
        flash[:notice] = 'booking added'
        redirect_to study_group_booking_path(@study_group, @booking)
      else
        render 'new'
      end
  end

  def find_study_group
    if params[:study_group_id]
      @study_group = StudyGroup.find_by_id(params[:study_group_id])
    end
  end

end
