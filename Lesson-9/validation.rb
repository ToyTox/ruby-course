module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send include, InstanceMethods
  end

  module ClassMethods
    def attrs
      @attrs ||= []
    end

    def validate(name, type, *args)
      attrs << {name: name, type: type, args: args}
    end
  end

  module InstanceMethods
  end
end