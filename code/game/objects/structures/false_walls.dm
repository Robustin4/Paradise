/*
 * False Walls
 */

// Minimum pressure difference to fail building falsewalls.
// Also affects admin alerts.
#define FALSEDOOR_MAX_PRESSURE_DIFF 25.0

/obj/structure/falsewall
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	anchored = TRUE
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"

	var/mineral = /obj/item/stack/sheet/metal
	var/mineral_amount = 2
	var/walltype = /turf/simulated/wall
	var/girder_type = /obj/structure/girder/displaced
	var/opening = FALSE

	density = TRUE
	opacity = TRUE
	max_integrity = 100

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_SIMULATED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

/obj/structure/falsewall/Initialize(mapload)
	. = ..()
	air_update_turf(1)

/obj/structure/falsewall/examine_status(mob/user)
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(100)
			return "<span class='notice'>It looks fully intact.</span>"
		if(70 to 99)
			return  "<span class='warning'>It looks slightly damaged.</span>"
		if(40 to 70)
			return  "<span class='warning'>It looks moderately damaged.</span>"
		if(0 to 40)
			return "<span class='danger'>It looks heavily damaged.</span>"

/obj/structure/falsewall/ratvar_act()
	new /obj/structure/falsewall/brass(loc)
	qdel(src)

/obj/structure/falsewall/Destroy()
	density = 0
	air_update_turf(1)
	return ..()

/obj/structure/falsewall/CanAtmosPass(turf/T)
	return !density

/obj/structure/falsewall/attack_ghost(mob/user)
	if(user.can_advanced_admin_interact())
		toggle(user)

/obj/structure/falsewall/attack_hand(mob/user)
	toggle(user)

/obj/structure/falsewall/proc/toggle(mob/user)
	if(opening)
		return

	opening = 1
	if(density)
		flick("fwall_opening", src)
		density = 0
		set_opacity(0)
		update_icon()
	else
		var/srcturf = get_turf(src)
		for(var/mob/living/obstacle in srcturf) //Stop people from using this as a shield
			opening = 0
			return
		flick("fwall_closing", src)
		density = 1
		set_opacity(1)
		update_icon()
	air_update_turf(1)
	opening = 0
	update_icon()


/obj/structure/falsewall/update_icon()
	if(opening)
		if(density)
			icon_state = "fwall_opening"
			smoothing_flags = NONE
			clear_smooth_overlays()
		else
			icon_state = "fwall_closing"
	else
		if(density)
			icon_state = initial(icon_state)
			smoothing_flags = SMOOTH_CORNERS
			icon_state = "[base_icon_state]-[smoothing_junction]"
			smoothing_flags = SMOOTH_BITMASK
			QUEUE_SMOOTH(src)
		else
			icon_state = "fwall_open"

/obj/structure/falsewall/proc/ChangeToWall(delete = TRUE)
	var/turf/T = get_turf(src)
	T.ChangeTurf(walltype)
	if(delete)
		qdel(src)
	return T

/obj/structure/falsewall/attackby(obj/item/W, mob/user, params)
	if(opening)
		to_chat(user, "<span class='warning'>You must wait until the door has stopped moving.</span>")
		return

	if(density)
		var/turf/T = get_turf(src)
		if(T.density)
			to_chat(user, "<span class='warning'>[src] is blocked!</span>")
			return
		if(istype(W, /obj/item/screwdriver))
			if(!istype(T, /turf/simulated/floor))
				to_chat(user, "<span class='warning'>[src] bolts must be tightened on the floor!</span>")
				return
			user.visible_message("<span class='notice'>[user] tightens some bolts on the wall.</span>", "<span class='warning'>You tighten the bolts on the wall.</span>")
			ChangeToWall()
	else
		to_chat(user, "<span class='warning'>You can't reach, close it first!</span>")

	if(istype(W, /obj/item/gun/energy/plasmacutter) || istype(W, /obj/item/pickaxe/drill/diamonddrill) || istype(W, /obj/item/pickaxe/drill/jackhammer) || istype(W, /obj/item/melee/energy/blade))
		dismantle(user, TRUE)

/obj/structure/falsewall/welder_act(mob/user, obj/item/I)
	if(!density)
		return
	. = TRUE
	if(!I.use_tool(src, user, volume = I.tool_volume))
		return
	dismantle(user, TRUE)

/obj/structure/falsewall/proc/dismantle(mob/user, disassembled = TRUE)
	user.visible_message("<span class='notice'>[user] dismantles the false wall.</span>", "<span class='warning'>You dismantle the false wall.</span>")
	playsound(src, 'sound/items/welder.ogg', 100, TRUE)
	deconstruct(disassembled)

/obj/structure/falsewall/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		if(disassembled)
			new girder_type(loc)
		if(mineral_amount)
			for(var/i in 1 to mineral_amount)
				new mineral(loc)
	qdel(src)

/*
 * False R-Walls
 */

/obj/structure/falsewall/reinforced
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to seperate rooms."
	icon = 'icons/turf/walls/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	smoothing_flags = SMOOTH_BITMASK
	walltype = /turf/simulated/wall/r_wall
	mineral = /obj/item/stack/sheet/plasteel

/obj/structure/falsewall/reinforced/examine_status(mob/user)
	. = ..()
	. += "<br><span class='notice'>The outer <b>grille</b> is fully intact.</span>"	//not going to fake other states of disassembly

/obj/structure/falsewall/reinforced/ChangeToWall(delete = 1)
	var/turf/T = get_turf(src)
	T.ChangeTurf(/turf/simulated/wall/r_wall)
	if(delete)
		qdel(src)
	return T

/*
 * Uranium Falsewalls
 */

/obj/structure/falsewall/uranium
	name = "uranium wall"
	desc = "A wall with uranium plating. This is probably a bad idea."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium_wall-0"
	base_icon_state = "uranium_wall"
	mineral = /obj/item/stack/sheet/mineral/uranium
	walltype = /turf/simulated/wall/mineral/uranium
	var/active = null
	var/last_event = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_URANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_URANIUM_WALLS)

/obj/structure/falsewall/uranium/attackby(obj/item/W as obj, mob/user as mob, params)
	radiate()
	..()

/obj/structure/falsewall/uranium/attack_hand(mob/user as mob)
	radiate()
	..()

/obj/structure/falsewall/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/L in range(3,src))
				L.apply_effect(12,IRRADIATE,0)
			for(var/turf/simulated/wall/mineral/uranium/T in range(3,src))
				T.radiate()
			last_event = world.time
			active = null
			return
	return
/*
 * Other misc falsewall types
 */

/obj/structure/falsewall/gold
	name = "gold wall"
	desc = "A wall with gold plating. Swag!"
	icon = 'icons/turf/walls/gold_wall.dmi'
	icon_state = "gold_wall-0"
	base_icon_state = "gold_wall"
	mineral = /obj/item/stack/sheet/mineral/gold
	walltype = /turf/simulated/wall/mineral/gold
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_GOLD_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_GOLD_WALLS)

/obj/structure/falsewall/silver
	name = "silver wall"
	desc = "A wall with silver plating. Shiny."
	icon = 'icons/turf/walls/silver_wall.dmi'
	icon_state = "silver"
	mineral = /obj/item/stack/sheet/mineral/silver
	walltype = /turf/simulated/wall/mineral/silver
	canSmoothWith = list(/obj/structure/falsewall/silver, /turf/simulated/wall/mineral/silver)

/obj/structure/falsewall/diamond
	name = "diamond wall"
	desc = "A wall with diamond plating. You monster."
	icon = 'icons/turf/walls/diamond_wall.dmi'
	icon_state = "diamond"
	mineral = /obj/item/stack/sheet/mineral/diamond
	walltype = /turf/simulated/wall/mineral/diamond
	canSmoothWith = list(/obj/structure/falsewall/diamond, /turf/simulated/wall/mineral/diamond)
	max_integrity = 800


/obj/structure/falsewall/plasma
	name = "plasma wall"
	desc = "A wall with plasma plating. This is definately a bad idea."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = "plasma"
	mineral = /obj/item/stack/sheet/mineral/plasma
	walltype = /turf/simulated/wall/mineral/plasma
	canSmoothWith = list(/obj/structure/falsewall/plasma, /turf/simulated/wall/mineral/plasma, /turf/simulated/wall/mineral/alien)

/obj/structure/falsewall/plasma/attackby(obj/item/W, mob/user, params)
	if(is_hot(W) > 300)
		add_attack_logs(user, src, "Ignited using [W]", ATKLOG_FEW)
		investigate_log("was <span class='warning'>ignited</span> by [key_name_log(user)]",INVESTIGATE_ATMOS)
		burnbabyburn()
	else
		return ..()

/obj/structure/falsewall/plasma/proc/burnbabyburn(user)
	playsound(src, 'sound/items/welder.ogg', 100, 1)
	atmos_spawn_air(LINDA_SPAWN_HEAT | LINDA_SPAWN_TOXINS, 400)
	new /obj/structure/girder/displaced(loc)
	qdel(src)

/obj/structure/falsewall/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	..()
	if(exposed_temperature > 300)
		burnbabyburn()

/obj/structure/falsewall/alien
	name = "alien wall"
	desc = "A strange-looking alien wall."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = "plasma"
	mineral = /obj/item/stack/sheet/mineral/abductor
	walltype = /turf/simulated/wall/mineral/abductor
	canSmoothWith = list(/obj/structure/falsewall/alien, /turf/simulated/wall/mineral/alien)


/obj/structure/falsewall/bananium
	name = "bananium wall"
	desc = "A wall with bananium plating. Honk!"
	icon = 'icons/turf/walls/bananium_wall.dmi'
	icon_state = "bananium"
	mineral = /obj/item/stack/sheet/mineral/bananium
	walltype = /turf/simulated/wall/mineral/bananium
	canSmoothWith = list(/obj/structure/falsewall/bananium, /turf/simulated/wall/mineral/bananium)

/obj/structure/falsewall/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone"
	mineral = /obj/item/stack/sheet/mineral/sandstone
	walltype = /turf/simulated/wall/mineral/sandstone
	canSmoothWith = list(/obj/structure/falsewall/sandstone, /turf/simulated/wall/mineral/sandstone)

/obj/structure/falsewall/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood"
	mineral = /obj/item/stack/sheet/wood
	walltype = /turf/simulated/wall/mineral/wood
	canSmoothWith = list(/obj/structure/falsewall/wood, /turf/simulated/wall/mineral/wood)

/obj/structure/falsewall/iron
	name = "rough metal wall"
	desc = "A wall with rough metal plating."
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = "iron"
	mineral = /obj/item/stack/rods
	mineral_amount = 5
	walltype = /turf/simulated/wall/mineral/iron
	canSmoothWith = list(/obj/structure/falsewall/iron, /turf/simulated/wall/mineral/iron)

/obj/structure/falsewall/abductor
	name = "alien wall"
	desc = "A wall with alien alloy plating."
	icon = 'icons/turf/walls/abductor_wall.dmi'
	icon_state = "abductor"
	mineral = /obj/item/stack/sheet/mineral/abductor
	walltype = /turf/simulated/wall/mineral/abductor
	canSmoothWith = list(/obj/structure/falsewall/abductor, /turf/simulated/wall/mineral/abductor)

/obj/structure/falsewall/titanium
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon = 'icons/turf/walls/plastinum_wall.dmi'
	icon_state = "plastinum_wall-0"
	base_icon_state = "plastinum_wall"
	mineral = /obj/item/stack/sheet/mineral/titanium
	walltype = /turf/simulated/wall/mineral/titanium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)

/obj/structure/falsewall/plastitanium
	desc = "An evil wall of plasma and titanium."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	mineral = /obj/item/stack/sheet/mineral/plastitanium
	walltype = /turf/simulated/wall/mineral/plastitanium
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)

/obj/structure/falsewall/brass
	name = "clockwork wall"
	desc = "A huge chunk of warm metal. The clanging of machinery emanates from within."
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	mineral_amount = 1
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_BRASS_WALL)
	smoothing_flags = SMOOTH_CORNERS
	girder_type = /obj/structure/clockwork/wall_gear/displaced
	walltype = /turf/simulated/wall/clockwork
	mineral = /obj/item/stack/sheet/brass

/obj/structure/falsewall/brass/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/temp_visual/ratvar/wall/false(T)
	new /obj/effect/temp_visual/ratvar/beam/falsewall(T)

/obj/structure/falsewall/clockwork/attack_hand(mob/user)
	if(!isclocker(user))
		user.changeNext_move(CLICK_CD_MELEE)
		to_chat(user, "<span class='notice'>You push the wall but nothing happens!</span>")
		playsound(src, 'sound/weapons/genhit.ogg', 25, 1) //sneaky
		return FALSE
	return ..()

/obj/structure/falsewall/clockwork/welder_act(mob/user, obj/item/I)
	if(!density)
		return
	WELDER_ATTEMPT_SLICING_MESSAGE
	if(I.use_tool(src, user, 120, volume = I.tool_volume)) // 20% more than double normal wall.
		dismantle(user, TRUE)

/obj/structure/falsewall/clockwork/attackby(obj/item/W, mob/user, params)
	if(opening)
		to_chat(user, "<span class='warning'>You must wait until the door has stopped moving.</span>")
		return FALSE

	if(density)
		var/turf/T = get_turf(src)
		if(T.density)
			to_chat(user, "<span class='warning'>[src] is blocked!</span>")
			return FALSE

	if(istype(W, /obj/item/gun/energy/plasmacutter) || istype(W, /obj/item/pickaxe/drill/diamonddrill) || istype(W, /obj/item/pickaxe/drill/jackhammer) || istype(W, /obj/item/melee/energy/blade))
		dismantle(user, TRUE)
		return TRUE
	return TRUE
