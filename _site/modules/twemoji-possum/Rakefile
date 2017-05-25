require 'open4'
require 'colored'

def runTask scriptPath
  Open4.popen4("ruby #{File.join(Dir.pwd, "src", scriptPath)}") do |pid, stdin, stdout, stderr|
    stdout.each { |line| puts line }
    stderr.each { |line| puts line }
  end
end

desc "run all transforms in sequence"
task default: [:map_unicode, :map_twemoji, :custom_rules, :combine_maps, :convert_to_scss, :generate_master_groups]

desc 'map unicode from source'
task :map_unicode do
  puts "\n"
  puts "Creating Unicode Map".bold.yellow
  puts "\n"
  runTask("UnicodeMapper.rb");
  puts "\n"
  puts "Generated map of Unicode 'code point' : 'human name'".bold.green
end

desc "map twemoji from source"
task :map_twemoji do
  puts "\n"
  puts "Creating Twemoji Map".bold.yellow
  puts "\n"
  runTask("TwemojiMapper.rb")
  puts "\n"
  puts "Generated list of Twemoji code points".bold.green
end

desc "apply custom rules from Elle Kasai (emoji cheat sheet) and twitter custom icons"
task :custom_rules do
  puts "\n"
  puts "Creating Custom Map".bold.yellow
  puts "\n"
  runTask("CustomMapper.rb")
  puts "\n"
  puts "Generated map of Custom 'code point' : 'human name'".bold.green
end

desc "combine twemoji and unicode maps"
task :combine_maps do
  puts "\n"
  puts "Combining Maps".bold.yellow
  puts "\n"
  runTask("CombineMapper.rb")
  puts "\n"
  puts "Generated map of Twemoji 'code point' : 'human name' and lists of unused values".bold.green
end

desc "convert matched twemoji pairs to importable sass"
task :convert_to_scss do
  puts "\n"
  puts "Converting to Sass".bold.yellow
  puts "\n"
  runTask("SassConverter.rb")
  puts "\n"
  puts "Generated Sass variable map for twemoji-awesome in dist directory".bold.green
end

desc "generate a limited master list of code points to Mac OS X groupings"
task :generate_master_groups do
  puts "\n"
  puts "Generating Master Groups".bold.yellow
  puts "\n"
  runTask("MasterGroupList.rb")
  puts "\n"
  puts "Generated 'code point' : 'group name' json in dist directory".bold.green
end

