FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y postgresql-client libnss3-dev nodejs

ENV APP_HOME /home/www/ruby_page_object_webinar

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

RUN mkdir /var/www

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock .ruby-version ./

RUN gem i bundler -v $(tail -1 Gemfile.lock | tr -d ' ')

RUN bundle check || bundle install

COPY . .

CMD bundle exec puma -C config/puma.rb
