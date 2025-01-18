extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: SNEAK
====================== """

var current_animation_speed_scale: float;

func enter() -> void:
	super();
	owner.character_current_speed = Globals.PLAYER_SNEAKING_SPEED;
	owner.AnimatedSprite.play(Globals.PlayerAnimations.SNEAK);
	current_animation_speed_scale = owner.AnimatedSprite.speed_scale;
#}

func exit() -> void:
	super();
#}

func physics_update(_delta: float) -> void:

	if owner.Character.velocity.y > 0:
		state_transitioned.emit(self, Globals.PlayerStates.FALL);
		return;

	if not owner.is_sneaking:
		if not owner.is_moving:
			state_transitioned.emit(self, Globals.PlayerStates.IDLE);
			return;
		if owner.is_walking:
			state_transitioned.emit(self, Globals.PlayerStates.WALK);
			return;
		state_transitioned.emit(self, Globals.PlayerStates.RUN);
		return;

	if not owner.is_moving:
		owner.AnimatedSprite.pause();
	else:
		owner.AnimatedSprite.play(Globals.PlayerAnimations.SNEAK);
#}
