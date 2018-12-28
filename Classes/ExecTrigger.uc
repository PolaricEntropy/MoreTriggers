//=============================================================================
// ExecTrigger
//
// Executes a ConsoleCommand on the player.
//
// By: PolaricEntropy
//=============================================================================
class ExecTrigger extends MoreTriggers;

var() string Command;

function BeenTriggered(Actor Other, actor instigator)
{
	local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());

	if(player != None)
		player.ConsoleCommand(Command);
}

defaultproperties
{
}