require './item'
require './gilded_rose'

items = []
items.push Item.new "+5 Dexterity Vest",10,20
items.push Item.new "Aged Brie", 2, 0
items.push Item.new "Elixir of the Mongoose", 5, 7
items.push Item.new "Sulfuras, Hand of Ragnaros", 0, 80
items.push Item.new "Sulfuras, Hand of Ragnaros", -1, 80
items.push Item.new "Backstage passes to a TAFKAL80ETC concert", 15, 20
items.push Item.new "Backstage passes to a TAFKAL80ETC concert", 10, 49
items.push Item.new "Backstage passes to a TAFKAL80ETC concert", 5, 49
#this conjured item does not work properly yet
items.push Item.new "Conjured Mana Cake", 3, 6

app = GildedRose.new 

days = 2
(0..days).each {|i| 
  puts "------------ day #{i} ---------"
  puts "name, sell_in, quality"
  for item in items
    puts item
  end
  app.updateQuality items
}

