#include <a_samp>
forward daojishi();
new	djskaiguan = 1;//倒计时开关，1为倒计时开服，2为更新，3为维修，4为转服(要在下面变量djskg4ip设置IP)
new djskgip[256] = "118.244.134.185";//当djskaiguan为4时设置IP
new djssjbl = 60;//当djskaiguan为1时设置的倒计时时间
new time;
public OnFilterScriptInit()
{
	if (djskaiguan == 1)
	{
	SendRconCommand("password www.hcyxsq.cn");
	time = SetTimer("daojishi",1000,1);
	return 1;
	}
	if (djskaiguan == 2)
	{
	SendRconCommand("password www.hcyxsq.cn");
	SendRconCommand("hostname ★HCYX★我的中国心 - 更新中,请稍等...");
	return 1;
	}
	if (djskaiguan == 3)
	{
	SendRconCommand("password www.hcyxsq.cn");
	SendRconCommand("hostname ★HCYX★我的中国心 - 维修/检修中,请稍等...");
	return 1;
	}
	if (djskaiguan == 4)
	{
	SendRconCommand("password www.hcyxsq.cn");
	new hostname[256];
	format(hostname,sizeof(hostname),"hostname ★HCYX★我的中国心 - 搬迁至:%s",djskgip);
	SendRconCommand(hostname);
	return 1;
	}
	if (djskaiguan == 5)
	{
	SendRconCommand("hostname ★HCYX★我的中国心 - 受到攻击较不稳定见谅...");
	return 1;
	}
	if (djskaiguan == 6)
	{
	SendRconCommand("hostname ★HCYX★我的中国心 - D服的,这样有意思么??!");
	return 1;
	}
	if (djskaiguan == 7)
	{
	SendRconCommand("password www.hcyxsq.cn");
	SendRconCommand("hostname ★HCYX★我的中国心 - 大更新中,请稍等...");
	return 1;
	}
	return 1;
}

public daojishi()
{
 		if (djssjbl > 0)
 		{
 		djssjbl  = djssjbl - 1;
		new mingzi[256];
		format(mingzi,sizeof(mingzi),"hostname ★HCYX★我的中国心 - 倒计时开服剩余: %d 秒",djssjbl);
		SendRconCommand(mingzi);
 		}
 		else
 		{
		SendRconCommand("password 0");
		SendRconCommand("hostname ★HCYX★我的中国心 - 中国心新机房上线!!!");
		KillTimer(time);
 		}
}
