#!/bin/bash
set -e
source /build/buildconfig
set -x

minimal_apt_get_install ruby2.2 ruby2.2-dev
gem2.2 install rake bundler --no-rdoc --no-ri
/build/ruby-finalize.sh
