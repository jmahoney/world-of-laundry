#!/usr/bin/env ruby
require "json"
# go through the corpus, find all the cloth items, put them in a text file

ARMOUR = 4
CLOTH = 1

instructions = JSON.parse(File.read("laundry_care.json"))["laundry_care_instructions"]

tweet_file = File.open("index.txt", "w")

Dir.glob("corpus/*.json").entries.each do |f|
    begin
        item = JSON.parse(File.read(f))
        if (item['itemClass'] == ARMOUR && item['itemSubClass'] == CLOTH)
            name = "#{item['name']}"
            tweet_file.write(name + "\n")
        end
    rescue
    end
end
