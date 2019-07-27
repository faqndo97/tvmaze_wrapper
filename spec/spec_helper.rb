# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
SimpleCov.add_filter 'spec/*'

require 'bundler/setup'
require 'tvmaze_wrapper'
require 'pry'


RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
