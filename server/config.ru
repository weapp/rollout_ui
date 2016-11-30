# # require "rollout_ui"
require 'bundler'
Bundler.setup(:default)
Bundler.require

redis = Redis.new
rollout = Rollout.new(redis)
RolloutUi.wrap(rollout)

run Rack::URLMap.new "/" => RolloutUi::Server.new

