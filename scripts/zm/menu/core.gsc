#using scripts\shared\callbacks_shared;
#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\shared\array_shared;

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
    self thread tmp();
}

function tmp()
{
    self endon("death");
    while( true ) {
        self iPrintLn(self getGuid());
        wait 1;
    }
}