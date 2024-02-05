# Use an official Ruby runtime as a base image
FROM ruby:3.1.2-slim as base

# Set environment variables
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development

# Set the working directory in the container
WORKDIR /rails

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Create a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

# Switch to the non-root user
USER rails:rails

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install

# Copy the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Set the default command to run the Rails server
CMD ["./bin/rails", "server"]
