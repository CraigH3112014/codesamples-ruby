require 'bundler/setup'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end


Bundler.require :default, :test
PayPal::SDK::Core::Config.load('spec/config/paypal.yml', 'test')

$LOAD_PATH.push(File.expand_path("../..", __FILE__))