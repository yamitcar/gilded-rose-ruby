require './gilded_rose'
require './item'

describe 'GildedRose' do
  it 'should degradated one unit in one item' do
    parametricTestCase("foo", 1, 1, 0, 0)
  end 

  it 'should not update item with quaility of sixty' do
    parametricTestCase("foo", 1, 60, 0, 59)
  end

  it 'deberia Mantener La Calidad En Cero' do
    parametricTestCase("foo", 1, 0, 0, 0)
  end

    it 'si El Dia De Venta Llega La Degradacion Se Duplica' do
        parametricTestCase("foo", 0, 30, -1, 28)
    end

    it 'Aged Brie Increases Quality' do
        parametricTestCase("Aged Brie", 10, 30, 9, 31)
    end

    it 'quality Is Never Greater Than 50' do
        parametricTestCase("Aged Brie", 10, 50, 9, 50)
    end

    it 'aged Brie Incrementa Su Calidad Despues De La fecha De Venta' do
        parametricTestCase("Aged Brie", -1, 48, -2, 50)
    end

    it 'sulfuras No Debe Degradarse Ni Modificar Los Dias' do
        parametricTestCase("Sulfuras, Hand of Ragnaros", 10, 80, 10, 80)
    end
    it 'backstage Passes Increases Quality' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 12, 30, 11, 31)
    end
    it 'backstage Passes Increases Quality By One With sell_in Is 11' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 11, 30, 10, 31)
    end
    it 'backstage Passes Increases By Two When Sell In Is Ten Or Less' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 10, 30, 9, 32)
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 9, 30, 8, 32)
    end

    it 'backstage Passes Increases By 3 When Sell In Is 5O or Less' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 5, 30, 4, 33)
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 4, 30, 3, 33)
    end

    it 'backstage Passes Increases By 2 When Sell In Is 6' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 6, 30, 5, 32)
    end

    it 'backstage Passes Reduce Su Calidad Cuando Llega El dia Final' do
        parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 0, 10, -1, 0)
    end
   it 'backstage Passes Increases By 3 When Sell In Is One' do
      parametricTestCase("Backstage passes to a TAFKAL80ETC concert", 1, 10, 0, 13)
  end
    
    #it 'Conjured Mana Cake Should Degrade Twice as fast as normal items before sell_in' do
    #  parametricTestCase("Conjured Mana Cake", 1, 10, 0, 8)
    #end

    #it 'Conjured Wand item should degrade twice as fast as normal items' do
    #  parametricTestCase("Conjured Wand", 1, 10, 0, 8)
    #end

    # Pruebas que faltan

    #it 'Conjured Wand item should degrade twice as fast as normal items' do
    #  parametricTestCase("Conjured Wand", 1, 10, 0, 8)
    #end

    
    # a. Items conjured hasta 0 de calidad.
    #it 'Conjured item with quality 0 cant decrease its quality any more ' do
    #  parametricTestCase("Conjured Wand", 1, 0, 0, 0)
    #end

    # b. 
    #it 'Conjured item with quality 1 shouldnt have a negative quality after one day' do
    #  parametricTestCase("Conjured Wand", 1, 1, 0, 0)
    #end

  it 'multiple items works successfully' do
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

    #act
    app.update_quality items;

     itemsOutput = []
    itemsOutput.push Item.new "+5 Dexterity Vest",9,19
    itemsOutput.push Item.new "Aged Brie", 1, 1
    itemsOutput.push Item.new "Elixir of the Mongoose", 4, 6
    itemsOutput.push Item.new "Sulfuras, Hand of Ragnaros", 0, 80
    itemsOutput.push Item.new "Sulfuras, Hand of Ragnaros", -1, 80
    itemsOutput.push Item.new "Backstage passes to a TAFKAL80ETC concert", 14, 21
    itemsOutput.push Item.new "Backstage passes to a TAFKAL80ETC concert", 9, 50
    itemsOutput.push Item.new "Backstage passes to a TAFKAL80ETC concert", 4, 50
    #this conjured item does not work properly yet
    #itemsOutput.push Item.new "Conjured Mana Cake", 2, 4

    
         
    (1..itemsOutput.size).each { |i| 
      itemsOutput[i-1].name.should == items[i-1].name
      itemsOutput[i-1].quality.should == items[i-1].quality
      itemsOutput[i-1].sell_in.should == items[i-1].sell_in
    }


  end

  def parametricTestCase name, initialsell_in, initialQuality,expectedsell_in, expectedQuality
    items = []
    items.push Item.new name, initialsell_in, initialQuality

    app = GildedRose.new 

    app.update_quality items

    items[0].name.should == name
    items[0].quality.should == expectedQuality
    items[0].sell_in.should == expectedsell_in
    
  end 
end