
AddCSLuaFile( "shared.lua" )

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

if ( CLIENT ) then

SWEP.PrintName			= "Plane Gun"			// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 0						// Slot in the weapon selection menu
SWEP.SlotPos			= 10					// Position in the slot
SWEP.DrawAmmo			= false					// Should draw the default HL2 ammo counter
SWEP.DrawCrosshair		= true 					// Should draw the default crosshair
SWEP.DrawWeaponInfoBox	= false					// Should draw the weapon info box
SWEP.BounceWeaponIcon   = false					// Should the weapon icon bounce?
SWEP.SwayScale			= 1.0					// The scale of the viewmodel sway
SWEP.BobScale			= 1.0					// The scale of the viewmodel bob
SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/swep" )

end

SWEP.AccurateCrosshair 					= true
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pistol.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"
SWEP.AnimPrefix		= "python"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1				// Size of a clip
SWEP.Primary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 8					// Size of a clip
SWEP.Secondary.DefaultClip	= 32				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= true				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	// Play shoot sound
	self.Weapon:EmitSound("Weapon_AR2.Single")
	
	self:ShootBullet( 2, 2, 0.04 )
	
	self:SetNextPrimaryFire( CurTime() + 0.05 )

end


/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	// Todo.. increase health..

	self:SetNextSecondaryFire( CurTime() + 0.1 )

end

/*---------------------------------------------------------
   Name: SWEP:ShootBullet( )
   Desc: A convenience function to shoot bullets
---------------------------------------------------------*/
function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 		// View model animation
	self.Owner:MuzzleFlash()								// Crappy muzzle light
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				// 3rd Person Animation

end


/*---------------------------------------------------------
   Name: SWEP:ShootBullet( )
   Desc: A convenience function to shoot bullets
---------------------------------------------------------*/
function SWEP:ShootBullet( damage, num_bullets, aimcone )
	
	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.Src 		= self.Owner:GetShootPos()			// Source
	bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
	bullet.Spread 	= Vector( aimcone, aimcone, 0 )		// Aim Cone
	bullet.Tracer	= 1									// Show a tracer on every x bullets 
	bullet.Force	= 10								// Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.AmmoType = "Pistol"
	bullet.HullSize = 2
	//bullet.TracerName = "LaserTracer"
	
	self.Owner:FireBullets( bullet )
	
	self:ShootEffects()
	
end

/*---------------------------------------------------------
   Name: GetTracerOrigin()
   Desc: Allows you to override where the tracer comes from (in first person view)
		 returning anything but a vector indicates that you want the default action
---------------------------------------------------------*/
function SWEP:GetTracerOrigin()

	local ply = self:GetOwner()
	local pos 
	
	if ( math.random( 0, 1 ) == 1 ) then
		pos = ply:EyePos() + ply:EyeAngles():Right() * -8 + ply:EyeAngles():Forward() * 2 + ply:EyeAngles():Up() * -5
	else
		pos = ply:EyePos() + ply:EyeAngles():Right() * 10 + ply:EyeAngles():Forward() * 2 + ply:EyeAngles():Up() * -5
	end
	return pos

end

