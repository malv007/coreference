#!/usr/bin/env ruby

require 'opener/daemons'

require_relative '../lib/opener/coreference'

daemon = Opener::Daemons::Daemon.new(Opener::Coreference)

daemon.start
