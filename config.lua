Config = {}

Config.Prefix = "^6[^7RSRP^6] "

Config.Modules = {
    NoDriveBy = {
        Enabled = true,
        Settings = {
            AllowPassengerDriveBy = false
        }
    },
    CombatRoll = {
        Enabled = true,
        Settings = {
            Disable = true
        }
    },
    BlindFire = {
        Enabled = true,
        Settings = {
            Disable = true
        }
    },
    StaffBlips = {
        Enabled = true,
        Settings = {}
    },
    TextureReload = {
        Enabled = true,
        Settings = {}
    },
    PhonePin = {
        Enabled = true,
        Settings = {}
    },
    ServiceCalls = {
        Enabled = true,
        Settings = {}
    },
    Drilling = {
        Enabled = false,
        Settings = {}
    },
    GasMask = {
         Enabled = true,
         Settings = {
            Mask = 46 -- Change this to whichever mask you want to be equipped when using the command
         }
    },
    NVG = {
        Enabled = true,
        Settings = {
            Glasses = 1,
            NVGOnDrawableId = 2,
            NVGOffDrawableId = 1
         }
   },
    BodyBag = {
        Enabled = true,
        Settings = {
            BagModel = "xm_prop_body_bag"
        }
    },
    Announcement = {
        Enabled = true,
        Settings = {
            Messages = {
                "^3By purchasing items from ^5store.rsrp.gg^3, you too can look and feel no better than what you already do!",
                "^3Like a resume, your criminal record is important to you! Stand out from the rest by applying to join one of our gangs @ ^5discord.gg/rsrp!",
                "^3Robbing banks is so Carolina... How about a Go-Kart race @ postal ^59276^3, or have a punch up with what friends you have at the fight club @ postal ^59300!",    
                "^3Dont let other people pay you to do their dirty work. Apply for your own business @ ^5discord.gg/rsrp ^3and pay others to do your dirty work instead!",
                "^3Fancy the ego boost of walking around with a gun (legally), wearing a stupid hat and saying \"license and registration please\"? Join our LEO departments today @ ^5discord.gg/rsrp!", 
                "^3Hey Apple nerds! You all have an \"Apple like\" device availale! Press ^5Y ^3to use your phone and communicate with other players on the server!",
                "^3Need to advertise your services or find other services? Download the Yellow Pages app on your phone and check out what everyone is offering!"
            },
            Interval = 60 -- Minutes
        }
    },
    Flashlight = {
        Enabled = false,
        Settings = {
            ComponentList = {
                `COMPONENT_AT_PI_FLSH`,
                `COMPONENT_AT_PI_FLSH_02`,
                `COMPONENT_AT_PI_FLSH_03`,
                `COMPONENT_AT_AR_FLSH`,
                `COMPONENT_HK416_SPEC_FLSH`,
                `COMPONENT_HK417_FLSH_01`,
                `COMPONENT_HK417_FLSH_02`,
                `COMPONENT_HK417_FLSH_03`,
                `COMPONENT_M249_FLSH_01`,
                `COMPONENT_M249_FLSH_02`,
                `COMPONENT_M249_FLSH_03`,
                `COMPONENT_M249_FLSH_04`,
                `COMPONENT_M249_FLSH_05`,
                `COMPONENT_MCXSPEAR_FLSH_01`,
                `COMPONENT_MCXSPEAR_FLSH_02`,
                `COMPONENT_MCXSPEAR_FLSH_03`,
                `COMPONENT_MCXSPEAR_FLSH_04`,
                `COMPONENT_MCXSPEAR_FLSH_05`,
                `COMPONENT_MCXSPEAR_FLSH_06`,
                `COMPONENT_MCXSPEAR_FLSH_07`,
                `COMPONENT_MCXSPEAR_FLSH_08`,
                `COMPONENT_MCXSPEAR_FLSH_09`,
                `COMPONENT_MCXSPEAR_FLSH_10`,
                `COMPONENT_MCXSPEAR_FLSH_11`,
                `COMPONENT_M4A1BLOCK2_FLSH_01`,
                `COMPONENT_M4A1BLOCK2_FLSH_02`,
            }
            --[[
            WeaponList = {
                --PISTOLS
                [0x1B06D571] = 0x359B7AAE, --WEAPON_PISTOL - COMPONENT_AT_PI_FLSH
                [0xBFE256D4] = 0x43FD595B, --WEAPON_PISTOL_MK2 - COMPONENT_AT_PI_FLSH_02
                [0x5EF9FEC4] = 0x359B7AAE, --WEAPON_COMBATPISTOL - COMPONENT_AT_PI_FLSH
                [0x99AEEB3B] = 0x359B7AAE, --WEAPON_PISTOL50 - COMPONENT_AT_PI_FLSH
                [0x88374054] = 0x4A4965F3, --WEAPONG_SNSPISTOL_MK2 - COMPONENT_AT_PI_FLSH_03
                [0xD205520E] = 0x359B7AAE, --WEAPON_HEAVYPISTOL - COMPONENT_AT_PI_FLSH
                [0xCB96392F] = 0x359B7AAE, --WEAPON_REVOLVER_MK2 - COMPONENT_AT_PI_FLSH
                [0x22D8FE39] = 0x359B7AAE, --WEAPON_APPISTOL - COMPONENT_AT_PI_FLSH

                --SUBMACHINE GUNS
                [0x13532244] = 0x359B7AAE, --WEAPON_MICROSMG - COMPONENT_AT_PI_FLSH
                [0x2BE6766B] = 0x7BC4CDDC, --WEAPON_SMG - COMPONENT_AT_AR_FLSH
                [0x78A97CD0] = 0x7BC4CDDC, --WEAPON_SMG_MK2 - COMPONENT_AT_AR_FLSH
                [0xEFE7E2DF] = 0x7BC4CDDC, --WEAPON_ASSAULTSMG - COMPONENT_AT_AR_FLSH
                [0x0A3D4D34] = 0x7BC4CDDC, --WEAPON_COMBATPDW - COMPONENT_AT_AR_FLSH

                --ASSAULT RIFLES
                [0xBFEFFF6D] = 0x7BC4CDDC, --WEAPON_ASSAULTRIFLE - COMPONENT_AT_AR_FLSH
                [0x394F415C] = 0x7BC4CDDC, --WEAPON_ASSAULTRIFLE_MK2 - COMPONENT_AT_AR_FLSH
                [`WEAPON_CARBINERIFLE`] = 0x7BC4CDDC, --WEAPON_CARBINERIFLE - COMPONENT_AT_AR_FLSH
                [0xFAD1F1C9] = 0x7BC4CDDC, --WEAPON_CARBINERIFLE_MK2 - COMPONENT_AT_AR_FLSH
                [0xAF113F99] = 0x7BC4CDDC, --WEAPON_ADVANCEDRIFLE - COMPONENT_AT_AR_FLSH
                [0xC0A3098D] = 0x7BC4CDDC, --WEAPON_SPECIALCARBINE - COMPONENT_AT_AR_FLSH
                [0x969C3D67] = 0x7BC4CDDC, --WEAPON_SPECIALCARBINE_MK2  - COMPONENT_AT_AR_FLSH
                [0x7F229F94] = 0x7BC4CDDC, --WEAPON_BULLPUPRIFLE - COMPONENT_AT_AR_FLSH
                [0x84D6FAFD] = 0x7BC4CDDC, --WEAPON_BULLPUPRIFLE_MK2  - COMPONENT_AT_AR_FLSH
                [`weapon_hk416_spec`] = `COMPONENT_HK416_SPEC_FLSH`, -- WEAPON_HK416_SPEC - COMPONENT_HK416_SPEC_FLSH

                --SHOTGUNS
                [0x1D073A89] = 0x7BC4CDDC, --WEAPON_PUMPSHOTGUN - COMPONENT_AT_AR_FLSH
                [0x555AF99A] = 0x7BC4CDDC, --WEAPON_PUMPSHOTGUN_MK2 - COMPONENT_AT_AR_FLSH
            }
            ]]--
        }
    },
    KnockOut = {
      Enabled = false,
      Settings = {
          BlackoutScreen = true,
          FistsOnly = false,
          KnockoutLengthFist = 30, -- Seconds
          KnockoutLengthMelee = 60, -- Seconds
          MaximumDamageKnockout = 200, -- Damage Limit Until Knockout
          ReduceDamageAmount = 10, -- Amount of damage that is reduced every 5 seconds
          DieAfterKnockout = false -- Allows a player to die from damage received while knocked out
      }
    },
    NeverWanted = {
        Enabled = true,
        Settings = {}
    },
    KeepDoorsOpen = {
        Enabled = true,
        Settings = {}
    },
    SeatShuffle = {
        Enabled = true,
        Settings = {}
    },
    Crouch = {
        Enabled = true,
        Settings = {}
    },
    DV = {
        Enabled = true,
        Settings = {}
    },
    SaveWheelPos = {
        Enabled = true,
        Settings = {}
    },
    HandsUp = {
        Enabled = true,
        Settings = {}
    },
    DeathMute = {
        Enabled = true,
        Settings = {}
    },
    Store = {
        Enabled = true,
        Settings = {}
    },
    Safezone = {
        Enabled = true,
        Settings = {
            Zones = {
                ["Lobby"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 324.27,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 330.05,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-407.83, 1118.46),
                        vector2(-470.50, 1135.93),
                        vector2(-466.63, 1149.84),
                        vector2(-433.01, 1180.10),
                        vector2(-415.18, 1246.40),
                        vector2(-387.58, 1237.08),
                        vector2(-377.73, 1222.13),
                    }
                },
                ["Paleto TownHall"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 45.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(233.77, 6595.21),
                        vector2(229.28, 6600.37),
                        vector2(229.28, 6667.34),
                        vector2(294.55, 6667.39),
                        vector2(302.63, 6666.32),
                        vector2(307.48, 6660.89),
                        vector2(307.47, 6658.85),
                        vector2(350.88, 6658.85),
                        vector2(351.08, 6657.06),
                        vector2(360.45, 6657.05),
                        vector2(360.47, 6650.6),
                        vector2(395.15, 6650.52),
                        vector2(395.08, 6592.94),
                        vector2(307.63, 6592.9),
                        vector2(307.58, 6594.86),
                        vector2(305.78, 6595.22),
                    }
                },
                ["Route 68 PD & Hospital"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 24.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 48.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1034.77, 2702.54),
                        vector2(1036.35, 2747.84),
                        vector2(1125.46, 2744.86),
                        vector2(1123.74, 2699.12),
                    }
                },
                ["SAM Headquarters"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 83.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-421.4, -362.81),
                        vector2(-413.82, -304.28),
                        vector2(-403.87, -311.46),
                        vector2(-402.83, -310.46),
                        vector2(-393.41, -317.22),
                        vector2(-393.64, -318.75),
                        vector2(-335.75, -360.27),
                        vector2(-333.73, -362.63),
                        vector2(-333.28, -364.99),
                        vector2(-335.02, -369.12),
                        vector2(-336.7, -370.98),
                        vector2(-339.35, -372.32),
                        vector2(-348.32, -372.35),
                    }
                },
                ["SAMHQ Underground"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = -10.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-408.56, -440.55),
                        vector2(-333.52, -459.0),
                        vector2(-310.99, -355.25),
                        vector2(-315.59, -267.11),
                        vector2(-443.29, -234.54),
                        vector2(-468.33, -441.56),
                    }
                },
                ["FIB Headquarters"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 80.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 126.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(2583.9, -384.46),
                        vector2(2583.75, -275.76),
                        vector2(2568.19, -275.71),
                        vector2(2559.8, -274.7),
                        vector2(2555.47, -267.36),
                        vector2(2554.24, -258.78),
                        vector2(2552.11, -257.26),
                        vector2(2518.13, -257.43),
                        vector2(2515.77, -259.08),
                        vector2(2514.14, -262.96),
                        vector2(2513.6, -267.43),
                        vector2(2510.84, -275.01),
                        vector2(2489.4, -274.83),
                        vector2(2486.35, -277.7),
                        vector2(2485.21, -281.86),
                        vector2(2485.3, -303.11),
                        vector2(2472.18, -311.84),
                        vector2(2471.96, -315.47),
                        vector2(2459.55, -315.75),
                        vector2(2459.910, -321.96),
                        vector2(2456.27, -330.16),
                        vector2(2431.31, -361.82),
                        vector2(2431.31, -416.42),
                        vector2(2486.8, -470.99),
                        vector2(2507.0, -490.68),
                        vector2(2526.73, -483.91),
                        vector2(2530.11, -481.36),
                        vector2(2576.82, -437.87),
                        vector2(2576.75, -394.73),
                    }
                },
                ["Pillbox Hill | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.79,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 35.81,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(12.55, -1082.61),
                        vector2(23.77, -1086.58),
                        vector2(17.0, -1105.47),
                        vector2(22.27, -1107.66),
                        vector2(19.42, -1114.89),
                        vector2(3.37, -1108.86),
                    }
                },
                ["La Mesa | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 27.19,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 35.81,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(846.7, -1025.25),
                        vector2(846.61, -1036.28),
                        vector2(839.74, -1036.24),
                        vector2(839.77, -1024.91),
                    }
                },
                ["MorningWood | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 35.7,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 41.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-1312.99, -387.79),
                        vector2(-1314.93, -394.88),
                        vector2(-1303.54, -397.65),
                        vector2(-1301.72, -390.67),
                    }
                },
                ["Chumash | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 19.7,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 24.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-3176.77, 1084.7),
                        vector2(-3165.8, 1079.98),
                        vector2(-3162.75, 1086.92),
                        vector2(-3173.53, 1091.45),
                    }
                },
                ["Staff Jail & County Coroner"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 18.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 49.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(195.42, -1393.45),
                        vector2(249.48, -1325.66),
                        vector2(291.65, -1325.9),
                        vector2(316.39, -1334.59),
                        vector2(243.96, -1422.47),
                    }
                },
                ["GoKart Track"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 29.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 41.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(836.33, -2229.14),
                        vector2(905.83, -2235.18),
                        vector2(913.96, -2141.82),
                        vector2(864.33, -2137.93),
                        vector2(863.6, -2146.62),
                        vector2(843.71, -2144.75),
                    }
                },
                ["Little Seoul | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 20.9,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 25.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-666.83, -928.56),
                        vector2(-657.68, -928.81),
                        vector2(-656.89, -943.93),
                        vector2(-666.43, -943.97),
                    }
                },
                ["Palomino Freeway | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 107.73,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 112.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(2572.43, 287.76),
                        vector2(2563.11, 287.83),
                        vector2(2563.05, 303.19),
                        vector2(2572.15, 303.04),
                    }
                },
                ["Sandy Shores | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 33.71,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 38.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1702.25, 3756.12),
                        vector2(1697.01, 3750.65),
                        vector2(1688.07, 3758.54),
                        vector2(1693.23, 3764.06),
                    }
                },
                ["El Rancho | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.62,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 33.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(827.54, -2148.67),
                        vector2(809.47, -2148.86),
                        vector2(809.38, -2157.39),
                        vector2(815.19, -2157.23),
                        vector2(815.45, -2177.7),
                        vector2(828.02, -2177.38),
                    }
                },
                ["Great Chaparral | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 17.5,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 22.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-1115.02, 2688.54),
                        vector2(-1108.58, 2695.32),
                        vector2(-1118.57, 2706.51),
                        vector2(-1124.83, 2700.44),
                    }
                },
                ["Paleto Bay | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 30.45,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 35.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-327.48, 6074.32),
                        vector2(-322.07, 6079.64),
                        vector2(-330.38, 6088.04),
                        vector2(-335.83, 6082.6),
                    }
                },
                ["Hawick | Ammunation"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 68.9,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 73.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(259.72, -48.1),
                        vector2(256.77, -56.59),
                        vector2(242.39, -51.33),
                        vector2(245.33, -42.88),
                    }
                },
                ["Mission Row Police Department"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 20.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(410.7, -1033.32),
                        vector2(466.83, -1026.6),
                        vector2(467.18, -1030.96),
                        vector2(488.6, -1028.29),
                        vector2(488.86, -966.44),
                        vector2(419.5, -966.62),
                        vector2(419.42, -1016.11),
                        vector2(410.57, -1016.18),
                    }
                },
                ["Vespucci Police Department"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 0.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-1081.13, -791.58),
                        vector2(-1153.45, -851.36),
                        vector2(-1128.59, -885.34),
                        vector2(-1099.2, -863.87),
                        vector2(-1079.77, -890.34),
                        vector2(-1053.36, -874.54),
                        vector2(-1029.32, -851.93),
                        vector2(-1013.11, -825.29),
                    }
                },
                ["Davis Police Department"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 20.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(364.81, -1569.1),
                        vector2(338.34, -1600.82),
                        vector2(387.31, -1641.8),
                        vector2(413.49, -1610.31),
                    }
                },
                ["El Burro Heights Fire Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 32.84,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 44.1,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1222.99, -1463.22),
                        vector2(1163.44, -1463.18),
                        vector2(1163.7, -1484.29),
                        vector2(1222.64, -1484.76),
                    }
                },
                ["Davis Fire Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 27.8,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 45.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(198.32, -1632.35),
                        vector2(225.86, -1655.34),
                        vector2(209.62, -1674.06),
                        vector2(182.42, -1651.21),
                    }
                },
                ["Grapeseed Fire Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 34.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(2517.73, 4168.66),
                        vector2(2519.9, 4176.05),
                        vector2(2527.23, 4174.37),
                        vector2(2562.49, 4232.64),
                        vector2(2534.89, 4240.04),
                        vector2(2535.6, 4245.45),
                        vector2(2506.69, 4253.11),
                        vector2(2506.17, 4250.45),
                        vector2(2501.62, 4251.52),
                        vector2(2500.86, 4248.16),
                        vector2(2496.54, 4248.31),
                        vector2(2493.88, 4257.63),
                        vector2(2510.76, 4263.3),
                        vector2(2506.91, 4277.18),
                        vector2(2478.83, 4268.96),
                        vector2(2482.64, 4255.28),
                        vector2(2485.42, 4245.65),
                        vector2(2455.98, 4228.97),
                        vector2(2460.93, 4208.67),
                        vector2(2466.58, 4210.25),
                        vector2(2469.86, 4209.28),
                        vector2(2472.14, 4207.01),
                        vector2(2480.24, 4190.78),
                        vector2(2481.94, 4188.59),
                        vector2(2483.85, 4186.71),
                        vector2(2486.98, 4184.89),
                        vector2(2489.02, 4183.61),
                        vector2(2489.88, 4181.36),
                        vector2(2488.94, 4176.06),

                    }
                },
                ["Sandy Shores Hospital"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 15.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1801.12, 3640.12),
                        vector2(1780.23, 3676.56),
                        vector2(1700.31, 3630.64),
                        vector2(1722.09, 3593.39),
                    }
                },
                ["Sandy Shores Fire Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 15.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1674.3, 3568.31),
                        vector2(1657.04, 3598.98),
                        vector2(1695.25, 3620.65),
                        vector2(1713.51, 3590.49),
                    }
                },
                ["Sandy Shores Sheriff Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 15.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1817.17, 3653.95),
                        vector2(1874.86, 3687.42),
                        vector2(1858.39, 3715.79),
                        vector2(1800.97, 3682.62),
                    }
                },
                ["Platinum Cars"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 10.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 40.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-804.13, -1017.07),
                        vector2(-763.72, -1089.28),
                        vector2(-716.41, -1060.57),
                        vector2(-761.51, -981.69),
                    }
                },
                ["Motorcycle Shop"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 10.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 40.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-791.78, -598.92),
                        vector2(-799.3, -615.29),
                        vector2(-819.2, -604.57),
                        vector2(-810.64, -588.39),
                    }
                },
                ["Paleto Bay Sheriff Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 20.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-420.42, 5993.1),
                        vector2(-439.18, 5974.38),
                        vector2(-449.57, 5984.97),
                        vector2(-472.13, 5962.28),
                        vector2(-501.52, 5991.85),
                        vector2(-478.91, 6014.27),
                        vector2(-489.11, 6024.4),
                        vector2(-460.82, 6052.72),
                        vector2(-458.88, 6053.25),
                        vector2(-445.54, 6061.52),
                        vector2(-438.63, 6047.92),
                        vector2(-432.69, 6034.9),
                        vector2(-426.27, 6021.38),
                        vector2(-432.25, 6014.94),
                        vector2(-420.97, 6003.56),
                    }
                },
                ["Paleto Bay Hospital"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 20.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 50.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-259.0, 6295.34),
                        vector2(-288.21, 6324.63),
                        vector2(-256.6, 6355.58),
                        vector2(-227.47, 6326.77),
                    }
                },
                ["Paleto Bay Fire Dept"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 16.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 44.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-361.27, 6155.44),
                        vector2(-401.82, 6113.31),
                        vector2(-368.58, 6081.4),
                        vector2(-329.34, 6123.02),
                    }
                },
                ["Boling Broke Penitentiary"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 44.4,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 55.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(1768.71, 2531.09),
                        vector2(1764.0, 2528.18),
                        vector2(1757.39, 2503.75),
                        vector2(1751.18, 2500.09),
                        vector2(1726.61, 2506.61),
                        vector2(1721.81, 2504.11),
                        vector2(1747.57, 2459.49),
                        vector2(1794.43, 2486.45),
                    }
                },
                ["Townhall"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 30.4,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 52.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-497.36, -205.95),
                        vector2(-566.16, -247.06),
                        vector2(-596.97, -202.99),
                        vector2(-523.24, -159.98),
                    }
                },
                ["McDonalds"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 28.3,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 35.3,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(284.72, -964.7),
                        vector2(274.83, -964.34),
                        vector2(270.99, -966.95),
                        vector2(267.8, -975.66),
                        vector2(273.65, -978.03),
                        vector2(278.96, -980.11),
                        vector2(285.29, -979.99),
                    }
                },
                ["Game Warden Station"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 32.9,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 44.4,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-781.55, 5403.22),
                        vector2(-836.61, 5403.42),
                        vector2(-836.51, 5382.96),
                        vector2(-781.57, 5382.92),
                    }
                },
                ["Luxury Autos"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 30.4,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 52.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-788.17, -248.96),
                        vector2(-812.78, -205.04),
                        vector2(-788.11, -191.03),
                        vector2(-761.0, -238.36),
                    }
                },
                ["Premium Deluxe Motorsports"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 23.5,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 40.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-53.6, -1069.46),
                        vector2(-21.73, -1081.07),
                        vector2(-19.48, -1074.84),
                        vector2(-1.15, -1081.55),
                        vector2(-15.18, -1119.85),
                        vector2(-64.89, -1122.45),
                        vector2(-70.35, -1116.75),
                    }
                },
                ["Pillbox Hospital"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 27.0,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 98.0,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(346.88, -637.03),
                        vector2(358.03, -619.27),
                        vector2(377.18, -570.69),
                        vector2(371.63, -571.56),
                        vector2(346.86, -566.23),
                        vector2(322.31, -558.61),
                        vector2(316.61, -561.61),
                        vector2(296.0, -554.39),
                        vector2(276.91, -611.24),
                    }
                },
                ["Devin Weston Hanger"] = {
                    ShowNotifications = true,
                    ShowBlip = false,
                    -- Draw the walls?
                    Debug = false,
                    -- Basically ground level. The bottom of the safezone
                    MinZ = 12.60,
                    -- How high the safezone is. The top of the safezone (Just fly a bit above the zone and record the Z)
                    MaxZ = 36.86,
                    -- X and Y coords.
                    -- MUST be in order (point to point)
                    Points = {
                        vector2(-1030.66, -3016.31),
                        vector2(-935.34, -3072.55),
                        vector2(-935.23, -3061.07),
                        vector2(-925.58, -3052.30),
                        vector2(-865.47, -2951.20),
                        vector2(-962.00, -2894.39)
                    }
                },
            }
        }
    },
    Compass = {
        Enabled = false,
        Settings = {
            Show = true,
            Position = {
                X = 0.5,
                Y = 0.07,
                Centered = true
            },
            Width = 0.25,
            Fov = 180,
            FollowGameplayCamera = true,
            TicksBetweenCardinals = 9.0,
            TickColor = {
                R = 255,
                G = 255,
                B = 255,
                A = 255
            },
            TickSize = {
                Width = 0.001,
                Height = 0.003
            },
            Cardinal = {
                Text = {
                    Size = 0.25,
                    Offset = 0.015,
                    Color = {
                        R = 255,
                        G = 255,
                        B = 255,
                        A = 255
                    }
                },
                Tick = {
                    Show = true,
                    Size = {
                        Width = 0.001,
                        Height = 0.012
                    },
                    Color = {
                        R = 255,
                        G = 255,
                        B = 255,
                        A = 255
                    }
                }
            },
            Intercardinal = {
                Show = true,
                Text = {
                    Show = true,
                    Size = 0.2,
                    Offset = 0.015,
                    Color = {
                        R = 255,
                        G = 255,
                        B = 255,
                        A = 255
                    }
                },
                Tick = {
                    Show = true,
                    Size = {
                        Width = 0.001,
                        Height = 0.006
                    },
                    Color = {
                        R = 255,
                        G = 255,
                        B = 255,
                        A = 255
                    }
                }
            },
            StreetName = {
                Show = true,
                Position = {
                    X = 0.5,
                    Y = 0.02,
                    Centered = true
                },
                TextSize = 0.35,
                TextColor = {
                    R = 255,
                    G = 255,
                    B = 255,
                    A = 255
                }
            }
        }
    },
    AutoMod = {
        Enabled = true,
        Settings = {
            EntityRateLimit = 5000,
            BlacklistedWords = {
                "Nigger",
                "N1gger",
                "N!gger",    
                "Faggot",
                "F@ggot",
                "Fag",
                "Coon",
                "Kike",
                "Beaner",
                "Nignog",
                "Niglet",
                "Tonk",
                "Coonass"
            },
            BannedColorCodes = {
                "^1",
                "^2",
                "^3",
                "^4",
                "^5",
                "^6",
                "^7",
                "^8",
                "^9",
                "~r~",
                "~b~",
                "~g~",
                "~y~",
                "~p~",
                "~w~",
                "~q~",
                "~o~",
                "~c~",
                "~m~",
                "~u~",
                "~n~",
                "~s~",
                "~h~",
                "~italic~",
                "¦",
                "÷",
                "∑"
            },
            SecondsUntilAfkKicked = 1800,
            AfkKickWarning = true,
            AfkKickMessage = "[AutoMod] You have been kicked for being AFK! If you were clocked on, you have been automatically clocked off!",
            ChatCooldown = 5000, -- Milliseconds
            ChatCharacterLimit = 150,
            BanColorCodes = true -- Use RSRPCore.AutoMod.AllowColorCodes ace perms to bypass this
        }
    },
    CarHud = {
        Enabled = false,
        Settings = {
            Speed = 'mph', 
	        Fuel = true, 
            Seatbelt = true,
	        SpeedIndicator = true,
	        ParkIndicator = false,
	        Top = true, 
	        Plate = true
        }
    },
    WorldManagement = {
        Enabled = true,
        Settings = {}
    },
    Pickups = {
        Enabled = false,
        Settings = {
            WeaponDropDespawnTime = 10,
            IgnoreWeapons = {
                [GetHashKey("WEAPON_UNARMED")] = true,
                [GetHashKey("WEAPON_GADGETPISTOL")] = true,
                [GetHashKey("WEAPON_MILITARYRIFLE")] = true,
                [GetHashKey("WEAPON_NAVYREVOLVER")] = true,
                [GetHashKey("WEAPON_COMBATSHOTGUN")] = true,
                [GetHashKey("WEAPON_RAYPISTOL")] = true,
                [GetHashKey("WEAPON_PIPEBOMB")] = true,
                [GetHashKey("WEAPON_MUSKET")] = true,
                [GetHashKey("WEAPON_RAYCARBINE")] = true,
                [GetHashKey("WEAPON_RAILGUN")] = true,
                [GetHashKey("WEAPON_PASSENGER_ROCKET")] = true,
                [GetHashKey("WEAPON_MOLOTOV")] = true,
                [GetHashKey("WEAPON_MINIGUN")] = true,
                [GetHashKey("WEAPON_GRENADELAUNCHER")] = true,
                [GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE")] = true,
                [GetHashKey("WEAPON_GRENADE")] = true,
                [GetHashKey("WEAPON_SMOKEGRENADE")] = true,
                [GetHashKey("WEAPON_HOMINGLAUNCHER")] = true,
                [GetHashKey("WEAPON_RPG")] = true,
                [GetHashKey("WEAPON_STICKYBOMB")] = true,
                [GetHashKey("WEAPON_PROXMINE")] = true,
                [GetHashKey("WEAPON_SNIPERRIFLE")] = true,
                [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = true,
                [GetHashKey("WEAPON_COMPACTLAUNCHER")] = true,
                [GetHashKey("WEAPON_REVOLVER_MK2")] = true,
                [GetHashKey("WEAPON_SMG_MK2")] = true,
                [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = true,
                [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = true,
                [GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = true,
                [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = true,
                [GetHashKey("WEAPON_COMBATMG_MK2")] = true,
                [GetHashKey("WEAPON_HEAVYSNIPER_MK2")] = true,
                [GetHashKey("WEAPON_MARKSMANRIFLE_MK2")] = true,
                [GetHashKey("WEAPON_STINGER")] = true,
                [GetHashKey("WEAPON_EMPLAUNCHER")] = true,
                [GetHashKey("WEAPON_HEAVYRIFLE")] = true,
            }
        }
    },
    Fuel = {
        Enabled = false,
        Settings = {
            GasStations = {
                vector3(49.4187, 2778.793, 58.043),
                vector3(263.894, 2606.463, 44.983),
                vector3(1039.958, 2671.134, 39.550),
                vector3(1207.260, 2660.175, 37.899),
                vector3(2539.685, 2594.192, 37.944),
                vector3(2679.858, 3263.946, 55.240),
                vector3(2005.055, 3773.887, 32.403),
                vector3(1687.156, 4929.392, 42.078),
                vector3(1701.314, 6416.028, 32.763),
                vector3(179.857, 6602.839, 31.868),
                vector3(-94.4619, 6419.594, 31.489),
                vector3(-2554.996, 2334.40, 33.078),
                vector3(-1800.375, 803.661, 138.651),
                vector3(-1437.622, -276.747, 46.207),
                vector3(-2096.243, -320.286, 13.168),
                vector3(-724.619, -935.1631, 19.213),
                vector3(-526.019, -1211.003, 18.184),
                vector3(-70.2148, -1761.792, 29.534),
                vector3(265.648, -1261.309, 29.292),
                vector3(819.653, -1028.846, 26.403),
                vector3(1208.951, -1402.567,35.224),
                vector3(1181.381, -330.847, 69.316),
                vector3(620.843, 269.100, 103.089),
                vector3(2581.321, 362.039, 108.468),
                vector3(176.631, -1562.025, 29.263),
                vector3(176.631, -1562.025, 29.263),
                vector3(-319.292, -1471.715, 30.549),
                vector3(1784.324, 3330.55, 41.253)
            },
            FuelUsage = {
                [1.0] = 1.4,
                [0.9] = 1.2,
                [0.8] = 1.0,
                [0.7] = 0.9,
                [0.6] = 0.8,
                [0.5] = 0.7,
                [0.4] = 0.5,
                [0.3] = 0.4,
                [0.2] = 0.2,
                [0.1] = 0.1,
                [0.0] = 0.0,
            },
            Classes = {
                [0] = 1.0, -- Compacts
                [1] = 1.0, -- Sedans
                [2] = 1.0, -- SUVs
                [3] = 1.0, -- Coupes
                [4] = 1.0, -- Muscle
                [5] = 1.0, -- Sports Classics
                [6] = 1.0, -- Sports
                [7] = 1.0, -- Super
                [8] = 1.0, -- Motorcycles
                [9] = 1.0, -- Off-road
                [10] = 1.0, -- Industrial
                [11] = 1.0, -- Utility
                [12] = 1.0, -- Vans
                [13] = 0.0, -- Cycles
                [14] = 1.0, -- Boats
                [15] = 1.0, -- Helicopters
                [16] = 1.0, -- Planes
                [17] = 1.0, -- Service
                [18] = 1.0, -- Emergency
                [19] = 1.0, -- Military
                [20] = 1.0, -- Commercial
                [21] = 1.0, -- Trains
            },
            PumpModels = {
                [-2007231801] = true,
                [1339433404] = true,
                [1694452750] = true,
                [1933174915] = true,
                [-462817101] = true,
                [-469694731] = true,
                [-164877493] = true
            },
            DisableKeys = {
                0,
                22,
                23,
                24,
                29,
                30,
                31,
                37,
                44,
                56,
                82,
                140,
                166,
                167,
                168,
                170,
                288,
                289,
                311,
                323
            },
            Strings = {
                ExitVehicle = "Exit the vehicle to refuel",
                EToRefuel = "Press ~g~E ~w~to refuel vehicle",
                JerryCanEmpty = "Jerry can is empty",
                FullTank = "Tank is full",
                CancelFuelingPump = "Press ~g~E ~w~to cancel the fueling",
                CancelFuelingJerryCan = "Press ~g~E ~w~to cancel the fueling",
                RefillJerryCan = "Press ~g~E ~w~ to refill the jerry can",
                PickupJerryCan = "Pickup Jerry Can",
                JerryCanFull = "Jerry can is full",
            }
        }
    },
    GamerTags = {
        Enabled = true,
        Settings = {}
    },
    DiscordPresence = {
        Enabled = true,
        Settings = {}
    },
    WastedScreen = {
        Enabled = true,
        Settings = {
            DefaultWastedMessage = "~r~Wasted",
            DefaultWastedSlogan = "Living isnt for everyone...",
            SuicideSlogan = "It really came to this huh...",
            -- Seconds
            DisplayTime = 15
        }
    },
    Permissions = {
        Enabled = true,
        Settings = {
            -- Rank must match the Ace Perm. Example, if ace permissions ended in Mod (RSRPCore.Permissions.ChatTag.Mod) Rank would be Mod
            -- MUST also rank from highest to lowest
            ChatTags = {
                {
                    Rank = "Owner",
                    Tag = "^5Owner"
                },
                {
                    Rank = "Key",
                    Tag = "^1I^2T^3S ^4M^5E ^6M^7R ^8K^9E^1Y"
                },
                {
                    Rank = "Director",
                    Tag = "^4Director"
                },
                {
                    Rank = "SrManagement",
                    Tag = "^4Senior Management"
                },
                {
                    Rank = "Management",
                    Tag = "^4Management"
                },
                {
                    Rank = "HeadAdmin",
                    Tag = "^8Head Administrator"
                },
                {
                    Rank = "SrAdmin",
                    Tag = "^8Senior Administrator"
                },
                {
                    Rank = "Admin",
                    Tag = "^1Administrator"
                },
                {
                    Rank = "HeadMod",
                    Tag = "^3Head Moderator"
                },
                {
                    Rank = "SrMod",
                    Tag = "^3Senior Moderator"
                },
                {
                    Rank = "Mod",
                    Tag = "^3Moderator"
                },
                {
                    Rank = "ST",
                    Tag = "^3Staff in Training"
                },
                {
                    Rank = "UltimateSupporter",
                    Tag = "^2Ultimate Supporter"
                },
                {
                    Rank = "Supporter",
                    Tag = "^2Supporter"
                },
                {
                    Rank = "Booster",
                    Tag = "^9Booster"
                },
                {
                    Rank = "HonoredCivilian",
                    Tag = "^3Honored Civilian"
                },
                {
                    Rank = "Civilian",
                    Tag = "^7Civilian"
                },
            },
            HeadTags = {
                {
                    Rank = "Owner",
                    Tag = "~b~Owner"
                },
                {
                    Rank = "Key",
                    Tag = "~b~Key"
                },
                {
                    Rank = "Director",
                    Tag = "~b~Director"
                },
                {
                    Rank = "SrManagement",
                    Tag = "~b~Senior Management"
                },
                {
                    Rank = "Management",
                    Tag = "~b~Management"
                },
                {
                    Rank = "HeadAdmin",
                    Tag = "~r~Head Administrator"
                },
                {
                    Rank = "SrAdmin",
                    Tag = "~r~Senior Administrator"
                },
                {
                    Rank = "Admin",
                    Tag = "~o~Administrator"
                },
                {
                    Rank = "HeadMod",
                    Tag = "~o~Head Moderator"
                },
                {
                    Rank = "SrMod",
                    Tag = "~o~Senior Moderator"
                },
                {
                    Rank = "Mod",
                    Tag = "~y~Moderator"
                },
                {
                    Rank = "ST",
                    Tag = "~y~Staff in Training"
                }
            },
            BlacklistedCustomTagText = {
                "Nigger",
                "N1gger",
                "F@ggot",
                "N!gger",
                "Faggot",
                "Fag",
                "Coon",
                "Nigga",
                "Niga",
                "Kike",
                "Beaner",
                "Nignog",
                "Niglet",
                "Tonk",
                "Coonass",
                "Staff",
                "Owner",
                "Director",
                "Management",
                "Management",
                "Head Administrator",
                "Senior Administrator",
                "Administrator",
                "Senior Moderator",
                "Moderator",
                "Staff in Training",
                "Mod",
                "Admin",
                "Sr Admin",
                "Director",
                "Sr Mod"
            },
            ColorCodes = {
                "^1",
                "^2",
                "^3",
                "^4",
                "^5",
                "^6",
                "^7",
                "^8",
                "^9",
                "~r~",
                "~b~",
                "~g~",
                "~y~",
                "~p~",
                "~w~",
                "~q~",
                "~o~",
                "~c~",
                "~m~",
                "~u~",
                "~n~",
                "~s~",
                "~h~",
                "~italic~",
                "¦",
                "÷",
                "∑"
            }
        }
    }
}