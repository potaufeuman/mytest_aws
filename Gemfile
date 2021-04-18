source 'https://rubygems.org'

gem 'rails',        '5.2.5'
gem 'bcrypt',       '3.1.12'
gem 'faker'         
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass', '3.3.7'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'ransack'
gem 'rails-i18n'
gem 'pg', '0.20.0'

group :development, :test do
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'spring-commands-rspec'
  gem 'rails-controller-testing'
  gem 'rubocop'
  gem 'bullet'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

# https://qiita.com/fuqda/items/61e6b39d43733cd19802
# https://qiita.com/IrieLuka/items/eba8693272c31d6af7f0
group :test do
  gem 'minitest',                 '5.10.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara' #Rails5.1以後ではもとから入っているが、一応インストール
  gem 'database_cleaner'
  gem 'launchy'
  gem "selenium-webdriver"
  gem 'shoulda-matchers'
    # git: 'https://github.com/thoughtbot/shoulda-matchers.git',
    # branch: 'rails-5'
end

group :production do
  # gem 'pg', '0.20.0'
  gem 'fog', '1.42'
  gem 'unicorn', '5.4.1'
end
