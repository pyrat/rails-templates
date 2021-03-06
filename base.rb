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
gem 'mislav-will_paginate', :lib => "will_paginate", :source => "http://gems.github.com"
gem 'haml'
gem 'rubyist-fakeweb', :lib => "fakeweb", :source => "http://gems.github.com"
gem 'thoughtbot-shoulda', :lib => "shoulda", :source => "http://gems.github.com"
gem 'thoughtbot-paperclip', :lib => "paperclip", :source => "http://gems.github.com"
gem 'thoughtbot-clearance', :lib => "clearance", :source => "http://gems.github.com"
gem 'thoughtbot-factory_girl', :lib => "factory_girl", :source => "http://gems.github.com"

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
git :add => ".", :commit => "-m 'initial commit'"
