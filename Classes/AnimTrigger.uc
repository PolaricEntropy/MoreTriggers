//=============================================================================
// AnimTrigger
//
// Forces an actor to play the specified anim. Animations in Unreal can be a bit wonky, so your milage may vary.
//=============================================================================

class AnimTrigger extends MoreTriggers;

var() Name AnimSequence;
var() float rate;
var() float tweentime;

function BeenTriggered(Actor instigator)
{
	local Actor a;

	foreach AllActors(LimitingClass,a,Event)
		a.PlayAnim(AnimSequence, rate, tweentime);

}

defaultproperties
{
	rate=1.0
}
