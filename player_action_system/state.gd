class_name FiniteState;
extends Node;

""" ======================
BASE STATE CLASS FOR STATE MACHINE
====================== """

signal state_transitioned(source_state: FiniteState, new_state_name: StringName);
signal state_animated(animation_name: StringName);

var Character: Player;
var is_active: bool = false;

func _ready() -> void:
	set_physics_process(false);
#}


func handle_input(_event: InputEvent) -> void:
	pass;


func enter() -> void:
	#print_debug("State: ", Character.StateMachine.current_state_name.to_upper());
	set_physics_process(true);
#}


func exit() -> void:
	set_physics_process(false);
#}


func update(_delta: float) -> void:
	pass;
#}


func physics_update(_delta: float) -> void:
	pass;
#}

func on_animation_finished() -> void:
	pass;
#}
