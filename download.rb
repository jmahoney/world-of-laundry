#!/usr/bin/env ruby
# download json files from the item api
# http://us.battle.net/api/wow/item/18802

require('open-uri')

ids = 30000..39999
url_base = "http://us.battle.net/api/wow/item/"

ids.each do |id|
    item_url = "#{url_base}#{id}"

    begin
        open(item_url) do |u|
            f = File.open("#{id}.json","w")
            u.each_line do |l|
                f.write(l)
            end
            f.close
            puts "#{id}"
        end
    rescue

    end

end
