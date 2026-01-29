module InstanceCounter
  @@instance = 0
  @@register_instance = 0

  def self.instance
    @@instance += 1
  end

  protected
  def self.register_instance
    @@register_instance += 1
  end
end