//=============================================================================
// EnergyTrigger
//
// Gives the player energy.
//=============================================================================
class EnergyTrigger extends MoreTriggers;

var() int Energy; //amount of BE energy to make player have
var() bool bAbsoluteSet; //if true, player's energy is set to Energy. If false, Energy is added on

function BeenTriggered(Actor Other, Actor instigator)
{
	local DeusExPlayer player;
	player=DeusExPlayer(instigator);
	
	if(player==None)
		return;

	if(bAbsoluteSet)
		player.Energy=Energy;
	else
		player.Energy+=Energy;

	if(player.Energy<0)
		player.Energy=0;
}

defaultproperties
{
	bAbsoluteSet=True
}
