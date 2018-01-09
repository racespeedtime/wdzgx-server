#include <a_samp>
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREEN 0x00B900AA
new jiankong[MAX_PLAYERS] = 0;
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 我的中国心 天眼监控系统 (tyjk.pwn) By TL_GTASA");
	print("--------------------------------------\n");
	Create3DTextLabel("==天眼系统==\n输入/ty开始",0x00B900AA,238.0772,71.3592,1005.0391,10,0,0);
	CreatePickup(1314, 0, 238.0772,71.3592,1005.0391);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);

	if (strcmp(cmd, "/ty", true) == 0) {
		cmd = strtok(cmdtext, idx);

		if (!strlen(cmd)) {
		    ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"天眼监控 TL_GTASA原创制作","{FF0000}/ty stop [停止查看]\n{FFFFFF}/ty xztosf [收费站往旧金山]\n/ty sftoxz [收费站往小镇]\n/ty xzlk [小镇路口]\n/ty jctcc [警察停车场]\n/ty xzjc [小镇机场]","确定","");
		    return 1;
		}

	    if (strcmp(cmd, "stop", true) == 0) {
	        if (jiankong[playerid] == 1)
	        {
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 关闭系统.");
			TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer(playerid);
			SetPlayerPos(playerid,238.0772,71.3592,1005.0391);
			SetPlayerInterior(playerid, 6);
			jiankong[playerid] = 0;
			}
			else
			{
			SendClientMessage(playerid,COLOR_GRAD2,"你不在监控中.");
			}
	        return 1;
	    }
	    
	    if (strcmp(cmd, "xztosf", true) == 0) {
   			if (!IsPlayerInRangeOfPoint(playerid, 5.0, 238.0772,71.3592,1005.0391)) {
				SendClientMessage(playerid,COLOR_GRAD2,"你不在警察局的天眼系统前.");
   				return 1;
		    }
     		SetPlayerCameraPos(playerid, -2690.1201,1278.7212,61.2178);
			SetPlayerCameraLookAt(playerid, -2689.3718,1339.5109,55.4297);
			SetPlayerPos(playerid,-2672.4885,1274.1372,55.4297);
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 连接至 '收费站往旧金山' 摄像头.");
			jiankong[playerid] = 1;
	        return 1;
	    }

	    if (strcmp(cmd, "sftoxz", true) == 0) {
   			if (!IsPlayerInRangeOfPoint(playerid, 5.0, 238.0772,71.3592,1005.0391)) {
				SendClientMessage(playerid,COLOR_GRAD2,"你不在警察局的天眼系统前.");
   				return 1;
		    }
     		SetPlayerCameraPos(playerid, -2672.5515,1270.2390,61.2178);
			SetPlayerCameraLookAt(playerid, -2671.3201,1238.1511,55.4219);
			SetPlayerPos(playerid,-2672.4885,1274.1372,55.4297);
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 连接至 '收费站往小镇' 摄像头.");
			jiankong[playerid] = 1;
	        return 1;
	    }
	    if (strcmp(cmd, "xzlk", true) == 0) {
   			if (!IsPlayerInRangeOfPoint(playerid, 5.0, 238.0772,71.3592,1005.0391)) {
				SendClientMessage(playerid,COLOR_GRAD2,"你不在警察局的天眼系统前.");
   				return 1;
		    }
     		SetPlayerCameraPos(playerid, -2727.2405,2344.0496,73.0234);
			SetPlayerCameraLookAt(playerid,-2720.8950,2305.1882,63.3532);
			SetPlayerPos(playerid,-2751.8140,2382.6936,75.8367);
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 连接至 '小镇路口' 摄像头.");
			jiankong[playerid] = 1;
	        return 1;
	    }
	    if (strcmp(cmd, "jctcc", true) == 0) {
   			if (!IsPlayerInRangeOfPoint(playerid, 5.0, 238.0772,71.3592,1005.0391)) {
				SendClientMessage(playerid,COLOR_GRAD2,"你不在警察局的天眼系统前.");
   				return 1;
		    }
     		SetPlayerCameraPos(playerid,-2475.9351,2273.0686,19.5349);
			SetPlayerCameraLookAt(playerid,-2466.6343,2242.1665,4.7934);
			SetPlayerPos(playerid,-2451.6467,2257.0808,5.2342);
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 连接至 '警察停车场' 摄像头.");
			jiankong[playerid] = 1;
	        return 1;
	    }
	    if (strcmp(cmd, "xzjc", true) == 0) {
   			if (!IsPlayerInRangeOfPoint(playerid, 5.0, 238.0772,71.3592,1005.0391)) {
				SendClientMessage(playerid,COLOR_GRAD2,"你不在警察局的天眼系统前.");
   				return 1;
		    }
     		SetPlayerCameraPos(playerid,-2289.0842,2337.0471,14.0790);
			SetPlayerCameraLookAt(playerid,-2259.1797,2323.8423,4.8125);
			SetPlayerPos(playerid,-2233.6465,2332.9219,3.5918);
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendClientMessage(playerid,COLOR_GREEN,"天眼系统: 连接至 '小镇机场' 摄像头.");
			jiankong[playerid] = 1;
	        return 1;
	    }
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}提示：输入错误，请输入/ty查看可用命令.");
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
