module Serializers
  def try_remove_const(const)
    Object.instance_eval { remove_const(const) } if Object.const_defined?(const)
  end
end
