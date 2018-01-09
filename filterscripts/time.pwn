#include <a_samp>
#define FILTERSCRIPT

new Text:Time, Text:Date;
new dizhencishu;//地震次数
new dizhenlevel;//地震级别
forward settime(playerid);
forward dizhen(playerid);
forward startbz(playerid);
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 溪夏都市 时间同步(time.pwn) By TL_GTASA");
	print("--------------------------------------\n");
    SetTimer("settime",1000,true);

	Date = TextDrawCreate(547.000000,11.000000,"--");

	TextDrawFont(Date,3);
	TextDrawLetterSize(Date,0.399999,1.600000);
    TextDrawColor(Date,0xffffffff);

	Time = TextDrawCreate(547.000000,28.000000,"--");

	TextDrawFont(Time,3);
	TextDrawLetterSize(Time,0.399999,1.600000);
	TextDrawColor(Time,0xffffffff);

	dizhencishu = 20;
	SetTimer("dizhen",10000,true);
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(Date);
	TextDrawDestroy(Time);
	return 1;
}
public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, Time), TextDrawShowForPlayer(playerid, Date);


	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, Time), TextDrawHideForPlayer(playerid, Date);
	return 1;
}

public settime(playerid)
{
	new string[256],year,month,day,hours,minutes,seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	format(string, sizeof string, "%d/%s%d/%s%d", year,(year < 10) ? ("0") : (""), month, ((month < 10) ? ("0") : ("")), day);
	TextDrawSetString(Date, string);
	format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Time, string);
	if (minutes == 00 && seconds == 00)
	{
	SetWorldTime(hours);
	}
}


public dizhen(playerid)
{
		if(dizhencishu>=20)
		{
		dizhencishu = 0;
		dizhenlevel=50;
		KillTimer(dizhen(playerid));
		SetTimer("startbz",1800000,true);
		}
		else
		{
		dizhenlevel = dizhenlevel -1;
		dizhencishu = dizhencishu -1;
		SetPlayerDrunkLevel(playerid,dizhenlevel);
		}
}
public startbz(playerid)
{
	SetTimer("dizhen",3600000,true);
}
//	format(string, sizeof string, "%d/%s%d/%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
//	TextDrawSetString(Date, string);
