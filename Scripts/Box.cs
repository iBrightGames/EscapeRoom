using Godot;
using System;

public class Box : KinematicBody2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	
	private bool mouseOn = false;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
		
	}
	
	public override void _Input(InputEvent inputEvent)
	{
		
		InputHandler(inputEvent);
		
	}
	
	private void InputHandler(InputEvent inputEvent)
	{
		
		if(!mouseOn)
			return;
			
		var button = inputEvent as InputEventMouseButton;

		if(button != null && button.ButtonIndex == (int)ButtonList.Left && inputEvent.IsPressed())
			GD.Print("Clicked");
			
	}

	public void OnMouseEntered()
	{
		
		GD.Print("Entered");
		
		mouseOn = true;
	}

	public void OnMouseExit()
	{
		
		GD.Print("Exitted");
		
		mouseOn = false;
	}

}
