#!/usr/bin/env ruby
require "json"

# read laundry care into instructions and warningd
instructions = []
warnings = []

json = File.read("laundry_care.json")
JSON.parse(json)["laundry_care_instructions"].map do |i|
    txt = i['instruction']
    txt.start_with?("Do Not") ? warnings << txt : instructions << txt
end

generator = Random.new

good_flare = []
File.open("good_flare.txt", "r").each_line{|l| good_flare << l}
bad_flare = []
File.open("bad_flare.txt", "r").each_line{|l| bad_flare << l}

ARMOUR = 4
CLOTH = 1
WOWHEAD = "http://www.wowhead.com/item="

tweet_file = File.open("index.txt", "w")
Dir.glob("corpus/*.json").entries.each do |f|
    begin
        if generator.rand(0..5) > 0
            care_text = instructions[generator.rand(0..instructions.length-1)]
            care_text += ": "
            care_text += good_flare[generator.rand(0..good_flare.length-1)]
        else
            care_text = warnings[generator.rand(0..warnings.length-1)]
            care_text += ": "
            care_text += bad_flare[generator.rand(0..bad_flare.length-1)]
        end

        item = JSON.parse(File.read(f))
        if (item['itemClass'] == ARMOUR && item['itemSubClass'] == CLOTH)

            name = "#{item['name']}\n"
            name += "#{care_text}"
            name += "#{WOWHEAD}#{File.basename(f, '.json')}\n\n"
            puts name
            tweet_file.write(name)
        end
    rescue
    end
end
