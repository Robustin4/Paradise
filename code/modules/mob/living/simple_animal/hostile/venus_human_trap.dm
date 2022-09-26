#define FINAL_BUD_GROWTH_ICON 3

/obj/structure/alien/resin/flower_bud_enemy //inheriting basic attack/damage stuff from alien structures
	name = "flower bud"
	desc = "A large pulsating plant..."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "flower_bud"
	layer = MOB_LAYER + 0.9
	opacity = 0
	canSmoothWith = list()
	smooth = SMOOTH_FALSE
	var/growth_time = 1200
	var/vine_spawned = FALSE

/obj/structure/alien/resin/flower_bud_enemy/New()
	..()
	var/list/anchors = list()
	anchors += locate(x-2,y+2,z)
	anchors += locate(x+2,y+2,z)
	anchors += locate(x-2,y-2,z)
	anchors += locate(x+2,y-2,z)

	for(var/turf/T in anchors)
		var/datum/beam/B = Beam(T, "vine", time=INFINITY, maxdistance=5, beam_type=/obj/effect/ebeam/vine)
		B.sleep_time = 10 //these shouldn't move, so let's slow down updates to 1 second (any slower and the deletion of the vines would be too slow)
	if(!vine_spawned)
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time)
	else
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time - 600)

/obj/structure/alien/resin/flower_bud_enemy/proc/bear_fruit()

	visible_message("<span class='danger'>The plant has borne fruit!</span>")
	new /mob/living/simple_animal/hostile/venus_human_trap(get_turf(src))
	qdel(src)


/obj/effect/ebeam/vine
	name = "thick vine"
	mouse_opacity = MOUSE_OPACITY_ICON
	desc = "A thick vine, painful to the touch."

/obj/effect/ebeam/vine/Crossed(atom/movable/AM, oldloc)
	if(isliving(AM))
		var/mob/living/L = AM
		if(!("vines" in L.faction))
			L.adjustBruteLoss(10)
			to_chat(L, "<span class='alert'>You cut yourself on the thorny vines.</span>")

/mob/living/simple_animal/hostile/venus_human_trap
	name = "venus human trap"
	desc = "Now you know how the fly feels."
	icon_state = "venus_human_trap"
	layer = MOB_LAYER + 0.9
	universal_understand = 0
	health = 60
	environment_smash = 2
	maxHealth = 60
	ranged = 1
	ranged_message = "launches vine"
	ranged_cooldown = 100
	harm_intent_damage = 5
	pressure_resistance = 50
	obj_damage = 60
	see_in_dark = 9999
	sight = SEE_MOBS | SEE_SELF | SEE_TURFS | SEE_OBJS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	melee_damage_lower = 25
	melee_damage_upper = 25
	a_intent = INTENT_HARM
	turns_per_move = 5
	move_to_delay = 4
	speed = 1.15
	robust_searching = 1
	ventcrawler = 2
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attacktext = "bites"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 0
	faction = list("hostile","vines","plants")
	var/list/grasping = list()
	var/max_grasps = 4
	var/grasp_chance = 20
	var/grasp_pull_chance = 85
	var/grasp_range = 4
	del_on_death = 1

/mob/living/simple_animal/hostile/venus_human_trap/New()
	..()
	add_language("Root Connection")
	default_language = GLOB.all_languages["Root Connection"]

	name += " ([rand(1, 1000)])"
	real_name = name

/mob/living/simple_animal/hostile/venus_human_trap/handle_automated_action()
	if(..())
		for(var/mob/living/L in grasping)
			if(L.stat == DEAD)
				var/datum/beam/B = grasping[L]
				if(B)
					B.End()
				grasping -= L

			//Can attack+pull multiple times per cycle
			if(L.Adjacent(src))
				L.attack_animal(src)
			else
				if(prob(grasp_pull_chance))
					dir = get_dir(src,L) //staaaare
					step(L,get_dir(L,src)) //reel them in
					L.Weaken(3) //you can't get away now~

		if(grasping.len < max_grasps)
			grasping:
				for(var/mob/living/L in view(grasp_range, src))
					if(L == src || faction_check_mob(L) || (L in grasping) || L == target)
						continue
					for(var/t in getline(src,L))
						for(var/a in t)
							var/atom/A = a
							if(A.density && A != L)
								continue grasping
					if(prob(grasp_chance))
						to_chat(L, "<span class='userdanger'>\The [src] has you entangled!</span>")
						grasping[L] = Beam(L, "vine", time=INFINITY, maxdistance=5, beam_type=/obj/effect/ebeam/vine)

						break //only take 1 new victim per cycle


/mob/living/simple_animal/hostile/venus_human_trap/OpenFire(atom/the_target)
	for(var/turf/T in getline(src,target))
		if (T.density)
			return
		for(var/obj/O in T)
			if(O.density)
				return
	var/dist = get_dist(src,the_target)
	Beam(the_target, "vine", time=dist*2, maxdistance=dist+2, beam_type=/obj/effect/ebeam/vine)
	the_target.attack_animal(src)


/mob/living/simple_animal/hostile/venus_human_trap/CanAttack(atom/the_target)
	. = ..()
	if(.)
		if(the_target in grasping)
			return 0

/**
 * Kudzu Flower Bud
 *
 * A flower created by flowering kudzu which spawns a venus human trap after a certain amount of time has passed.
 *
 * A flower created by kudzu with the flowering mutation.  Spawns a venus human trap after 2 minutes under normal circumstances.
 * Also spawns 4 vines going out in diagonal directions from the bud.  Any living creature not aligned with plants is damaged by these vines.
 * Once it grows a venus human trap, the bud itself will destroy itself.
 *
 */
/obj/structure/alien/resin/flower_bud //inheriting basic attack/damage stuff from alien structures
	name = "flower bud"
	desc = "A red large pulsating plant..."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "bud0"
	layer = MOB_LAYER + 0.9
	opacity = 0
	canSmoothWith = list()
	smooth = SMOOTH_FALSE
	var/growth_time = 2400
	var/growth_icon = 0
	var/vine_spawned = FALSE

	/// Used by countdown to check time, this is when the timer will complete and the venus trap will spawn.
	var/finish_time
	/// The countdown ghosts see to when the plant will hatch

	var/list/vines = list()

/obj/structure/alien/resin/flower_bud/Initialize(mapload)
	. = ..()
	var/list/anchors = list()
	anchors += locate(x-2,y+2,z)
	anchors += locate(x+2,y+2,z)
	anchors += locate(x-2,y-2,z)
	anchors += locate(x+2,y-2,z)

	for(var/turf/T in anchors)
		vines += Beam(T, "vine", maxdistance=5, beam_type=/obj/effect/ebeam/vine)
	finish_time = world.time + growth_time

	if(!vine_spawned)
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time)
		addtimer(CALLBACK(src, .proc/progress_growth), growth_time/4)
	else
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time - 1200)
		addtimer(CALLBACK(src, .proc/progress_growth), growth_time/8)

/obj/structure/alien/resin/flower_bud/Destroy()
	QDEL_LIST(vines)
	return ..()

/**
 * Spawns a venus human trap, then qdels itself.
 *
 * Displays a message, spawns a human venus trap, then qdels itself.
 */
/obj/structure/alien/resin/flower_bud/proc/bear_fruit()
	visible_message("<span class='danger'>The giant plant has borne fruit!</span>")
	new /mob/living/simple_animal/hostile/venus_human_trap/red_piranha(get_turf(src))
	qdel(src)

/obj/structure/alien/resin/flower_bud/proc/progress_growth()
	growth_icon++
	icon_state = "bud[growth_icon]"
	if(growth_icon == FINAL_BUD_GROWTH_ICON)
		return
	addtimer(CALLBACK(src, .proc/progress_growth), growth_time/4)

/mob/living/simple_animal/hostile/venus_human_trap/red_piranha
	name = "venus red piranha"
	desc = "This thing can eat even a cow."
	icon_state = "venus_red_piranha"
	layer = MOB_LAYER + 0.9
	health = 286
	maxHealth = 286
	ranged = 0
	harm_intent_damage = 2
	obj_damage = 146
	see_in_dark = 9999
	sight = SEE_MOBS | SEE_SELF | SEE_TURFS | SEE_OBJS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	attacked_sound = 'sound/creatures/venus_trap_hurt.ogg'
	death_sound = 'sound/creatures/venus_trap_death.ogg'
	attack_sound = 'sound/creatures/venus_trap_hit.ogg'
	attacktext = "absorbs"
	speed = 1.65
	melee_damage_lower = 20
	melee_damage_upper = 40
	pressure_resistance = 50
	a_intent = INTENT_HARM
	turns_per_move = 6
	move_to_delay = 8
	robust_searching = 1
	ventcrawler = 2
	environment_smash = 3
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 0
	faction = list("hostile","vines","plants")
	grasping = list()
	max_grasps = 8
	grasp_chance = 40
	grasp_pull_chance = 95
	del_on_death = 1

/mob/living/simple_animal/hostile/venus_human_trap/Life(seconds, times_fired)

	if(stat != DEAD && (getBruteLoss() || getFireLoss())) // Heal on blob structures
		if(locate(/obj/structure/spacevine || /obj/structure/spacevine_controller) in get_turf(src))
			adjustBruteLoss(-0.80)
			adjustFireLoss(-0.80)
			if(on_fire)
				adjust_fire_stacks(-4)// lowly extinguish the flames

/mob/living/simple_animal/hostile/venus_human_trap/red_piranha/Life(seconds, times_fired)

	if(stat != DEAD && (getBruteLoss() || getFireLoss())) // Heal on blob structures
		if(locate(/obj/structure/spacevine || /obj/structure/spacevine_controller) in get_turf(src))
			adjustBruteLoss(-0.60)
			adjustFireLoss(-0.60)
			if(on_fire)
				adjust_fire_stacks(-2) // Slowly extinguish the flames

/mob/living/simple_animal/hostile/venus_human_trap/attack_ghost(mob/user)
	humanize_plant(user)

/mob/living/simple_animal/hostile/venus_human_trap/proc/humanize_plant(mob/user)
	if(key)//Someone is in it
		return
	//var/humanize_prompt = "Take direct control of [src]?"

	if(cannotPossess(user))
		visible_message(src,"You have enabled antag HUD and are unable to re-enter the round.")
	else if(stat == DEAD)
		return

	if(jobban_isbanned(user, "Syndicate") )
		to_chat(user,"You are jobbanned from role of syndicate and/or alien lifeform.")
		return

	var/ask

	if(!istype(src, /mob/living/simple_animal/hostile/venus_human_trap/red_piranha))
		ask = alert("Become a venus human trap? Average damage, health and speed. Ventcrawler.",,"Yes", "No")
	else
		ask = alert("Become a venus red piranha? High damage and health, but low speed.",,"Yes", "No")
	if(ask == "No" || !src || QDELETED(src))
		return
	if(key)
		return
	key = user.key
	to_chat(user, "<span class='notice'>Walk on spacevine to heal.</span>")

#undef FINAL_BUD_GROWTH_ICON