DATA_STORE_FILE = './data/main.json'

def get_todos_list()
  file = File.read(DATA_STORE_FILE)
  data = JSON.parse(file)

  return data['todos']
end


def update_list(existing_todos = [])
  puts existing_todos

  file_write = File.new(DATA_STORE_FILE, 'w')
  current_time = Time.new

  data = {
    'todos' => existing_todos,
    'last_updated': current_time,
  }

  file_write.puts(JSON.pretty_generate data)
  file_write.close

  return existing_todos
end


def list_todos()
  existing_todos = get_todos_list

  if existing_todos.length > 0
    puts '====================='

    existing_todos.each_with_index {|todo, index|
      puts "#{index}. #{todo}"
    }

    puts '====================='
  else
    puts "You don't have anything to do..."
  end
end


def ask_todos()
  existing_todos = get_todos_list

  while true
    puts "What's your todo?"

    existing_todos.push(gets.strip)

    puts "Want to stop [y/N]?"
    should_stop = gets.strip.downcase

    if should_stop == "y"
      puts "Stopping..."
      break
    end
  end

  update_list(existing_todos)
end
