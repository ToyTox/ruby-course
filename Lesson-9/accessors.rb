module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"
        history_var = "#{name}_history"
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=") do |value|
          history = innstance_variable_get(history_var) || []
          history << value
          instance_variable_set(vistory_var, history)
          instance_variable_set(var_name, value)
        end


        define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
      end
    end

    def strong_attr_accessor
    end
  end
end
