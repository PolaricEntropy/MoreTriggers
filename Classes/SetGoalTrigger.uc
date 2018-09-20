//=============================================================================
// SetGoalTrigger
//
// Allows you to set a goal for a player without using ConEdit.
//
// By: Steve Tack :D
//=============================================================================

class SetGoalTrigger expands MoreTriggers;

// Creates a goal when touched or triggered
// Set bCollideActors to False to make it triggered

var() name goalName;
var() string goalText;

function BeenTriggered(Actor Instigator)
{
	local DeusExGoal newGoal;
	local DeusExGoal prevGoal;
	local DeusExPlayer player;

	player=DeusExPlayer(GetPlayerPawn());

	if (player != None)
	{
		// Make sure goal doesn't already exist
		prevGoal = player.FindGoal(goalName);

		if (prevGoal == None)
		{
			newGoal = Player.AddGoal(goalName, True);
			newGoal.SetText(goalText);
		}
	}
}

defaultproperties
{
	bTriggerOnceOnly=True
}