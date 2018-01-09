#include <a_samp>
#include <streamer>
#include <Dini>

enum Server_Info
{
	DydCs,
};
new ServerInfo[Server_Info];

//new dydxx;
public OnFilterScriptInit()
{

	AddStaticPickup(1239, 1, -2241.6726,2358.5945,4.9797);//创建买票点的图标
	Create3DTextLabel("售票处\n输入/cp来购买船票",0xFFFF00AA,-2241.6726,2358.5945,4.9797,200,0,0);//创建买票点问题，坐标对应图标

	Create3DTextLabel("上船处",0xFFFF00AA,-2218.6472,2386.9041,4.9561,200,0,0);
	Create3DTextLabel("钓鱼岛",0xFFFF00AA,-229.2917,4325.3403,3.0196,50000,0,0);
	//钓鱼岛
	Create3DTextLabel("钓鱼岛顶峰",0xFFFF00AA,135.9545,4276.9053,125.2662,500,0,0);
	CreatePickup(1239, 0, 135.9545,4276.9053,125.2662);
	CreateDynamicObject(17135,5238.98000000,11571.02000000,2258.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,13.95000000,4185.26000000,-25.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,-139.99000000,4292.55000000,0.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17095,121.25000000,4303.51000000,0.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17095,55.11000000,4345.24000000,8.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17095,147.38000000,4573.65000000,-15.00000000,-4.00000000,11.00000000,80.00000000); //
	CreateDynamicObject(17096,-26.00000000,4293.16000000,4.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17081,-94.13000000,4107.46000000,15.00000000,0.00000000,0.00000000,4.00000000); //
	CreateDynamicObject(17082,48.28000000,3867.83000000,-20.00000000,0.00000000,11.00000000,120.00000000); //
	CreateDynamicObject(17135,49.85000000,4098.97000000,20.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,-130.24000000,4178.62000000,30.00000000,-18.00000000,-4.00000000,97.00000000); //
	CreateDynamicObject(17135,-112.02000000,4440.25000000,2.00000000,-4.00000000,4.00000000,62.00000000); //
	CreateDynamicObject(17135,87.87000000,3975.68000000,20.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,164.82000000,4114.22000000,15.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,245.56000000,3945.53000000,10.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,147.44000000,4298.06000000,10.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,5.62000000,4277.78000000,1.00000000,-11.00000000,-4.00000000,-142.00000000); //
	CreateDynamicObject(17135,93.48000000,4213.30000000,30.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17096,97.70000000,4364.88000000,33.00000000,-4.00000000,-4.00000000,0.00000000); //
	CreateDynamicObject(16229,-46.42000000,4379.93000000,20.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(17135,69.10000000,4351.68000000,10.00000000,11.00000000,-4.00000000,236.00000000); //
	CreateDynamicObject(17095,116.31000000,4571.89000000,10.00000000,0.00000000,-4.00000000,60.00000000); //
	CreateDynamicObject(17135,105.98000000,4528.79000000,-20.00000000,0.00000000,0.00000000,62.00000000); //
	CreateDynamicObject(17135,23.13000000,4534.88000000,-15.00000000,0.00000000,0.00000000,280.00000000); //
	CreateDynamicObject(17135,-21.46000000,4673.21000000,-20.00000000,0.00000000,0.00000000,236.00000000); //
	ServerInfo[DydCs] = dini_Int("dyd/xxzq.txt","DydCs");
	print("--------------------------------------");
	print("海滩售票系统、钓鱼岛系统(scc.pwn) By TL_GTASA");
	print("--------------------------------------");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);

	if (strcmp(cmd, "/cp", true) == 0) {

		if (!IsPlayerInRangeOfPoint(playerid, 5.0, -2241.6726,2358.5945,4.9797)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在售票处前 !");
	        return 1;
	    }

		cmd = strtok(cmdtext, idx);

		if (!strlen(cmd)) {
		    ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"海滩码头船票价格表：","/cp dyd [钓鱼岛(100)]","确定","");
		    return 1;
		}

	    if (strcmp(cmd, "dyd", true) == 0) {
	        GivePlayerMoney(playerid, -100);
			GameTextForPlayer(playerid,	"~r~-$100",	3000, 1);
			SendClientMessage(playerid,	0xFFFF00AA,"信息：你花费了 100 元买了一张去往 钓鱼岛 的 往返 票,现在,你可以前往上船处等候啦！");
	        return 1;
	    }
	    
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}提示：输入错误，请输入 /cp 查看买票命令。");
  		return 1;
	}

	if (strcmp(cmd, "/dyd", true) == 0)
	{
		if (!IsPlayerInRangeOfPoint(playerid, 5.0, 135.9545,4276.9053,125.2662))
		{
			SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在钓鱼岛的顶峰 !");
  			return 1;
    	}

		cmd = strtok(cmdtext, idx);

		if (!strlen(cmd))
		{
 			ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"中国的钓鱼岛：","/dyd xszq[宣誓主权]","确定","");
   			return 1;
		}

		if (strcmp(cmd, "xszq", true) == 0)
		{
			new string[256],pname[MAX_PLAYER_NAME],file[256],Dyd[20];
			ServerInfo[DydCs] ++;
			GetPlayerName(playerid, pname, sizeof(pname));
			format(file,sizeof(file),"/dyd/xxzq.txt");
			format(Dyd, sizeof(Dyd), "%d",ServerInfo[DydCs]);
			dini_Set(file,"DydCs",Dyd);
			format(string, sizeof(string), "{FFFF00}钓鱼岛：%s [ID:%d] 登上了钓鱼岛，插上了中国国旗。成为了第 %d 个登上了钓鱼岛的人.",pname,playerid,ServerInfo[DydCs]);
			SendClientMessageToAll(0xFFFF00AA, string);
  			return 1;
		}
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}提示：输入错误，请输入 /dyd 查看钓鱼岛可用命令。");
  		return 1;
	}
	return 0;
}




public OnPlayerSpawn(playerid)
{
	SetPlayerMapIcon(playerid,25,-2218.6472,2386.9041,4.9561, 57, 0);//为该玩家在地图上创建上船点图标
	SetPlayerMapIcon(playerid,26,-229.2917,4325.3403,3.0196, 19, 0);//为该玩家在地图上创建钓鱼岛图标
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,2,135.9545,4276.9053,125.2662))
	{
	new msg[256];
	format(msg,128,"~y~Diaoyu Islands,type ~r~/dyd ~y~to view the available command");
	GameTextForPlayer(playerid,msg,5000,3);
	}
	return 1;
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

