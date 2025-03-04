/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	materials = list(MAT_METAL = 4000)
	caliber = ".357"
	projectile_type = /obj/item/projectile/bullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/rubber9mm
	desc = "A 9mm rubber bullet casing."
	icon_state = "r-casing"
	materials = list(MAT_METAL = 650)
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/weakbullet4

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	icon_state = "762-casing"
	materials = list(MAT_METAL = 4000)
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_STRONG
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/a762/enchanted
	materials = list(MAT_METAL = 1000)
	projectile_type = /obj/item/projectile/bullet/weakbullet3

/obj/item/ammo_casing/a50
	desc = "A .50AE bullet casing."
	materials = list(MAT_METAL = 4000)
	caliber = ".50ae" //change to diffrent caliber because players got deagle in uplink
	projectile_type = /obj/item/projectile/bullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/c38
	desc = "A .38 bullet casing."
	icon_state = "r-casing"
	materials = list(MAT_METAL = 650)
	caliber = ".38"
	projectile_type = /obj/item/projectile/bullet/weakbullet2
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c38/invisible
	projectile_type = /obj/item/projectile/bullet/weakbullet2/invisible
	muzzle_flash_effect = null // invisible eh

/obj/item/ammo_casing/c38/invisible/fake
	projectile_type = /obj/item/projectile/bullet/weakbullet2/invisible/fake

/obj/item/ammo_casing/c10mm
	desc = "A 10mm bullet casing."
	materials = list(MAT_METAL = 1500)
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/midbullet3
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c10mm/ap
	materials = list(MAT_METAL = 2000, MAT_SILVER = 200)
	projectile_type = /obj/item/projectile/bullet/midbullet3/ap

/obj/item/ammo_casing/c10mm/fire
	materials = list(MAT_METAL = 2000, MAT_SILVER = 200, MAT_PLASMA = 300)
	projectile_type = /obj/item/projectile/bullet/midbullet3/fire
	muzzle_flash_color = LIGHT_COLOR_FIRE

/obj/item/ammo_casing/c10mm/hp
	materials = list(MAT_METAL = 2000, MAT_SILVER = 200)
	projectile_type = /obj/item/projectile/bullet/midbullet3/hp

/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	materials = list(MAT_METAL = 1000)
	projectile_type = /obj/item/projectile/bullet/weakbullet3
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_WEAK
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c9mm/ap
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150)
	projectile_type = /obj/item/projectile/bullet/armourpiercing

/obj/item/ammo_casing/c9mm/tox
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150, MAT_URANIUM = 200)
	projectile_type = /obj/item/projectile/bullet/toxinbullet

/obj/item/ammo_casing/c9mm/inc
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150, MAT_PLASMA = 200)
	projectile_type = /obj/item/projectile/bullet/incendiary/firebullet
	muzzle_flash_color = LIGHT_COLOR_FIRE

/obj/item/ammo_casing/c46x30mm
	desc = "A 4.6x30mm bullet casing."
	materials = list(MAT_METAL = 1000)
	caliber = "4.6x30mm"
	projectile_type = /obj/item/projectile/bullet/weakbullet3
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_WEAK
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c46x30mm/ap
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150)
	projectile_type = /obj/item/projectile/bullet/armourpiercing

/obj/item/ammo_casing/c46x30mm/tox
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150, MAT_URANIUM = 200)
	projectile_type = /obj/item/projectile/bullet/toxinbullet

/obj/item/ammo_casing/c46x30mm/inc
	materials = list(MAT_METAL = 1500, MAT_SILVER = 150, MAT_PLASMA = 200)
	projectile_type = /obj/item/projectile/bullet/incendiary/firebullet
	muzzle_flash_color = LIGHT_COLOR_FIRE

/obj/item/ammo_casing/rubber45
	desc = "A .45 rubber bullet casing."
	icon_state = "r-casing"
	materials = list(MAT_METAL = 650)
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/midbullet_r
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	materials = list(MAT_METAL = 1500)
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/midbullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/c45/nostamina
	materials = list(MAT_METAL = 1500)
	projectile_type = /obj/item/projectile/bullet/midbullet3

/obj/item/ammo_casing/n762
	desc = "A 7.62x38mmR bullet casing."
	materials = list(MAT_METAL = 4000)
	caliber = "n762"
	projectile_type = /obj/item/projectile/bullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/caseless/magspear
	name = "magnetic spear"
	desc = "A reusable spear that is typically loaded into kinetic spearguns."
	projectile_type = /obj/item/projectile/bullet/reusable/magspear
	caliber = "spear"
	icon_state = "magspear"
	throwforce = 15 //still deadly when thrown
	throw_speed = 3
	muzzle_flash_color = null

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge lead slug."
	icon_state = "blshell"
	materials = list(MAT_METAL = 4000)
	drop_sound = 'sound/weapons/gun_interactions/shotgun_fall.ogg'
	caliber = ".12"
	projectile_type = /obj/item/projectile/bullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_STRONG
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet
	pellets = 6
	variance = 25

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "cshell"
	materials = list(MAT_METAL = 1000)
	projectile_type = /obj/item/projectile/bullet/pellet/rubber
	pellets = 6
	variance = 25

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag slug"
	desc = "A weak beanbag slug for riot control."
	icon_state = "bshell"
	materials = list(MAT_METAL = 1000)
	projectile_type = /obj/item/projectile/bullet/weakbullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/shotgun/improvised
	name = "improvised shell"
	desc = "An extremely weak shotgun shell with multiple small pellets made out of metal shards."
	icon_state = "improvshell"
	materials = list(MAT_METAL = 250)
	projectile_type = /obj/item/projectile/bullet/pellet/weak
	pellets = 10
	variance = 25
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/shotgun/improvised/overload
	name = "overloaded improvised shell"
	desc = "An extremely weak shotgun shell with multiple small pellets made out of metal shards. This one has been packed with even more \
	propellant. It's like playing russian roulette, with a shotgun."
	icon_state = "improvshell"
	materials = list(MAT_METAL = 250)
	projectile_type = /obj/item/projectile/bullet/pellet/overload
	pellets = 4
	variance = 40
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/shotgun/stunslug
	name = "taser slug"
	desc = "A stunning taser slug."
	icon_state = "stunshell"
	materials = list(MAT_METAL = 250)
	projectile_type = /obj/item/projectile/bullet/stunshot
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL
	muzzle_flash_color = "#FFFF00"

/obj/item/ammo_casing/shotgun/meteorshot
	name = "meteorshot shell"
	desc = "A shotgun shell rigged with CMC technology, which launches a massive slug when fired."
	icon_state = "mshell"
	projectile_type = /obj/item/projectile/bullet/meteorshot

/obj/item/ammo_casing/shotgun/breaching
	name = "breaching shell"
	desc = "An economic version of the meteorshot, utilizing similar technologies. Great for busting down doors."
	icon_state = "mshell"
	projectile_type = /obj/item/projectile/bullet/meteorshot/weak

/obj/item/ammo_casing/shotgun/pulseslug
	name = "pulse slug"
	desc = "A delicate device which can be loaded into a shotgun. The primer acts as a button which triggers the gain medium and fires a powerful \
	energy blast. While the heat and power drain limit it to one use, it can still allow an operator to engage targets that ballistic ammunition \
	would have difficulty with."
	icon_state = "pshell"
	projectile_type = /obj/item/projectile/beam/pulse/shot
	muzzle_flash_color = LIGHT_COLOR_DARKBLUE

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary slug"
	desc = "An incendiary-coated shotgun slug."
	icon_state = "ishell"
	projectile_type = /obj/item/projectile/bullet/incendiary/shell
	muzzle_flash_color = LIGHT_COLOR_FIRE

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12 slug"
	desc = "A high explosive breaching round for a 12 gauge shotgun."
	icon_state = "heshell"
	projectile_type = /obj/item/projectile/bullet/frag12

/obj/item/ammo_casing/shotgun/incendiary/dragonsbreath
	name = "dragonsbreath shell"
	desc = "A shotgun shell which fires a spread of incendiary pellets."
	icon_state = "ishell2"
	projectile_type = /obj/item/projectile/bullet/incendiary/shell/dragonsbreath
	pellets = 4
	variance = 35
	muzzle_flash_color = LIGHT_COLOR_FIRE

/obj/item/ammo_casing/shotgun/ion
	name = "ion shell"
	desc = "An advanced shotgun shell which uses a subspace ansible crystal to produce an effect similar to a standard ion rifle. \
	The unique properties of the crystal splot the pulse into a spread of individually weaker bolts."
	icon_state = "ionshell"
	projectile_type = /obj/item/projectile/ion/weak
	pellets = 4
	variance = 35
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL
	muzzle_flash_color = LIGHT_COLOR_LIGHTBLUE

/obj/item/ammo_casing/shotgun/laserslug
	name = "laser slug"
	desc = "An advanced shotgun shell that uses a micro laser to replicate the effects of a laser weapon in a ballistic package."
	icon_state = "lshell"
	projectile_type = /obj/item/projectile/beam/laser/slug
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL
	muzzle_flash_color = LIGHT_COLOR_DARKRED

/obj/item/ammo_casing/shotgun/techshell
	name = "unloaded technological shell"
	desc = "A high-tech shotgun shell which can be loaded with materials to produce unique effects."
	icon_state = "cshell"
	materials = list(MAT_METAL = 1000, MAT_GLASS = 200)
	projectile_type = null

/obj/item/ammo_casing/shotgun/dart
	name = "shotgun dart"
	desc = "A dart for use in shotguns. Can be injected with up to 30 units of any chemical."
	icon_state = "cshell"
	container_type = OPENCONTAINER
	materials = list(MAT_METAL = 500, MAT_GLASS = 200)
	projectile_type = /obj/item/projectile/bullet/dart
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/shotgun/dart/New()
	..()
	create_reagents(30)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/dart/bioterror
	desc = "A shotgun dart filled with deadly toxins."

/obj/item/ammo_casing/shotgun/dart/bioterror/New()
	..()
	reagents.add_reagent("neurotoxin", 6)
	reagents.add_reagent("spore", 6)
	reagents.add_reagent("capulettium_plus", 6) //;HELP OPS IN MAINT
	reagents.add_reagent("coniine", 6)
	reagents.add_reagent("sodium_thiopental", 6)

/obj/item/ammo_casing/shotgun/tranquilizer
	name = "tranquilizer darts"
	desc = "A tranquilizer round used to subdue individuals utilizing stimulants."
	icon_state = "nshell"
	materials = list(MAT_METAL = 500, MAT_GLASS = 200)
	projectile_type = /obj/item/projectile/bullet/dart/syringe/tranquilizer
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/a556
	desc = "A 5.56mm bullet casing."
	materials = list(MAT_METAL = 3250)
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/heavybullet
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/shotgun/fakebeanbag
	name = "beanbag shell"
	desc = "A weak beanbag shell."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/weakbullet/booze
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	materials = list(MAT_METAL = 10000)
	caliber = "rocket"
	projectile_type = /obj/item/missile
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_STRONG
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/caseless
	desc = "A caseless bullet casing."

/obj/item/ammo_casing/caseless/fire(atom/target as mob|obj|turf, mob/living/user as mob|obj, params, distro, quiet, zone_override = "", spread)
	if(..())
		loc = null
		return 1
	else
		return 0

/obj/item/ammo_casing/caseless/a75
	desc = "A .75 bullet casing."
	caliber = "75"
	materials = list(MAT_METAL = 8000)
	projectile_type = /obj/item/projectile/bullet/gyro
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_STRONG
	muzzle_flash_range = MUZZLE_FLASH_RANGE_STRONG

/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	icon_state = "40mmHE"
	materials = list(MAT_METAL = 8000)
	caliber = "40mm"
	projectile_type = /obj/item/projectile/bullet/a40mm
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/caseless/foam_dart
	name = "foam dart"
	desc = "It's nerf or nothing! Ages 8 and up."
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foamdart"
	materials = list(MAT_METAL = 10)
	caliber = "foam_force"
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart
	muzzle_flash_effect = null
	var/modified = 0
	harmful = FALSE

/obj/item/ammo_casing/caseless/foam_dart/update_icon()
	..()
	if(modified)
		icon_state = "foamdart_empty"
		desc = "Its nerf or nothing! ... Although, this one doesn't look too safe."
		if(BB)
			BB.icon_state = "foamdart_empty"
	else
		icon_state = initial(icon_state)
		if(BB)
			BB.icon_state = initial(BB.icon_state)

/obj/item/ammo_casing/caseless/foam_dart/attackby(obj/item/A, mob/user, params)
	..()
	var/obj/item/projectile/bullet/reusable/foam_dart/FD = BB
	if(istype(A, /obj/item/screwdriver) && !modified)
		modified = 1
		FD.damage_type = BRUTE
		update_icon()
	else if((istype(A, /obj/item/pen)) && modified && !FD.pen)
		if(!user.unEquip(A))
			return
		harmful = TRUE
		A.loc = FD
		FD.log_override = FALSE
		FD.pen = A
		FD.damage = 5
		FD.nodamage = 0
		to_chat(user, "<span class='notice'>You insert [A] into [src].</span>")
	return

/obj/item/ammo_casing/caseless/foam_dart/attack_self(mob/living/user)
	var/obj/item/projectile/bullet/reusable/foam_dart/FD = BB
	if(FD.pen)
		FD.damage = initial(FD.damage)
		FD.nodamage = initial(FD.nodamage)
		user.put_in_hands(FD.pen)
		to_chat(user, "<span class='notice'>You remove [FD.pen] from [src].</span>")
		FD.pen = null

/obj/item/ammo_casing/caseless/foam_dart/riot
	name = "riot foam dart"
	desc = "Whose smart idea was it to use toys as crowd control? Ages 18 and up."
	icon_state = "foamdart_riot"
	materials = list(MAT_METAL = 650)
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart/riot

/obj/item/ammo_casing/caseless/foam_dart/sniper
	name = "foam sniper dart"
	desc = "For the big nerf! Ages 8 and up."
	icon_state = "foamdartsniper"
	materials = list(MAT_METAL = 20)
	caliber = "foam_force_sniper"
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart/sniper

/obj/item/ammo_casing/caseless/foam_dart/sniper/update_icon()
	..()
	if(modified)
		icon_state = "foamdartsniper_empty"
		desc = "Its nerf or nothing! ... Although, this one doesn't look too safe."
		if(BB)
			BB.icon_state = "foamdartsniper_empty"
	else
		icon_state = initial(icon_state)
		if(BB)
			BB.icon_state = initial(BB.icon_state)

/obj/item/ammo_casing/caseless/foam_dart/sniper/riot
	name = "riot foam sniper dart"
	desc = "For the bigger brother of the crowd control toy. Ages 18 and up."
	icon_state = "foamdartsniper_riot"
	materials = list(MAT_METAL = 1800)
	caliber = "foam_force_sniper"
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart/sniper/riot

/obj/item/ammo_casing/shotgun/assassination
	name = "assassination shell"
	desc = "A specialist shrapnel shell that has been laced with a silencing toxin."
	materials = list(MAT_METAL = 1500, MAT_GLASS = 200)
	projectile_type = /obj/item/projectile/bullet/pellet/assassination
	muzzle_flash_effect = null
	icon_state = "gshell"
	pellets = 6
	variance = 25

/obj/item/ammo_casing/cap
	desc = "A cap for children toys."
	materials = list(MAT_METAL = 10)
	caliber = "cap"
	projectile_type = /obj/item/projectile/bullet/cap
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_NORMAL
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL

/obj/item/ammo_casing/laser
	desc = "An experimental laser casing."
	icon_state = "lasercasing"
	materials = list(MAT_METAL = 2000, MAT_PLASMA = 200)
	caliber = "laser"
	projectile_type = /obj/item/projectile/beam/laser
	muzzle_flash_effect = /obj/effect/temp_visual/target_angled/muzzle_flash/energy
	muzzle_flash_strength = MUZZLE_FLASH_STRENGTH_WEAK
	muzzle_flash_range = MUZZLE_FLASH_RANGE_NORMAL
	muzzle_flash_color = LIGHT_COLOR_DARKRED
