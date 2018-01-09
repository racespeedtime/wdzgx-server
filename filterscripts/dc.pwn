#include <a_samp>

#define COLOR_BLUE 0x0042F6AA
#define COLOR_DBLUE 0x00008DAA
#define COLOR_DRED 0xA50000AA
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_YELLOW 0xF6F600AA
#define COLOR_GREEN 0x00B900AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GRAD2 0xBFC0C2FF

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

public OnFilterScriptInit()
{
    CreatePickup(1239, 1, 1955.3671,1018.1188,992.4688);
    Create3DTextLabel("==�ưɷ���̨==\n����/dc�鿴����",COLOR_GREEN,1955.3671,1018.1188,992.4688,10,0,0);
   	new dcggp = CreateObject(19353, 1982.2729,1025.9106,994.4688, 0.0, 0.0, 0); //create the object
	SetObjectMaterialText(dcggp, "{FF0000}�ĳ���ӭ��", 0, OBJECT_MATERIAL_SIZE_256x128,\"����", 40, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);

	if (strcmp(cmd, "/dc", true) == 0) {
		cmd = strtok(cmdtext, idx);
		
		if (!strlen(cmd)) {
		    ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"�ĳ����","/dc pijiu [��ơ��(10$)]\n/dc guozhi [���֭(5$)]","ȷ��","");
		    return 1;
		}

	    if (strcmp(cmd, "pijiu", true) == 0) {
			if(PlayerToPoint(2.0,playerid,1955.3671,1018.1188,992.4688))
        	{
       		SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_BEER );
 	    	GivePlayerMoney(playerid,-10);
     		SendClientMessage(playerid, COLOR_GRAD2, "{FFCC00}����10$����һƿơ��.");
        	}
        	else
	    	{
	    	SendClientMessage(playerid,0xCD0000FF, "{FFFF99}�㲻�ڶĳ��ưɷ���̨ǰ!");
	    	}
	        return 1;
	    }

	    if (strcmp(cmd, "guozhi", true) == 0) {
			if(PlayerToPoint(2.0,playerid,1955.3671,1018.1188,992.4688))
        	{
        	SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_SPRUNK );
        	GivePlayerMoney(playerid,-5);
        	SendClientMessage(playerid, COLOR_GRAD2, "{FFCC00}����5$����һ����֭.");
        	}
        	else
	    	{
	    	SendClientMessage(playerid,0xCD0000FF, "{FFFF99}�㲻�ڶĳ��ưɷ���̨ǰ!");
	    	}
	        return 1;
	    }
	    
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}��ʾ��������������� /dc �鿴����.");
  		return 1;
	}
	return 0;
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

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
