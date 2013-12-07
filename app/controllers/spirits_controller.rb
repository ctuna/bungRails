class SpiritsController < ApplicationController
  # GET /spirits
  # GET /spirits.json
  def index
    @spirits = Spirit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spirits }
    end
  end

  # GET /spirits/1
  # GET /spirits/1.json
  def show
    @spirit = Spirit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spirit }
    end
  end

  # GET /spirits/new
  # GET /spirits/new.json
  def new
    @barrel = Barrel.find(params[:barrel])

    @spirit = @barrel.spirits.create()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spirit }
    end
  end

  # GET /spirits/1/edit
  def edit
    @spirit = Spirit.find(params[:id])
  end

  # POST /spirits
  # POST /spirits.json
  def create
    @spirit = Spirit.new(params[:spirit])

    respond_to do |format|
      if @spirit.save
        format.html { redirect_to @spirit, notice: 'Spirit was successfully created.' }
        format.json { render json: @spirit, status: :created, location: @spirit }
      else
        format.html { render action: "new" }
        format.json { render json: @spirit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spirits/1
  # PUT /spirits/1.json
  def update
    @spirit = Spirit.find(params[:id])

    respond_to do |format|
      if @spirit.update_attributes(params[:spirit])
        format.html { redirect_to @spirit, notice: 'Spirit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @spirit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spirits/1
  # DELETE /spirits/1.json
  def destroy
    @spirit = Spirit.find(params[:id])
    @spirit.destroy

    respond_to do |format|
      format.html { redirect_to spirits_url }
      format.json { head :no_content }
    end
  end
end
