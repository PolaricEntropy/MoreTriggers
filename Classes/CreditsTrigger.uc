//=============================================================================
// CreditsTrigger
//
// Gives the player credits (duh).
//=============================================================================

class CreditsTrigger extends MoreTriggers;

var() int NumCredits; //number of credits to make player have
var() bool bAbsoluteSet; //if true, player's credits is set to NumCredits. If false, NumCredits is added on

function BeenTriggered(Actor instigator)
{
	local DeusExPlayer player;
	player=DeusExPlayer(instigator);
	
	if(player==None)
		return;

	if(bAbsoluteSet)
		player.Credits=NumCredits;
	else
		player.Credits+=NumCredits;

	if(player.Credits<0)
		player.Credits=0;
}

defaultproperties
{
	NumCredits=0
	bAbsoluteSet=True
	TriggerType=TT_PlayerProximity
}