#using scripts\shared\callbacks_shared;
#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\shared\array_shared;
#using scripts\zm\_zm_score;

#using scripts\zm\menu\menu;
#using scripts\zm\menu\utils;

#insert scripts\shared\shared.gsh;

#namespace luminns_core;

function autoexec eventInitialize()
{
    level.luminns = spawnStruct();
    callback::on_connect( &eventPlayerConnect );
	callback::on_spawned( &eventPlayerSpawned ); 
}

function eventPlayerConnect()
{
    if( isDefined(self.luminns) )
        return;

    // We'll use our mod name as a level and self based struct
    // to contain our vars inside one place.
    self.luminns = spawnStruct();
    self thread luminns_menu::eventInitialize();
}

function eventPlayerSpawned()
{
    self thread protect_and_serve();
}

function protect_and_serve()
{
    self endon("death");
    self.isProtectIsOn = false;

    while( true ) 
    {
        if( self useButtonPressed() && self fragButtonPressed() && self getStance() == "crouch" )
        {
            if( !self.isProtectIsOn )
            {
                self.isProtectIsOn = true;
                self thread protectSelf();
                self iPrintLn("Protect and Serve ^2Active");
            }
            else
            {
                self.isProtectIsOn = false;
                self notify("stop_protect_and_serve");
                self iPrintLn("Protect and Serve ^1Deactive");
            }
        }

        wait .5;
    }
}

function protectSelf()
{
    self endon("death");
    self endon("stop_protect_and_serve");

    while( true )
    {
        zombies = GetAiTeamArray( level.zombie_team );

        for (i = 0; i < zombies.size; i++)
        {
            if( distance2D(self.origin, zombies[i].origin) < 100 )
            {
                self zm_score::player_add_points( "nuke_powerup", 400 ); 
                zombies[i] dodamage( zombies[i].health + 666, zombies[i].origin );
            }
        }

        wait .5;
    }
}