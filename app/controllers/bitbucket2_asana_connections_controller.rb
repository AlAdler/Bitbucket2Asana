class Bitbucket2AsanaConnectionsController < ApplicationController
  before_action :set_bitbucket2_asana_connection, only: [:show, :destroy]

  def index
    redirect_to new_bitbucket2_asana_connection_path 
  end

  # GET /bitbucket2_asana_connections/1
  def show
  end

  # GET /bitbucket2_asana_connections/new
  def new
    @bitbucket2_asana_connection = Bitbucket2AsanaConnection.new
  end

  # POST /bitbucket2_asana_connections
  def create
    @bitbucket2_asana_connection = Bitbucket2AsanaConnection.find_by_asana_api_key(bitbucket2_asana_connection_params[:asana_api_key])
    unless @bitbucket2_asana_connection.nil?
      respond_to do |format|
        format.html { redirect_to @bitbucket2_asana_connection, notice: 'Bitbucket2 asana connection already exists.' }
      end
      return
    end
    code = SecureRandom.hex(12)
    @bitbucket2_asana_connection = Bitbucket2AsanaConnection.new(asana_api_key: bitbucket2_asana_connection_params[:asana_api_key], b2a_code: code)
    
    respond_to do |format|
      if @bitbucket2_asana_connection.save
        format.html { redirect_to @bitbucket2_asana_connection, notice: 'Bitbucket2 asana connection was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /bitbucket2_asana_connections/1
  # DELETE /bitbucket2_asana_connections/1.json
  def destroy
    @bitbucket2_asana_connection.destroy
    respond_to do |format|
      format.html { redirect_to new_bitbucket2_asana_connection_path, notice: 'Bitbucket2 asana connection was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bitbucket2_asana_connection
      @bitbucket2_asana_connection = Bitbucket2AsanaConnection.find_by_asana_api_key(params[:id])
      raise ActionController::RoutingError.new('Not Found') if @bitbucket2_asana_connection.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bitbucket2_asana_connection_params
      params.require(:bitbucket2_asana_connection).permit(:b2a_code, :asana_api_key)
    end
end
