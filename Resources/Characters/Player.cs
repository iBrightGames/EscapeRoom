using Godot;
using System;

public class Player : KinematicBody2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	
	[Export]
	public float speed = 1;
	
	private Sprite sprite;
	private AnimationPlayer animator;
	
	private bool moving = false;
	private Vector2 targetPos;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("> Player initialized\n");
		sprite = GetChild(0) as Sprite;
		animator = GetChild(1) as AnimationPlayer;

		animator.Play("Idle");
	}

	public override void _PhysicsProcess(float delta)
	{
		Move();
	}
	
	public override void _Input(InputEvent inputEvent)
	{
		
		if (inputEvent is InputEventMouseButton eventMouseButton)
			GetTarget(GetViewport().GetMousePosition());
		
	}
	
	public void Move()
	{
		
		if(!moving)
			return;
			
			
		
		if(targetPos.DistanceTo(Position) <= 1)
		{
			Reached();
			return;	
		}
		
		Vector2 direction = (targetPos - Position).Normalized();
		
		bool flipped = direction.x < 0;
		sprite?.SetFlipH(flipped);
//		GetNode("Sprite").SetFlipH(flipped);
		
		MoveAndSlide(direction * speed * 100);
		
		
	}

	public void GetTarget(Vector2 position)
	{

		targetPos = position;

		moving = true;

		animator.Play("Run");

	}

	public void Reached()
	{

		moving = false;

		animator.Play("Idle");

	}


}
