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
			SendClientMessage(playerid,0xFFFF00AA,"��ʾ���ϳ�ϵͳ�Ѹ���Ϊ/tow�ϳ�����ע��.");
		    }
		else
		    {
		    if	(TowTruckers>0)
		        {
		    	SendClientMessage(playerid,0xFFFF00AA,"�����ĳ������鷳�ˣ�������/towme.");
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
    	SendClientMessage(playerid,0xFFFF00AA,"�����ĳ������鷳�ˣ�������/towme.");
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
		    SendClientMessage(playerid,0xFFFF00AA,"��ʾ���Բ�������û���κ��ϳ�˾���ϰ�.");
		    return 1;
		    }
        SendClientMessage(playerid,0xFFFF00AA,"��ʾ���㷢���˶��ϳ�˾�����ϳ��������Ժ�.");
		new pName[MAX_PLAYER_NAME];
		new msg[256];
		GetPlayerName(playerid,pName,sizeof(pName));
		format(msg,sizeof(msg),"��ʾ��%s [ID:%d]��Ҫ�ϳ���֧Ԯ.",pName,playerid);
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
