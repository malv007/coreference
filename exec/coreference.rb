#!/usr/bin/env ruby

require 'opener/daemons'
require_relative '../lib/opener/coreference'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon  = Opener::Daemons::Daemon.new(Opener::Coreference, options)

daemon.start