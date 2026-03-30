module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attrs
      @attrs ||= []
    end

    def validate(name, type, **options)
      attrs << name
    end

    def run_validate
      self.class.attrs.each { |attr| send(attr) }
    end
  end
end