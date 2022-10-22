
/datum/antagonist/infiltrator
	name = "Infiltrator"
	roundend_category = "infilrtrators"
	job_rank = ROLE_INFILTRATOR
	var/special_role = SPECIAL_ROLE_INFILTRATOR
	var/list/assigned_targets = list() // This includes assassinate as well as steal objectives. prevents duplicate objectives

// Adding/removing objectives in the owner's mind until we can datumize all antags. Then we can use the /datum/antagonist/objectives var to handle them
// Change "owner.objectives" to "objectives" once objectives are handled in antag datums instead of the mind
/datum/antagonist/infiltrator/proc/add_objective(datum/objective/O)
	owner.objectives += O

/datum/antagonist/infiltrator/proc/empty() // не спрашивайте, зачем этот прок. просто надо
	return

/datum/antagonist/infiltrator/proc/remove_objective(datum/objective/O)
	owner.objectives -= O

/datum/antagonist/infiltrator/on_gain()
	var/datum/mindslaves/slaved = new()
	slaved.masters += owner
	owner.som = slaved //we MIGHT want to mindslave someone
	SSticker.mode.traitors += owner
	owner.special_role = special_role
	forge_objectives()
	update_infiltrator_icons_added()

/datum/antagonist/infiltrator/proc/forge_objectives()
	var/is_hijacker = prob(10)
	var/martyr_chance = prob(20)
	var/objective_count = is_hijacker 			//Hijacking counts towards number of objectives
	objective_count += 1					//Exchange counts towards number of objectives

	var/objective_amount = config.traitor_objectives_amount

	if(is_hijacker && objective_count <= objective_amount) //Don't assign hijack if it would exceed the number of objectives set in config.traitor_objectives_amount
		if(!(locate(/datum/objective/hijack) in objectives))
			var/datum/objective/hijack/hijack_objective = new
			hijack_objective.owner = owner
			add_objective(hijack_objective)
			return

	for(var/i = objective_count, i < objective_amount)
		i += forge_single_objective()

	var/martyr_compatibility = 1 //You can't succeed in stealing if you're dead.
	for(var/datum/objective/O in owner.objectives)
		if(!O.martyr_compatible)
			martyr_compatibility = 0
			break

	if(martyr_compatibility && martyr_chance)
		var/datum/objective/die/martyr_objective = new
		martyr_objective.owner = owner
		add_objective(martyr_objective)
		return

	if(!(locate(/datum/objective/survive) in objectives))
		var/datum/objective/survive/survive_objective = new
		survive_objective.owner = owner
		add_objective(survive_objective)
		return

/datum/antagonist/infiltrator/proc/forge_single_objective() // Returns how many objectives are added
	. = 1
	if(prob(50))
		var/list/active_ais = active_ais()
		if(active_ais.len && prob(100/GLOB.player_list.len))
			var/datum/objective/destroy/destroy_objective = new
			destroy_objective.owner = owner
			destroy_objective.find_target()
			if("[destroy_objective]" in assigned_targets)	        // Is this target already in their list of assigned targets? If so, don't add this objective and return
				return 0
			else if(destroy_objective.target)					    // Is the target a real one and not null? If so, add it to our list of targets to avoid duplicate targets
				assigned_targets.Add("[destroy_objective.target]")	// This logic is applied to all traitor objectives including steal objectives
			add_objective(destroy_objective)

		else if(prob(5))
			var/datum/objective/debrain/debrain_objective = new
			debrain_objective.owner = owner
			debrain_objective.find_target()
			if("[debrain_objective]" in assigned_targets)
				return 0
			else if(debrain_objective.target)
				assigned_targets.Add("[debrain_objective.target]")
			add_objective(debrain_objective)

		else
			var/datum/objective/maroon/maroon_objective = new
			maroon_objective.owner = owner
			maroon_objective.find_target()
			if("[maroon_objective]" in assigned_targets)
				return 0
			else if(maroon_objective.target)
				assigned_targets.Add("[maroon_objective.target]")
			add_objective(maroon_objective)

	else
		var/datum/objective/steal/steal_objective = new
		steal_objective.owner = owner
		steal_objective.find_target()
		if("[steal_objective.steal_target]" in assigned_targets)
			return 0
		else if(steal_objective.steal_target)
			assigned_targets.Add("[steal_objective.steal_target]")
		add_objective(steal_objective)

/datum/antagonist/infiltrator/proc/update_infiltrator_icons_added(datum/mind/infiltrator_mind)
	if(locate(/datum/objective/hijack) in owner.objectives)
		var/datum/atom_hud/antag/hijackhud = GLOB.huds[ANTAG_HUD_INFILTRATOR]
		hijackhud.join_hud(owner.current, null)
		set_antag_hud(owner.current, "hudhijackinfiltrator")
	else
		var/datum/atom_hud/antag/infiltratorhud = GLOB.huds[ANTAG_HUD_INFILTRATOR]
		infiltratorhud.join_hud(owner.current, null)
		set_antag_hud(owner.current, "hudinfiltrator")


/datum/antagonist/infiltrator/proc/update_infiltrator_icons_removed(datum/mind/traitor_mind)
	var/datum/atom_hud/antag/infiltratorhud = GLOB.huds[ANTAG_HUD_INFILTRATOR]
	infiltratorhud.leave_hud(owner.current, null)
	set_antag_hud(owner.current, null)