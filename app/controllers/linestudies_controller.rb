class LinestudiesController < ApplicationController
  before_action :signed_in_user, only: [:create, :show, :edit, :update, :destroy]

  # GET /linestudies
  # GET /linestudies.json
  def index
    @linestudies = current_user.linestudies.all
  end

  # GET /linestudies/1
  # GET /linestudies/1.json
  def show
    @user = current_user
    @linestudy = @user.linestudies.find(params[:id])
    @events = @linestudy.events.all
  end

  # GET /linestudies/new
  def new
  end

  # GET /linestudies/1/edit
  def edit
  end

  # POST /linestudies
  # POST /linestudies.json
  def create
    @linestudy = current_user.linestudies.build(linestudy_params)
    if @linestudy.save
      flash[:success] = "Linestudy created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  # PATCH/PUT /linestudies/1
  # PATCH/PUT /linestudies/1.json
  def update
    respond_to do |format|
      if @linestudy.update(linestudy_params)
        format.html { redirect_to @linestudy, notice: 'Linestudy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @linestudy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /linestudies/1
  # DELETE /linestudies/1.json
  def destroy
    @linestudy.destroy
    respond_to do |format|
      format.html { redirect_to linestudies_url }
      format.json { head :no_content }
    end
  end

  def save
    @linestudy = current_user.linestudies.find_by_id(params[:id])
    @events = @linestudy.events

    Rails.logger.info("We have entered linestudies Save (in linestudies Controller)")
    Rails.logger.info("The linestudy description is " + @linestudy.description.to_yaml)
    Rails.logger.info("The CURRENT events are " + @events.to_yaml)
    Rails.logger.info("js_events are " + params[:line_study_table].to_yaml)
    # create function to sync js table with rails table
    respond_to do |format|
      format.html {redirect_to 'show'}
      format.js do
        js_events = params[:line_study_table]
        Rails.logger.info("When saving, the current js_events are " + js_events.to_yaml)
        update_events(@events, js_events, @linestudy)
        delete_events(@events, js_events)
        render nothing: true
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linestudy
      @linestudy = Linestudy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linestudy_params
      params.require(:linestudy).permit(:name, :description, :category, :start_time, :end_time)
    end

    def update_events(events, js_events, study)
      #update and create rails events based on the js events

      Rails.logger.info('We have entered update_events (in linestudiesController')
      Rails.logger.info("Within update_events, the current events are " + events.to_yaml)
      Rails.logger.info("Within update_events, the current js_events are " + js_events.to_yaml)
      Rails.logger.info("within update_events, the study is " + study.to_yaml)

      js_events.each do |js_event|
        Rails.logger.info("
        javascript event (js_event):  " + js_event.to_s() + "
        ")
        js_event_items = js_event[1]   #because each js_event is an array with 1 element
        Rails.logger.info("Its js_id is " + js_event_items['js_id'].to_s)

        if js_event_items["js_id"] == ""
          Rails.logger.info("It's a new event!!!")
          new_event = study.events.build(js_id: study.events.max_by {|e| e.js_id}.js_id+ 1, start_time: js_event_items["start_time"], 
                                          stop_time: js_event_items["stop_time"], description: js_event_items["description"] , 
                                          status: js_event_items["status"] , speed: js_event_items["speed"],
                                          machine_id: study.machine_id, line_id: study.line_id)
          Rails.logger.info('Event created')
          new_event.save!
        else
          event_js_id = js_event_items["js_id"].to_i
          if (events.exists?(js_id: event_js_id)) && (js_event_items["js_id"] != "")
            existing_event = events.where(js_id: event_js_id)[0]
            existing_event.update_attributes(start_time: js_event_items["start_time"], stop_time: js_event_items["stop_time"],
                    description: js_event_items["description"], status: js_event_items["status"], speed: js_event_items["speed"])
            Rails.logger.info('                       Event updated')
            existing_event.save!
          else
            raise("Something funky is happening- a new event came in with a js_id that is not null nor existing.")
          end
        end
      end
  end


  def delete_events(events, js_events)
    #delete any rails objects that no longer exist in the js
    Rails.logger.info('We have entered delete_events (in lineStudiesController')
    e_ids = Array.new
    js_events.each do |js_e|      
      js_event = js_e[1]
      e_ids.push(js_event["js_id"].to_i)
    end
    events.each do |eve|
      Rails.logger.info("E_IDS  " + e_ids.to_s + " ; EVENT JS ID  " + eve.js_id.to_s + "\n")
      if not e_ids.include?(eve.js_id)
        Rails.logger.info("We are deleting an event!")
        eve.destroy
      end
    end
  end

end
