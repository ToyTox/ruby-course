module InstanceCounter
  @@instance = 0
  @@register_instance = 0

  def instance
    @@instance += 1
    puts @@instance
  end

  protected
  def register_instance
    @@register_instance += 1
  end
end