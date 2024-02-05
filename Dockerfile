# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Create a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

# Switch to the non-root user
USER rails:rails

# Copy application code
COPY . .

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Finalize the image
EXPOSE 3000
CMD ["./bin/rails", "server"]
