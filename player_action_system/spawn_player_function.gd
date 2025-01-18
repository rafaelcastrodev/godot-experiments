
func _spawn_player(player_id: int):

	# . . .

	var player: Player = Globals.PLAYER_SCENE.instantiate();
	player.initialize(player_id);

	add_child(player);

	# . . .

	var pas: PackedScene = DINO_RUSH_PAS;
	var pas_instance: PAS_Platform2D = pas.instantiate();

	player.add_child(pas_instance);
	pas_instance.initialize(player);

#}
