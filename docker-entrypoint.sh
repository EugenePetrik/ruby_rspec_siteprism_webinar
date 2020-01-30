#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f ruby_page_object_webinar/tmp/pids/server.pid
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:test:populate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"