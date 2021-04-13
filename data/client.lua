ESX = nil
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end

  ESX.PlayerData = ESX.GetPlayerData()
end)

local menu = nil


    RegisterCommand('craft', function()
        OpenCraftMenu()
    end)


function OpenCraftMenu()
    LoadMenu()
    menu:Visible(not menu:Visible())
end


function LoadMenu()

    local items = {}

    _menuPool = NativeUI.CreatePool()
    mainMenu = NativeUI.CreateMenu(Craft.Language.Title, Craft.Language.Subtitle)
    _menuPool:Add(mainMenu)
    menu = mainMenu
    for i=1, #Craft.Recipes do
        local data = Craft.Recipes[i]
        local canCraft = false
        for k,v in pairs(data.items) do

            ESX.TriggerServerCallback('craft:hasItem', function(hasItem)
              if hasItem then
                if data.job ~= 'none' then
                    if ESX.PlayerData.job.name == data.job and ESX.PlayerData.job.grade >= data.jobGrade then
                        canCraft = true
                    end
                else
                    canCraft = true
                end
            else
                canCraft = false
            end
          end, k, v)
        end
        Citizen.Wait(500)
        if canCraft then
            local newitem = NativeUI.CreateItem(data.name, Craft.Language.ClickToCraft..data.name)
            newitem:SetLeftBadge(BadgeStyle.Star)
            newitem:SetRightBadge(BadgeStyle.Tick)
            menu:AddItem(newitem)
            items[i] = data
        else
            local newitem = NativeUI.CreateItem(Craft.Language.UnknownItem, Craft.Language.CantCraft)
            menu:AddItem(newitem)
            items[i] = nil
        end
        Citizen.CreateThread(function()
            while menu:Visible() do
                Citizen.Wait(0)
                _menuPool:ProcessMenus()
            end
        end)
    end
    menu.OnItemSelect = function(sender, item, index)
        local d = items[index]
        if d ~= nil then
          _menuPool:CloseAllMenus()
            CraftItem(d)
        end
    end
    _menuPool:RefreshIndex()
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    _menuPool:ProcessMenus()
end

function CraftItem(data)
    for k,v in pairs(data.items) do
    TriggerServerEvent('craft:removeItem', k, v)
    end

local time = data.timeToCraft * 1000
    ESX.ShowNotification("Crafting Item...")
    RequestAnimDict("random@arrests@busted")
    while (not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0,-1.0, time, 0, 1, true, true, true)
    Citizen.Wait(time)

    ESX.ShowNotification("Item was crafted successfully!", "")
    TriggerServerEvent('craft:addItem', data.item, data.amount)
    _menuPool:CloseAllMenus()
end
