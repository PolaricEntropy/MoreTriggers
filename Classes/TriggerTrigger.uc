//=============================================================================
// TriggerTrigger
//
// Allows chaining triggers to other trigger-type events: when triggered it passes on the trigger in the form specified, either trigger, touch or frob. 
// So you could have a player Touch() this trigger and have this trigger then Frob() an NPC behind a door, initiating a conversation that wouldn't otherwise be possible. Or something.
// I'm sure you could come up with much better ideas.
//=============================================================================

class TriggerTrigger extends MoreTriggers;

enum eTrigType
	{
	TRIG_Trigger,
	TRIG_Touch,
	TRIG_Frob
	};

var() eTrigType TrigType;

function BeenTriggered(Actor Instigator)
{
	local Actor a;

	foreach AllActors(LimitingClass,a,Event)
	{
		switch(TrigType)
		{
			case TRIG_Trigger:
				a.Trigger(Instigator,Pawn(Instigator));
				break;
			case TRIG_Touch:
				a.Touch(Instigator);
				break;
			case TRIG_Frob:
				a.Frob(Instigator,None);
				break;
		}
	}
}

defaultproperties
{
	TrigType=TRIG_Trigger
}