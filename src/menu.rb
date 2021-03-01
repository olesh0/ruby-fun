require 'terminal-menu'
require './src/todo_actions'

DEFAULT_MENU_WIDTH = 80
DEFAULT_FOREGROUND = '#000'
DEFAULT_BACKGROUND = 'transparent'


def show_todo_actions(todos_list = [], todo_index = nil)
  if !todo_index
    puts "No todo index specified..."
    return
  end

  todo_actions = [
    { 'label' => '< Back...', 'handler' => method(:show_todos), 'no_args' => true },
    { 'label' => 'Delete', 'handler' => method(:delete_todo) },
    { 'label' => 'Edit', 'handler' => method(:edit_todo) },
  ]

  selected_todo = todos_list[todo_index]

  actions = TerminalMenu.new(
    title: "What you wanna do with this todo? [#{selected_todo}]",
    width: DEFAULT_MENU_WIDTH,
    fg: DEFAULT_FOREGROUND,
    bg: DEFAULT_BACKGROUND,
  ) do |selected|
    actions.quit
  end

  todo_actions.each_with_index do |action, index|
    actions.add(action['label']) do
      selected_action = todo_actions[index]

      if action['handler']
        if action['no_args']
          action['handler'].()
        else
          action['handler'].(selected_todo)
        end
      else
        puts "No handler for \"#{action['label']}\""
      end
    end
  end

  actions.show
end


def show_todos
  todos_list = get_todos_list

  todos = TerminalMenu.new(
    title: 'Choose an option...',
    description: '',
    width: DEFAULT_MENU_WIDTH,
    fg: DEFAULT_FOREGROUND,
    bg: DEFAULT_BACKGROUND,
  ) do |selected|
    todos.quit
  end

  todos.add('< Back...') do
    show_menu
  end

  todos_list.each_with_index do |todo, todo_index|
    todos.add(todo) do |selected|
      show_todo_actions(todos_list, todo_index)
    end
  end

  todos.show
end


def add_todo
  print "Name of your todo: "

  todo_name = gets.chomp

  if !todo_name
    return add_todo
  end

  user_todos = get_todos_list
  user_todos.push(todo_name)
  update_list(user_todos)

  show_todos
end


def show_menu
  options = [
    {
      'label' => '+ Add todo',
      'name' => 'add_todo',
      'handler' => method(:add_todo),
    },
    {
      'label' => 'Show todos',
      'name' => 'show_todos',
      'handler' => method(:show_todos),
    },
  ]

  menu = TerminalMenu.new(
    title: 'Choose an option...',
    description: '',
    width: DEFAULT_MENU_WIDTH,
    fg: DEFAULT_FOREGROUND,
    bg: DEFAULT_BACKGROUND,
  ) do |selected|
    menu.quit
  end

  options.each_with_index do |option, index|
    menu.add(option['label']) do |selected|
      handle_chosen_option(options[index])
    end
  end

  menu.show
end


def handle_chosen_option(option)
  handler = option['handler']

  if handler
    handler.()
  else
    puts "Handler was not specified for '#{option['name']}' option"
  end
end
