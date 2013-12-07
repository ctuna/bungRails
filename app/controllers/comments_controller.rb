class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    #TODO: make get a real barrel/spirit combo using params
    @spirit = Spirit.find(params[:spirit])
    print "#{@spirit.name}"
    @comments = @spirit.comments
    respond_to :js
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    @spirit = @comment.spirit
    @comments = @spirit.comments
    respond_to :js
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @spirit = Spirit.find(params[:spirit])
    @comment = @spirit.comments.create()
    
    respond_to :js
   
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    respond_to :js
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        @notice=""
        @notice= 'Comment was successfully created.' 
        respond_to :js
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.json { render json: @comment, status: :created, location: @comment }
      else
        respond_to :js
        #format.html { render action: "new" }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @spirit = @comment.spirit
    @comment.destroy
    @comments = @spirit.comments
    respond_to :js

  end
end
