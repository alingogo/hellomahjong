class GamesController < ApplicationController
  before_filter :authorize
  before_filter :validate_create_params, :only => ['create']
  before_filter :validate_update_params, :only => ['update']
  # GET /games
  # GET /games.json
  def index
    @games = Game.find_all_by_meeting_id(@meeting.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/result
  def result
    @games = Game.find_all_by_meeting_id(@meeting.id)
    @participants = Participant.find_all_by_meeting_id(@meeting.id)

    @result = compute(@games, @participants)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end

  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @scores = Score.find_all_by_game_id(@game.id)
    @tuogong = 0
    unless @scores[0].points.nil?
      @tuogong = (100000 - @scores.inject(0){|sum, i| sum += i.points}) / 1000
    end
    @scores.sort! do |a,b|
      if a.points == b.points
        b.direction <=> a.direction
      else
        b.points <=> a.points
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
    @participants = Participant.find_all_by_meeting_id(@meeting.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @participants = Participant.find_all_by_meeting_id(@meeting.id)
    scores = Score.find_all_by_game_id(@game.id)
    @game_participants = scores.collect{|s| s.participant.id}
    @scores = Score.find_all_by_game_id(@game.id)
    @tuogong = 0
    unless @scores[0].points.nil?
      @tuogong = (100000 - @scores.inject(0){|sum, i| sum += i.points}) / 1000
    end
  end

  # POST /games
  # POST /games.json
  def create
    #directions = Score::DIRECTIONS.map{|k,v| k}
    #directions.shuffle!
    params[:game].merge!({:meeting_id => @meeting.id})
    @game = Game.create!(params[:game])
    participant_ids = params[:participants].collect{|id| id.to_i} if params[:participants]
    participant_ids.each do |id|
      score = Score.new
      score.game_id = @game.id
      score.participant_id = id.to_i
      #score.direction  = directions.shift
      score.save!
    end

    respond_to do |format|
      if @game
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])
    params[:game][:points].each do |k, v|
      score = Score.find_by_id(k)
      score.update_attributes(points: v)
      d = params[:direction][k]
      #direc = Score::DIRECTIONS.invert
      score.update_attributes(direction: d) # direc[d])
    end

    respond_to do |format|
      if @game.update_attributes(table: params[:game][:table],
                                 number: params[:game][:number],
                                 status: params[:game][:status])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private

  def compute(games, users)
    result = []
    game_results = []

    games.each do |game|
      if game_scores?(game)
        game_results << sort_scores(game)
      end
    end
    users.each do |user|
      point = 0
      game_results.each do |e|
        e.each do |k,v|
          v.each do |i|
            point += i[3] if user.id == i[0]
          end
        end
      end
      result << [user.name, point]
    end
    result.sort!{|a,b| b[1] <=> a[1]}
  end

  def sort_scores(game)
    sorts = []
    game.scores.each do |score|
      sorts << [score.participant_id,
                score.points,
                score.direction]
    end
    sorts.sort! do |a,b|
      if a[1] == b[1]
        b[2].to_i <=> a[2].to_i
      else
        b[1] <=> a[1]
      end
    end
    sorts.each_with_index do |e, i|
      e[3] = (e[1].to_i - 30000)/1000.0 + (30 - i*20) + (i == 0 ? 20 : 0)
    end
    {game.id => sorts}
  end

  def game_scores?(game)
    game.scores.each do |e|
      return false if e.points.blank?
    end
    true
  end

  def validate_create_params
    errors = []
    errors << "table is null!" if params['game']['table'].blank?
    errors << "number is null!" if params['game']['number'].blank?
    errors << "participants are less than 4!" if params['participants'].nil? or params['participants'].size < 4
    flash[:error] = errors.join(" ")
    redirect_to :action => 'new' unless errors.empty?
  end

  def validate_update_params
    errors = []
    errors << "table is null!" if params['game']['table'].blank?
    errors << "number is null!" if params['game']['number'].blank?
    points = params['game']['points']
    points.each do |k,v|
      if v.blank?
        errors << "point is null!"
        break
      end
    end
    errors << "total is not 100,000" unless 100000 == points.inject(0){|sum, p| sum += p[1].to_i} + params['game']['tuogong'].to_i * 1000
    direction = params['direction']
    dires = ['1', '2', '3', '4']
    direction.each do |k,v|
      if v.blank?
        errors << "direction are null!"
        break
      else
        unless dires.delete(v)
          errors << "direction are wrong!"
          break
        end
      end
    end
    flash[:error] = errors.join(" ")
    redirect_to :action => 'edit' unless errors.empty?
  end
end
