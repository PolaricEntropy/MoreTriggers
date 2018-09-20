//=============================================================================
// FragmentTrigger
//
// Spawns fragments. Like fleshchunks and stuff.
//
// By: DDL
//=============================================================================

class FragmentTrigger extends MoreTriggers;

var() class<DeusExFragment> FragClass[8];
var() bool bRandomAngle; //fire off in random direction?
var() int FixedAngleVar; //if not, amount to vary fixed direction firing
var() int NumFrags;
var() bool bFragSmoking;
var() float fixedfragdrawscale;
var() float randomfragdrawscale;
var() texture fragskin;
var() vector Momentum;

//internal
var int numclasses;

function BeenTriggered(Actor instigator)
{
	local rotator tracerot;
	local int i;

	//spawn some fragments! W00t!

	for(i=0; i<numfrags; i++)
	{
		if(!bRandomAngle)
		{
			tracerot = rotation;
			tracerot.pitch += (frand() - 0.5) * FixedAngleVar * 2;
			tracerot.yaw += (frand() - 0.5) * FixedAngleVar * 2;
			SpawnFrag(location, tracerot);
		}
		else
		{
			tracerot = rotrand();
			spawnfrag(location, tracerot);
		}
	}

}

function spawnFrag(vector location, rotator rot)
{

	local int rnd;
	local deusexfragment s;

	rnd = rand(numclasses);

	s = spawn(FragClass[rnd],,,location, rot);
	if (s != None)
		{
			s.CalcVelocity(Momentum,0);
			s.DrawScale = fixedfragdrawscale;
			s.Drawscale += randomfragdrawscale;
			
			if(Fragskin != none)
				s.Skin = FragSkin;
			if (bfragSmoking)
				s.bSmoking = True;
		}
}



function postbeginplay()
{
	local int i;

	for(i=0; i<arraycount(FragClass); i++)
	{
		if(Fragclass[i] == none)
			break;
		numclasses++;
	}

	super.postbeginplay();
}


defaultproperties
{
	bDirectional=true
	bRandomAngle=false
	FixedAngleVar=2048
	fixedfragdrawscale=1.0
}
