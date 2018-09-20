//=============================================================================
// SheepsGiveItemTrigger
//
// Gives the pawn triggering it (must be triggered/touched by a pawn, then) the item specified.
//
// By: Sheep
//=============================================================================

class SheepsGiveItemTrigger extends MoreTriggers;

var() class<Inventory> GiveClass;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	if(GiveClass==None)
		Destroy();
}

function BeenTriggered(Actor instigator)
{
	local Pawn pwn;
	local Inventory inv;

	pwn=Pawn(instigator);
	
	if(pwn==None)
		return;

	inv=Spawn(GiveClass);
	inv.InitialState='Idle2';
	inv.GiveTo(pwn);
	inv.SetBase(pwn);

	if(inv.owner==None)
		inv.Destroy();
}

defaultproperties
{
	GiveClass=None
}