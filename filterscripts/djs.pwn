#include <a_samp>
forward daojishi();
new	djskaiguan = 1;//����ʱ���أ�1Ϊ����ʱ������2Ϊ���£�3Ϊά�ޣ�4Ϊת��(Ҫ���������djskg4ip����IP)
new djskgip[256] = "118.244.134.185";//��djskaiguanΪ4ʱ����IP
new djssjbl = 60;//��djskaiguanΪ1ʱ���õĵ���ʱʱ��
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
	SendRconCommand("hostname ��HCYX���ҵ��й��� - ������,���Ե�...");
	return 1;
	}
	if (djskaiguan == 3)
	{
	SendRconCommand("password www.hcyxsq.cn");
	SendRconCommand("hostname ��HCYX���ҵ��й��� - ά��/������,���Ե�...");
	return 1;
	}
	if (djskaiguan == 4)
	{
	SendRconCommand("password www.hcyxsq.cn");
	new hostname[256];
	format(hostname,sizeof(hostname),"hostname ��HCYX���ҵ��й��� - ��Ǩ��:%s",djskgip);
	SendRconCommand(hostname);
	return 1;
	}
	if (djskaiguan == 5)
	{
	SendRconCommand("hostname ��HCYX���ҵ��й��� - �ܵ������ϲ��ȶ�����...");
	return 1;
	}
	if (djskaiguan == 6)
	{
	SendRconCommand("hostname ��HCYX���ҵ��й��� - D����,��������˼ô??!");
	return 1;
	}
	if (djskaiguan == 7)
	{
	SendRconCommand("password www.hcyxsq.cn");
	SendRconCommand("hostname ��HCYX���ҵ��й��� - �������,���Ե�...");
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
		format(mingzi,sizeof(mingzi),"hostname ��HCYX���ҵ��й��� - ����ʱ����ʣ��: %d ��",djssjbl);
		SendRconCommand(mingzi);
 		}
 		else
 		{
		SendRconCommand("password 0");
		SendRconCommand("hostname ��HCYX���ҵ��й��� - �й����»�������!!!");
		KillTimer(time);
 		}
}
