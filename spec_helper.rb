# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.minimum_coverage 100
SimpleCov.start
require 'minitest/autorun'

require 'roda/plugins/cors'

ENV['RACK_ENV'] = 'test'


def dummy_app(&block)
  c = Class.new(Roda)
  c.class_eval(&block)
  c
end


def req(path = '/', env = {})
  if path.is_a?(Hash)
    env = path
  else
    env['PATH_INFO'] = path.dup
  end

  env = {
    'REQUEST_METHOD' => 'GET',
    'PATH_INFO' => '/',
    'SCRIPT_NAME' => '',
    'rack.input' => ''
  }.merge(env)
  app.call(env)
end
