print('[^2W_Emploi^7] [^2Info^7] Created by Wozztv#0001 ^1<^6/^1>^7')

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end 
end)  

Wozz              = {}
Wozz.DrawDistance = 100
Wozz.Size         = {x = 0.6, y = 0.6, z = 0.6}
Wozz.Color        = {r = 125, g = 63, b = 175}
Wozz.Type         = 25

local emploi = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 200, 100}, Title = 'Pôle emploi'},
	Data = { currentMenu = "Emploie", GetPlayerName()},
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			local btn = btn.name

			if btn == "Eboueur" then
				TriggerServerEvent('emploie:eboueur')
				ESX.ShowAdvancedNotification('Pôle emploi', '~p~Eboueur', '~w~Tu es désormais Eboueur', 'CHAR_LIFEINVADER')
			elseif btn == "Go Postal" then
				TriggerServerEvent('emploie:gopostal')
				ESX.ShowAdvancedNotification('Pôle emploi', '~p~Go Postal', '~w~Tu es désormais Postier', 'CHAR_LIFEINVADER')
		end
	end,
},

	Menu = {
		["Emploie"] = {
			b = {
				{name = "Eboueur",ask = "→→→", askX = true, Description = 'Salaire de ~g~50$'},
				{name = "Go Postal",ask = "→→→", askX = true, Description = 'Salaire de ~g~100$'},
			}
		}
	
	}
}

local pos = {
	{x = -269.69,  y = -954.73,  z = 30.22} 
}


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(pos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= 1.1 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~Pôle emploi.")
				if IsControlJustPressed(1,51) then 					
                    CreateMenu(emploi)
				end
            end
        end
    end  
end)

Citizen.CreateThread(function()

    for k in pairs(pos) do

	local blip = AddBlipForCoord(pos[k].x, pos[k].y, pos[k].z)

	SetBlipSprite(blip, 269)
	SetBlipColour(blip, 58)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pôle emploi")
    EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId()), true

        for k in pairs(pos) do
            if (Wozz.Type ~= -1 and GetDistanceBetweenCoords(coords, pos[k].x, pos[k].y, pos[k].z, true) < Wozz.DrawDistance) then
                DrawMarker(Wozz.Type, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Wozz.Size.x, Wozz.Size.y, Wozz.Size.z, Wozz.Color.r, Wozz.Color.g, Wozz.Color.b, 100, false, true, 2, false, false, false, false)
			end
        end
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("a_f_m_bevhills_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "a_f_m_bevhills_02",-270.01,-954.24,30.22, 220.65, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, true) 
    FreezeEntityPosition(ped, true) 
	SetEntityInvincible(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CAR_PARK_ATTENDANT") 
end)