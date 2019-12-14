source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'aasm', '4.9'
gem 'api-pagination', '~> 4.8.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'kaminari', '~> 1.1.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'

group :development, :test do
  gem 'byebug', '~> 11.0.1'
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'pry', '~> 0.12.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 3.9'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
