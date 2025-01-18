class_name Player;
extends CharacterBody2D;

signal leave(player_id: int);

var player_id: int = 0;
var player_device: int = 0;
var character_current_skin: int = 0;

@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D;

""" BUILT-IN METHODS ====================== """

func _ready() -> void:
	Ui_Label.text = str("#",player_id + 1);
#}

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int());
#}

func _exit_tree() -> void:
	leave.emit(player_id);
#}


""" PUBLIC METHODS ====================== """

func initialize(id: int):
	player_id = id;
	player_device = MultiplayerConnectionManager.get_player_device(player_id);
#}

