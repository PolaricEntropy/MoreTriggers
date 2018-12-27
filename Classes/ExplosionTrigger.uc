//=============================================================================
// ExplosionTrigger
//
// Unsurprisingly, spawns an explosion.
// Explosion code ripped almost cluelessly from DeusExDecoration :)
//=============================================================================
class ExplosionTrigger extends MoreTriggers;

var() int explosionDamage;			// how much damage does the explosion cause?
var() float explosionRadius;		// how big is the explosion?


function BeenTriggered(Actor Other, Actor instigator)
{
	local ShockRing ring;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local Actor a;

	// make sure we wake up when taking damage
	bStasis = False;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius * 16);

	if (explosionRadius <= 128)
		PlaySound(Sound'SmallExplosion1', SLOT_None,,, explosionRadius*16);
	else
		PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight');
	if (explosionRadius < 128)
	{
		Spawn(class'ExplosionSmall');
		light.size = 2;
	}
	else if (explosionRadius < 256)
	{
		Spawn(class'ExplosionMedium');
		light.size = 4;
	}
	else
	{
		Spawn(class'ExplosionLarge');
		light.size = 8;
	}


	// draw a pretty shock ring
	ring = Spawn(class'ShockRing',,,, rot(16384,0,0));
	if (ring != None)
		ring.size = explosionRadius / 32.0;
	ring = Spawn(class'ShockRing',,,, rot(0,0,0));
	if (ring != None)
		ring.size = explosionRadius / 32.0;
	ring = Spawn(class'ShockRing',,,, rot(0,16384,0));
	if (ring != None)
		ring.size = explosionRadius / 32.0;

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks
	for (i=0; i<explosionDamage/30+1; i++)
		if (FRand() < 0.8)
			spawn(class'Rockchip');

	foreach RadiusActors(class'Actor',a,explosionRadius)
		a.TakeDamage(explosionDamage,Pawn(instigator),Location,vect(0,0,1),'Exploded');
}

defaultproperties
{
	explosionDamage=100
	explosionRadius=768.000000
}
