module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr_name, validate_type, **attrs)
      def attrs
        @attrs ||= []
      end

      def validate(checks)
        attrs << checks
      end

      def run_validate
        self.class.attrs.each { |attr| send(attr) }
      end
      # ToDo write validate method
    end
  end
end