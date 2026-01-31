module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstanceMethonds)
  end

  module ClassMethods
    def instance
      @instance ||= 0
    end

    def instance=(value)
      @instance = value
    end
  end

  module InstanceMethonds
    protected
    
    def register_instance
      self.class.instance += 1
    end
  end
end