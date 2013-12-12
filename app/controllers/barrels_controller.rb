class BarrelsController < ApplicationController
  # GET /barrels
  # GET /barrels.json
  def index
 
    @barrels = Barrel.all
    #@barrel = Barrel.find(1)
    #@spirits = @barrel.spirits
    #@spirit = @barrel.spirits.order("id DESC").first
    #@comments = Spirit.find(5).comments

   
    respond_to do |format|
      
      format.html # index.html.erb
      #CSV code courtesy of: http://railscasts.com/episodes/362-exporting-csv-and-excel?view=asciicast
      format.csv { send_data @barrels.to_csv }
      format.xls 
      format.js 
      format.json { render json: @barrels }
    end
  end
  
  def refresh

    @barrels = Barrel.all
    respond_to :js
  end
  
  def vis
    #needs readings 
    @readings = Spirit.find(params[:spirit]).readings

    respond_to do |format|
      format.js 
      format.html # index.html.erb
      format.json { render :json => @readings.to_json }
    end
  end
  
  def history
    @barrel = Barrel.find(params[:barrel])
    @spirits = @barrel.spirits
    @spirit = @spirits.last
    @readings = @spirit.readings
    
    @comments = @spirit.comments
    respond_to :js
  end
  
  # GET /barrels/1
  # GET /barrels/1.json
  def show
    @barrel = Barrel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @barrel }
    end
  end

  # GET /barrels/new
  # GET /barrels/new.json
  def new
    @barrel = Barrel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @barrel }
    end
  end

  # GET /barrels/1/edit
  def edit
    @barrel = Barrel.find(params[:id])
    @hello_message = "Welcome to JRuby on Rails on the Sun GlassFish Enterprise Server"
    @measurement = params[:measurement]
  end

  # POST /barrels
  # POST /barrels.json
  def create
    @barrel = Barrel.new(params[:barrel])

    respond_to do |format|
      if @barrel.save
        format.html { redirect_to @barrel, notice: 'Barrel was successfully created.' }
        format.json { render json: @barrel, status: :created, location: @barrel }
      else
        format.html { render action: "new" }
        format.json { render json: @barrel.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /barrels/receive
  def receive
   @barrel = Barrel.find(params[:id])
   @spirit = @barrel.spirits.order("id DESC").first
   @reading = @spirit.readings.create();
   @reading.measurement = params[:reading]
   
   #HARD CODED LENGTH
   @length = 36.6;
   @r =  27.305/2;
   @d = 2*@r;
   @df= 2*@r - @reading.measurement;
   #JUSTIN FORMULA GOES HERE
   @centimeters = @length *((@r**2)*Math.acos((@r-@df)/@r) - ((@r-@df)*Math.sqrt(2*@r*@df-(@df**2))))
   @reading.liters = @centimeters*0.001

   #CUBIC CENTIMETERS -> LITERS
   
   @reading.timeOfDay= @reading.updated_at.strftime('%l:%M %p')
   @reading.save
   
   @num_cycles = 4
   
    respond_to do |format|
      #math 
       format.any { render :text => "$#{@num_cycles.to_s}!" }
       #if (params[:gallons] && @barrel.update_attribute(:gallons, params[:gallons]) || @barrel.update_attributes(params[:barrel]))
         #MESSAGE FOR ARDUINO
        # format.any { render :text => "$#{@num_cycles.to_s}!" }
         #format.json { head :no_content }
       #end
     end
   
   
  end
  
  def resp
  end

  # PUT /barrels/1
  # PUT /barrels/1.json
  def update
    @barrel = Barrel.find(params[:id])
    respond_to do |format|
      if (params[:gallons] && @barrel.update_attribute(:gallons, params[:gallons]) || @barrel.update_attributes(params[:barrel]))
        format.html { redirect_to @barrel, notice: 'Barrel was successfully updated.' }
        format.json { head :no_content }
        
      else
        format.html { render action: "edit" }
        format.json { render json: @barrel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barrels/1
  # DELETE /barrels/1.json
  def destroy
    @barrel = Barrel.find(params[:id])
    @barrel.destroy
    respond_to :js

  end
end
