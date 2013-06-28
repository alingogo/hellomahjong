class MeetingsController < ApplicationController
  before_filter :reset_session, :only => [:index, :login, :create, :new]
  before_filter :authorize, :only => [:show, :update, :edit, :destroy]
  before_filter :check_meeting_params_for_create, :only => [:create]
  before_filter :check_meeting_params_for_update, :only => [:update]
  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
  end

  def login
    @meeting = Meeting.find(params["meeting"]["meeting_id"])
    reset_session
    url = url_for :controller => 'games', :action => 'index'
    unless params['meeting']['password'].nil?
      if @meeting.passwd == params["meeting"]["password"]
        session[:tm] = true
      else
        url = url_for :controller => 'meetings', :action => 'show', :id => @meeting.id
        flash[:error] = "password is wrong!"
      end
    end
    session[:meeting_id] = @meeting.id

    redirect_to url
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to :controller => 'games', :action => 'index', notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end

  private

  def check_meeting_params_for_create
    error = []
    params[:meeting].each do |k, v|
      case k
      when "passwd"
        error << "password is null!" if v.blank?
      when "title"
        error << "title is null" if v.blank?
      when "creator"
        error << "creator is null" if v.blank?
      end
    end

    unless error.empty?
      flash[:error] = error.join(" ")
      redirect_to :action => 'new'
    end
  end

  def check_meeting_params_for_update
    error = []
    params[:meeting].each do |k, v|
      case k
      when "passwd"
        error << "password is null!" if v.blank?
      when "title"
        error << "title is null" if v.blank?
      when "creator"
        error << "creator is null" if v.blank?
      end
    end

    unless error.empty?
      flash[:error] = error.join(" ")
      redirect_to :action => 'edit'
    end
  end
end
