#this file loads a big array, with a stupid but an easy tech ;)
bigfile = File.open "bigfile"
a = eval bigfile.gets
puts a.count
