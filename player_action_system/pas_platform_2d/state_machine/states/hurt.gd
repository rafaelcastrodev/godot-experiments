extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: HURT
====================== """

func enter() -> void:
	super();
	owner.is_hurt = true;
	owner.AnimatedSprite.play(Globals.PlayerStates.HURT);
#}

func exit() -> void:
	super();
	owner.is_hurt = false;
#}
