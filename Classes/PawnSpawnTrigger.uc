//=============================================================================
// PawnSpawnTrigger
//
// Normal SpawnTriggers are broken, and don't really work for pawns. This one does, more or less.
// Will not allow you to specify inventory, but alliances can be set. Thus you could use it to randomly add pedestrians in the background, or to make an eternal wave of MJ12Troops (since they already have inventory specified).
//=============================================================================

class PawnSpawnTrigger extends MoreTriggers;

var() class<ScriptedPawn> SpawnClass;
var() name Orders;
var() name OrdersTag;
var() name AllianceName;
var() float AllianceLevel;
var() bool bSpawnOutOfSight;
var() float checktimer;
var actor spawnOwner;
var actor savedinstigator;

function BeenTriggered(Actor Instigator)
{
	local ScriptedPawn MyPawn;

	if(!bSpawnOutOfSight)
	{
		MyPawn=Spawn(SpawnClass);
		if(MyPawn != none)
		{
			MyPawn.SetOrders(Orders, ordersTag, True);
			MyPawn.InitialAlliances[0].AllianceLevel=AllianceLevel;
			MyPawn.InitialAlliances[0].AllianceName=AllianceName;
			MyPawn.InitialAlliances[0].bPermanent=True;
		}
	}
	else
	{
		if(!checkspawn())
		{
			savedinstigator = instigator;
			settimer(checktimer,true);
		}
		else
		{
			checktimer = 0;
			settimer(checktimer,false);
		}
	}
}
function timer()
{
	if(checktimer > 0)
		BeenTriggered(savedinstigator);
}

function bool Checkspawn()
{
	local ScriptedPawn MyPawn;
	local deusexplayer p;

	P = deusexplayer(getplayerpawn());
	if(P != none && (P.LineOfSightTo(self, true) || vsize(P.location - location) < 256))
		return false;
	else
	{
		MyPawn=Spawn(SpawnClass);
        if(MyPawn != none)
		{
			MyPawn.SetOrders(Orders, ordersTag, True);
			MyPawn.InitialAlliances[0].AllianceLevel=AllianceLevel;
			MyPawn.InitialAlliances[0].AllianceName=AllianceName;
			MyPawn.InitialAlliances[0].bPermanent=True;
			return true;
		}
		else
			return false;
	}
	return false;
}

defaultproperties
{
	bSpawnOutOfSight=true
	checktimer=2.0
	SpawnClass=None
	Orders='Wandering'
	AllianceName=None
	AllianceLevel=0.000000
}
