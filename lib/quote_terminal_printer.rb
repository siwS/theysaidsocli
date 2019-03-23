require 'hirb'

class QuoteTerminalPrinter

  def initialize(quote)
    @quote = quote
    @print_text = "#{@quote.author} said: \"#{@quote.quote}\""
    @width = @print_text.size
  end

  def print
    puts
    print_separator
    print_quote
    print_separator
    puts
  end

  private

  def print_quote
    puts "~ #{@print_text} ~"
  end

  def print_separator
    puts "*" * separator_width
  end

  def separator_width
    [@width + 4, terminal_width].min
  end

  def terminal_width
    Hirb::Util.detect_terminal_size[0]
  end

end