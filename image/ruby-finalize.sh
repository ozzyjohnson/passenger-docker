#!/bin/bash
set -e
source /build/buildconfig
set -x

## This script is to be run after ruby1.9.sh, ruby2.0.sh and ruby2.1.sh.

cp /build/ruby-switch /usr/local/bin/ruby-switch
echo "gem: --no-ri --no-rdoc" > /etc/gemrc

## Fix shebang lines in rake and bundler so that they're run with the currently
## configured default Ruby instead of the Ruby they're installed with.
sed -i 's|/usr/bin/env ruby.*$|/usr/bin/env ruby|; s|/usr/bin/ruby.*$|/usr/bin/env ruby|' \
	/usr/local/bin/rake /usr/local/bin/bundle /usr/local/bin/bundler

## The Rails asset compiler requires a Javascript runtime.
minimal_apt_get_install nodejs

## Install development headers for native libraries that tend to be used often by Ruby gems.

## For nokogiri.
minimal_apt_get_install libxml2-dev libxslt1-dev
## For rmagick and minimagick.
minimal_apt_get_install imagemagick libmagickwand-dev
## For mysql and mysql2.
minimal_apt_get_install libmysqlclient-dev
## For sqlite3.
minimal_apt_get_install libsqlite3-dev
## For postgres and pg.
minimal_apt_get_install libpq-dev
## For capybara-webkit.
minimal_apt_get_install libqt4-webkit libqt4-dev
## For curb.
minimal_apt_get_install libcurl4-openssl-dev
## For all kinds of stuff.
minimal_apt_get_install zlib1g-dev

## Set the latest available Ruby as the default.
if [[ -e /usr/bin/ruby2.2 ]]; then
	ruby-switch --set ruby2.2
elif [[ -e /usr/bin/ruby2.1 ]]; then
	ruby-switch --set ruby2.1
elif [[ -e /usr/bin/ruby2.0 ]]; then
	ruby-switch --set ruby2.0
elif [[ -e /usr/bin/ruby1.9.1 ]]; then
	ruby-switch --set ruby1.9.1
fi
