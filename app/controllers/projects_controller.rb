class ProjectsController < ApplicationController

	def index
		@user = current_client || current_developer

		if params[:status]
			if current_client
				@projects = @user.projects.where(status: params[:status])
			else 
				@projects = @user.statuses.where(status: params[:status]).map(&:project)
			end
		else
			@projects = @user.projects
		end

	
	# @client.projects.each do |project|
		# 	@project_pending if project.status == 'Pending'
		# 	@project_in_progress if project.status == 'In Progress'
		# 	@project_completed if project.status == 'Completed'
		# 	@project_declined if project.status == 'Declined'
		# end

	end

	def new
		@client = Client.find params[:client_id]
		@project = @client.projects.new
	end

	def create
		@client = Client.find params[:client_id]
		skill = params['project'].delete('skills')
		language = params['project'].delete('languages')
		params['project']['status'] = 'Pending'
		@project = @client.projects.create project_params

		added_skills = skill.split(',').map(&:strip).uniq.map do |skill_name|
			Skill.find_or_create_by(name: skill_name)
		end
		added_languages = language.split(',').map(&:strip).uniq.map do |language_name|
			Language.find_or_create_by(name: language_name)
		end
		(@project.languages << added_languages).uniq
		(@project.skills << added_skills).uniq
		dev_array = @project.viable_developers
		dev_array.each do |developer|
			@project.developers << developer
		end
		redirect_to client_project_path(@client, @project)
	end

	def show
		if current_client 
			@client = Client.find params[:client_id]
			@project = @client.projects.find params[:id]
		elsif current_developer
			@developer = Developer.find params[:developer_id]
			@project = @developer.projects.find params[:id]
		end	
	end

	def edit
		if params[:client_id]
			@client = Client.find params[:client_id] 
		else
	 		@developer = Developer.find params[:developer_id]
	 	end
 		@project = Project.find params[:id]
 		@status = @project.statuses.find_by(developer: current_developer)
	end

	def update
		if current_developer
			@project = Project.find(params[:id])
			@status = @project.statuses.find_by(developer: current_developer)

			@status.status = params[:answer] if params[:answer]
			@status.update(status_params) if params[:status]

			@status.save
			if @status.status == 'declined'
				redirect_to developer_projects_path(current_developer)
			elsif params[:status]
				@project.status = "Pending Approval"
				@project.save
				redirect_to dashboard_path
			else 
				# redirect_to new_developer_quote_path(current_developer)
				# redirect_to '/*'
				redirect_to edit_developer_project_path(current_developer, @project)
			end

		elsif current_client
			@client = Client.find params[:client_id] 
			@project = @client.projects.find params[:id]

			skill = params['project'].delete('skills')
			language = params['project'].delete('languages')

	   		@project.update project_params

			added_skills = skill.split(',').map(&:strip).uniq.map do |skill_name|
				Skill.find_or_create_by(name: skill_name)
			end
			added_languages = language.split(',').map(&:strip).uniq.map do |language_name|
				Language.find_or_create_by(name: language_name)
			end
			@project.skills.clear and @project.languages.clear

			(@project.languages << added_languages).uniq
			(@project.skills << added_skills).uniq

			dev_array = @project.viable_developers
			dev_array.each do |developer|
				@project.developers << developer
			end
		
	   		redirect_to client_project_path(@client, @project)
		end
	end

	private
	def project_params
		params[:project].permit(:name, :deadline, :client_id, :developer_id, :budget, :projectIndustry, :skills, :description, :status, :timeframe, :workflow, :pitch, :cost)
	end

	def status_params
		params[:status].permit(:cost, :timeframe, :workflow, :pitch, :status)
	end
end
