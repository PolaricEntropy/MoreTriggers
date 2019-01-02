//=============================================================================
// FlaggedActorTrigger
// 
// Sets a flag with a prefix, suffix and the name of the actor that touched it.
//
// By: PolaricEntropy (for Deus Ex: Revision)
//=============================================================================
class FlaggedActorTrigger extends MoreTriggers;

var() name flagPrefix;
var() name flagSuffix;
var() bool flagValue;
var() int flagExpiration;

function BeenTriggered(Actor Other, Actor instigator)
{
	local DeusExPlayer player;
	local Actor A;
	local String flagName;
	
	if(flagPrefix != 'None')
		flagName = "" $ flagPrefix;
	
	flagName = flagName $ instigator.Name;
	
	if (flagSuffix != 'None')
		flagName = flagName $ flagSuffix;
	
	player = DeusExPlayer(GetPlayerPawn());
	
	if (player != None)
	{
		if (flagExpiration == -1)
			player.flagBase.SetBool(player.flagBase.StringToName(flagName), flagValue);
		else
			player.flagBase.SetBool(player.flagBase.StringToName(flagName), flagValue,, flagExpiration);
	}
}

defaultproperties
{
}
