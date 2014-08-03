class ContactsController < ApplicationController

	def index
		@client = Client.find params[:client_id]
		@contact = @client.contacts.all
	end

	def new
		@client = Client.find params[:client_id]
		@contact = @client.contacts.new
	end

	def create
		@client = Client.find params[:client_id]
		@contact = @client.contacts.create contact_params
		redirect_to "/clients/#{params[:client_id]}"
	end

	def edit
   		@client = Client.find params[:client_id] 
   		@contact = @client.contacts.find params[:id]
  	end

  	def update
   		@client = Client.find params[:client_id] 
   		@contact = @client.contacts.find params[:id]
   		@contact.update contact_params
   		redirect_to "/clients/#{params[:client_id]}"
  	end

	private
	def contact_params
		params[:contact].permit(:name, :email, :phone, :website)
	end
end
