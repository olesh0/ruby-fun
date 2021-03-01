require 'json'
require './src/data' # TODO use load path instead
require './src/menu'


if __FILE__ == $0
  begin
    show_menu()
  rescue Interrupt => exception
    print "\nKeyboard interrupt... Stopping..."
  end
end
