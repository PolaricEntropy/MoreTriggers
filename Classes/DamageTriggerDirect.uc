//=============================================================================
// DamageTriggerDirect
//
// Rather than damaging NPC's or whoever using DamageTriggers, which are radius based and at best unreliable, this trigger simply finds the specified actors and damages them directly, using the DamageType of your choice.
//
// By: DDL
//=============================================================================
class DamageTriggerDirect extends MoreTriggers;

var() float damageAmount;
var() bool bConstantDamage;
var() float damageInterval;
var() name damageType;
var() float damageradius;
var Actor savedOther;
var Actor savedinstigator;
var bool bIsOn;

function Timer()
{
	if (!bIsOn)
	{
		SetTimer(0.1, False);
		return;
	}

	beentriggered(savedOther, savedinstigator);
}

function BeenTriggered(Actor Other, actor instigator)
{
    local actor A;

    bIsOn = true;

    if(bIsOn)
    {
    	foreach Allactors(LimitingClass,A,event)
    	{
			if(damageradius > 0)
			{
				if(vsize(A.Location - location) < damageradius)
					 A.TakeDamage(damageamount,pawn(instigator),A.location,vect(0,0,0),damagetype);
			}
			else
				A.TakeDamage(damageamount,pawn(instigator),A.location,vect(0,0,0),damagetype);
        }
				
        if(bConstantDamage)
        {
            settimer(damageinterval, true);
            savedinstigator = instigator;
			savedOther = Other;
        }
    }
}


// if we are untriggered, turn us off
function UnTrigger(Actor Other, Pawn Instigator)
{
	if (bIsOn)
		bIsOn = False;

	Super.UnTrigger(Other, Instigator);
}

defaultproperties
{
     DamageAmount=5.000000
     bConstantDamage=True
     damageInterval=0.500000
     DamageType=Burned
}
