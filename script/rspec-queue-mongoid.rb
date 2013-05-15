#!/usr/bin/env ruby
require 'bundler'
Bundler.setup(:default, :development, :test)
require 'test_queue'
require 'test_queue/runner/rspec'


class MongoidRspecRunner < TestQueue::Runner::RSpec
  def after_fork(num)
    super
    Mongoid.master = Mongoid.master.connection.db(Mongoid.master.name + "_#{num}")
  end
end

MongoidRspecRunner.new.execute
