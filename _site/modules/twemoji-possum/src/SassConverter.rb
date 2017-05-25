#######################################################
# CONVERT csv to importable scss variable
#######################################################

require 'csv'
require 'colored'

LIST_PATH = File.join(Dir.pwd, "tmp", "twemoji-unicode-pairs.csv")
COLLISIONS_PATH = File.join(Dir.pwd, "tmp", "COLLSIONS.csv")
OUTPUT_PATH = File.join(Dir.pwd, "dist", "emoji-map.scss")

$stdout.sync = true



#######################################################
# GENERATING the key value pairs
#######################################################

puts "generating one-to-one list"

entries = {}
collisions = {}

# reversing to where the names all point at the codepoint, this way
# the sass list-comprehension can still iterably generate css since
# its a 1-to-1 mapping this way
CSV.foreach(LIST_PATH) do |row|
  code_point = row[0]
  names = row.drop(1)

  # directly creating the string list that will be put to the file
  names.each do |key|
    if entries[key].nil?
      entries[key] = code_point
    else
      collisions[key] = [code_point] << entries[key]
    end
  end
end

rows = []

entries.each do |key, val|
  rows << "  \"#{key}\": \"#{val}\",\n"
end


# these strings are in arrays for easy concatenation
header = ["$emoji-map: (\n"]
footer = [");\n"]

output = header + rows + footer

puts "writing collisions..."
CSV.open(COLLISIONS_PATH, "wb") do |csv|
  collisions.each do |key, val|
    csv << [key, *val]
  end
end

if !collisions.empty?
  puts "there are key collisions in the emoji map, check tmp/COLLISIONS.csv and resolve otherwise sass won't compile twemoji-awesome".bold.red
end

puts "writing scss..."

File.open(OUTPUT_PATH, "w") do |file|
  file.puts output
end

puts "scss writing complete"

