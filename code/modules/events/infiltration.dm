#define SYNDI 1
#define GORLEX 2
#define PRISONER 3
#define VAMPIRE 4
#define CHANGELING 5
#define AGENT 6
#define USSP 7
#define WIZARD_APPRENTICE 8

/datum/event/infiltration
	startWhen = 1
	var/inf_type
	var/mob/living/carbon/human/infiltrator
	var/phrases
	var/responses
	var/syndi_outfit
	var/gorlex_outfit
	var/prisoner_outfit
	var/mob/dead/observer/candidate
	endWhen = 2

/datum/event/infiltration/setup()
	inf_type = rand(1,3)
	phrases = jointext(GLOB.syndicate_code_phrase, ", ")
	responses = jointext(GLOB.syndicate_code_response, ", ")
	syndi_outfit = /datum/outfit/job/infiltrator/syndi
	gorlex_outfit = /datum/outfit/job/infiltrator/gorlex
	prisoner_outfit = /datum/outfit/job/infiltrator/prisoner

/datum/event/infiltration/start()
	processing = 0

	inf_type = rand(1,3)

	var/list/candidates = SSghost_spawns.poll_candidates("Хотите занять роль внедрителя?", ROLE_INFILTRATOR, TRUE)
	candidate = pick(candidates)

	sleep(20)

	var/list/possible_spawns = list()
	for(var/thing in GLOB.landmarks_list)
		var/obj/effect/landmark/C = thing
		if(C.name == "carpspawn") //spawn them at the same place as carp
			C += possible_spawns

	var/turf/spawn_loc = get_turf(pick(possible_spawns))

	infiltrator = create_infiltrator(null, spawn_loc)

	if(inf_type != CHANGELING)
		to_chat(infiltrator, "<B><font size=3 color=red>Вы [infiltrator.mind.special_role]!</font></B>")
	else
		to_chat(infiltrator, "<B><font size=6 color=red>МЫ ЖИВЫ. СНОВА.</font></B>")

	switch(inf_type)
		if(SYNDI || GORLEX)
			to_chat(infiltrator,"Синдикат предоставил вам следующие кодовые слова, чтобы определять потенциальных агентов на станции:")
			to_chat(infiltrator,"<B>Кодовые слова: </B>[phrases]<BR>\n")
			to_chat(infiltrator,"<B>Кодовые ответы: </B>[responses]<BR>\n")
			to_chat(infiltrator,"Используйте слова при общении с потенциальными агентами. В тоже время будьте осторожны, ибо кто угодно может оказаться потенциальным врагом.")
		if(SYNDI)
			to_chat(infiltrator, "<B><font size=2>Вы работаете на синдикат и Вам было приказано сделать некоторые дела. В Вашем распоряжении самые нужные инструменты для внедрения в [station_name()] и возможности побега с последующей сменой личности.</font></B>")
			to_chat(infiltrator, "<B><font size=2 color=red>Вы можете действовать вместе с агентами синдиката, вампирами и генокрадами против не связанных с синдикатом антагонистов.</font></B>")
		if(GORLEX)
			infiltrator.rename_character(null, "[syndicate_name()] Operative #[rand(5,11)]")
			update_syndicate_id(infiltrator.mind)
			to_chat(infiltrator, "<B><font size=2>Вы работаете на синдикат и Вам было приказано сделать некоторые дела по громкому. В Вашем распоряжении аплинк. Кажется, Вы перепутали станцию. Или отстали от команды... Или рано начали... Маловато телекристаллов... Хм...</font></B>")
			to_chat(infiltrator, "<B><font size=2 color=red>Вы можете действовать вместе с агентами синдиката, вампирами и генокрадами против не связанных с синдикатом антагонистов.</font></B>")
		if(PRISONER)
			to_chat(infiltrator, "<B><font size=2>Вы сбежали из тюрьмы. Однако у Вас остались некоторые не законченные дела на [station_name()]... Благо перед побегом Вы ограбили шкафчик охраны.</font></B>")
			to_chat(infiltrator, "<B><font size=2>Стоит быть осторожным, вероятно о Вашем побеге узнают.</font></B>")

	if(inf_type == CHANGELING && prob(26))
		to_chat(infiltrator,"Перед прилетом сюда Мы [pick("поглоити агента и знаем какие-то кодовые слова", "встретились с агентом и знаем кодовые слова")]")
		to_chat(infiltrator,"<B>Кодовые слова: </B>[phrases]<BR>\n")
		to_chat(infiltrator,"<B>Кодовые ответы: </B>[responses]<BR>\n")

	if(inf_type == VAMPIRE && prob(66))
		to_chat(infiltrator,"Перед прилетом сюда Вы контактировали с агентом. Он сообщил о кодовых словах:")
		to_chat(infiltrator,"<B>Кодовые слова: </B>[phrases]<BR>\n")
		to_chat(infiltrator,"<B>Кодовые ответы: </B>[responses]<BR>\n")

	if(inf_type == PRISONER && prob(46))
		to_chat(infiltrator, "Вы бывший агент синдиката. Вы знаете кодовые слова. Не факт, что они актуальны на данный момент.")
		to_chat(infiltrator,"<B>Кодовые слова: </B>[phrases]<BR>\n")
		to_chat(infiltrator,"<B>Кодовые ответы: </B>[responses]<BR>\n")

		if(prob(36))
			infiltrator.mind.make_Vampire()

		if(prob(28))
			sleep(800)
			GLOB.event_announcement.Announce("Один из заключенных тюрьмы в ближайшем секторе сбежал. Возможно он рядом с [station_name()]. Приказ: униточжение на месте.", "Central Command Prison Supervisor", new_sound = 'sound/AI/commandreport.ogg')
			/*
			if(prob(26))
				infiltrator.mind.make_Changeling() // генокрадов же любыми способами хотят уничтожить, поэтому тюремщиком он быть никак не может.
			*/


	var/datum/antagonist/infiltrator/new_antag = new /datum/antagonist/infiltrator(infiltrator)
	new_antag.empty()

	if(inf_type == GORLEX)
		update_syndicate_id(infiltrator.mind)

	/*

	infiltrator.reagents.add_reagent("perfluorodecalin", 3.9)
	infiltrator.reagents.add_reagent("salbutamol", 8) // не задыхаться в космосе чтобы, успеть интерналсы включить. (я пытался самостоятельно включать их, однако что-то гибался карбон... )
	infiltrator.reagents.add_reagent("epinephrine", 16)

	*/

/datum/event/infiltration/proc/create_infiltrator(var/new_gender, var/turf/spawn_location)
	var/list/possible_spawns = list()
	for(var/thing in GLOB.landmarks_list)
		var/obj/effect/landmark/C = thing
		if(C.name == "Syndicate-Infiltrator") //пусть не в космосе сначала
			possible_spawns.Add(C)

	var/turf/spawn_loc_tech = get_turf(pick(possible_spawns))

	var/hair_c
	var/eye_c
	var/skin_tone

	var/mob/living/carbon/human/M = new(spawn_loc_tech)
	var/obj/item/organ/external/head/head_organ = M.get_organ("head")

	if(new_gender == null)
		if(prob(50))
			M.change_gender(MALE)
		else
			M.change_gender(FEMALE)

	M.set_species(/datum/species/human, TRUE)
	M.dna.ready_dna(M)
	M.cleanSE() //No fat/blind/colourblind/epileptic/whatever infiltrator.
	M.overeatduration = 0

	if(inf_type != GORLEX)
		hair_c = pick("#8B4513","#000000","#FF4500","#FFD700") // Brown, black, red, blonde
		eye_c = pick("#000000","#8B4513","1E90FF") // Black, brown, blue
		skin_tone = rand(-140, 140) // A range of skin colors
		M.age = rand(16,48)
	else
		hair_c = pick("#8B4513","#000000","#FF4500","#FFD700") // Brown, black, red, blonde
		eye_c = pick("#000000","#8B4513","1E90FF") // Black, brown, blue
		skin_tone = pick(-50, -30, -10, 0, 0, 0, 10) // Caucasian/black
		M.age = rand(32,62)

	head_organ.facial_colour = hair_c
	head_organ.sec_facial_colour = hair_c
	head_organ.hair_colour = hair_c
	head_organ.sec_hair_colour = hair_c
	M.change_eye_color(eye_c)
	M.s_tone = skin_tone
	M.rename_character(null, "[M.gender==FEMALE ? pick(GLOB.first_names_female) : pick(GLOB.first_names_male)] [M.gender==FEMALE ? pick(GLOB.last_names_female) : pick(GLOB.last_names)]")
	head_organ.h_style = random_hair_style(M.gender, head_organ.dna.species.name)
	head_organ.f_style = random_facial_hair_style(M.gender, head_organ.dna.species.name)

	M.regenerate_icons()
	M.update_body()
	M.update_dna()

	//Creates mind stuff.

	M.mind = new
	M.mind.current = M
	M.mind.original = M
	M.mind.assigned_role = SPECIAL_ROLE_INFILTRATOR
	M.mind.special_role = SPECIAL_ROLE_INFILTRATOR

	candidate.mind.key = infiltrator.key
	candidate.key = infiltrator.key
	candidate.update_icons()

	if(!(M.mind in SSticker.minds))
		SSticker.minds += M.mind //Adds them to regular mind list.

	M.forceMove(spawn_location)

	gear_up(M)

	var/datum/dna/D = M.dna
	if(!D.species.is_small)
		M.change_dna(D, TRUE, TRUE)

	candidate.ckey = M.ckey
	qdel(candidate)

	return M

/datum/event/infiltration/proc/update_syndicate_id(var/datum/mind/synd_mind)
	var/list/found_ids = synd_mind.current.search_contents_for(/obj/item/card/id)

	if(LAZYLEN(found_ids))
		for(var/obj/item/card/id/ID in found_ids)
			ID.name = "[synd_mind.current.real_name] ID card"
			ID.registered_name = synd_mind.current.real_name

/datum/event/infiltration/proc/gear_up(var/mob/living/carbon/human/who)

	switch(inf_type)
		if(SYNDI || GORLEX || PRISONER)
			who.faction |= "syndicate"
		if(SYNDI)
			who.equipOutfit(syndi_outfit)
		if(GORLEX)
			who.equipOutfit(gorlex_outfit)
		if(PRISONER)
			who.equipOutfit(prisoner_outfit)

/datum/outfit/job/infiltrator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/pill/mutadone(H.back), slot_in_backpack) // если попал в радиоактвный шторм, то поможет. понадеемся на отсутствие метаебов ( надеяться не на что)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/pill/patch/silver_sulf(H.back), slot_in_backpack)

	var/obj/item/tank/internals/tank = (locate(/obj/item/tank/internals/oxygen) in H)
	tank.toggle_internals(H, TRUE)
	tank.air_contents.oxygen = (10 * ONE_ATMOSPHERE) * tank.volume / (R_IDEAL_GAS_EQUATION * T20C)

/datum/outfit/job/infiltrator/syndi
	name = "Syndicate Chameleon Infiltration Single Operative"
	uniform = /obj/item/clothing/under/chameleon
	shoes = /obj/item/clothing/shoes/chameleon
	mask = /obj/item/clothing/mask/chameleon
	glasses = /obj/item/clothing/glasses/chameleon
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/space/eva
	suit_store = /obj/item/tank/internals/oxygen
	head = /obj/item/clothing/head/helmet/space/eva
	r_hand = /obj/item/tank/jetpack/carbondioxide
	back = /obj/item/storage/backpack/chameleon
	belt = /obj/item/storage/belt/utility/full/multitool
	l_ear = /obj/item/radio/headset/chameleon/syndteam_key // энкриптоключ синдикоманды - его потеря не так уж и страшна, посему, если будет такое стечение обстоятельств, что админ защистпавнит внедрителей и выберется именно этот ивент и именно этот вид внедрителя, то они получат дополнительного оперативника. ( со своими целями, но оперативника)
	id = /obj/item/card/id/syndicate
	pda = /obj/item/pda/chameleon

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/clothing/suit/chameleon = 1,
		/obj/item/clothing/head/chameleon = 1,
		/obj/item/clothing/gloves/chameleon = 1,
		/obj/item/storage/belt/chameleon = 1,
		/obj/item/clothing/glasses/chameleon/thermal = 1,
		/obj/item/clothing/shoes/chameleon/noslip = 1,
		/obj/item/dnascrambler = 1,
		/obj/item/clothing/glasses/hud/security/chameleon = 1
	)

	implants = list(/obj/item/implant/dust,
		/obj/item/implant/adrenalin,
		/obj/item/implant/emp,
		/obj/item/implant/storage,
		/obj/item/implant/freedom,
		/obj/item/implant/uplink
	)

/datum/outfit/job/infiltrator/gorlex
	name = "Lonely Operative from Gorlex Infiltration"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	mask = /obj/item/clothing/mask/gas/syndicate
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	suit_store = /obj/item/tank/internals/oxygen/red
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/military
	head = /obj/item/clothing/head/helmet/space/eva
	r_hand = /obj/item/tank/jetpack/oxygen/harness
	l_ear = /obj/item/radio/headset/syndicate/alt
	l_pocket = /obj/item/gun/projectile/automatic/pistol
	r_pocket = /obj/item/ammo_box/magazine/m10mm
	id = /obj/item/card/id/syndicate
	pda = /obj/item/pinpointer/nukeop

	backpack_contents = list(
		/obj/item/storage/box/survival_syndi = 1,
		/obj/item/radio/uplink/nuclear = 1,
		/obj/item/storage/belt/utility/full/multitool = 1
	)

	implants = list(/obj/item/implant/explosive,
	)

/datum/outfit/job/infiltrator/gorlex/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H && H.w_uniform)
		var/obj/item/clothing/under/U = H.w_uniform
		var/obj/item/clothing/accessory/holster/M = new(U)
		U.accessories += M
		M.on_attached(U)

/datum/outfit/job/infiltrator/prisoner
	name = "Prisoner Infiltrator"
	uniform = /obj/item/clothing/under/color/orange/prison_inf
	shoes = /obj/item/clothing/shoes/orange
	mask = /obj/item/clothing/mask/breath
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/color/yellow
	suit = /obj/item/clothing/suit/space/eva
	head = /obj/item/clothing/head/helmet/space/eva
	suit_store = /obj/item/tank/internals/oxygen
	r_hand = /obj/item/tank/jetpack/carbondioxide
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/utility/full/multitool
	l_ear = /obj/item/radio/headset/headset_sec/alt
	l_pocket = /obj/item/flashlight/seclite
	id = /obj/item/card/id/prisoner/random

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/belt/security/full_sec = 1,
		/obj/item/gun/energy/dominator/no_sibyl = 1,
		/obj/item/clothing/suit/armor/vest/security = 1,
		/obj/item/clothing/suit/armor/secjacket = 1
	)

/datum/outfit/job/infiltrator/prisoner/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H && H.w_uniform)
		var/obj/item/clothing/under/U = H.w_uniform
		var/obj/item/clothing/accessory/holster/M = new(U)
		U.accessories += M
		M.on_attached(U)

#undef SYNDI
#undef GORLEX
#undef PRISONER
#undef VAMPIRE
#undef CHANGELING
#undef AGENT
#undef USSP
#undef WIZARD_APPRENTICE
