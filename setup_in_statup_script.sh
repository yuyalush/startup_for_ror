#!/bin/sh
# pwd => /
# whoami => root

cd /root
echo "START!!!!"
date
apt-get install -y build-essential libssl-dev openssl libreadline6 libreadline6-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion git-core
echo "apt-get finished."
date

#ruby1.9.2
echo "TITLE:Ruby start."
date
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p290.tar.gz
tar zxvf ruby-1.9.2-p290.tar.gz
cd ruby-1.9.2-p290
./configure
make -j
make install
echo "TITLE:Ruby finished."
date

#Rails
echo "TITLE:Rails start"
date
echo "gem: --no-ri --no-rdoc" > /root/.gemrc
cd ..
sudo gem update --system
sudo gem update rake
sudo gem install rails -v=3.0.9
echo "TITLE:Rails finished"
date

# Sqlite3
echo "TITLE:Sqlite3 start."
date
wget http://www.sqlite.org/sqlite-autoconf-3070701.tar.gz
tar zxf sqlite-autoconf-3070701.tar.gz
cd sqlite-autoconf-3070701/
./configure
make -j
make install
cd ..
gem install sqlite3-ruby
gem install sqlite3
echo "TITLE:Sqlite3 finished."
date

# Check
echo "TITLE:ruby & rails check"
ruby -v
rails -v

# Test Rails App
sudo rails new testapp --skip-bundle
cd testapp
#echo "gem 'therubyracer'" >> Gemfile
echo "gem 'unicorn'" >> Gemfile
echo "gem 'nifty-generators'" >> Gemfile
echo "gem 'mocha'" >> Gemfile
sudo bundle install
sudo rails g nifty:scaffold Book title:string price:integer
sudo rails g nifty:layout -f
sudo rake db:migrate
sudo bundle exec unicorn_rails -D

echo "TITLE:ufw setting"
ufw allow 8080

echo "TITLE:Finish!!!!!"
date

# Please Access http:// global-ip :8080/books/
