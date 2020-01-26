FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y postgresql-client libnss3-dev

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/ruby_page_object_webinar

RUN useradd -m -d $APP_USER_HOME $APP_USER

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

RUN mkdir /var/www && \
   chown -R $APP_USER:$APP_USER /var/www && \
   chown -R $APP_USER $APP_USER_HOME

WORKDIR $APP_HOME

USER $APP_USER

COPY Gemfile Gemfile.lock .ruby-version ./

RUN gem i bundler -v $(tail -1 Gemfile.lock | tr -d ' ')

RUN bundle check || bundle install

COPY . .

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

CMD bundle exec puma -C config/puma.rb
