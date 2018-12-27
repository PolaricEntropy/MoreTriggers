//=============================================================================
// HealthTrigger
//
// Adds or sets absolutely, the players health. You can specify limbs, too, so you can have a trigger that very specifically rips JC's arm off. Or heals them.
//=============================================================================
class HealthTrigger extends MoreTriggers;

var() int Health;
var() int HealthHead;
var() int HealthTorso;
var() int HealthLegLeft;
var() int HealthLegRight;
var() int HealthArmLeft;
var() int HealthArmRight;//amount of Health to make player have
var() bool bAbsoluteSet; //if true, player's Health is set to Health. If false, Health is added on

function BeenTriggered(Actor Other, Actor instigator)
{
	local DeusExPlayer player;
	player=DeusExPlayer(instigator);
	
	if(player==None)
		return;

	if(bAbsoluteSet)
	{
		player.Health=Health;
		player.HealthHead=HealthHead;
		player.HealthTorso=HealthTorso;
		player.HealthLegLeft=HealthLegLeft;
		player.HealthLegRight=HealthLegRight;
		player.HealthArmLeft=HealthArmLeft;
		player.HealthArmRight=HealthArmRight;
	}
	else
	{
		player.Health+=Health;
		player.HealthHead+=HealthHead;
		player.HealthTorso+=HealthTorso;
		player.HealthLegLeft+=HealthLegLeft;
		player.HealthLegRight+=HealthLegRight;
		player.HealthArmLeft+=HealthArmLeft;
		player.HealthArmRight+=HealthArmRight;
	}
	if(player.Health<0)
	{
		player.Health=0;
		player.HealthHead=0;
		player.HealthTorso=0;
		player.HealthLegLeft=0;
		player.HealthLegRight=0;
		player.HealthArmLeft=0;
		player.HealthArmRight=0;
	}
}

defaultproperties
{
	bAbsoluteSet=True
}
