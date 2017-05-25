#######################################################
# UNICODE SCRAPER: return code point : name
# pairs from the authoritative emoji list at
# http://unicode.org/emoji/charts/full-emoji-list.html
#######################################################

require 'nokogiri'
require 'open-uri'
require 'csv'

URL =  "http://unicode.org/emoji/charts/full-emoji-list.html"
OUTPUT_PATH = File.join(Dir.pwd, "tmp", "full-emoji-list.csv")

# this will be called from a rake task primarily, so the stdout
# buffer needs to make it through to the caller's context
$stdout.sync = true



#######################################################
# FUNCTIONS: for process legibility
#######################################################

def codeOf node
  node.css("td.code a")[0]
    .attributes["name"]
    .value
    .gsub("_", "-")
end

def nameOf node
  name = node.css("td.name")[0]
    .children
    .text
    .downcase
    .strip
    .gsub(/\s+/, "-")
    .gsub(/,/, "")
    .gsub(/:/, "")
    .gsub("!", "exc")
    .gsub("'", "")
    .gsub("’", "")
    .gsub(/å|ã/, "a")
    .gsub(/é/, "e")
    .gsub(/í/, "i")
    .gsub(/ô/, "o")

  { node: node, name: name }
end

def swapBackwardsFlagName name
  if name.match("flag")
    n_array = name.split("-")
    n_array
      .insert(-1, n_array.delete_at(n_array.index("flag"))) # moves flag to the end
      .join("-")
  else
    name
  end
end

def flagNameOf node
  name = node.css("td.name")[1]
    .children
    .css("a")
    .children
    .map {|child| child.text.downcase.strip }
    .join("-")
    .gsub(/\s+/, "-")
    .gsub(/,/, "")
    .gsub("!", "exc")
    .gsub("'", "")
    .gsub("’", "")
    .gsub(/å|ã/, "a")
    .gsub(/é/, "e")
    .gsub(/í/, "i")
    .gsub(/ô/, "o")

  swapBackwardsFlagName name
end

def substForFlag obj
  str = obj[:name]
  # upon writing, all flag names were designated as "regional indicator"
  name = str.include?("regional-indicator-symbol") ? flagNameOf(obj[:node]) : str

  { node: obj[:node], name: name }
end

def substituteEquivalent obj
  str = obj[:name]
  # some of the clunkier names have an ≊ moniker for a simpler name
  name = str.include?("≊") ? str.split("≊")[1].strip.sub(/^-/, '') : str

  { node: obj[:node], name: name }
end



#######################################################
# ANONYMOUS FXNS: for call-chaining legibility
#######################################################

# this removes the "th" rows from the scrape because they don't
# have any important info
withoutHeaders = lambda { |node| node.child.name != "th" }

# this creates the mapping pairs by chaining the methods in the
# FUNCTIONS subheading
codeToName = lambda do |node|
  code_point = codeOf node
  human_name = (substForFlag substituteEquivalent nameOf node)[:name]

  [ code_point, human_name ]
end



#######################################################
# CALLING THE SCRAPE/MAP PROCESS, WRITING THE LIST
#######################################################

puts "generating unicode hex code point to human readable names list"

puts "loading full emoji list"
doc = Nokogiri::HTML(open(URL))

puts "emoji list loaded, converting to map"
emoji_entries = doc
  .css("tr")
  .select(&withoutHeaders)
  .map(&codeToName)

puts "map generated, writing csv"
CSV.open(OUTPUT_PATH, "wb") do |csv|
  emoji_entries.each do |entry|
    csv << entry
  end
end

puts "csv writing complete"

