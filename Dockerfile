FROM ruby:2.6

# libnss3-dev is necessary to install google-chrome & run chromedriver-helper
RUN apt-get update -qq && apt-get install -y postgresql-client libnss3-dev

# Install the newest version of NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Install google-chrome for debian
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

RUN mkdir /ruby_page_object_webinar
WORKDIR /ruby_page_object_webinar
COPY Gemfile /ruby_page_object_webinar/Gemfile
COPY Gemfile.lock /ruby_page_object_webinar/Gemfile.lock
RUN bundle install
COPY . /ruby_page_object_webinar

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]