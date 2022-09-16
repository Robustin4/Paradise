//Types of usual mutations
#define	POSITIVE 			1
#define	NEGATIVE			2
#define	MINOR_NEGATIVE		3

/datum/event/spacevine/start()

	processing = 0

	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/obj/structure/spacevine/SV = new()

	for(var/area/hallway/A in world)
		for(var/turf/F in A)
			if(F.Enter(SV))
				turfs += F

	for(var/area/crew_quarters/sleep/A2 in world)
		for(var/turf/F in A2)
			if(F.Enter(SV))
				turfs += F

	for(var/area/crew_quarters/locker/A3 in world)
		for(var/turf/F in A3)
			if(F.Enter(SV))
				turfs += F

	for(var/area/bridge/vip/A4 in world)
		for(var/turf/F in A4)
			if(F.Enter(SV))
				turfs += F

	for(var/area/medical/research/A5 in world)
		for(var/turf/F in A5)
			if(F.Enter(SV))
				turfs += F

	for(var/area/security/permahallway/A6 in world)
		for(var/turf/F in A6)
			if(F.Enter(SV))
				turfs += F

	for(var/area/security/securehallway/A7 in world)
		for(var/turf/F in A7)
			if(F.Enter(SV))
				turfs += F

	for(var/area/medical/medbay/A8 in world)
		for(var/turf/F in A8)
			if(F.Enter(SV))
				turfs += F

	for(var/area/medical/medbay2/A9 in world)
		for(var/turf/F in A9)
			if(F.Enter(SV))
				turfs += F

	for(var/area/medical/virology/A10 in world)
		for(var/turf/F in A10)
			if(F.Enter(SV))
				turfs += F

	qdel(SV)

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/T = pick(turfs)

		var/obj/structure/spacevine_controller/SC = new /obj/structure/spacevine_controller(T, , rand(30,70),rand(5,2)) //spawn a controller at turf

		notify_ghosts("Лоза выросла в [get_area(T)].", source = SV, action = NOTIFY_FOLLOW)
		message_admins("Spacevine has been spawned in [T.loc.name] [ADMIN_COORDJMP(T)] ")
		log_game("Spacevine has been spawned in [T.loc.name] [COORD(T)] ")

		// Make the event start fun - give the vine a random hostile mutation
		if(SC.vines.len)
			SV = SC.vines[1]
			var/list/mutations = SC.mutations_list.Copy()
			while(mutations.len)
				var/datum/spacevine_mutation/SM = pick_n_take(mutations)
				if(SM.quality == NEGATIVE && !SM.nofun)
					SM.add_mutation_to_vinepiece(SV)
					break
			mutations.Cut()
			mutations = null

		var/list/candidates = SSghost_spawns.poll_candidates("Вы хотите занять роль Лозы?", ROLE_BLOB, TRUE , 15 SECONDS)

		var/mob/candidate = pick(candidates)

		if(candidate)
			var/mob/camera/vine/cam = new /mob/camera/vine(T)
			cam.central_vine = SV
			cam.init = FALSE
			cam.key = candidate.key
			SV.tied_to_cam = cam
			message_admins("[key_name_admin(cam)] выбран на роль Лозы по событию.")
			log_game("[key_name_admin(cam)] выбран на роль Лозы по событию.")
		else
			message_admins("Никто не был выбран на роль Лозы по событию.")
			log_game("Никто не был выбран на роль Лозы по событию.")

/datum/spacevine_mutation
	var/name = ""
	var/severity = 1
	var/hue
	var/quality
	// For stuff that isn't fun as a random-event vine
	var/nofun = FALSE

/datum/spacevine_mutation/proc/add_mutation_to_vinepiece(obj/structure/spacevine/holder)
	holder.mutations |= src
	holder.color = hue

/datum/spacevine_mutation/proc/remove_mutation_from_vinepiece(obj/structure/spacevine/holder)
	holder.mutations -= src
	var/datum/spacevine_mutation/oldmutation
	if(holder.mutations.len)
		oldmutation = pick(holder.mutations)
		holder.color = oldmutation.hue
	else
		holder.color = ""

/datum/spacevine_mutation/proc/process_mutation(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/process_temperature(obj/structure/spacevine/holder, temp, volume)
	return

/datum/spacevine_mutation/proc/on_birth(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_grow(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_death(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_deletion(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_hit(obj/structure/spacevine/holder, mob/hitter, obj/item/I, expected_damage)
	. = expected_damage

/datum/spacevine_mutation/proc/on_cross(obj/structure/spacevine/holder, mob/crosser)
	return

/datum/spacevine_mutation/proc/on_chem(obj/structure/spacevine/holder, datum/reagent/R)
	return

/datum/spacevine_mutation/proc/on_eat(obj/structure/spacevine/holder, mob/living/eater)
	return

/datum/spacevine_mutation/proc/on_spread(obj/structure/spacevine/holder, turf/target)
	return

/datum/spacevine_mutation/proc/on_buckle(obj/structure/spacevine/holder, mob/living/buckled)
	return

/datum/spacevine_mutation/proc/on_explosion(severity, obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_search(severity, obj/structure/spacevine/holder)
	return


/datum/spacevine_mutation/space_covering
	name = "space protective"
	hue = "#aa77aa"
	quality = POSITIVE

/turf/simulated/floor/vines
	color = "#aa77aa"
	icon_state = "vinefloor"
	broken_states = list()


//All of this shit is useless for vines

/turf/simulated/floor/vines/attackby()
	return

/turf/simulated/floor/vines/burn_tile()
	return

/turf/simulated/floor/vines/break_tile()
	return

/turf/simulated/floor/vines/make_plating()
	return

/turf/simulated/floor/vines/break_tile_to_plating()
	return

/turf/simulated/floor/vines/ex_act(severity)
	if(severity < 3)
		ChangeTurf(baseturf)

/turf/simulated/floor/vines/narsie_act()
	if(prob(20))
		ChangeTurf(baseturf) //nar sie eats this shit

/turf/simulated/floor/vines/singularity_pull(S, current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(50))
			ChangeTurf(baseturf)

/turf/simulated/floor/vines/ChangeTurf(turf/simulated/floor/T, defer_change = FALSE, keep_icon = TRUE, ignore_air = FALSE)
	. = ..()
	//Do this *after* the turf has changed as qdel in spacevines will call changeturf again if it hasn't
	for(var/obj/structure/spacevine/SV in src)
		SV.wither()

/datum/spacevine_mutation/space_covering
	var/static/list/coverable_turfs

/datum/spacevine_mutation/space_covering/New()
	. = ..()
	if(!coverable_turfs)
		coverable_turfs = typecacheof(list(
			/turf/space
		))
		coverable_turfs -= typecacheof(list(
			/turf/space/transit
		))

/datum/spacevine_mutation/space_covering/on_grow(obj/structure/spacevine/holder)
	process_mutation(holder)

/datum/spacevine_mutation/space_covering/on_spread(obj/structure/spacevine/holder, turf/target)
	if(target.type == /turf/space && !locate(/obj/structure/spacevine) in target)
		holder.master.spawn_spacevine_piece(target, holder)
		. = TRUE

/datum/spacevine_mutation/space_covering/process_mutation(obj/structure/spacevine/holder)
	var/turf/T = get_turf(holder)
	if(is_type_in_typecache(T, coverable_turfs))
		var/currtype = T.type
		T.ChangeTurf(/turf/simulated/floor/vines)
		T.baseturf = currtype

/datum/spacevine_mutation/space_covering/on_deletion(obj/structure/spacevine/holder)
	var/turf/T = get_turf(holder)
	if(istype(T, /turf/simulated/floor/vines))
		T.ChangeTurf(T.baseturf)

/datum/spacevine_mutation/bluespace
	name = "bluespace"
	hue = "#3333ff"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/bluespace/on_spread(obj/structure/spacevine/holder, turf/target)
	if(holder.energy > 1 && !locate(/obj/structure/spacevine) in target)
		// Lose bluespace upon piercing a single tile, and drop it from our own mutations too
		// Representing a loss in "high potential"
		// also conveniently prevents this from spreading too crazily
		remove_mutation_from_vinepiece(holder)
		holder.master.spawn_spacevine_piece(target, holder)
		playsound(holder, 'sound/misc/interference.ogg', 50, 1)
		. = TRUE

/datum/spacevine_mutation/light
	name = "light"
	hue = "#ffff00"
	quality = POSITIVE
	severity = 4

/datum/spacevine_mutation/light/on_grow(obj/structure/spacevine/holder)
	if(holder.energy)
		holder.set_light(severity)

/datum/spacevine_mutation/toxicity
	name = "toxic"
	hue = "#ff00ff"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/toxicity/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(issilicon(crosser))
		return
	if(prob(severity) && istype(crosser) && !isvineimmune(crosser))
		to_chat(crosser, "<span class='alert'>You accidently touch the vine and feel a strange sensation.</span>")
		crosser.adjustToxLoss(5)

/datum/spacevine_mutation/toxicity/on_eat(obj/structure/spacevine/holder, mob/living/eater)
	if(!isvineimmune(eater))
		eater.adjustToxLoss(5)

/datum/spacevine_mutation/explosive  //OH SHIT IT CAN CHAINREACT RUN!!!
	name = "explosive"
	hue = "#ff0000"
	quality = NEGATIVE
	severity = 2
	// kaboom events aren't fun
	nofun = TRUE

/datum/spacevine_mutation/explosive/on_explosion(explosion_severity, obj/structure/spacevine/holder)
	if(explosion_severity < 3)
		qdel(holder)
	else
		. = 1
		spawn(5)
			holder.wither()

/datum/spacevine_mutation/explosive/on_death(obj/structure/spacevine/holder, mob/hitter, obj/item/I)
	explosion(holder.loc, 0, 0, severity, 0, 0)

/datum/spacevine_mutation/fire_proof
	name = "fire proof"
	hue = "#ff8888"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/fire_proof/process_temperature(obj/structure/spacevine/holder, temp, volume)
	return 1

/datum/spacevine_mutation/fire_proof/on_hit(obj/structure/spacevine/holder, mob/hitter, obj/item/I, expected_damage)
	if(I && I.damtype == "fire")
		. = 0
	else
		. = expected_damage

/datum/spacevine_mutation/vine_eating
	name = "vine eating"
	hue = "#ff7700"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/vine_eating/on_spread(obj/structure/spacevine/holder, turf/target)
	var/obj/structure/spacevine/prey = locate() in target
	if(prey && !prey.mutations.Find(src))  //Eat all vines that are not of the same origin
		prey.wither()
		. = TRUE

/datum/spacevine_mutation/aggressive_spread  //very OP, but im out of other ideas currently
	name = "aggressive spreading"
	hue = "#333333"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/aggressive_spread/on_spread(obj/structure/spacevine/holder, turf/target)
	if(istype(target, /turf/simulated/wall/r_wall))
		// Too tough to pierce - should lead to interesting spread patterns
		return
	// Bust through windows or other stuff blocking the way
	if(!target.Enter(holder))
		for(var/atom/movable/AM in target)
			if(istype(AM, /obj/structure/spacevine) || !AM.density)
				continue
			AM.ex_act(severity)
	target.ex_act(severity) // vine immunity handled at /mob/ex_act
	. = TRUE

/datum/spacevine_mutation/aggressive_spread/on_buckle(obj/structure/spacevine/holder, mob/living/buckled)
	buckled.ex_act(severity)

/datum/spacevine_mutation/transparency
	name = "transparent"
	hue = ""
	quality = POSITIVE

/datum/spacevine_mutation/transparency/on_grow(obj/structure/spacevine/holder)
	holder.set_opacity(0)
	holder.alpha = 125

/datum/spacevine_mutation/thorns
	name = "thorny"
	hue = "#666666"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/thorns/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(prob(severity) && istype(crosser) && !isvineimmune(holder))
		var/mob/living/M = crosser
		M.adjustBruteLoss(5)
		to_chat(M, "<span class='alert'>You cut yourself on the thorny vines.</span>")

/datum/spacevine_mutation/thorns/on_hit(obj/structure/spacevine/holder, mob/living/hitter, obj/item/I, expected_damage)
	if(prob(severity) && istype(hitter) && !isvineimmune(holder))
		var/mob/living/M = hitter
		M.adjustBruteLoss(5)
		to_chat(M, "<span class='alert'>You cut yourself on the thorny vines.</span>")
	. =	expected_damage

/datum/spacevine_mutation/woodening
	name = "hardened"
	hue = "#997700"
	quality = NEGATIVE

/datum/spacevine_mutation/woodening/on_grow(obj/structure/spacevine/holder)
	if(holder.energy)
		holder.density = TRUE
	holder.max_integrity = 100
	holder.obj_integrity = holder.max_integrity

/datum/spacevine_mutation/woodening/on_hit(obj/structure/spacevine/holder, mob/living/hitter, obj/item/I, expected_damage)
	if(!is_sharp(I))
		. = expected_damage * 0.5
	else
		. = expected_damage

/datum/spacevine_mutation/flowering
	name = "flowering"
	hue = "#0A480D"
	quality = NEGATIVE
	severity = 10

/datum/spacevine_mutation/flowering/on_grow(obj/structure/spacevine/holder)
	if(holder.energy == 2 && prob(severity) && !locate(/obj/structure/alien/resin/flower_bud_enemy || /obj/structure/alien/resin/flower_bud || /obj/structure/alien/resin/giant_tomato) in range(6,holder))
		if(prob(44))
			new /obj/structure/alien/resin/flower_bud_enemy(get_turf(holder))
		else if(prob(77))
			new /obj/structure/alien/resin/giant_tomato(get_turf(holder))
		else
			new /obj/structure/alien/resin/flower_bud(get_turf(holder))

/datum/spacevine_mutation/flowering/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(prob(25))
		holder.entangle(crosser)


/datum/spacevine_mutation/virulent_spread
	name = "virulently spreading"
	hue = "#FF8080"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/virulent_spread/on_search(obj/structure/spacevine/holder)
	return 1

// Sure, let's encourage crew members to deliberately breed a highly dangerous
// threat. What could *possibly* go wrong? ;)
/datum/spacevine_mutation/mineral
	name = "metallic"
	hue = "#444444"
	quality = POSITIVE
	severity = 3
	var/drop_rate = 20
	var/list/mineral_results = list(
	/obj/item/stack/sheet/metal = 1
	)

/datum/spacevine_mutation/mineral/on_death(obj/structure/spacevine/holder)
	if(!prob(drop_rate))
		return
	var/itemtype = pickweight(mineral_results)
	var/turf/pos = get_turf(holder)
	new itemtype(pos, severity)

/datum/spacevine_mutation/mineral/valuables
	name = "glimmering"
	hue = "#888800"
	drop_rate = 10
	mineral_results = list(
	/obj/item/stack/sheet/mineral/silver = 4,
	/obj/item/stack/sheet/mineral/gold = 2,
	/obj/item/stack/sheet/mineral/diamond = 1
	)

/datum/spacevine_mutation/mineral/glass
	name = "glassy"
	hue = "#8888FF"
	mineral_results = list(
	/obj/item/stack/sheet/glass = 1
	)

/datum/spacevine_mutation/mineral/plastic
	name = "plasticine"
	hue = "#222288"
	mineral_results = list(
	/obj/item/stack/sheet/plastic = 1
	)

/datum/spacevine_mutation/mineral/wood
	name = "wooden"
	hue = "#442200"
	mineral_results = list(
	/obj/item/stack/sheet/wood = 1
	)

// SPACE VINES (Note that this code is very similar to Biomass code)
/obj/structure/spacevine
	name = "space vines"
	desc = "An extremely expansionistic species of vine."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Light1"
	anchored = TRUE
	density = FALSE
	layer = SPACEVINE_LAYER
	mouse_opacity = MOUSE_OPACITY_OPAQUE //Clicking anywhere on the turf is good enough
	pass_flags = PASSTABLE | PASSGRILLE
	max_integrity = 50
	var/energy = 0
	var/obj/structure/spacevine_controller/master = null
	var/list/mutations = list()
	var/tied_to_cam = null

/obj/structure/spacevine/blob_act(obj/structure/spacevine)
	return

/obj/structure/spacevine/Initialize(mapload)
	. = ..()
	color = "#ffffff"

/obj/structure/spacevine/examine(mob/user)
	. = ..()
	var/text = "This one is a"
	if(mutations.len)
		for(var/A in mutations)
			var/datum/spacevine_mutation/SM = A
			text += " [SM.name]"
	else
		text += " normal"
	text += " vine."
	. += text

/obj/structure/spacevine/proc/wither()
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_death(src)
	qdel(src)


/obj/structure/spacevine/Destroy()
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_deletion(src)
	if(master)
		master.vines -= src
		master.growth_queue -= src
		if(!master.vines.len)
			var/obj/item/seeds/kudzu/KZ = new(loc)
			KZ.mutations |= mutations
			KZ.set_potency(10 ** sqrt(master.mutativeness))
			KZ.set_production(10 - (master.spread_cap / 10))
			qdel(master)
	master = null
	mutations.Cut()
	set_opacity(0)
	qdel(tied_to_cam)
	if(has_buckled_mobs())
		unbuckle_all_mobs(force = TRUE)
	return ..()

/obj/structure/spacevine/proc/add_mutation(datum/spacevine_mutation/mutation)
	mutations |= mutation
	color = mutation.hue

/obj/structure/spacevine/proc/on_chem_effect(datum/reagent/R)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.on_chem(src, R)
	if(!override && istype(R, /datum/reagent/glyphosate))
		if(prob(50))
			wither()

/obj/structure/spacevine/proc/eat(mob/eater)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.on_eat(src, eater)
	if(!override)
		if(prob(10))
			eater.say("Nom")
		wither()

/obj/structure/spacevine/attacked_by(obj/item/I, mob/living/user)
	var/damage_dealt = I.force
	if(istype(I, /obj/item/scythe))
		var/obj/item/scythe/S = I
		if(S.extend)	//so folded telescythes won't get damage boosts / insta-clears (they instead will instead be treated like non-scythes)
			damage_dealt *= 4
			for(var/obj/structure/spacevine/B in range(1,src))
				if(B.obj_integrity > damage_dealt)	//this only is going to occur for woodening mutation vines (increased health) or if we nerf scythe damage/multiplier
					B.take_damage(damage_dealt, I.damtype, "melee", 1)
				else
					B.wither()
			return
	if(is_sharp(I))
		damage_dealt *= 4
	if(I.damtype == BURN)
		damage_dealt *= 4

	for(var/datum/spacevine_mutation/SM in mutations)
		damage_dealt = SM.on_hit(src, user, I, damage_dealt) //on_hit now takes override damage as arg and returns new value for other mutations to permutate further
	take_damage(damage_dealt, I.damtype, "melee", 1)

/obj/structure/spacevine/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/weapons/slash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/spacevine/obj_destruction()
	wither()

/obj/structure/spacevine/Crossed(mob/crosser, oldloc)
	if(isliving(crosser))
		for(var/datum/spacevine_mutation/SM in mutations)
			SM.on_cross(src, crosser)

/obj/structure/spacevine/attack_hand(mob/user)
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_hit(src, user)
	user_unbuckle_mob(user, user)

/obj/structure/spacevine/attack_alien(mob/living/user)
	eat(user)

/obj/structure/spacevine_controller
	invisibility = 101
	var/list/obj/structure/spacevine/vines = list()
	var/list/growth_queue = list()
	var/spread_multiplier = 5
	var/spread_cap = 30
	var/list/mutations_list = list()
	var/mutativeness = 1

/obj/structure/spacevine_controller/New(loc, list/muts, potency, production)
	color = "#ffffff"
	spawn_spacevine_piece(loc, , muts)
	START_PROCESSING(SSobj, src)
	init_subtypes(/datum/spacevine_mutation/, mutations_list)
	if(potency != null && potency > 0)
		// 1 mutativeness at 10 potency
		// 4 mutativeness at 100 potency
		mutativeness = log(10, potency) ** 2
	if(production != null)
		// 1 production is crazy powerful
		var/spread_value = max(10 - production, 1)
		// 40 at 6 production
		// 90 at 1 production
		spread_cap = spread_value * 10
		// 6 vines/spread at 6 production
		// ~2.5 vines/spread at 1 production
		spread_multiplier /= spread_value / 5
	..()


/obj/structure/spacevine_controller/ex_act() //only killing all vines will end this suffering
	return

/obj/structure/spacevine_controller/singularity_act()
	return

/obj/structure/spacevine_controller/singularity_pull()
	return

/obj/structure/spacevine_controller/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/spacevine_controller/proc/spawn_spacevine_piece(turf/location, obj/structure/spacevine/parent, list/muts)
	var/obj/structure/spacevine/SV = new(location)
	growth_queue += SV
	vines += SV
	SV.master = src
	if(muts && muts.len)
		for(var/datum/spacevine_mutation/M in muts)
			M.add_mutation_to_vinepiece(SV)
		return
	if(parent)
		SV.mutations |= parent.mutations
		SV.color = parent.color
		if(prob(mutativeness))
			var/list/random_mutations_picked = mutations_list - SV.mutations
			if(random_mutations_picked.len)
				var/datum/spacevine_mutation/randmut = pick(random_mutations_picked)
				randmut.add_mutation_to_vinepiece(SV)

	for(var/datum/spacevine_mutation/SM in SV.mutations)
		SM.on_birth(SV)

/obj/structure/spacevine_controller/process()
	if(!vines || !vines.len)
		qdel(src) //space vines exterminated. Remove the controller
		return
	if(!growth_queue)
		qdel(src) //Sanity check
		return

	var/length = 0

	length = min( spread_cap , max( 1 , vines.len / spread_multiplier ) )
	var/i = 0
	var/list/obj/structure/spacevine/queue_end = list()

	for(var/obj/structure/spacevine/SV in growth_queue)
		if(QDELETED(SV))
			continue
		i++
		queue_end += SV
		growth_queue -= SV
		for(var/datum/spacevine_mutation/SM in SV.mutations)
			SM.process_mutation(SV)
		if(SV.energy < 2) //If tile isn't fully grown
			if(prob(20))
				SV.grow()
		else //If tile is fully grown
			SV.entangle_mob()

		//if(prob(25))
		SV.spread()
		if(i >= length)
			break

	growth_queue = growth_queue + queue_end

/obj/structure/spacevine/proc/grow()
	if(!energy)
		icon_state = pick("Med1", "Med2", "Med3")
		energy = 1
		set_opacity(1)
	else
		icon_state = pick("Hvy1", "Hvy2", "Hvy3")
		energy = 2

	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_grow(src)

/obj/structure/spacevine/proc/entangle_mob()
	if(!has_buckled_mobs() && prob(25))
		for(var/mob/living/V in loc)
			entangle(V)
			if(has_buckled_mobs())
				break //only capture one mob at a time


/obj/structure/spacevine/proc/entangle(mob/living/V)
	if(!V || isvineimmune(V))
		return
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_buckle(src, V)
	if((V.stat != DEAD) && (V.buckled != src)) //not dead or captured
		to_chat(V, "<span class='danger'>The vines [pick("wind", "tangle", "tighten")] around you!</span>")
		buckle_mob(V, 1)

/obj/structure/spacevine/proc/spread()
	var/list/dir_list = GLOB.cardinal.Copy()
	var/spread_search = FALSE // Whether to exhaustive search all 4 cardinal dirs for an open direction
	for(var/datum/spacevine_mutation/SM in mutations)
		spread_search |= SM.on_search(src)
	while(dir_list.len)
		var/direction = pick(dir_list)
		dir_list -= direction
		var/turf/stepturf = get_step(src,direction)
		var/spread_success = FALSE
		for(var/datum/spacevine_mutation/SM in mutations)
			spread_success |= SM.on_spread(src, stepturf) // If this returns 1, spreading succeeded
		if(!locate(/obj/structure/spacevine, stepturf))
			// snowflake for space turf, but space turf is super common and a big deal
			if(!istype(stepturf, /turf/space) && stepturf.Enter(src))
				if(master)
					master.spawn_spacevine_piece(stepturf, src)
				spread_success = TRUE
		if(spread_success || !spread_search)
			break

/obj/structure/spacevine/ex_act(severity)
	var/i
	for(var/datum/spacevine_mutation/SM in mutations)
		i += SM.on_explosion(severity, src)
	if(!i && prob(100/severity))
		wither()

/obj/structure/spacevine/temperature_expose(null, temp, volume)
	..()
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.process_temperature(src, temp, volume)
	if(!override)
		wither()

/obj/structure/spacevine/CanPass(atom/movable/mover, turf/target, height=0)
	if(isvineimmune(mover))
		. = TRUE
	else
		. = ..()

/proc/isvineimmune(atom/A)
	. = FALSE
	if(isliving(A))
		var/mob/living/M = A
		if(("vines" in M.faction) || ("plants" in M.faction))
			. = TRUE

/obj/structure/spacevine/attack_animal(mob/living/simple_animal/M)
	if("vines" in M.faction)
		return
	..()

/mob/camera/vine
	name = "Spacevine The Root Council"
	real_name = "Spacevine The Root Council"
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "marker"

	invisibility = INVISIBILITY_OBSERVER
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	see_in_dark = 9999
	sight = SEE_MOBS | SEE_SELF | SEE_TURFS | SEE_OBJS

	faction = list("hostile","vines","plants")

	var/obj/structure/spacevine/central_vine = null // first vine structure
	var/vine_points = 100
	var/max_vine_points = 400
	var/init = TRUE
	var/splited = FALSE
	//var/datum/spacevine_mutation/vine_mutation

/mob/camera/vine/New()
	..()

	add_language("Root Connection")

	var/new_name = "[initial(name)] ([rand(1, 999)])"
	name = new_name
	real_name = new_name

	var/time = rand(10,100)

	addtimer(CALLBACK(src, .proc/add_points), time)

/mob/camera/vine/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/mob/camera/vine/proc/add_points()

	var/how_many_points_to_add = rand(0,40)

	if(how_many_points_to_add + vine_points > 400)
		how_many_points_to_add = 0
		var/a = vine_points
		a -= 400
		vine_points -= a

	while(how_many_points_to_add > 0)
		how_many_points_to_add--
		vine_points++

	again_points()

/mob/camera/vine/proc/again_points()

	var/time = rand(10,100)

	sleep(time)

	add_points()

/mob/camera/vine/process()
	if(!central_vine)
		qdel(src)

/mob/camera/vine/Login()
	..()

	sync_mind()

/*
	update_health_hud()

/mob/camera/vine/update_health_hud()
	if(central_vine && hud_used)
		hud_used.vinehealthdisplay.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#e36600'>[round(central_vine.obj_integrity)]</font></div>"
*/

/*

/mob/camera/vine/proc/add_points(var/points)
	points = rand(0,4)
	vine_points = clamp(vine_points + points, 0, max_vine_points)
		//if(hud_used)
			//hud_used.blobpwrdisplay.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#82ed00'>[round(src.blob_points)]</font></div>"

*/

/mob/camera/vine/say(var/message)
	if(!message)
		return

	if(src.client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, "You cannot send IC messages (muted).")
			return
		if(src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if(stat)
		return

	vine_talk(message)

/mob/camera/vine/proc/vine_talk(message)
	log_say("(Vine) [message]", src)

	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	if(!message)
		return

	var/verb = "states,"
	var/rendered = "<font color=\"#006400\"><i><span class='game say'>Root Connection, <span class='name'>[name]</span> <span class='message'>[verb] <b>\"[message]\"</b></span></span></i></font>"

	for(var/mob/M in GLOB.mob_list)
		if(isvinecouncil(M) || isobserver(M))
			if(("vines" in M.faction))
				M.show_message(rendered, 2)

/mob/camera/vine/emote(act, m_type = 1, message = null, force)
	return

/mob/camera/vine/blob_act(obj/structure/spacevine)
	return

/mob/camera/vine/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Space-o-synthesis points Stored: [src.vine_points]/[src.max_vine_points]")

/mob/camera/vine/Move(atom/destination)

	if(world.time < last_movement)
		return
	last_movement = world.time + 0.2 // cap to idk fps

	var/obj/structure/spacevine/sv = locate() in range("10x10", destination)
	if(sv)
		var/oldloc = loc
		loc = destination
		Moved(oldloc, NONE)
	else
		return 0

/mob/camera/vine/verb/transport_central_vine()
	set category = "Vine"
	set name = "Jump to Central Vine"
	set desc = "Transport back to your central vine."

	if(central_vine)
		src.loc = central_vine.loc

/mob/camera/vine/verb/expand_vine()
	set category = "Vine"
	set name = "Expand Vine (40)"
	set desc = "Attempts to create a new vine in this tile."

	var/turf/T = get_turf(src)

	var/cost = 40

	if(vine_points >= cost)
		vine_points -= cost
	else
		return

	if(!locate(/obj/structure/spacevine, T))
		// var/obj/structure/spacevine/vine = new /obj/structure/spacevine(T)

		for(var/obj/structure/spacevine/SV in range(src, 4))
			for(var/datum/spacevine_mutation/SM in SV.mutations)
				SM.process_mutation(SV)
				//SV.grow()
				SV.spread()

/mob/camera/vine/verb/grow_vine()
	set category = "Vine"
	set name = "Grow Vine (25)"
	set desc = "Attempts to grow vine in this tile."

	var/turf/T = get_turf(src)

	var/cost = 25

	if(vine_points >= cost)
		vine_points -= cost
	else
		return

	if(!locate(/obj/structure/spacevine, T))
		// var/obj/structure/spacevine/vine = new /obj/structure/spacevine(T)

		for(var/obj/structure/spacevine/SV in range(src, 4))
			for(var/datum/spacevine_mutation/SM in SV.mutations)
				SM.process_mutation(SV)
				SV.grow()
				//SV.spread()

/mob/camera/vine/verb/destroy_objects()
	set category = "Vine"
	set name = "Destroy Objects (25)"
	set desc = "Attempts to destroy objects in this tile."

	var/cost = 25

	var/radius = 2

	var/dmg = 0.1

	if(vine_points >= cost)
		vine_points -= cost
	else
		return

	for(var/obj/structure/str in range(src, radius))
		str -= /obj/structure/spacevine
		str -= /obj/structure/spacevine_controller
		str.ex_act(dmg)

	for(var/obj/machinery/mcha in range(src, radius))
		mcha.ex_act(dmg)

	for(var/obj/spacepod/sp in range(src, radius))
		sp.ex_act(dmg)

	for(var/obj/vehicle/vh in range(src, radius))
		vh.ex_act(dmg)


/mob/camera/vine/verb/create_tomato()
	set category = "Vine"
	set name = "Create tomato(20)"
	set desc = "Making a fast growing and walking minion. He's weak."

	var/cost = 20

	if(vine_points >= cost)
		vine_points -= cost
		new /obj/structure/alien/resin/giant_tomato(src.loc)

/mob/camera/vine/verb/create_venus()
	set category = "Vine"
	set name = "Create venus human trap(60)"
	set desc = "Making an average minion."

	var/cost = 60

	if(vine_points >= cost)
		vine_points -= cost
		new /obj/structure/alien/resin/flower_bud_enemy(src.loc)

/mob/camera/vine/verb/create_red_piranha()
	set category = "Vine"
	set name = "Create venus red piranha(80)"
	set desc = "Making a very strong, but slow minion."

	var/cost = 80

	if(vine_points >= cost)
		vine_points -= cost
		new /obj/structure/alien/resin/flower_bud(src.loc)

/mob/camera/vine/verb/rally_thorns()
	set category = "Vine"
	set name = "Attack this point order"
	set desc = "Sending your not sentient minions attack position of your location."

	var/turf/T = get_turf(src)
	rally_thorns_proc(T)

/mob/camera/vine/proc/rally_thorns_proc(var/turf/T)
	to_chat(src, "You rally your thorns.")

	var/list/surrounding_turfs = block(locate(T.x - 1, T.y - 1, T.z), locate(T.x + 1, T.y + 1, T.z))
	if(!surrounding_turfs.len)
		return

	for(var/mob/living/simple_animal/hostile/VineMinion in GLOB.alive_mob_list)
		if(isturf(VineMinion.loc) && get_dist(VineMinion, T) <= 40 && ("vines" in VineMinion.faction) && !VineMinion.key)
			VineMinion.LoseTarget()
			VineMinion.Goto(pick(surrounding_turfs), VineMinion.move_to_delay)
	return

/mob/camera/vine/verb/new_council()
	set category = "Vine"
	set name = "New Root Council(400)"
	set desc = "Making an another sentient Root Concil if someone want it and only one once. He cant split and have same central vine as you..."

	var/cost = 400

	to_chat(src, "Waiting for soul in 15 seconds. Dont do things to make your points lower 400.")

	if(vine_points < cost || splited)
		return

	var/list/candidates = SSghost_spawns.poll_candidates("Вы хотите занять роль Лозы?", ROLE_BLOB, TRUE , 15 SECONDS)

	var/mob/candidate = pick(candidates)

	if(candidate && vine_points >= cost)
		var/turf/T = get_turf(src)
		var/mob/camera/vine/cam = new /mob/camera/vine(T)
		splited = TRUE
		cam.central_vine = src.central_vine
		vine_points -= cost
		to_chat(src, "A new Root Council was created.")
		cam.init = FALSE
		cam.splited = TRUE
		cam.key = candidate.key
		message_admins("[key_name_admin(cam)] выбран на роль Лозы при разделении.")
		log_game("[key_name_admin(cam)] выбран на роль Лозы при разделении.")
