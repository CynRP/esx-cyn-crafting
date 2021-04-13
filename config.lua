Craft = {}


Craft.Settings = {
  UseCommand = true,
  Command = 'craft',

  UseButton = true,
  Button = 344 -- Default: F11
}

Craft.Language = {
  Title = 'Crafting Menu',
  Subtitle = '~b~Item Crafting Menu',
  ClickToCraft = 'Click to Craft: ',
  UnknownItem = 'Unknown',
  CantCraft = 'You cannot craft this'
}

Craft.Animation = {
    [1] = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- Crafting animation
    [2] = "machinic_loop_mechandplayer"
}

Craft.Recipes = {
    {
        name = 'Repairkit',   -- Item label to show in the crafting menu
        item = 'fixkit',      -- Item to get when crafting is done (Using ESX item list)
        amount = 1,           -- Amount of the item above to get when crafted
        timeToCraft = 20,     -- Time in seconds to craft the item
        job = 'none',         -- Job required to craft the item?
        jobGrade = 0,         -- Job grade required to craft the item
        items = {             -- List of items required to craft the item (Need the items in your inventory to show in the menu)
            ['radio'] = 0
        }
    }
}
