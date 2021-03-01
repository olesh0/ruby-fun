require './src/data'
require './src/main'

def delete_todo(todo_to_delete)
  todos_list = get_todos_list
  updated_todos = []

  todos_list.each do |todo|
    # dummy delete (more like filtering)
    if todo != todo_to_delete
      updated_todos.push(todo)
    end
  end

  update_list(updated_todos)
  show_todos

  return nil
end


def edit_todo(todo)
  print "New name for '#{todo}': "
  new_todo_name = gets.chomp
  user_todos = get_todos_list
  updated_list = []

  user_todos.each do |todo_name|
    if todo_name == todo
      updated_list.push(new_todo_name)
    else
      updated_list.push(todo_name)
    end
  end

  update_list(updated_list)

  show_todos

  return nil
end