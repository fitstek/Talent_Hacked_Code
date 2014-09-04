Introduction:
=============

Talent Hacked is a final project undertaken during the last two weeks of Makers Academy's 12 week developer programme.

More importantly it is a business venture that Josh Fail-Brown, a makers graduate, is pursuing after the course. Members in the final project team (specified below) have each contributed to bring this application to life.

Talent Hacked is a business venture aimed to lean into the incredible talent emerging from academies like Makers along with the growing demand for developers within the city of London.

The aim of the Talent-Hacked, and therefore this application, is to act as a project management business, connecting developers that have the right skills to clients with project demands.


Application:
============

- The application allows developers and businesses/clients to resigter online

- Developers are able to:
	- Update their professional profile and contact details manually
	- Alternatively they can choose to sign-in with and import their LinkedIn profile
	- Manage their work through a customized dashboard consisting of offers, current, declined and 	finished projects
	- Receive incoming offers, allowing for specified project quotes and accept or reject capabilities 

- Clients are able to:
	- Update their business profile
	- Create new development projects
	- Send offers to developers

- The application macthes the most appropriate developers based on their skill set with a client's unique demands.

Technologies:
============
Ruby (version 2.1.1)
Rails
Postgresql
Capybara
Rspec
Devise
Paperclip
Poltergeist
Amazon Web Services S3
Bootstrap
Heroku
Javascript

Gems used:
=============
devise
omniauth-linkedin-oauth2
bootstrap-sass
font-awesome-rails
gritter
paperclip
rmagick
aws-sdk
thin
activeadmin
polyamorous
ransack
formtastic
rspec-rails
capybara
rspec-collection_matchers
database_cleaner
poltergeist
byebug
launchy

Heroku
======
http://talent-hacked.herokuapp.com/

How to run the program:
======================

- git clone https://github.com/JoshFB/Talent_Hacked_Code
- cd Talent_Hacked_Code
- bundle install
- bin/rake db:create
- bin/rake db:migrate 
- bin/rake db:migrate RAILS_ENV=test
- thin start


How to run tests:
================
- cd Talent_Hacked_Code
- rspec

Authors:
==============
Josh Fail-Brown			https://github.com/JoshFB/
Kate Hamilton				https://github.com/katehamilton247
Nadav Matalon	 			https://github.com/nadavmatalon
Will Allen		 			https://github.com/painted
Fitsum Teklehaimanot		https://github.com/fitstek
Faezrah Rizalman 			https://github.com/frism
Johann Bornman				https://github.com/jchb9
