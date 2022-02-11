local Translations = {
    error = {
        ["blips_deactivated"] = "Blips desativados",
        ["names_deactivated"] = "Nomes desativados",
        ["changed_perm_failed"] = "Escolhe um grupo!",
        ["missing_reason"] = "Tens de dar uma razão!",
        ["invalid_reason_length_ban"] = "Tens de dar uma razão e definir o tempo do ban!",
        ["no_store_vehicle_garage"] = "Não podes guardar este veículo..", 
        ["no_vehicle"] = "Não estás num veículo..",
        ["no_weapon"] = "Não tens uma arma nas tuas mãos..",
        ["no_free_seats"] = "O veículo não tem lugares disponíveis!",
        ["failed_vehicle_owner"] = "Este veículo já te pertence..",
        ["not_online"] = "Este jogador não está online",
        ["no_receive_report"] = "Não estás a receber reports",
        ["failed_set_speed"] = "Não definiste uma velocidade.. (`fast` para super-corrida, `normal` para corrida normal)",
        ["failed_set_model"] = "Não definiste um model..",
    },
    success = {
        ["blips_activated"] = "Blips ativados",
        ["names_activated"] = "Nomes ativados",
        ["coords_copied"] = "Coordenadas copiadas!",
        ["heading_copied"] = "Heading copiado!",
        ["changed_perm"] = "Grupo alterado",
        ["entered_vehicle"] = "Entrou num veículo",
        ["success_vehicle_owner"] = "Este veículo agora é teu!",
        ["receive_reports"] = "Estás A Receber Reports",
    },
    info = {
        ["ped_coords"] = "Coordenadas Do Ped:",
        ["vehicle_dev_data"] = "Dev Veículo Data:",
        ["ent_id"] = "Entity ID:",
        ["net_id"] = "Net ID:",
        ["model"] = "Model",
        ["hash"] = "Hash",
        ["eng_health"] = "Estado Do Motor:",
        ["body_health"] = "Estado Do Chassi:",
        ["goto"] = "Ir Para", 
        ["remove"] = "Remover",
        ["confirm"] = "Confirmar",
        ["reason_title"] = "Razão",
        ["length"] = "Tempo",
        ["options"] = "Opções",
        ["position"] = "Posição",
        ["your_position"] = "Para A Tua Posição",
        ["open"] = "Abrir",
        ["inventories"] = "Inventários",
        ["reason"] = "Precisas De Dar Uma Razão", 
        ["give"] = "Dar",
        ["id"] = "ID:", 
        ["player_name"] = "Nome Do Jogador",
        ["delete_object_info"] = "Para Eliminar O Objeto Pressiona ~g~E", 
        ["obj"] = "Obj",
        ["ammoforthe"] = "+%{value} Munição Para A Arma %{weapon}", 
        ["kicked_server"] = "Foste Kickado Do Servidor",
        ["check_discord"] = "🔸 Verifica O Nosso Discord Para Mais Informações: ", 
        ["banned"] = "Foste Banido(a):",
        ["ban_perm"] = "\n\nO Teu Ban É Permanente.\n🔸 Verifica O Nosso Discord Para Mais Informações: ",
        ["ban_expires"] = "\n\nBan Expira: ",
        ["rank_level"] = "O Teu Nível de Permissões Agora É ",
        ["admin_report"] = "Reports Admin - ",
        ["staffchat"] = "STAFFCHAT - ",
        ["warning_chat_message"] = "^8AVISO ^7 Foste Avisado Por ",
        ["warning_staff_message"] = "^8AVISO ^7 Avisaste ",
        ["no_reason_specified"] = "Razão Não Indicada",
        ["server_restart"] = "Server Em Restart, Verifica O Nosso Discord Para Mais Informações: ",
    },
    menu = {
        ["admin_menu"] = "Menu Admin",
        ["admin_options"] = "Opções Admin",
        ["online_players"] = "Jogadores Online",
        ["manage_server"] = "Gerir Servidor",
        ["weather_conditions"] = "Opções Clima",
        ["dealer_list"] = "Lista De Dealers",
        ["ban"] = "Ban",
        ["kick"] = "Kick",
        ["permissions"] = "Permissões",
        ["developer_options"] = "Opções Developer",
        ["vehicle_options"] = "Opções Veículo",
        ["vehicle_categories"] = "Categorias Veículo",
        ["vehicle_models"] = "Modelos Veículo",
        ["player_management"] = "Gestão Jogador",
        ["server_management"] = "Gestão Servidor",
        ["vehicles"] = "Veículos",
        ["noclip"] = "NoClip",
        ["revive"] = "Revive",
        ["invisible"] = "Invisível",
        ["god"] = "GodMode",
        ["names"] = "Names",
        ["blips"] = "Blips",
        ["weather_options"] = "Opções Clima",
        ["server_time"] = "Tempo Servidor",
        ["time"] = "Tempo",
        ["copy_vector3"] = "Copiar vector3", 
        ["copy_vector4"] = "Copiar vector4",
        ["display_coords"] = "Ativar/Desativar Coords",
        ["copy_heading"] = "Copiar Heading",
        ["vehicle_dev_mode"] = "Dev Mode Veículo",
        ["delete_laser"] = "Laser Apagar", 
        ["spawn_vehicle"] = "Spawnar Veículo",
        ["fix_vehicle"] = "Reparar Veículo",
        ["buy"] = "Comprar",
        ["remove_vehicle"] = "Remover Veículo",
        ["edit_dealer"] = "Editar Dealer ", 
        ["dealer_name"] = "Nome Dealer",
        ["category_name"] = "Nome Categoria",
        ["kill"] = "Kill",
        ["freeze"] = "Freeze",
        ["spectate"] = "Spectate",
        ["bring"] = "Bring",
        ["sit_in_vehicle"] = "Sentar No Veículo", 
        ["open_inv"] = "Abrir Inventário",
        ["give_clothing_menu"] = "Dar Menu De Roupa",
    },
    desc = {
        ["admin_options_desc"] = "Misc. Opções Admin",
        ["player_management_desc"] = "Ver Lista De Jogadores",
        ["server_management_desc"] = "Misc. Opções Servidor",
        ["vehicles_desc"] = "Opções De Veículo",
        ["dealer_desc"] = "Lista De Dealers Existentes",
        ["noclip_desc"] = "Ativar/Desativar NoClip",
        ["revive_desc"] = "Reviver A Ti Próprio(a)",
        ["invisible_desc"] = "Ativar/Desativar Invisibilidade",
        ["god_desc"] = "Ativar/Desativar Modo God", 
        ["names_desc"] = "Ativar/Desativar Nomes Na Cabeça",
        ["blips_desc"] = "Ativar/Desativar Blips Dos Jogadores No Mapa",
        ["weather_desc"] = "Alterar Clima",
        ["developer_desc"] = "Misc. Opções Dev",
        ["vector3_desc"] = "Copiar vector3",
        ["vector4_desc"] = "Copiar vector4", 
        ["display_coords_desc"] = "Ativar/Desativar Coords No Ecrã",
        ["copy_heading_desc"] = "Copiar Heading",
        ["vehicle_dev_mode_desc"] = "Ativar/Desativar Informação Do Veículo",
        ["delete_laser_desc"] = "Ativar/Desativar Laser",
        ["spawn_vehicle_desc"] = "Spawnar Veículo",
        ["fix_vehicle_desc"] = "Reparar Veículo",
        ["buy_desc"] = "Adicionar Veículo Na Tua Garagem",
        ["remove_vehicle_desc"] = "Remover Veículo Próximo",
        ["dealergoto_desc"] = "Ir Para Dealer",
        ["dealerremove_desc"] = "Remover Dealer",
        ["kick_reason"] = "Razão do Kick",
        ["confirm_kick"] = "Confirmar O Kick",
        ["ban_reason"] = "Razão Do Ban",
        ["confirm_ban"] = "Confirmar O Ban",
        ["sit_in_veh_desc"] = "Sentar No Veículo",
        ["sit_in_veh_desc2"] = "Sentar No Veículo2",
        ["clothing_menu_desc"] = "Dar Menu De Roupa Ao Jogador",
    },
    time = {
        ["ban_length"] = "Tempo do Ban",
        ["1hour"] = "1 Hora",
        ["6hour"] = "6 Horas",
        ["12hour"] = "12 Horas",
        ["1day"] = "1 Dia",
        ["3day"] = "3 Dias",
        ["1week"] = "1 Semana",
        ["1month"] = "1 Mês",
        ["3month"] = "3 Mês",
        ["6month"] = "6 Mês",
        ["1year"] = "1 Ano",
        ["permenent"] = "Permanente",
        ["self"] = "Prório",
        ["changed"] = "Tempo Alterado Para %{time}H 00 Min",
    },
    weather = {
        ["extra_sunny"] = "Extra Sunny",
        ["extra_sunny_desc"] = "Estou A Soar Com Este Sol!",
        ["clear"] = "Clear",
        ["clear_desc"] = "Dia Perfeito!",
        ["neutral"] = "Neutral",
        ["neutral_desc"] = "Apenas Um Dia Normal!",
        ["smog"] = "Smog",
        ["smog_desc"] = "Máquina De Fumo!",
        ["foggy"] = "Foggy",
        ["foggy_desc"] = "Máquina De Fumo x2!",
        ["overcast"] = "Overcast",
        ["overcast_desc"] = "Vejo Pouco O Sol!",
        ["clouds"] = "Clouds",
        ["clouds_desc"] = "Onde Está O Sol?",
        ["clearing"] = "Clearing",
        ["clearing_desc"] = "As Núvens Estão A Desaparecer!",
        ["rain"] = "Rain",
        ["rain_desc"] = "Façam Chover!",
        ["thunder"] = "Thunder",
        ["thunder_desc"] = "Corre E Esconde-te!",
        ["snow"] = "Snow",
        ["snow_desc"] = "Está Frio Aí?",
        ["blizzard"] = "Blizzard", 
        ["blizzed_desc"] = "Máquina De Neve?",
        ["light_snow"] = "Light Snow",
        ["light_snow_desc"] = "Cheira-me A Natal!",
        ["heavy_snow"] = "Heavy Snow (XMAS)",
        ["heavy_snow_desc"] = "Luta de Bolas De Neve!",
        ["halloween"] = "Halloween",
        ["halloween_desc"] = "Que Barulho É Este?!",
        ["weather_changed"] = "clima Alterado Para: %{value}", 
    },
    commands = {
        ["blips_for_player"] = "Mostrar Blips Dos Jogadores (Apenas Admin)",
        ["player_name_overhead"] = "Mostrar Nome Dos Jogadadores Por Cima Da Cabeça (Apenas Admin)", 
        ["coords_dev_command"] = "Ativar/Desativar Coordenadas De Desenvolvimento (Apenas Admin)",
        ["toogle_noclip"] = "Ativar/Desativar Noclip (Apenas Admin)",
        ["save_vehicle_garage"] = "Salvar Veículo Na Tua Garagem (Apenas Admin)",
        ["make_announcement"] = "Fazer Um Anúncio (Apenas Admin)",
        ["open_admin"] = "Abrir Menu De Admin (Apenas Admin)",
        ["staffchat_message"] = "Enviar Mensagem Para Toda A Staff (Apenas Admin)",
        ["nui_focus"] = "Dar NUI Focus A Um Jogador (Apenas Admin)",
        ["warn_a_player"] = "Avisar Jogador (Apenas Admin)",
        ["check_player_warning"] = "Verificar Avisos De Um Jogador (Apenas Admin)",
        ["delete_player_warning"] = "Remover Avisos De Um Jogador (Apenas Admin)", 
        ["reply_to_report"] = "Responder A Um Report (Apenas Admin)",
        ["change_ped_model"] = "Alterar Ped Model (Apenas Admin)",
        ["set_player_foot_speed"] = "Definir Velocidade Do Jogador (Apenas Admin)",
        ["report_toggle"] = "Ativar/Desativar Reports (Apenas Admin)",
        ["kick_all"] = "Kickar Todos Os Jogadores (Apenas Admin)",
        ["ammo_amount_set"] = "Definir Munição Da Arma (Apenas Admin)",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
