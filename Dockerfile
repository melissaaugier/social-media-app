FROM ruby:3.3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn git

# Set the working directory
WORKDIR /social_media_app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add Yarn repository and install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Install Node.js packages
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the application code
COPY . .

# Configure Sprockets to look for assets in node_modules
RUN echo 'Rails.application.config.assets.paths << Rails.root.join("node_modules")' >> config/initializers/assets.rb

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
