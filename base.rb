git :init

# # Delete unnecessary files
run "rm public/index.html"
run "rm public/favicon.ico"
run "rm public/rails.png"
run "echo 'TODO add readme content' > README"
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/database.example"
# 
# # Make .gitignore file
file ".gitignore", <<-END
log/*.log
tmp/**/*
.DS_Store
config/database.yml
public/system/*
END
# 

plugin 'exception_notifier', :git => 'git://github.com/rails/exception_notification.git'
plugin 'role_requirement', :git => 'git://github.com/timcharper/role_requirement.git'
plugin 'deployment_recipiez', :git => 'git://github.com/pyrat/deployment_recipiez.git'

# 
gem 'RedCloth', :lib => 'redcloth'
gem 'mislav-will-paginate'
gem 'haml'
gem 'thoughtbot-shoulda'
gem 'rubyist-fakeweb'
gem 'thoughtbot-paperclip'
gem 'thoughtbot-clearance'
# 
rake("gems:install")
rake("gems:unpack")
# 

# 
# #  Initializers
# 
initializer 'session_store.rb', <<-END
  ActionController::Base.session = { :session_key => '_#{(1..6).map { |x| (65 + rand(26)).chr }.join}_session', :secret => '#{(1..40).map { |x| (65 + rand(26)).chr }.join}' }
  ActionController::Base.session_store = :active_record_store
  END
# 
initializer 'time_formats.rb',
%q{# Example time formats
  { :short_date => "%x", :long_date => "%a, %b %d, %Y" }.each do |k, v|
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(k => v)
  end
  }
# 
# 
git :add => ".", :commit => "-m 'initial commit'"
