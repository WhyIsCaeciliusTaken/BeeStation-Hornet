// Effects
/obj/effect/oneway
	name = "one way effect"
	desc = "Only lets things in from it's dir."
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "field_dir"
	invisibility = INVISIBILITY_MAXIMUM
	anchored = TRUE

/obj/effect/oneway/CanPass(atom/movable/mover, turf/target)
	var/turf/T = get_turf(src)
	var/turf/MT = get_turf(mover)
	return ..() && (T == MT || get_dir(MT,T) == dir)


/obj/effect/wind
	name = "wind effect"
	desc = "Creates pressure effect in it's direction. Use sparingly."
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "field_dir"
	invisibility = INVISIBILITY_MAXIMUM
	var/strength = 30

/obj/effect/wind/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/effect/wind/process()
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.consider_pressure_difference(get_step(T,dir),strength)

/obj/effect/explosionblocker
	name = "explosion inhibitor"
	desc = "Blocks all explosions from occuring on this Z-level"
	invisibility = INVISIBILITY_MAXIMUM
	anchored = TRUE

//Keep these rare due to cost of doing these checks
/obj/effect/path_blocker
	name = "magic barrier"
	desc = "You shall not pass."
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "blocker" //todo make this actually look fine when visible
	anchored = TRUE
	var/list/blocked_types = list()
	var/reverse = FALSE //Block if path not present

/obj/effect/path_blocker/Initialize()
	. = ..()
	if(blocked_types.len)
		blocked_types = typecacheof(blocked_types)

/obj/effect/path_blocker/CanPass(atom/movable/mover, turf/target)
	if(blocked_types.len)
		var/list/mover_contents = mover.GetAllContents()
		for(var/atom/movable/thing in mover_contents)
			if(blocked_types[thing.type])
				return reverse
	return !reverse

// Away Mission Rework Items

/obj/item/awaymaploader
	name = "debug away mission loader - report this!"
	desc = "A disk containing a set of data codes needed to lock onto an away mission. Insert it into the station gateway to lock onto the mission."
	icon = 'icons/obj/module.dmi'
	icon_state = "datadisk0"
	w_class = WEIGHT_CLASS_TINY
	var/unstable = FALSE // Does the map have a time limit?
	var/time = 0 // If so, how long is the time limit (in minutes)?
	var/difficulty = "Medium" // Currently unused, will be used in an anti-duplicate disk device later
	var/map
	var/mapcode = "MAIN_MISSION" // This is the code the user must enter into the gateway to journey to your map. Set this to whatever you set the targetid variable of the gateway in your map to be. If you have more than one gateway on an away mission, set it to the code of the gateway you want them to start at.

/obj/item/awaymaploader/beach
	name = "away mission data disk: Beach (Easy)"
	map = '_maps/RandomZLevels/TheBeach.dmm'
	difficulty = "Easy"
	mapcode = "BEACH"

/obj/item/awaymaploader/challenge
	name = "away mission data disk: Challenge (Medium)"
	map = '_maps/RandomZLevels/challenge.dmm'
	unstable = TRUE
	time = 7.5
	mapcode = "CHALLENGE"

/obj/item/awaymaploader/snowcabin
	name = "away mission data disk: Snow Cabin (Easy)"
	unstable = TRUE
	time = 25
	difficulty = "Easy"
	map = '_maps/RandomZLevels/SnowCabin.dmm'
	mapcode = "SNOW_CABIN"

/obj/item/awaymaploader/moonoutpost19
	name = "away mission data disk: Moon Outpost 19 (Medium)"
	unstable = TRUE
	time = 35
	map = '_maps/RandomZLevels/moonoutpost19.dmm'
	mapcode = "MOON_OUTPOST"

/obj/item/awaymaploader/undergroundoutpost45
	name = "away mission data disk: Underground Outpost 45 (Medium)"
	unstable = TRUE
	time = 20
	map = '_maps/RandomZLevels/undergroundoutpost45.dmm'
	mapcode = "UNDERGROUND_OUTPOST"

obj/item/awaymaploader/wildwest
	name = "away mission data disk: Wild West (Medium)"
	map = '_maps/RandomZLevels/wildwest.dmm'
	mapcode = "WILD_WEST"

// Decon disks

/obj/item/reverseengineeringdata
	name = "broken gateway technology disk"
	desc = "Deconstruct this at the RnD lab to reverse engineer new tech."
	icon = 'icons/obj/module.dmi'
	icon_state = "datadisk0"

/obj/item/reverseengineeringdata/basic
	name = "basic gateway technology disk"

/obj/item/reverseengineeringdata/advanced
	name = "advanced gateway technology disk"

/obj/item/reverseengineeringdata/epic // Currently does nothing
	name = "rare gateway technology disk"



