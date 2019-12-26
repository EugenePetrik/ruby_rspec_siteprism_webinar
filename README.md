## This project has been prepared for the webinar.
## We use the following tools, such as **Ruby**, **Capybara**, **SitePrism**, and **RSpec**.

#### Install Postgres for Ubuntu

[Setup Postgres for Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04)

#### Install Postgres for Mac

[Setup Postgres for Mac](https://www.codementor.io/@engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb)

#### Install Chromedriver on Ubuntu

```shell
wget -N http://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip -P ~/
```

```shell
unzip ~/chromedriver_linux64.zip -d ~/
```

```shell
rm ~/chromedriver_linux64.zip
```

```shell
sudo mv -f ~/chromedriver /usr/local/bin/chromedriver
```

```shell
sudo chown root:root /usr/local/bin/chromedriver
```

```shell
sudo chmod 0755 /usr/local/bin/chromedriver
```

#### Install Chromedriver on Mac via Homebrew

```shell
brew cask install chromedriver
```

#### Install Geckodriver on Ubuntu

```shell
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
```

```shell
sudo sh -c 'tar -x geckodriver -zf geckodriver-v0.26.0-linux64.tar.gz -O > /usr/bin/geckodriver'
```

```shell
sudo chmod +x /usr/bin/geckodriver
```

```shell
rm geckodriver-v0.26.0-linux64.tar.gz
```

#### Install Geckodriver on Mac via Homebrew

```shell
brew install geckodriver
```

#### Install rvm Ubuntu

[Ubuntu rvm](https://github.com/rvm/ubuntu_rvm)

#### Install rvm Mac

[Mac rvm](https://null-byte.wonderhowto.com/how-to/mac-for-hackers-install-rvm-maintain-ruby-environments-macos-0174401/)

#### Install Ruby 2.6.5

```shell
rvm install 2.6.5
```

```shell
rvm --default use 2.6.5
```

```shell
rvm list
```

```shell
ruby -v
```

#### Install bundler

```shell
gem install bundler
```

#### Install gems

```shell
bundle install
```

#### Create database (will create an empty database for the current environment)

```shell
rails db:create
```

#### Run migrations (runs migrations for the current environment and create db/schema.rb file)

```shell
rails db:migrate
```

```shell
Test User -> test@test.com / 123456
```

#### Seeds database with fake data

```shell
rails db:test:populate
```
#### Run Rubocop

```shell
rubocop
```

#### Run Rubocop with auto refactoring

```shell
rubocop -a
```

#### Setup RSpec

```shell
rails generate rspec:install
```

#### Run all spec files

```shell
rspec
```

#### Run all spec files in a single directory

```shell
rspec spec/feature
```

#### Run a single spec file

```shell
rspec spec/feature/welcome_page_spec.rb
```

#### Run a single example from a spec file (by line number)

```shell
rspec spec/feature/key_presses_spec.rb:18
```

#### Run all spec files with the 'smoke' tag

```shell
rspec spec/feature/tags_spec.rb --tag smoke
```

#### Useful links

[Site Prism](https://github.com/site-prism/site_prism)

[Capybara Cheatsheet](https://gist.github.com/tomas-stefano/6652111)

[Ruby Capybara With Selenium Cheat Sheat](https://blog.morizyun.com/blog/capybara-selenium-webdriver-ruby/index.html)

[Rubocop Tests Naming](https://github.com/rubocop-hq/rspec-style-guide#naming)
