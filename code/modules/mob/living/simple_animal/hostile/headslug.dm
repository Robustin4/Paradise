#define EGG_INCUBATION_TIME 120

/mob/living/simple_animal/hostile/headslug
	name = "headslug"
	desc = "Absolutely not de-beaked or harmless. Keep away from corpses."
	icon_state = "headslug"
	icon_living = "headslug"
	icon_dead = "headslug_dead"
	icon = 'icons/mob/mob.dmi'
	health = 50
	maxHealth = 50
	melee_damage_lower = 5
	melee_damage_upper = 5
	attacktext = "грызёт"
	attack_sound = 'sound/weapons/bite.ogg'
	faction = list("creature")
	robust_searching = 1
	stat_attack = DEAD
	obj_damage = 0
	environment_smash = 0
	speak_emote = list("squeaks")
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	ventcrawler = 2
	var/datum/mind/origin
	var/egg_lain = 0
	var/toxin_damage = 5
	var/ghost_join = FALSE
	sentience_type = SENTIENCE_OTHER

/mob/living/simple_animal/hostile/headslug/examine(mob/user)
	. = ..()
	if(stat == DEAD)
		. += "It appears to be dead."

/mob/living/simple_animal/hostile/headslug/New()
	. = ..()

	add_language("Cortical Link")
	add_language("Changeling")

/mob/living/simple_animal/hostile/headslug/proc/Infect(mob/living/carbon/victim)
	var/obj/item/organ/internal/body_egg/changeling_egg/egg = new(victim)
	egg.insert(victim)
	if(origin)
		egg.origin = origin
	else if(mind) // Let's make this a feature
		egg.origin = mind
	for(var/obj/item/organ/internal/I in src)
		I.forceMove(egg)
	visible_message("<span class='warning'>[src] plants something in [victim]'s flesh!</span>", \
					"<span class='danger'>We inject our egg into [victim]'s body!</span>")
	egg_lain = 1

/mob/living/simple_animal/hostile/headslug/AttackingTarget()
	. = ..()
	if(. && !egg_lain && iscarbon(target) && !issmall(target))
		// Changeling egg can survive in aliens!
		var/mob/living/carbon/C = target
		if(C.stat != DEAD)
			C.adjustToxLoss(toxin_damage)
		if(C.stat == DEAD)
			if(C.status_flags & XENO_HOST)
				to_chat(src, "<span class='userdanger'>A foreign presence repels us from this body. Perhaps we should try to infest another?</span>")
				return
			Infect(target)
			to_chat(src, "<span class='userdanger'>With our egg laid, our death approaches rapidly...</span>")
			addtimer(CALLBACK(src, .proc/death), 100)

/obj/item/organ/internal/body_egg/changeling_egg
	name = "changeling egg"
	desc = "Twitching and disgusting."
	origin_tech = "biotech=7" // You need to be really lucky to obtain it.
	var/datum/mind/origin
	var/time

/obj/item/organ/internal/body_egg/changeling_egg/egg_process()
	// Changeling eggs grow in dead people
	time++
	if(time >= EGG_INCUBATION_TIME)
		Pop()
		remove(owner)
		qdel(src)

/obj/item/organ/internal/body_egg/changeling_egg/proc/Pop()
	var/mob/living/carbon/human/monkey/M = new(owner)
	LAZYADD(owner.stomach_contents, M)

	for(var/obj/item/organ/internal/I in src)
		I.insert(M, 1)

	if(origin && origin.current && (origin.current.stat == DEAD))
		origin.transfer_to(M)
		if(!origin.changeling)
			M.make_changeling()
		if(origin.changeling.can_absorb_dna(M, owner))
			origin.changeling.absorb_dna(owner, M)

		var/datum/action/changeling/humanform/HF = new
		HF.Grant(M)
		for(var/power in origin.changeling.purchasedpowers)
			var/datum/action/changeling/S = power
			if(istype(S) && S.needs_button)
				S.Grant(M)
		M.key = origin.key
	owner.gib()

/mob/living/simple_animal/hostile/headslug/attack_ghost(mob/user)

	if(!ghost_join)
		return

	if(cannotPossess(user))
		to_chat(user, "<span class='boldnotice'>Upon using the antagHUD you forfeited the ability to join the round.</span>")
		return
	if(jobban_isbanned(user, "Syndicate" || "Changeling"))
		to_chat(user, "<span class='warning'>You are banned from antagonists!</span>")
		return
	if(key)
		return
	if(stat != CONSCIOUS)
		return
	var/be_headslug = alert("Become a headslug? (Warning, You can no longer be cloned!)",,"Yes","No")
	if(be_headslug == "No" || !src || QDELETED(src))
		return
	if(key)
		return
	transfer_personality(user.client)

/mob/living/simple_animal/hostile/headslug/proc/transfer_personality(var/client/candidate)

	if(!candidate || !candidate.mob)
		return

	if(!QDELETED(candidate) || !QDELETED(candidate.mob))
		var/datum/mind/M = create_headslug_mind(candidate.ckey)
		M.transfer_to(src)
		candidate.mob = src
		ckey = candidate.ckey
		to_chat(src, "<span class='notice'>You are a headslug!</span>")
		to_chat(src, "You are a brain slug that worms its way into the head of its dead victim. Use stealth, persuasion to reincarnate us again.")
		to_chat(src, "Find a dead body and infestate it. We must be careful.")
		to_chat(src, "You can speak to your fellow borers and changelings by prefixing your messages with ':bo' to borers and ':g' to changelings.")

/mob/living/simple_animal/hostile/headslug/proc/create_headslug_mind(key)
	var/datum/mind/M = new /datum/mind(key)
	M.assigned_role = "Headslug"
	M.special_role = "Headslug"
	return M

#undef EGG_INCUBATION_TIME
