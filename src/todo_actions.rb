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
  puts "editing...", todo

  show_todos

  return nil
end