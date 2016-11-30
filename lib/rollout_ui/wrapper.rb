module RolloutUi
  class Wrapper
    class NoRolloutInstance < StandardError; end

    attr_reader :rollout

    def initialize(rollout = nil)
      @rollout = rollout || RolloutUi.rollout
      raise NoRolloutInstance unless @rollout
    end

    def groups
      rollout.instance_variable_get("@groups").keys
    end

    def add_feature(feature)
      f = [*features, feature]
      redis.set("feature:__features__", f.join(","))

    end

    def remove_feature(feature)
      f = features
      f.delete(feature)
      redis.set("feature:__features__", f.join(","))
    end

    def features
      features = redis.get("feature:__features__") || ""
      features.split(",").sort
    end

    def redis
      rollout.instance_variable_get("@storage")
    end
  end
end
