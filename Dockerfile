# Use the appropriate Ruby image
FROM ruby:3.3.5

# Install necessary system dependencies, Node.js, and Yarn
RUN apt-get update -qq && apt-get install -y curl gnupg build-essential postgresql-client

# Install Node.js (use v16.x as an example)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Install Yarn globally
RUN npm install --global yarn

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies (gems)
RUN gem install bundler -v 2.5.20
RUN bundle install

# Copy the rest of the app source code
COPY . .

# Expose the port Rails will run on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
