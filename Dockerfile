# Use the appropriate Ruby image
FROM ruby:3.3.5

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install
RUN gem install bundler -v 2.5.20
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
RUN npm install --global yarn

# Copy the rest of the app source code
COPY . .

# Expose the port Rails will run on
EXPOSE 3000

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

