
/obj/item/clothing/gloves/space_ninja
	desc = "These nano-enhanced gloves insulate from electricity and provide fire resistance."
	name = "ninja gloves"
	icon_state = "s-ninja"
	item_state = "s-ninja"
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 120
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/obj/item/energy_katana/energyKatana
	var/recall_charges = 3
	var/fabrication_charges = 10
	var/fabrication_options = list(/obj/item/restraints/legcuffs/bola/energy = "energy bola", /obj/item/caltrops = "caltrops", /obj/item/grenade/smokebomb = "smoke bomb")
	actions_types = list(/datum/action/item_action/ninjafabricate, /datum/action/item_action/ninja_sword_recall)

/obj/item/clothing/gloves/space_ninja/attackby(obj/I, mob/user, params)
		if(istype(I, /obj/item/energy_katana))
			energyKatana = I
			to_chat(user, "<span class='notice'>You link the [I] to the [src].</span>")

/obj/item/clothing/gloves/space_ninja/ui_action_click(mob/living/carbon/human/user, action)
		if(istype(action, /datum/action/item_action/ninjafabricate))
			ninjafabricate(user)
			return TRUE
		if(istype(action, /datum/action/item_action/ninja_sword_recall))
			ninja_sword_recall(user)
			return TRUE
		return FALSE

/obj/item/clothing/gloves/space_ninja/wisdom
	name = "smart ninja gloves"
	desc = "Advanced ninja gloves with a wider variety of better quality fabrications. Also teaches the user Krav Maga."
	fabrication_charges = 15
	fabrication_options = list(/obj/item/restraints/legcuffs/bola/tactical = "heavy bola", /obj/item/grenade/clusterbuster/smoke = "large smoke bomb", /obj/item/grenade/clusterbuster/caltrops = "caltrop scatter grenade", /obj/item/throwing_star/ninja = "throwing star")
	var/datum/martial_art/krav_maga/style = new

/obj/item/clothing/gloves/space_ninja/wisdom/equipped(mob/user, slot)
	if(!ishuman(user))
		return
	if(slot == SLOT_GLOVES)
		var/mob/living/carbon/human/H = user
		style.teach(H,1)

/obj/item/clothing/gloves/space_ninja/wisdom/dropped(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(SLOT_GLOVES) == src)
		style.remove(H)
