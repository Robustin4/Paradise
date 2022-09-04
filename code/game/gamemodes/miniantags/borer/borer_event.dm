//Cortical borer spawn event - care of RobRichards1997 with minor editing by Zuhayr.

/datum/event/borer_infestation
	announceWhen = 400

	var/spawncount = 5
	var/headslug
	var/successSpawn = FALSE        //So we don't make a command report if nothing gets spawned.

/datum/event/borer_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	spawncount = rand(2, 4)
	headslug = rand(0, 1) //это мидраунд генокрад. конечно же он бдует редок

/datum/event/borer_infestation/announce()
	if(successSpawn)
		GLOB.command_announcement.Announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", new_sound = 'sound/AI/aliens.ogg')
	else
		log_and_message_admins("Warning: Could not spawn any mobs for event Borer Infestation")

/datum/event/borer_infestation/start()
	var/list/vents = get_valid_vent_spawns(exclude_mobs_nearby = TRUE, exclude_visible_by_mobs = TRUE)
	while(spawncount && length(vents))
		var/obj/vent = pick_n_take(vents)
		new /mob/living/simple_animal/borer(vent.loc)
		successSpawn = TRUE
		spawncount--

	if(headslug == 1)
		var/list/availableareas = list()
		for(var/area/maintenance/A in world)
			availableareas += A
		var/obj/vent = pick_n_take(vents in availableareas)
		var/mob/living/simple_animal/hostile/headslug/headslug = new /mob/living/simple_animal/hostile/headslug(vent.loc)
		headslug.ghost_join = TRUE
		notify_ghosts("A headslug has been appeared in [get_area(headslug)]!", enter_link = "<a href=?src=[UID()];ghostjoin=1>(Click to enter)</a>", source = src, action = NOTIFY_ATTACK)
