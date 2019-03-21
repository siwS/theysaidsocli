class Category

  attr_accessor :key, :description

  def initialize(key, description)
    @key = key
    @description = description
  end

  def to_s
    "#{@key}: '#{@description}'"
  end

end