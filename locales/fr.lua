local Translations = {
    error = {
        ["blips_deactivated"] = "Blips desactivés",
        ["names_deactivated"] = "Noms deactivés",
        ["changed_perm_failed"] = "Choisissez un groupe!",
        ["missing_reason"] = "Vous devez donner une raison!",
        ["invalid_reason_length_ban"] = "Vous devez donner une raison et spécifier une durée pour le ban!",
        ["no_store_vehicle_garage"] = "Vous ne pouvez pas ranger ce véhicule dans votre garage..",
        ["no_vehicle"] = "Vous n'êtes pas dans un véhicule..",
        ["no_weapon"] = "Vous n'avez pas d'arme dans vos mains..",
        ["no_free_seats"] = "Le véhicule n'a pas de siège disponible!",
        ["failed_vehicle_owner"] = "Le véhicule vous appartient déjà..",
        ["not_online"] = "Ce joueur n'est pas connecté",
        ["no_receive_report"] = "Vous ne recevez plus de reports",
        ["failed_set_speed"] = "Vous n'avez pas spécifié de vitesse.. (`fast` pour super-run, `normal` pour normal)",
        ["failed_set_model"] = "Vous n'avez pas mis de model..",
        ["failed_entity_copy"] = "Aucune information d'entité freeaim à copier dans le presse-papier !",
    },
    success = {
        ["blips_activated"] = "Blips activés",
        ["names_activated"] = "Noms activés",
        ["coords_copied"] = "Coordonnés copiés!",
        ["heading_copied"] = "Cap copiés!",
        ["changed_perm"] = "Autorité de groupe modifiée",
        ["entered_vehicle"] = "Vous êtes entré dans un véhicule",
        ["success_vehicle_owner"] = "Le véhicule vous appartients maintenant!",
        ["receive_reports"] = "Vous recevez des reports",
        ["entity_copy"] = "Informations sur l'entité Freeaim copiées dans le presse-papier !",
    },
    info = {
        ["ped_coords"] = "Coordonnés du ped:",
        ["vehicle_dev_data"] = "Données de véhicule pour developpeur :",
        ["ent_id"] = "ID de l'Entité:",
        ["net_id"] = "ID Net:",
        ["net_id_not_registered"] = "Non enregistré",
        ["model"] = "Model",
        ["hash"] = "Hash",
        ["eng_health"] = "Santé moteur:",
        ["body_health"] = "Santé carrosserie:",
        ["goto"] = "Aller à",
        ["remove"] = "Retirer",
        ["confirm"] = "Confirmer",
        ["reason_title"] = "Raison",
        ["length"] = "durée",
        ["options"] = "Options",
        ["position"] = "Position",
        ["your_position"] = "a votre position",
        ["open"] = "Ouvrir",
        ["inventories"] = "inventaires",
        ["reason"] = "Vous devez donner une raison",
        ["give"] = "donner",
        ["id"] = "ID:",
        ["player_name"] = "Nom du joueur",
        ["obj"] = "Obj",
        ["ammoforthe"] = "+%{value} Munitions pour: %{weapon}",
        ["kicked_server"] = "Vous avez été Kick du serveur !",
        ["check_discord"] = "🔸 Allez sur le Discord pour plus d'informations: ",
        ["banned"] = "Vous avez été Ban:",
        ["ban_perm"] = "\n\nVotre Ban est Permanent.\n🔸 Allez sur le Discord pour plus d'informations: ",
        ["ban_expires"] = "\n\nLe ban expire dans: ",
        ["rank_level"] = "Votre nouveau niveau de Permissions est ",
        ["admin_report"] = "Report Admin - ",
        ["staffchat"] = "Chat Staff - ",
        ["warning_chat_message"] = "^8WARNING ^7 Vous avez été Warn par",
        ["warning_staff_message"] = "^8WARNING ^7 Vous avez warn ",
        ["no_reason_specified"] = "Pas de raison spécifiée",
        ["server_restart"] = "Restart serveur, Allez sur le Discord pour plus d'informations: ",
        ['entity_view_distance'] = "Distance de la vue de l'entité définie sur : %{distance} mètres",
        ["entity_view_info"] = "Informations sur l'entité",
        ["entity_view_title"] = "Mode de visée libre d'entité",
        ["entity_freeaim_delete"] = "Supprimer l'entité",
        ["entity_freeaim_freeze"] = "Geler l'entité",
        ["entity_frozen"] = "Gelé",
        ["entity_unfrozen"] = "Dégelé",
        ["model_hash"] = "Modèle de hachage :",
        ["obj_name"] = "Nom de l'objet :",
        ["ent_owner"] = "Propriétaire de l'entité :",
        ["cur_health"] = "Santé actuelle :",
        ["max_health"] = "Santé maximale :",
        ["armure"] = "Armure :",
        ["rel_group"] = "Groupe de relations :",
        ["rel_to_player"] = "Relation avec le joueur :",
        ["rel_group_custom"] = "Custom Relationship",
        ["veh_acceleration"] = "Accélération :",
        ["veh_cur_gear"] = "Équipement actuel :",
        ["veh_speed_kph"] = "Kph :",
        ["veh_speed_mph"] = "Mi/h :",
        ["veh_rpm"] = "Régime :",
        ["dist_to_obj"] = "Dist :",
        ["obj_heading"] = "Titre :",
        ["obj_coords"] = "Coords :",
        ["obj_rot"] = "Rotation :",
        ["obj_velocity"] = "Vitesse :",
        ["obj_unknown"] = "Inconnu",
        ["you_have"] = "Vous avez",
        ["freeaim_entity"] = " l'entité freeaim",
        ["entity_del"] = "Entité supprimée",
        ["entity_del_error"] = "Erreur lors de la suppression de l'entité",
    },
    menu = {
        ["admin_menu"] = "Menu Admin",
        ["admin_options"] = "Options Admin",
        ["online_players"] = "Joueurs En Ligne",
        ["manage_server"] = "Gérer le serveur",
        ["weather_conditions"] = "Options météos disponible",
        ["dealer_list"] = "Liste de Dealeurs",
        ["ban"] = "Ban",
        ["kick"] = "Kick",
        ["permissions"] = "Permissions",
        ["developer_options"] = "Options Developpeurs",
        ["vehicle_options"] = "Options Véhicule",
        ["vehicle_categories"] = "Categories Véhicule",
        ["vehicle_models"] = "Modèles Vehicule",
        ["player_management"] = "Gérer des joueurs",
        ["server_management"] = "Gérer le serveur",
        ["vehicles"] = "Vehicules",
        ["noclip"] = "NoClip",
        ["revive"] = "Réanimer",
        ["invisible"] = "Invisible",
        ["god"] = "Godmode",
        ["names"] = "Noms",
        ["blips"] = "Blips",
        ["weather_options"] = "Options météo",
        ["server_time"] = "Temps du Serveur",
        ["time"] = "temps",
        ["copy_vector3"] = "Copier vector3",
        ["copy_vector4"] = "Copier vector4",
        ["display_coords"] = "Afficher Coords",
        ["copy_heading"] = "Copier Cap",
        ["vehicle_dev_mode"] = "Mode Dev Véhicule",
        ["spawn_vehicle"] = "Spawn Véhicule",
        ["fix_vehicle"] = "Réparer Véhicule",
        ["buy"] = "Acheter",
        ["remove_vehicle"] = "Supprimer un Vehicule",
        ["edit_dealer"] = "Modifier le Dealeur ",
        ["dealer_name"] = "Nom du Dealeur",
        ["category_name"] = "Nom de Catégorie",
        ["kill"] = "Kill",
        ["freeze"] = "Freeze",
        ["spectate"] = "Spectate",
        ["bring"] = "Ramener",
        ["sit_in_vehicle"] = "S'asseoir dans le véhicule",
        ["open_inv"] = "Ouvrir l'inventaire",
        ["give_clothing_menu"] = "Donner le menu vêtement",
        ["hud_dev_mode"] = "Mode développeur (qb-hud)",
        ["entity_view_options"] = "Mode d'affichage d'entité",
        ["entity_view_distance"] = "Définir la distance de vue",
        ["entity_view_freeaim"] = "Mode de visée libre",
        ["entity_view_peds"] = "Afficher les Peds",
        ["entity_view_vehicles"] = "Afficher les véhicules",
        ["entity_view_objects"] = "Afficher les objets",
        ["entity_view_freeaim_copy"] = "Copier les informations d'entité Freeaim",
        ["spawn_weapons"] = "Spawn Weapons",
        ["max_mods"] = "Max car mods",
    },
    desc = {
        ["admin_options_desc"] = "Options Admin Divers",
        ["player_management_desc"] = "Voir La Liste Des Players",
        ["server_management_desc"] = "Divers Options Serveur",
        ["vehicles_desc"] = "Options Véhicule",
        ["dealer_desc"] = "Liste des Dealeurs Existant",
        ["noclip_desc"] = "Activer/Désactiver NoClip",
        ["revive_desc"] = "Réanimer Vous",
        ["invisible_desc"] = "Activer/Désactiver Invisibilité",
        ["god_desc"] = "Activer/Désactiver God Mode",
        ["names_desc"] = "Activer/Désactiver Noms",
        ["blips_desc"] = "Activer/Désactiver Blips des joueurs sur la carte",
        ["weather_desc"] = "Changer la Météo",
        ["developer_desc"] = "Options Dev Divers",
        ["vector3_desc"] = "Copier vector3",
        ["vector4_desc"] = "Copier vector4",
        ["display_coords_desc"] = "Afficher les coordonnées",
        ["copy_heading_desc"] = "Copier cap",
        ["vehicle_dev_mode_desc"] = "Afficher Information Véhicule",
        ["delete_laser_desc"] = "Activer/Désactiver Laser",
        ["spawn_vehicle_desc"] = "Spawn un vehicule",
        ["fix_vehicle_desc"] = "Réparer votre véhicule",
        ["buy_desc"] = "Acheter le véhicule gratuitement",
        ["remove_vehicle_desc"] = "Supprimer le véhicule le plus proche",
        ["dealergoto_desc"] = "Aller au dealeur",
        ["dealerremove_desc"] = "Supprimer le dealeur",
        ["kick_reason"] = "Raison du kick",
        ["confirm_kick"] = "Confirmer le kick",
        ["ban_reason"] = "Raison du ban",
        ["confirm_ban"] = "Confirmer le ban",
        ["sit_in_veh_desc"] = "S'asseoir dans le véhicule de",
        ["sit_in_veh_desc2"] = ".",
        ["clothing_menu_desc"] = "Donner le menu vêtements à",
        ["hud_dev_mode_desc"] = "Activer/Désactiver le mode développeur",
        ["entity_view_desc"] = "Afficher les informations sur les entités",
        ["entity_view_freeaim_desc"] = "Activer/Désactiver les informations sur l'entité via freeaim",
        ["entity_view_peds_desc"] = "Activer/Désactiver les infos ped dans le monde",
        ["entity_view_vehicles_desc"] = "Activer/Désactiver les informations sur les véhicules dans le monde",
        ["entity_view_objects_desc"] = "Activer/Désactiver les informations sur les objets dans le monde",
        ["entity_view_freeaim_copy_desc"] = "Copie les informations de l'entité de visée libre dans le presse-papiers",
        ["spawn_weapons_desc"] = "Apparaître n'importe quelle arme.",
        ["max_mod_desc"] = "Max mod votre véhicule actuel",
    },
    time = {
        ["ban_length"] = "Durée du Ban",
        ["1hour"] = "1 Heure",
        ["6hour"] = "6 Heures",
        ["12hour"] = "12 heures",
        ["1day"] = "1 Jour",
        ["3day"] = "3 Jours",
        ["1week"] = "1 Semaine",
        ["1month"] = "1 Mois",
        ["3month"] = "3 Mois",
        ["6month"] = "6 Mois",
        ["1year"] = "1 An",
        ["permenent"] = "Permanent",
        ["self"] = "sois-même",
        ["changed"] = "Temps Changé à %{time} hs 00 min",
        ["placeholder"] = " hs 00 min",
    },
    weather = {
        ["extra_sunny"] = "Extra Ensoleillé",
        ["extra_sunny_desc"] = "Je fond!",
        ["clear"] = "Claire",
        ["clear_desc"] = "Le jour parfait!",
        ["neutral"] = "Neute",
        ["neutral_desc"] = "Just A Regular Day!",
        ["smog"] = "Brouillard",
        ["smog_desc"] = "Machine à fumé!",
        ["foggy"] = "Brumeux",
        ["foggy_desc"] = "Machine a fumé x2!",
        ["overcast"] = "Ciel Couvert",
        ["overcast_desc"] = "pas très ensoleillé!",
        ["clouds"] = "Nuageux",
        ["clouds_desc"] = "Oû-est le soleil?",
        ["clearing"] = "Dégagé",
        ["clearing_desc"] = "Les nuages s'en vont!",
        ["rain"] = "Pluie",
        ["rain_desc"] = "Make It Rain!",
        ["thunder"] = "Orage",
        ["thunder_desc"] = "Courez et Cachez vous!",
        ["snow"] = "Neige",
        ["snow_desc"] = "Fait-il froid dehors?",
        ["blizzard"] = "Blizzard",
        ["blizzed_desc"] = "Machine a neige?",
        ["light_snow"] = "Neige Légère",
        ["light_snow_desc"] = "Ca commence a sentir comme Nôel!",
        ["heavy_snow"] = "Neige épaisse (Nôel)",
        ["heavy_snow_desc"] = "Combat de boule de neige!",
        ["halloween"] = "Halloween",
        ["weather_changed"] = "Météo changée à: %{value}",
    },
    commands = {
        ["blips_for_player"] = "Affiche les blips des joueurs (Admin Only)",
        ["player_name_overhead"] = "Affiche le nom des joueurs (Admin Only)",
        ["coords_dev_command"] = "Affiche les coordonnées pour le dev (Admin Only)",
        ["toogle_noclip"] = "Active le noclip (Admin Only)",
        ["save_vehicle_garage"] = "Sauvegarde un véhicule dans votre garage (Admin Only)",
        ["make_announcement"] = "Fais une Annonce (Admin Only)",
        ["open_admin"] = "Ouvre le menu Admin (Admin Only)",
        ["staffchat_message"] = "Envoie un message a tous les staffs (Admin Only)",
        ["nui_focus"] = "Donner a un joueur le Focus NUI (Admin Only)",
        ["warn_a_player"] = "Warn Un Joueur (Admin Only)",
        ["check_player_warning"] = "Check Les Warns d'un joueur (Admin Only)",
        ["delete_player_warning"] = "Supprime les Warns d'un joueur (Admin Only)",
        ["reply_to_report"] = "Répond a un report (Admin Only)",
        ["change_ped_model"] = "Change le modèle du Ped (Admin Only)",
        ["set_player_foot_speed"] = "Défini la vitesse du joueur (Admin Only)",
        ["report_toggle"] = "Active les reports (Admin Only)",
        ["kick_all"] = "Kick tout les joueurs",
        ["ammo_amount_set"] = "Défini vos munitions (Admin Only)",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
