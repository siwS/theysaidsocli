class Quote

  attr_accessor :author, :quote, :length, :tags, :category, :date

  def initialize(quote_hash)
    @author = quote_hash[:author]
    @quote = quote_hash[:quote]
    @length = quote_hash[:length]
    @tags = quote_hash[:tags]
    @category = quote_hash[:category]
    @date = quote_hash[:date]
  end


end