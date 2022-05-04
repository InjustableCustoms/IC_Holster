-- Scripted and configured by Injustable Customs





Config 				  = {}
Config.cooldown		  = 0

-- Add/remove weapon hashes here to be added for holster checks.
Config.HWeapons = { -- Holsterable Weapons, otherwise drawn from back
	"WEAPON_COMBATPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"weapon_doubleaction",
	"weapon_ceramicpistol",
	"WEAPON_REVOLVER",
	"weapon_gadgetpistol",
}

Config.Weapons = { -- Weapons drawn from back
	"weapon_microsmg",
	"weapon_machinepistol",
	"weapon_minismg",
	"weapon_dbshotgun",
	"weapon_sawnoffshotgun",
}

Config.FWeapons = { -- Weapons drawn from front
	"weapon_stungun",
}

EUP = {
  ["peds"] = {
    ["mp_m_freemode_01"] = { -- Male multiplayer ped
      ["components"] = {
        [7] = { -- Component ID, "Neck" or "Teeth" category
          [8] = 2, -- Drawable ID, can specify multiple, separated by comma and or line breaks
		  [1] = 3,
		  [120] = 111
        }
      }
    },
    ["mp_f_freemode_01"] = { -- Female multiplayer ped
      ["components"] = {
        [7] = { -- Component ID, "Neck" or "Teeth" category
          [8] = 2,
		  [1] = 3,
          [6] = 5
        }
      }
    }
  }
}