#######################################################
# CUSTOM RULE MAPPING
# credit to Elle Kasai for mapping the values from
# emoji cheatsheet
#######################################################

require 'json'
require 'csv'

OUTPUT_PATH = File.join(Dir.pwd, "tmp", "custom-list.csv")
EMOJI_CHEAT_SHEET_PATH = File.join(Dir.pwd, "lib", "modified-cheat-sheet.json")
NULL_LIST_PATH = File.join(Dir.pwd, "lib", "null-list-rules.json")

$stdout.sync = true



#######################################################
# CALLING THE SCRAPE/MAP PROCESS, WRITING THE LIST
#######################################################

puts "generating custom code point list"

puts "loading elle kasai emoji cheatsheet list"
doc = File.read(EMOJI_CHEAT_SHEET_PATH)
custom_entries = JSON.parse(doc);

puts "loading null list"
doc2 = File.read(File.join(NULL_LIST_PATH))
null_entries = JSON.parse(doc2)

puts "list generated, writing csv"
CSV.open(OUTPUT_PATH, "wb") do |csv|
  custom_entries.each do |key, val|
    csv << [key, val]
  end
  null_entries.each do |key, val|
    csv << [key, *val]
  end
end

puts "csv writing complete"


