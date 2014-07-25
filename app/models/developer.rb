class Developer < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/images/:style/missing.png"

  validates_attachment_size :image, :in => 0.megabytes..1.megabytes


	# has_attached_file :image, 
	#     styles: { thumb: '300x300>' },
	#     storage: :s3,
	#     s3_credentials: {
	#       bucket: 'instagram_may_alex',
	#       access_key_id: Rails.application.secrets.s3_access_key,
	#       secret_access_key: Rails.application.secrets.s3_secret_key
	#     }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


	def self.from_omniauth(auth)
	  # puts auth.inspect
	  where(auth.slice(:provider, :uid)).first_or_create do |developer|
	  	# byebug
	    developer.email = auth.info.email
	    developer.password = Devise.friendly_token[0,20]
	    developer.name = auth.extra.raw_info.formattedName
	    developer.avatarUrl = auth.extra.raw_info.pictureUrl 
	    developer.linkedinPublicUrl = auth.extra.raw_info.publicProfileUrl
	    developer.address = auth.extra.raw_info.mainAddress
	    if auth.extra.raw_info.dateOfBirth
	    	dob = auth.extra.raw_info.dateOfBirth
		    developer.dob = Date.new(dob[:year], dob[:month], dob[:day])
	    end
	    developer.twitter = auth.extra.raw_info.primaryTwitterAccount
	    # developer.languages = auth.extra.raw_info.languages 
	    # developer.skills = auth.extra.raw_info.skills
	    # developer.phone = auth.info.phone-numbers   ## don't uncomment without finding currect source - this one is buggy and will crash the app
	    # developer.certifications = auth.info.certifications
	    # developer.educations = auth.info.educations
	    # developer.courses = auth.info.courses
	  end
	end
end

     
