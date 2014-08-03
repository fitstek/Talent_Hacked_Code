class ClientsController < ApplicationController
before_action :authenticate_client!

	def show
	    @client = Client.find params[:id] 
	    redirect_to '/' unless @client == current_client
	end

end
