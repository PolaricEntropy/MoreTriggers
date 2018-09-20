//=============================================================================
// MoreTriggers - parent class.
//
// This simply integrates Touch() (when you touch a trigger) and Trigger() (when it gets triggered otherwise) to both call BeenTriggered, which makes downstream shit a whole fuckton easier.
//=============================================================================

class MoreTriggers extends Trigger abstract;

var(Events) class<Actor> LimitingClass;

function Trigger(Actor other,Pawn instigator)
{
	BeenTriggered(instigator);
	if(bTriggerOnceOnly)
		Destroy();
}

function Touch(Actor other)
{
	if(IsRelevant(other))
	{
		BeenTriggered(other);
		if(bTriggerOnceOnly)
			Destroy();
	}
}

function BeenTriggered(Actor instigator)
{} //set by subclasses

defaultproperties
{
	Texture=Texture'MoreTriggersIcon'
	LimitingClass=class'Actor'
}
