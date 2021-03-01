require 'json'
require './src/data' # TODO use load path instead

if __FILE__ == $0
  list_todos()
  ask_todos()
end
