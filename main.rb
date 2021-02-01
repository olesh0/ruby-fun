require 'json'

store_file = "data/main.json"

file = File.read(store_file)
data = JSON.parse(file.to_s)

existing_todos = data["todos"]

puts "-------"

existing_todos.each {|todo|
  puts todo
}

puts "-------"

while true
  puts "What's your todo?"

  existing_todos.push(gets.to_s)

  puts "Want to stop [Yes/No]?"
  should_stop = gets.to_s.downcase

  # WHY THE HELL IT'S ALWAYS FALSE...

  if should_stop.strip == "yes"
    puts "Stopping..."
    break
  else
    puts "Let's keep going..."
  end
end

file_write = File.new(store_file, "w")
file_write.puts(JSON.generate({ todos: existing_todos }))
file_write.close
