class EntriesController < BaseController
  require 'mechanize'
  before_action :set_entry, only: [:show, :edit, :update, :destroy, :me]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all.order('updated_at DESC')
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    if current_user
      @entry = Entry.new
    else
      redirect_to root_path
    end
  end

  # GET /entries/1/edit
  def edit
    # ログインしていない場合リダイレクト
    unless current_user
      redirect_to root_path
    end
    # 自分のエントリ以外は不正なのでリダイレクト
    unless @entry.user_id == session[:user_id]
      flash[:error] = "不正なデータです"
      redirect_to root_path
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params[:entry][:user_id] = session[:user_id]
      params.require(:entry).permit(:user_id, :url, :title, :comment, :category)
    end
end
