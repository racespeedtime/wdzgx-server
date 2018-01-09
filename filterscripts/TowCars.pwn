//------------------------------------------------------------------------------
//
//   TowCars Filter Script v1.0
//   Designed for SA-MP v0.2.2
//
//   Created by zeruel_angel
//
//------------------------------------------------------------------------------
#include <a_samp>

new TowTruckers=0;
new IsTowTrucker[MAX_PLAYERS];

//------------------------------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
	{
	if	(newstate==PLAYER_STATE_DRIVER)
	    {
		if	(GetVehicleModel(GetPlayerVehicleID(playerid)) == 525 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 485 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 470)
	        {
	        IsTowTrucker[playerid]=1;
	        TowTruckers++;
			SendClientMessage(playerid,0xFFFF00AA,"提示：拖车系统已更改为/tow拖车，请注意.");
		    }
		else
		    {
		    if	(TowTruckers>0)
		        {
		    	SendClientMessage(playerid,0xFFFF00AA,"如果你的车遇到麻烦了，请输入/towme.");
		    	}
		    }
	    }
	if 	((newstate==PLAYER_STATE_ONFOOT)&&(IsTowTrucker[playerid]==1))
	    {
	    IsTowTrucker[playerid]=0;
	    TowTruckers--;
	    }
	if 	((newstate==PLAYER_STATE_PASSENGER)&&(TowTruckers>0))
        {
    	SendClientMessage(playerid,0xFFFF00AA,"如果你的车遇到麻烦了，请输入/towme.");
    	}
	return 1;
	}
//------------------------------------------------------------------------------------------------------
/*public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	    {
	    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 485)
	        {
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
   				{
   				vid++;
   				GetVehiclePos(vid,vX,vY,vZ);
   				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
   				    {
   				    Found=1;
   				    if	(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
   				        {
   				        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   				        }
   				    AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
   				    }
       			}
			if  (!Found)
			    {
			    }
		    }
	    }
	}*/
//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
	{
	if 	(IsTowTrucker[playerid]==1)
	    {
	    IsTowTrucker[playerid]=0;
	    TowTruckers--;
	    }
	return 1;
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid,cmdtext[])
	{
	if	(strcmp(cmdtext, "/towme", true)==0)
		{
		if  (TowTruckers==0)
		    {
		    SendClientMessage(playerid,0xFFFF00AA,"提示：对不起，现在没有任何拖车司机上班.");
		    return 1;
		    }
        SendClientMessage(playerid,0xFFFF00AA,"提示：你发出了对拖车司机的拖车请求，请稍候.");
		new pName[MAX_PLAYER_NAME];
		new msg[256];
		GetPlayerName(playerid,pName,sizeof(pName));
		format(msg,sizeof(msg),"提示：%s [ID:%d]需要拖车的支援.",pName,playerid);
		for (new i=0;i<MAX_PLAYERS;i++)
		    {
		    if 	(IsTowTrucker[i]==1)
		        {
		        SendClientMessage(i,0xFFFF00AA,msg);
		        }
		    }
		return 1;
		}
	if  (strcmp(cmdtext, "/tow", true)==0)
	    {
	    	if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 485 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 470)
	        {
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
   				{
   				vid++;
   				GetVehiclePos(vid,vX,vY,vZ);
   				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
   				    {
   				    Found=1;
   				    if	(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
   				        {
   				        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   				        }
   				    AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
   				    }
       			}
			if  (!Found)
			    {
			    }
		    }
	    	return 1;
	    }
	return 0;
	}
