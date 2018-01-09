#include <a_samp>
#include <streamer>
new	gatetime[4];
new sfztoxz1lg;
new sfztoxz2lg;
new sfztosf1lg;
new sfztosf2lg;
forward	gatetimedjs();
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 我的中国心 收费站系统(sfz.pwn) By TL_GTASA");
	print("--------------------------------------\n");
	SetTimer("gatetimedjs",1000,1);
	sfztoxz1lg = CreateDynamicObject(968,-2671.7678,1280.7557,55.3456,90.00000000,0.00000000,90.00000000);
	sfztoxz2lg = CreateDynamicObject(968,-2673.3496,1280.7557,55.3456,90.00000000,0.00000000,270.00000000);
	sfztosf1lg = CreateDynamicObject(968,-2691.2283,1268.8329,55.3456,90.00000000,0.00000000,270.00000000);
	sfztosf2lg = CreateDynamicObject(968,-2689.9995,1268.8329,55.3456,90.00000000,0.00000000,90.00000000);

	new sfztoxz1 = CreateObject(19353, -2667.9214,1270.3619,61.5178, 0.0, 0.0, 90.0);
	SetObjectMaterialText(sfztoxz1, "{FFFF00}↓[{00DB00}开{FFFF00}]收费通道↓", 0, OBJECT_MATERIAL_SIZE_256x128,\"微软雅黑", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	new sfztoxz2 = CreateObject(19353, -2676.9214,1270.3619,61.5178, 0.0, 0.0, 90.0);
	SetObjectMaterialText(sfztoxz2, "{FFFF00}↓[{00DB00}开{FFFF00}]收费通道↓", 0, OBJECT_MATERIAL_SIZE_256x128,\"微软雅黑", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	new sfztosf1 = CreateObject(19353, -2686.1499,1278.8914,61.5178, 0.0, 0.0, 90.0);
	SetObjectMaterialText(sfztosf1, "{FFFF00}↓[{00DB00}开{FFFF00}]收费通道↓", 0, OBJECT_MATERIAL_SIZE_256x128,\"微软雅黑", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	new sfztosf2 = CreateObject(19353, -2695.1499,1278.8914,61.5178, 0.0, 0.0, 90.0);
	SetObjectMaterialText(sfztosf2, "{FFFF00}↓[{00DB00}开{FFFF00}]收费通道↓", 0, OBJECT_MATERIAL_SIZE_256x128,\"微软雅黑", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/sfz", cmdtext, true, 10) == 0)
	{
		if (IsPlayerInRangeOfPoint(playerid,3.0,-2695.0649,1274.9344,55.4297) || IsPlayerInRangeOfPoint(playerid,3.0,-2686.5771,1274.3635,55.4297) || IsPlayerInRangeOfPoint(playerid,3.0,-2677.3564,1274.9639,55.4297) || IsPlayerInRangeOfPoint(playerid,3.0,-2668.5168,1274.8555,55.4297)) {
			
			if (PlayerToPoint(2.0,playerid,-2668.5168,1274.8555,55.4297)){
            	DestroyDynamicObject(sfztoxz1lg);
           		sfztoxz1lg = CreateDynamicObject(968,-2671.7678,1280.7557,55.3456,0.00000000,0.00000000,0.00000000);
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}栏杆已打开，你有5秒钟的时间过去.");
  				SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}你支付了过桥费用￥100元.");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,	"~r~-$100",	3000, 1);
                gatetime[0] = 5;
			}
			
			if (PlayerToPoint(2.0,playerid,-2677.3564,1274.9639,55.4297)){
            	DestroyDynamicObject(sfztoxz2lg);
           		sfztoxz2lg = CreateDynamicObject(968,-2673.3496,1280.7557,55.3456,0.00000000,0.00000000,0.00000000);
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}栏杆已打开，你有5秒钟的时间过去.");
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}你支付了过桥费用￥100元.");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,	"~r~-$100",	3000, 1);
                gatetime[1] = 5;
			}
			
			if (PlayerToPoint(2.0,playerid,-2686.5771,1274.3635,55.4297)){
            	DestroyDynamicObject(sfztosf2lg);
           		sfztosf2lg = CreateDynamicObject(968,-2689.9995,1268.8329,55.3456,0.00000000,0.00000000,0.00000000);
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}栏杆已打开，你有5秒钟的时间过去.");
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}你支付了过桥费用￥100元.");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,	"~r~-$100",	3000, 1);
                gatetime[3] = 5;
			}
			
			if (PlayerToPoint(2.0,playerid,-2695.0649,1274.9344,55.4297)){
            	DestroyDynamicObject(sfztosf1lg);
           		sfztosf1lg = CreateDynamicObject(968,-2691.2283,1268.8329,55.3456,0.00000000,0.00000000,0.00000000);
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}栏杆已打开，你有5秒钟的时间过去.");
           		SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}你支付了过桥费用￥100元.");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,	"~r~-$100",	3000, 1);
                gatetime[2] = 5;
			}
	        return 1;
	    }
	    SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}你不在收费站!");
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,3,-2695.0649,1274.9344,55.4297) || IsPlayerInRangeOfPoint(playerid,3,-2686.5771,1274.3635,55.4297) || IsPlayerInRangeOfPoint(playerid,3,-2677.3564,1274.9639,55.4297) || IsPlayerInRangeOfPoint(playerid,3,-2668.5168,1274.8555,55.4297))
	{
	new msg[256];
	format(msg,128,"~y~Toll stations,type ~r~/sfz ~y~to view the available command");
	GameTextForPlayer(playerid,msg,5000,3);
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public gatetimedjs()
{
	if(gatetime[0]>0)
	{
		gatetime[0]=gatetime[0]-1;
		if(gatetime[0]==0)
		{
			DestroyDynamicObject(sfztoxz1lg);
			sfztoxz1lg = CreateDynamicObject(968,-2671.7678,1280.7557,55.3456,90.00000000,0.00000000,90.00000000);
		}
	}

	if(gatetime[1]>0)
	{
		gatetime[1]=gatetime[1]-1;
		if(gatetime[1]==0)
		{
			DestroyDynamicObject(sfztoxz2lg);
			sfztoxz2lg = CreateDynamicObject(968,-2673.3496,1280.7557,55.3456,90.00000000,0.00000000,270.00000000);
		}
	}
	
	if(gatetime[2]>0)
	{
		gatetime[2]=gatetime[2]-1;
		if(gatetime[2]==0)
		{
			DestroyDynamicObject(sfztosf1lg);
			sfztosf1lg = CreateDynamicObject(968,-2691.2283,1268.8329,55.3456,90.00000000,0.00000000,270.00000000);
		}
	}
	
	if(gatetime[3]>0)
	{
		gatetime[3]=gatetime[3]-1;
		if(gatetime[3]==0)
		{
			DestroyDynamicObject(sfztosf2lg);
			sfztosf2lg = CreateDynamicObject(968,-2689.9995,1268.8329,55.3456,90.00000000,0.00000000,90.00000000);
		}
	}
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}
