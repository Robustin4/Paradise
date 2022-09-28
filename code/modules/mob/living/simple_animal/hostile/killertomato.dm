/mob/living/simple_animal/hostile/killertomato
	name = "Killer Tomato"
	desc = "It's a horrifyingly enormous beef tomato, and it's packing extra beef!"
	icon_state = "tomato"
	icon_living = "tomato"
	icon_dead = "tomato_dead"
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 30
	health = 30
	see_in_dark = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/tomatomeat = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 8
	melee_damage_upper = 12
	attacktext = "кусает"
	attack_sound = 'sound/weapons/punch1.ogg'
	ventcrawler = 2
	faction = list("plants")

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 150
	maxbodytemp = 500
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/killertomato/spacevine
	name = "Spacevine Tomato"
	desc = "It's a horrifyingly enormous beef tomato from spacevine, and it's packing extra beef!"
	icon_state = "tomato"
	icon_living = "tomato"
	layer = MOB_LAYER + 0.9
	universal_understand = 0
	icon_dead = "tomato_dead"
	speak_chance = 0
	turns_per_move = 4
	move_to_delay = 4
	see_in_dark = 9999
	sight = SEE_MOBS | SEE_SELF | SEE_TURFS | SEE_OBJS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	maxHealth = 35
	health = 35
	pressure_resistance = 50
	see_in_dark = 6
	obj_damage = 30
	speed = 0.40
	a_intent = INTENT_HARM
	environment_smash = 1
	butcher_results = list(/obj/item/reagent_containers/food/snacks/tomatomeat = 2)
	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"
	melee_damage_lower = 10
	melee_damage_upper = 14
	robust_searching = 1
	attacktext = "кусает"
	attack_sound = list('sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg')
	ventcrawler = 2
	faction = list("hostile","vines","plants")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 250
	maxbodytemp = 350
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/killertomato/spacevine/New()
	..()
	add_language("Root Connection")
	default_language = GLOB.all_languages["Root Connection"]

	name += " ([rand(1, 1000)])"
	real_name = name

/mob/living/simple_animal/hostile/killertomato/spacevine/death(gibbed)
	..()

	addtimer(CALLBACK(src, .proc/gibbo), rand(20,40))

/mob/living/simple_animal/hostile/killertomato/spacevine/proc/gibbo()
	..()

	src.gib()
	new /obj/item/reagent_containers/food/snacks/tomatomeat(get_turf(src))
	new /obj/item/reagent_containers/food/snacks/tomatomeat(get_turf(src))


/mob/living/simple_animal/hostile/killertomato/spacevine/attack_ghost(mob/user)
	humanize_plant(user)

/mob/living/simple_animal/hostile/killertomato/spacevine/proc/humanize_plant(mob/user)
	if(key)//Someone is in it
		return
	//var/humanize_prompt = "Take direct control of [src]?"

	if(cannotPossess(user))
		visible_message(src,"You have enabled antag HUD and are unable to re-enter the round.")
	else if(stat == DEAD)
		return

	if(jobban_isbanned(user, "Syndicate") || jobban_isbanned(user, "Space Vine"))
		to_chat(user,"You are jobbanned from role of syndicate and/or alien lifeform.")
		return

	var/ask = alert("Become a killer tomato? Fast plant with low damage and health. Ventcrawler.",,"Yes", "No")
	if(ask == "No" || !src || QDELETED(src))
		return
	if(key)
		return
	key = user.key
	to_chat(user, "<span class='notice'>Walk on spacevine to heal.</span>")

/obj/structure/alien/resin/giant_tomato
	name = "giant tomato"
	desc = "A innatural large tomato. A feeling, that it can be alive at any moment."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "killertomato"
	layer = MOB_LAYER + 0.9
	opacity = 0
	canSmoothWith = list()
	smooth = SMOOTH_FALSE
	var/growth_time = 600
	var/vine_spawned = FALSE

/obj/structure/alien/resin/giant_tomato/New()
	..()

	if(!vine_spawned)
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time)
	else
		addtimer(CALLBACK(src, .proc/bear_fruit), growth_time - 590)

/obj/structure/alien/resin/giant_tomato/proc/bear_fruit()

	visible_message("<span class='danger'>The tomato is alive now!</span>")
	new /mob/living/simple_animal/hostile/killertomato/spacevine(get_turf(src))
	qdel(src)

/mob/living/simple_animal/hostile/killertomato/spacevine/Life(seconds, times_fired)

	if(stat != DEAD && (getBruteLoss() || getFireLoss())) // Heal on blob structures
		if(locate(/obj/structure/spacevine || /obj/structure/spacevine_controller) in get_turf(src))
			adjustBruteLoss(-1)
			adjustFireLoss(-1)
			if(on_fire)
				adjust_fire_stacks(-6)	// Slowly extinguish the flames
