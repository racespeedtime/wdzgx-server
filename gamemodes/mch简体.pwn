/*
================================================================================
                	��      ��      ��      ��      ��
                	��      Դ      ��      ��      ��
                	----------------------------------
                       �ӣ��ͣУ��ȣã٣أӣѣ��ã�
================================================================================

-----------------------------[��   ��   ��   ��]--------------------------------
|* �緢��BUG���뵽samp.hcyxsq.cn������QȺ198412914Ѱ�����, ע���汾, BUGλ��  |
|                                                                              |
|*��ʾ: ������޸�filterscripts�µ�djs.pwn�����������õ���ʱ�����ĵȴ�ʱ��     |
|                                                                              |
|�����ϲ�������ͼ�����������ǣ��Ա��������ж���������Դ��ȥ����ϵQQ:947585287|
|                                                                              |
|==============================================================================|

|==============================================================================|
| =====    ������Ҫ�Ƕ���һ�汾��BUG�޸�, ������0.3z, �Լ�һЩ��ȫ����   ===== |
|==============================================================================|
|������¼�����Ҫ:                                                             |
|1���޸�ID0�����������˽�����֯��ʾû���������bug                           |
|2���޸�һЩ��֪�ı���Warning                                                  |
|3���޸�����Ա/ky��ʾû���ϰ��BUG (��л��̳��Ա1156183796�ķ���)              |
|4������һ��RCONĬ������û���޸ĵ���ʾ��Ϣ                                     |
|5�����ӷ�������ʼ��ʱ�ķ�������Ϣ                                             |
|6������/reloadbans���ڽ����Һ���ֶ�ˢ���б�                                |
|7��ȥ��NDVDS(���˳�������), ac(�Ӿ����)�ű�                                  |
|------------------------------------------------------------------------------|

																TL_GTASA
														      �����Ϸ����
										                   �����Ϸ����������
                                                           �ҵ��й��Ŀ�Դ�Ŷ�
                                                           
                                                           �� �� �� �� �� Ʒ
                                                           
														  2014-03-23 19:35:56
==============================================================================*/
forward Shuache(id,playerid);
forward ChangeSkin(skinid, playerid);
#pragma tabsize 0
#include <a_samp>
#include <KINI>
#include <streamer>
#include <utils>
#include <maxplay>
#include <YSI/y_ini>
//#include <colors>
#include <getvehicledriver>
#include <foreach>
//=======================================================
#pragma tabsize 0
//===================================[ƽ��]=====================================
new Text:TabletWin8[23];
new Text:TabletWin8Start[51];
new Text:TabletWin8UserLog[12];
new PlayerText:TabletWin8UserLog2;
new Text:TabletWin8Pag[3];
new PlayerText:TabletWin8Pag2;
new PlayerText:Escritorio[4];
new Text:TabletPhotos[12];
new PlayerText:TabletTime[2];
new Text:TabletMusicPlayer[11];
new Text:CameraTD[24];
new Text:MapsTD[8];
new Text:Games;
new PlayerText:TabletWeather[3];
new PlayerText:Tragaperras[5];
new Text:TwoBut[2];
new TabletTimer[MAX_PLAYERS][8];
new lda[MAX_PLAYERS];
new firstperson[MAX_PLAYERS];
new chattext[MAX_PLAYERS][2048];
new chatid[MAX_PLAYERS];
new slots[][] =
{
	"ld_slot:bar1_o",
	"ld_slot:bar2_o",
	"ld_slot:bell",
	"ld_slot:cherry",
	"ld_slot:grapes",
	"ld_slot:r_69"
};
new randomvar[3];

new temperature[][] =
{
	"14 C",
	"16 C",
	"8 C",
	"6 C",
	"20 C",
	"2 C"
};
#define DIALOG_TABLETCHAT 7742
//==============================================================================
#define	COLOR_YELLOW 0xFFFF00AA
#define	COLOR_YELLOW2 0xF5DEB3AA
#define	COLOR_GRAD1	0xB4B5B7FF
#define	COLOR_GRAD2	0xBFC0C2FF
#define	COLOR_GRAD3	0xCBCCCEFF
#define	COLOR_GRAD4	0xD8D8D8FF
#define	COLOR_GRAD5	0xE3E3E3FF
#define	COLOR_GRAD6	0xF0F0F0FF
#define	COLOR_FADE1	0xFFFFFFFF
#define	COLOR_FADE2	0xC8C8C8C8
#define	COLOR_FADE3	0xAAAAAAAA
#define	COLOR_FADE4	0x8C8C8C8C
#define	COLOR_FADE5	0x6E6E6E6E
#define	COLOR_LIGHTRED 0xFF6347AA
#define	COLOR_GREY 0xAFAFAFAA
#define	COLOR_LIGHTBLUE	0x33CCFFAA
#define	COLOR_PURPLE 0xC2A2DAAA
#define	COLOR_WHITE	 0xFFFFFFFF
#define	COLOR_BLUE 0x2641FEAA
#define	TEAM_CYAN_COLOR	0xFF8282AA
#define	ANNOUNCEMENT 0x6AF7E1FF
#define	LIGHTGREEN 0x38FF06FF
#define	COLOR_RED 0xAA3333AA
#define	COLOR_ALLDEPT 0xFF8282AA
#define	COLOR_GREEN	0x9EC73DAA
#define	COLOR_TEAL 0x00AAAAAA
#define	COLOR_OFFWHITE 0xF5DEB3AA
#define	COLOR_DARKAQUA 0x83BFBFAA
//=======================================================
#define RocketHeight 50
#define RocketSpread 30
#define MAX_LAUNCH 20
#define MAX_FIREWORKS 100

new Rocket[MAX_LAUNCH];
new RocketLight[MAX_LAUNCH];
new RocketSmoke[MAX_LAUNCH];
new RocketExplosions[MAX_LAUNCH];
new Float:rx[MAX_LAUNCH];
new Float:ry[MAX_LAUNCH];
new Float:rz[MAX_LAUNCH];
new FireworkTotal;
new Fired;
//=======================================================
//=======================================================
#define	HOLDING(%0)	\
((newkeys &	(%0)) == (%0))
#define	PRESSED(%0)	\
(((newkeys & (%0)) == (%0))	&& ((oldkeys & (%0)) !=	(%0)))
#define	RELEASED(%0) \
(((newkeys & (%0)) != (%0))	&& ((oldkeys & (%0)) ==	(%0)))
//=======================================================
//----------------[�������]---------------------------//
#define	ATTACH_ARMOR	4
#define GOTOMENU 8552
#define	MAX_ROADBLOCKS 35
//=======================================================

//===================================================================================================
//											   Settings
//===================================================================================================
//					 SETTING:							VALUE:					Discription:
#define				 CAMERA_LIMIT						100						//Max loaded cameras (keep this	as low as possible for the best	performance)
#define				 CAMERA_UPDATE_INTERVAL				750						//update interval of all speedcams (in miliseconds)
#define				 CAMERA_FLASH_TIME					1200					//ammount of miliseconds until the "flash" effect gets removed again
#define				 CAMERA_DIALOG_RANGE				1337					//dialog ID	range (Example:	0 will take	dialogid's 0 - 9)
#define				 CAMERA_USEMPH						0						//toggles camera using mph by default (0=kmh, 1=mph)
#define				 CAMERA_LABEL_COLOR					0xFF000FFF				//The default color	of the camera's	label
#define				 CAMERA_PERSPECTIVE					false					 //Sets	playercamera temporary at the camera's position	while flashing
//streamer options (will be	used if	STREAMER_ENABLED is	set	on true)
#define				 STREAMER_ENABLED					false					//uses a streamer (true/false)
#define				 STREAMER_ADD						CreateDynamicObject		//put here at the value	the	command	your streamer uses to make an object (CreateDynamicObject by default)
#define				 STREAMER_REMOVE					DestroyDynamicObject	//put here at the value	the	command	your streamer uses to remove an	object (STREAMER_REMOVE	by default)
#if	STREAMER_ENABLED ==	true													//ignore this line
#include											streamer				//put your include name	here
#endif																			//ignore this line
//===================================================================================================
//											  Variables
//===================================================================================================
#define	DIALOG_MAIN	CAMERA_DIALOG_RANGE
#define	DIALOG_RANGE CAMERA_DIALOG_RANGE +1
#define	DIALOG_LIMIT CAMERA_DIALOG_RANGE +2
#define	DIALOG_FINE	CAMERA_DIALOG_RANGE	+3
#define	DIALOG_EDIT	CAMERA_DIALOG_RANGE	+4
#define	DIALOG_EANGLE CAMERA_DIALOG_RANGE +5
#define	DIALOG_ELIMIT CAMERA_DIALOG_RANGE +6
#define	DIALOG_ERANGE CAMERA_DIALOG_RANGE +7
#define	DIALOG_EFINE CAMERA_DIALOG_RANGE +8
#define	DIALOG_ETYPE CAMERA_DIALOG_RANGE +9
#define	DIALOG_LABEL CAMERA_DIALOG_RANGE +10
enum _camera
{Float:_x,Float:_y,Float:_z,Float:_rot,_range,_limit,_fine,_usemph,_objectid,bool:_active,bool:_activelabel,_labeltxt[128],Text3D:_label}
																																																																																																																																																																																																																																																															new	SpeedCameras[CAMERA_LIMIT][_camera],loaded_cameras = 0,Text:flash;
//stocks for attaching labels to camera	(must be defined befnewore	use, thats why this	one	is at the top)
																																																																																																																																																																																																																																																															stock Text3D:AttachLabelToCamera(cameraid,text[])
{
	new	position,buffer[128];format(buffer,sizeof buffer,"%s",text);
	for(new	i =	0;strfind(buffer,"\\n",true) !=	-1;i++)
	{
		position = strfind(buffer,"\\n",true);
		strdel(buffer,position,position	+2);
		strins(buffer,"\r\n",position,sizeof(buffer));
	}
	return Create3DTextLabel(buffer,CAMERA_LABEL_COLOR,SpeedCameras[cameraid][_x],SpeedCameras[cameraid][_y],SpeedCameras[cameraid][_z]	+7,100,0,0);
}
																																																																																																																																																																																																																																																															stock UpdateCameraLabel(Text3D:labelid,text[])
{
	new	position,buffer[128];format(buffer,sizeof buffer,"%s",text);
	for(new	i =	0;strfind(buffer,"\\n",true) !=	-1;i++)
	{
		position = strfind(buffer,"\\n",true);
		strdel(buffer,position,position	+2);
		strins(buffer,"\r\n",position,sizeof(buffer));
	}
	return	Update3DTextLabelText(labelid,CAMERA_LABEL_COLOR,buffer);
}
new SwearWords[][] = //Add more words :-
{
  "ɵ��",
  "ɷ��",
  "ɵ��",
  "ɳ��",
  "������",
  "�����",
  "�����",
  "������",
  "������",
  "fuck"
};
new PlayerWeapons[MAX_PLAYERS][44];
new Kicking[MAX_PLAYERS];
//==============================================================================
new allscactive = 0;
#define STARTAMOUNT 300.66
#define MONEYPER100 30.00
new Text:taxiblackbox[MAX_PLAYERS];
new Text:taxigreendisplay[MAX_PLAYERS];
new Text:taxitimedisplay[MAX_PLAYERS];
new Text:taxi100mfare[MAX_PLAYERS];
new Text:taxithisfare[MAX_PLAYERS];
new Text:taxilstlogo[MAX_PLAYERS];
new Text:taxistatus[MAX_PLAYERS];
new Text:startfare[MAX_PLAYERS];
new IsOnFare[MAX_PLAYERS];
new OnDuty[MAX_PLAYERS];
new clockupdate;
new faretimer[MAX_PLAYERS];
new Float:OldX[MAX_PLAYERS],Float:OldY[MAX_PLAYERS],Float:OldZ[MAX_PLAYERS],Float:NewX[MAX_PLAYERS],Float:NewY[MAX_PLAYERS],Float:NewZ[MAX_PLAYERS];
new Float:TotalFare[MAX_PLAYERS];
//==============================================================================
new djssjbl = 10;
new allscdjstime;
new jybdyszt[MAX_PLAYERS];//����ü���Կ��״̬
new jybdlinggunzt[MAX_PLAYERS];//����Ƿ��Ѿ���ǹ
new jybdzt[MAX_PLAYERS];																																																																																																																																																																																																																																																														//new	Float:TelePos[MAX_PLAYERS][6];
new	RegistrationStep[MAX_PLAYERS];
//=========================TLԭ������ϵͳ=======================================
new hzxtnqyw[MAX_PLAYERS];//����������Ϊ
new hzxtjcxqn[MAX_PLAYERS];//���½ܳ�С����
new hzxtwnzy[MAX_PLAYERS];//��������רҵ

new hzxtcdqc[MAX_PLAYERS];//���²ƴ�����
new hzxtycwg[MAX_PLAYERS];//�����������
new hzxtfkdg[MAX_PLAYERS];//���¸��ɵй�

new hzxtscjj[MAX_PLAYERS];//������������
new hzxtscyj[MAX_PLAYERS];//���������Ǿ�
new hzxtscgj[MAX_PLAYERS];//���������ھ�

//new hdcd[100];//��¼�
/*new shu1;//����ʱV1
new shu2;//����ʱV2
new shu3;//����ʱV3
new shu4;//����ʱV4*/
new playeryanhua[100];//��¼����̻�
new playerlive[100];//��¼��Ҳɷ�״̬
new playerircadmin[100];//��¼IRC����Ա
new playerircid[100];//��¼IRCƵ��ID
//new DefaultWeather=10;//��¼����
//new to[100],tocar[100],toid[100];//���¼
new	playeripad[100];//��¼���IPAD
new playersfz[100];//��¼������֤
new	playeradmin[100];//��¼��ҹ���Ա�ȼ�
new	playerput[100];//��¼����Ƿ�̳̹�
new	playersex[100];//��¼����Ա�
new	playerage[100];//��¼�������
new	playermoney[100];//��¼��ҽ�Ǯ
new	playercar[100];//��¼����м�����
new	playermima[100][100];//��¼�������
new	playername[100][100];//��¼�������
new	playerzuzhi[100];//��¼�����֯
new	playerskin[100];//��¼���Ƥ��
new	playerzuzhilv[100];//��¼�����֯�׼�
new zuzhichushenghj[18],Float:zuzhichushengx[18],Float:zuzhichushengy[18],Float:zuzhichushengz[18],Float:zuzhichushenga[18];//��֯������ID
new	playerlock[100];//��¼���Կ��
new	playerlock1[100];//��¼���2��Կ��
new	playerlock2[100];//��¼���3��Կ��
new	playerspawn[100];//��¼��ҳ�����
new	playerlv[100];//��ҵȼ�
new	playerlvup[100];//�����������
new	playerjianyutime[100];//����ʣ��ʱ��
new	playergunzhizhao[100];//��¼�����û������ִ�� 0Ϊ�� 1Ϊ��
new	playercarzhizhao[100];//��¼�����û�м�ʻִ�� 0Ϊ�� 1Ϊ��
new	playerwuqi[100][7];//��¼�������
new	playerinvwuqi[100][7];//��¼��������ֿ�����
new	playercall[100];//��¼��ҵ绰
new	playerjob[100];//��¼��ҹ���
new	SNOS[100];//��¼���NOS��
new	playersupernos[100];//��¼NOS
/*new ms1[100];
new ms2[100];
new ms3[100];
new ms4[100];
new ms5[100];//��¼�����б�*/
new	playerviplv[100];//��¼���VIP�ȼ�
new	playervdou[100];//��¼���V������
new	playervipczz[100];//��¼���VIP�ɳ�ֵ
//new	playerjiedu[100];//��¼��Ҽ�����
//new	playerkouke[100];//��¼��ҿڿ�ֵ
new	food1[100];//��¼��԰���ȱ�����
new	food2[100];//��¼ѩ������
new	food3[100];//��¼�׷�����
new	playermats[100];//��¼��Ҳ���
new	playerbank[100];//��¼������д��
new	playercallmoney[100];//��¼��ҵ绰���
new	SL[100];//��ҵ�½״̬*0Ϊû��½ 1Ϊ��½*
new	ZFJGID[1000];//�������������ı�־ID
new	ZFJGSTR[1000][128],ZFJGSTR1[1000][128],/*ZFJGSTR2[100][64],*/ZFJGMONEY[1000];//�������������ı�־ID�������Ϣ
new	ZFJGTID[1000],ZFJGLV[1000],ZFJGLOCK[1000],ZFJGZJ[1000],ZFJGLOCALHID[1000];//�������������ſڱ�־ID��ID
new	ZFJGZUZHI[1000];//��¼���������ĸ���֯
new Float:ZFJGX[1000];//������������������X
new Float:ZFJGY[1000];//������������������Y
new Float:ZFJGZ[1000];//������������������Z
new Float:ZFJGCX[1000],Float:ZFJGCY[1000],ZFJGHU[1000],Float:ZFJGCZ[1000],ZFJGLX[1000];//��������������������XYZ�Լ��ı��Ƿ����Լ�PICKUP����
new	ZFJGHID[1000];//����������������ID
new	zuzhiname[18][32];//��֯����
new ircname[18][32];//��¼IRC���
new	zuzhilv[18][32][64];//��֯�׼�
new	yaoqingjiaru[100];//������Ҽ�����֯
new	zuzhiskin[18][32];//��֯Ƥ��
new	zuzhigonggao[18][64];//��֯����
new	zuzhichushengid[18];//��֯������ID
new	gongzuoname[8][32];//��������
//new playerdm[100]; //DMģʽ
new	gate;//�����OBJ
new	gate1;//�����OBJ
new	gate2;//�����OBJ
new	gate3;//FBI���⿪��
new	gate4;//������
new	gate5,gate6,gate7,gate8,gate9,gate10;//GM������
new	gate11,gate12,gate13,gate14,gate15,pdmen,pdmen1,pdmen2;//���������	����
new	gate16,gate17,gate18,gate19,gate20,gate21;//��¼����
new	gate22,gate23,gate24,gate25,gate26,gate27,yymen,yymen1;//ҽԺ
new ewmen1,ewmen2,xzmen1,xzmen2,xzmen3;
new rqq1;//������
//new gate88,gate89;//���ӻ���OBJ
new	gatetime[25];//�����OBJ����ʱ
new	houseid[100];//��¼���뷿���ID
new	carzuyongkey[100];//��¼�⳵Կ��
new	cargzbc[1000];//��¼������װ
new	savetime;//����������ϼ��
//new carsl=1;//��¼��ǰ���������м���
new	pickupids=0;//��¼��־
new	vsellto[100],vselltocar[100],vselltomoney[100],vselltoid[100];//��¼�������ID,������ID,�۸�
new	carname[1000][64],carmoney[1000],carfill[1000],car[1000],carfuel[1000],Float:carx[1000],Float:cary[1000],Float:carz[1000],Float:carmianxiang[1000],carcolor1[1000],carcolor2[1000],carzuzhi[1000],carmoxing[1000];
new	cargz[1000][10],caryinqing[1000],cardengguang[1000],carlock[1000];//������װ���������桢�����ƹ⡢������
new	askqtime[100];//���ASKQ���
new	carzuyong[1000];//��¼��������
new	tg[2][32];//Ԥ��ִ���ַ��� 0Ϊ��1Ϊ��
new	adminduty[100];//��¼��ҹ���Ա��½״̬
new Text:TextdrawMav;

new	su[100],cu[100],tofind[100],duty[100],swat[100],jcys[100],healid[100],healmoney[100],healtoid[100],Text3D:liaotiantext[100],liaotiantexts[100];//��¼ͨ��״̬����¼CU״̬����¼����ID����¼�ϰ�״̬,��¼swat״̬,��¼��������״̬,��¼���3D����
new	call[100],callbuff[100],calls[100];//��¼ͨ��ID	��¼ͨ��״̬ ��¼ͨ��ʱ��
new	sellcarsilunchemoney[13],sellcarsilunchemod[13],sellcarlianglunchemoney[8],sellcarlianglunchemod[8],sellfeijimod[3],sellfeijimoney[3],sellvipcarmod[9],sellvipcarmoney[9];//��¼������Ϣ
new	fills[100],fillmoney[100],fillvid[100],engine[100],enginevid[100];
new	KillSpawn[MAX_PLAYERS];
//text ��ʼ
new	Text:Textdraw51[MAX_PLAYERS];
//News
new NOSTimer[MAX_PLAYERS];
//new kouchujike[MAX_PLAYERS];
new	PlayerSitting[MAX_PLAYERS];
new	Float:Playerx[MAX_PLAYERS],	Float:Playery[MAX_PLAYERS],	Float:Playerz[MAX_PLAYERS],	Float:Playera[MAX_PLAYERS],	PlayerSkin[MAX_PLAYERS];
new SexOffer[MAX_PLAYERS];
new SexPrice[MAX_PLAYERS];
//Forwards
forward daojishi();
forward	IsAtBlueBusStop(playerid);
forward	IsAtBlackBusStop(playerid);
forward	ResetView(playerid);
forward	CPOff(playerid);
forward	CostTimer(playerid);

forward	SavePlayer();//����	����������� ÿ10�뱣��һ�Ρ�
forward	AdminXX(zuzhi,string[],color);//������ADMIN������Ϣ
forward	XY(Float:real,playerid,Float:x,Float:y,Float:z);//�жϾ���ĺ��� (��Χ,��Ҫ�жϵ����,ԭ�� XYZ)
forward	sjd();//ÿ��1Сʱ��1�㾭���
//forward koujike(playerid);//�۳�����ֵ
forward	WeatherAndTime();//������ʱ��
forward NOS(playerid);
#define	MAX_ROADBLOCKS 35
enum rInfo
{
	sCreated,
	Float:sX,
	Float:sY,
	Float:sZ,
		sObject,
};
new	Roadblocks[MAX_ROADBLOCKS][rInfo];
// ����ʱ��ID.
/*new	const RandomWorldTime[24][1] =
{
	{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23}
};*/
// ����ID.
/*new	const RandomWeather[15][1] =
{
	{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}
};*/
new	RandMsg;
new	ANNOUNCEMENTS[11][128] ={
	"[��ʾ]:��������:/110 [������] /120 [��ҽ��] /888 [������]",
	"[��ʾ]:ÿ��ˢ����ĳ��Ӷ�������������ĳ�������/vparkͣ�ó���~",
	"[��ʾ]:��ʲô�������/askq [����]Ŷ~",
    "[����]:��ʲô���ʣ�����ϵ����QQ947585287���Ⱥ:163084182",
	"[����]:������������?��ʹ�� /askq	�������ԱŶ.",
	"[SAMPС��ʿ]:��Ҫ���ڻ�������ALT+ENTER�ɣ�",
	"[����]:�ռ�BUG�ˣ���ʹ��/kong �޸��ռ��!.",
	"[��ʾ]:�������������������������˰�~.",
	"[��ʾ]:ע��������������ҪСдŶ~����/help.",
	"[��ʾ]:�벻Ҫ����!��С��װ�˺ܶ೬������ͷŶ~",
	"[����]:���޹��棡"
};
forward	GlobalAnnouncement();
public GlobalAnnouncement()
{
	switch (RandMsg)
	{
		case 0:	{SendClientMessageToAll(ANNOUNCEMENT,ANNOUNCEMENTS[0]);	RandMsg++;}	// -- This will	be the first message
		case 1:	{SendClientMessageToAll(ANNOUNCEMENT,ANNOUNCEMENTS[1]);	RandMsg++;}
		case 2:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[2]); RandMsg++;}
		case 3:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[3]); RandMsg++;}
		case 4:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[4]); RandMsg++;}
 		case 5:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[5]); RandMsg++;}
  		case 6:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[6]); RandMsg++;}
   		case 7:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[7]); RandMsg++;}
   		case 8:	{SendClientMessageToAll(LIGHTGREEN,ANNOUNCEMENTS[8]); RandMsg++;}
		case 9:	{SendClientMessageToAll(COLOR_RED,ANNOUNCEMENTS[9]); RandMsg = 0;} // -- and This will be the last message
	}
	return 1;
}

new	CivMalePeds[54][1] = {
	{2},
	{47},
	{48},
	{50},
	{58},
	{60},
	{68},
	{72},
	{73},
	{80},
	{81},
	{82},
	{83},
	{95},
	{100},
	{101},
	{102},
	{103},
	{104},
	{108},
	{109},
	{110},
	{121},
	{122},
	{123},
	{135},
	{142},
	{143},
	{144},
	{146},
	{153},
	{154},
	{155},
	{156},
	{158},
	{159},
	{160},
	{161},
	{170},
	{180},
	{189},
	{202},
	{203},
	{204},
	{258},
	{259},
	{260},
	{293},
	{295},
	{296},
	{297},
	{61},
	{255},
	{253}
};
new	CivFemalePeds[33][1] = {
	{55},
	{56},
	{63},
	{69},
	{76},
	{85},
	{91},
	{93},
	{131},
	{141},
	{148},
	{150},
	{151},
	{152},
	{157},
	{169},
	{172},
	{190},
	{192},
	{193},
	{194},
	{195},
	{198},
	{201},
	{214},
	{216},
	{219},
	{225},
	{233},
	{237},
	{251},
	{263},
	{298}
};
#define	SCRIPT_VERSION		"�ҵ��й��Ŀ�Դ���߰�"
main()
{
	print("		*        *  ***********  *         *  *           *");
	print("		*        *  *             *       *    *         * ");
	print("		*        *  *              *     *      *       *  ");
	print("		*        *  *               *   *        *     *   ");
	print("		*        *  *                * *          *   *    ");
	print("		**********  *                 *            * *     ");
	print("		*        *  *                 *           *   *    ");
	print("		*        *  *                 *          *     *   ");
	print("		*        *  *                 *         *       *  ");
	print("		*        *  *                 *        *         * ");
	print("		*        *  ***********       *       *           *");
	print(" ");
	print("                                       �ҵ��й���                    ");
	print("                                    My Chinese Heart               ");
	print("________________________________________________________________________________");
	print("                             �ҵ��й��Ŀ�Դ���߼������İ�           ");
	print("________________________________________________________________________________");
	print("                              By:TL_GTASA @ hcyxsq.cn            ");
	print("________________________________________________________________________________");
	SendRconCommand("hostname �ҵ��й��� - ��Դ���߼������İ� - SAMP.HCYXSQ.CN");
	SendRconCommand("weather 2");
}


public NOS(playerid)
{
new	vid=GetPlayerVehicleID(playerid);
if(vid!=0)
    {
    AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
    }
return 1;
}

/*public koujike(playerid)
{
new msg[128];


playerjiedu[playerid]=playerjiedu[playerid]-1;
playerkouke[playerid]=playerkouke[playerid]-1;
                new list[256];
		    	format(list,256,"             Your Hungry:%d   Your Thirsty:%d",playerjiedu[playerid],playerkouke[playerid]);
TextDrawSetString(Text:TextdrawMav,list);
    if(playerjiedu[playerid]<0)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*�����ںܳ�ʱ��û�гԶ������ε��ˣ������ǵ��Ժ�ʱ�Է�����");
			SetPlayerHealth(playerid, 0);
			return 1;
    }
    if(playerkouke[playerid]<0)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*�����ںܳ�ʱ��û�кȵ�ˮ���ε��ˣ�����Ҫ���ˮ��������ܰ�����");
			SetPlayerHealth(playerid, 0);
			return 1;
    }
    if(playerjiedu[playerid]<10)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*��е��е���ˣ�ȥ�Ե㶫���ɣ�Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			playerjiedu[playerid]=100;
			SendClientMessage(playerid,COLOR_YELLOW,"��ϵͳ��ȥ�����벻�ص��ģ�");
    }
    if(playerkouke[playerid]<10)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*��е��е���ˣ�ȥ�ȵ����ϰɣ�Ŀǰ�ڿʶȣ�%d",playerkouke[playerid]);
			playerkouke[playerid]=100;
			SendClientMessage(playerid,COLOR_YELLOW,"��ϵͳ��ȥ�����벻�ص��ģ�");
    }
return 1;
}*/
public OnPlayerCommandText(playerid, cmdtext[])//�������ָ��ʱ���¼�
{
	new	cmd[128];
	new	idx;
	cmd=strtok(cmdtext,idx);
	new	cartype	= GetPlayerVehicleID(playerid);
	new	State=GetPlayerState(playerid);
	if(playeradmin[playerid]==0)
	{
	if(KillSpawn[playerid])
	{
		SendClientMessage(playerid,	COLOR_GREY,	"	������ֻ����ʹ��/120����Ԯ�� !");
		if(strcmp(cmd,"/120")==0)
		{
			if(SL[playerid]==1)
			{
				new	msgg[128];
				new	name[128];
				new	tmp[128];
				GetPlayerName(playerid,name,128);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/120 [�Ȼ�����]");
					return 1;
				}
				if(askqtime[playerid]!=0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"���Ѿ������120��~��ȴ�10����ٲ���~��");
					return 1;
				}
				format(msgg,128,"[120��������]:����[ID:%d]%s:%s",playerid,name,tmp);
				AdminXX(6,msgg,0x98FB98FF);
				askqtime[playerid]=10;
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ����������������!~��ȴ�120�Ȼ����ϵ�~");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
			return 1;
		}
		return 1;
	}
	}
	
	if (strcmp("/tablet", cmdtext, true, 10) == 0)
	{
	    if (playeripad[playerid]!= 1)
	    {
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ��!");
			return 1;
		}
		if(!GetPVarInt(playerid,"tablet"))
		{
			SetPVarInt(playerid,"tablet",1);
			TextDrawShowForPlayer(playerid,TabletWin8Start[0]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[1]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[2]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[3]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[4]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[5]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[6]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[7]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[8]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[9]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[10]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[21]);
			TextDrawShowForPlayer(playerid,TabletWin8Start[22]);
			TextDrawShowForPlayer(playerid,TwoBut[0]);
			TextDrawShowForPlayer(playerid,TwoBut[1]);
			SelectTextDraw(playerid,0x33AA33AA);
		}
		else
		{
	    	HidePagForItems(playerid);
	    	HideTabletForPlayer(playerid);
	    	HidePhotosForPlayer(playerid);
	    	HideClockForPlayer(playerid);
	    	HideTabletMusicPlayer(playerid);
	    	HideStartMenuTablet(playerid);
	    	HideUserLogTablet(playerid);
	    	HideTabletWeather(playerid);
			HideEscritorioForPlayer(playerid);
			HideGames(playerid);
			HideSlotMachine(playerid);
	    	CancelSelectTextDraw(playerid);
	    	CameraMode(playerid,2);
	    	HideTabletMap(playerid);
			TextDrawHideForPlayer(playerid,TwoBut[0]);
			TextDrawHideForPlayer(playerid,TwoBut[1]);
	    	KillTimer(TabletTimer[playerid][0]);
	    	KillTimer(TabletTimer[playerid][1]);
	    	KillTimer(TabletTimer[playerid][2]);
	    	KillTimer(TabletTimer[playerid][3]);
	    	KillTimer(TabletTimer[playerid][4]);
	    	KillTimer(TabletTimer[playerid][5]);
	    	DeletePVar(playerid,"tablet");
	    	DeletePVar(playerid,"onoff");
	    	DeletePVar(playerid,"camara");
		}
		return 1;
	}
	
	if(strcmp(cmd,"/placefw")==0)
	{
        if(Fired == 1)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "��ȴ�Ŀǰ�̻��������(Ŀǰֻ��ȫ��ͬʱ����һ���̻�).");
			return 1;
		}
		if (GetPlayerInterior(playerid) != 0)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "��Ҫը���ⶰ¥ô...");
		    return 1;
		}
		if (playeryanhua[playerid] <= 0)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "��û���̻���.");
		    return 1;
		}
		new string[128];
		format(string, sizeof(string), "%s �������̻�.", GetPlayerNameEx(playerid));
	    new Float:x, Float:y, Float:z, Float:a;
	    GetPlayerPos(playerid, x, y, z);
	    foreach(Player, i)
		{
			if(IsPlayerInRangeOfPoint(i, 30, x, y, z)) {
				SendClientMessage(i, COLOR_YELLOW, string);
			}
	    }
	    GetPlayerFacingAngle(playerid, a);
	    x += (2 * floatsin(-a, degrees));
    	y += (2 * floatcos(-a, degrees));
	    Rocket[FireworkTotal] = CreateDynamicObject(3786, x, y, z, 0, 90, 0);
	    RocketLight[FireworkTotal] = CreateDynamicObject(354, x, y, z + 1, 0, 90, 0);
		RocketSmoke[FireworkTotal] = CreateDynamicObject(18716, x, y, z - 4, 0, 0, 0);
		rx[FireworkTotal] = x;
		ry[FireworkTotal] = y;
		rz[FireworkTotal] = z;
		RocketExplosions[FireworkTotal] = 0;
  		FireworkTotal++;
  		playeryanhua[playerid] --;
	    return 1;
	}
	if(strcmp(cmd,"/launchfw")==0)
	{
		if(Fired == 1)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "�Ѿ���һ���̻��ڷ�����!(Ŀǰֻ��ȫ��ͬʱ����һ���̻�).");
			return 1;
		}
		if(FireworkTotal <= 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "û���̻��ѷ���.");
			return 1;
		}
		for(new i = 0; i < FireworkTotal; i++)
		{
			CreateExplosion(rx[i] ,ry[i], rz[i], 12, 5);
			new time = MoveDynamicObject(Rocket[i], rx[i] ,ry[i], rz[i] + RocketHeight, 10);
			MoveDynamicObject(RocketLight[i], rx[i] ,ry[i], rz[i] + 2 + RocketHeight, 10);
			MoveDynamicObject(RocketSmoke[i], rx[i] ,ry[i], rz[i] + RocketHeight, 10);
			SetTimerEx("Firework", time, 0, "i", i);
		}
		Fired = 1;
	    return 1;
	}
	
	if(strcmp(cmdtext, "/cc", true) == 0)
	{
	    if(playeradmin[playerid] > 0)
	    {
		    for(new g; g<50; g++)
		    {
		        SendClientMessageToAll(COLOR_WHITE, "");
		    }
		    new msg[128],name[128];
		    GetPlayerName(playerid,name,128);
			format(msg, sizeof(msg), "����Ա {1B8AE4}%s(%d) {FFFFFF}������.", name,playerid);
			SendClientMessageToAll(COLOR_WHITE, msg);
			return 1;
		}
	}
	
	if (strcmp("/fare",	cmdtext, true, 10) == 0)
	{
	    if (playerjob[playerid] != 6) return SendClientMessage(playerid,COLOR_RED,"�㲻�ǳ��⳵˾��");
		if(OnDuty[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"��û��ֵ��");
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!IsATaxi(vehicleid)) return SendClientMessage(playerid,COLOR_RED,"����Ҫ�ڳ��⳵�ϣ�");
		if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid,COLOR_RED,"��Ҫ��ʻԱ��ʻ!");
		if(CheckPassengers(vehicleid) != 1) return SendClientMessage(playerid,COLOR_RED,"��ȴ����˽���ĳ��⳵!");
		if(IsOnFare[playerid] == 0)
		{

		if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"���Ѿ�����Ʊ��");
		GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
		faretimer[playerid] = SetTimerEx("FareUpdate", 1000, true, "i", playerid);
		IsOnFare[playerid] = 1;
		TotalFare[playerid] = STARTAMOUNT;
		new formatted[128];
		format(formatted,128,"All money: %.2f $",STARTAMOUNT);
		TextDrawSetString(taxithisfare[playerid],formatted);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�����ڵ�Ʊ�ۣ�����Ŀͻ��͵���/����Ҫȥ�ĵط�");
		return 1;
		}
		if(IsOnFare[playerid] == 1)
		{
		TotalFare[playerid] = 0.00;
		TextDrawSetString(taxithisfare[playerid],"All money: N/A");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ʊ��ֹͣ");
		IsOnFare[playerid] = 0;
		KillTimer(faretimer[playerid]);
	 	return 1;
		}
	    return 1;
	}
	
	
	if (strcmp("/taxiduty",	cmdtext, true, 10) == 0)
	{
        if (playerjob[playerid] != 6) return SendClientMessage(playerid,COLOR_RED,"�㲻�ǳ��⳵˾��");
		if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"��Ŀǰ������Ʊ�ۣ������㲻��ȥ�°�!");
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"������³�����ܸ����°�/�ϰ�!");
		if(OnDuty[playerid] == 0)
		{
		OnDuty[playerid] = 1;

		SendClientMessage(playerid,COLOR_LIGHTBLUE,"���ϰ���!");
		new name[256],msg[256];
		GetPlayerName(playerid,name,256);
		format(msg,sizeof(msg),"���⳵˾��:%s�ϰ���! ����: %d",name,playercall[playerid]);
 		SendClientMessageToAll(COLOR_BLUE,msg);

		taxiblackbox[playerid] = TextDrawCreate(497.000000, 302.000000, "              ");
		TextDrawBackgroundColor(taxiblackbox[playerid], 255);
		TextDrawFont(taxiblackbox[playerid], 1);
		TextDrawLetterSize(taxiblackbox[playerid], 0.500000, 1.000000);
		TextDrawColor(taxiblackbox[playerid], -1);
		TextDrawSetOutline(taxiblackbox[playerid], 0);
		TextDrawSetProportional(taxiblackbox[playerid], 1);
		TextDrawSetShadow(taxiblackbox[playerid], 1);
		TextDrawUseBox(taxiblackbox[playerid], 1);
		TextDrawBoxColor(taxiblackbox[playerid], 255);
		TextDrawTextSize(taxiblackbox[playerid], 140.000000, -1.000000);

		taxigreendisplay[playerid] = TextDrawCreate(484.000000, 318.000000, "          ");
		TextDrawBackgroundColor(taxigreendisplay[playerid], 255);
		TextDrawFont(taxigreendisplay[playerid], 1);
		TextDrawLetterSize(taxigreendisplay[playerid], 0.500000, 1.000000);
		TextDrawColor(taxigreendisplay[playerid], -1);
		TextDrawSetOutline(taxigreendisplay[playerid], 0);
		TextDrawSetProportional(taxigreendisplay[playerid], 1);
		TextDrawSetShadow(taxigreendisplay[playerid], 1);
		TextDrawUseBox(taxigreendisplay[playerid], 1);
		TextDrawBoxColor(taxigreendisplay[playerid], 576786175);
		TextDrawTextSize(taxigreendisplay[playerid], 154.000000, -1.000000);

		taxitimedisplay[playerid] = TextDrawCreate(160.000000, 340.000000, "Time:  Loading..");
		TextDrawBackgroundColor(taxitimedisplay[playerid], 255);
		TextDrawFont(taxitimedisplay[playerid], 2);
		TextDrawLetterSize(taxitimedisplay[playerid], 0.250000, 0.799999);
		TextDrawColor(taxitimedisplay[playerid], 835715327);
		TextDrawSetOutline(taxitimedisplay[playerid], 1);
		TextDrawSetProportional(taxitimedisplay[playerid], 1);
		new format100[128];
		format(format100,128,"100m Fare: %.2f",MONEYPER100);
		taxi100mfare[playerid] = TextDrawCreate(160.000000, 360.000000, format100);
		TextDrawBackgroundColor(taxi100mfare[playerid], 255);
		TextDrawFont(taxi100mfare[playerid], 2);
		TextDrawLetterSize(taxi100mfare[playerid], 0.250000, 0.799999);
		TextDrawColor(taxi100mfare[playerid], 835715327);
		TextDrawSetOutline(taxi100mfare[playerid], 1);
		TextDrawSetProportional(taxi100mfare[playerid], 1);

		taxithisfare[playerid] = TextDrawCreate(160.000000, 380.000000, "Fare: N/A ");
		TextDrawBackgroundColor(taxithisfare[playerid], 255);
		TextDrawFont(taxithisfare[playerid], 2);
		TextDrawLetterSize(taxithisfare[playerid], 0.250000, 0.799999);
		TextDrawColor(taxithisfare[playerid], 835715327);
		TextDrawSetOutline(taxithisfare[playerid], 1);
		TextDrawSetProportional(taxithisfare[playerid], 1);

		taxilstlogo[playerid] = TextDrawCreate(220.000000, 317.000000, "Taxi Job");
		TextDrawBackgroundColor(taxilstlogo[playerid], 255);
		TextDrawFont(taxilstlogo[playerid], 3);
		TextDrawLetterSize(taxilstlogo[playerid], 0.550000, 1.799998);
		TextDrawColor(taxilstlogo[playerid], 835715327);
		TextDrawSetOutline(taxilstlogo[playerid], 1);
		TextDrawSetProportional(taxilstlogo[playerid], 1);

		taxistatus[playerid] = TextDrawCreate(320.000000, 390.000000, "This Taxi: ");
		TextDrawBackgroundColor(taxistatus[playerid], 255);
		TextDrawFont(taxistatus[playerid], 2);
		TextDrawLetterSize(taxistatus[playerid], 0.250000, 0.799998);
		TextDrawColor(taxistatus[playerid], 835715327);
		TextDrawSetOutline(taxistatus[playerid], 1);
		TextDrawSetProportional(taxistatus[playerid], 1);
		new formatted[128];
		format(formatted,128,"Start Fare: %.2f",STARTAMOUNT);

		startfare[playerid] = TextDrawCreate(380.000000, 340.000000, formatted);

		TextDrawBackgroundColor(startfare[playerid], 255);

		TextDrawFont(startfare[playerid], 2);

		TextDrawLetterSize(startfare[playerid], 0.250000, 0.799998);

		TextDrawColor(startfare[playerid], 835715327);

		TextDrawSetOutline(startfare[playerid], 1);

		TextDrawSetProportional(startfare[playerid], 1);

		TextDrawSetString(taxistatus[playerid],"This Taxi��Free");
		Clock();

		return 1;
		}

		if(OnDuty[playerid] == 1)
		{
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"���°���");
		OnDuty[playerid] = 0;
		new name[256],msg[256];
		GetPlayerName(playerid,name,256);
		format(msg,sizeof(msg),"���⳵˾��:%s�°���!",name);
 		SendClientMessageToAll(COLOR_BLUE,msg);
		TextDrawDestroy(taxiblackbox[playerid]);
		TextDrawDestroy(taxigreendisplay[playerid]);
		TextDrawDestroy(taxitimedisplay[playerid]);
		TextDrawDestroy(taxi100mfare[playerid]);
		TextDrawDestroy(taxithisfare[playerid]);
		TextDrawDestroy(taxilstlogo[playerid]);
		TextDrawDestroy(taxistatus[playerid]);
		TextDrawDestroy(startfare[playerid]);

		return 1;
		}


	}
//===============================================[TLԭ����������]====================================
	if (strcmp(cmd, "/jybd", true) == 0) {
		cmd = strtok(cmdtext, idx);
		if (!strlen(cmd)) {
		    ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"�����������ܰ��� (TLԭ��)","/jybd start [��ʼ����]\n/jybd stop [ֹͣ����(�˳�����)]\n/jybd door [����]\n/jybd ys [��Կ��]\n /jybd gun [��ǹ]","ȷ��","");
		    return 1;
		}

	    if (strcmp(cmd, "start", true) == 0) {//��ʼ����
			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 265.6101,76.1229,1001.0391)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڼ���!");
	        return 1;
   		 	}
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڶ׼���!");
	        return 1;
   		 	}
			jybdzt[playerid] = 1;
			SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:�㿪ʼ�����ˣ��尡!!!(������������С�����ת�ҵĴ�����)");
			SetPlayerCheckpoint(playerid,-2831.4377,2306.6553,98.3154,3);
			SetPlayerPos(playerid,267.2517,76.3074,1001.0391);
			new	msg[128];
			new	name[128];
			GetPlayerName(playerid,name,128);
			su[playerid]=su[playerid]+1;
			format(msg,128,"[�ܲ�]:	%s��ͨ�����Ѿ������ˣ�ͨ���ȼ�:%d,ͨ������:����",name,su[playerid]);
			AdminXX(3,msg,0x00FF00AA);
			ABroadCast(0x00FF00AA,msg,1);
	        return 1;
	    }

	    if (strcmp(cmd, "stop", true) == 0) {//ֹͣ����
			jybdzt[playerid] = 0;
			SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:ֹͣ����!!!");
			jybdyszt[playerid] = 0;
			jybdlinggunzt[playerid] = 0;
	        return 1;
	    }
	    if (strcmp(cmd, "ys", true) == 0) {//��Կ��
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڶ׼���!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ����û���ڱ���!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 230.7155,71.3590,1005.0391)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڰ칫����Կ�׵�!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:��ȡ��Կ��.");
			jybdyszt[playerid] = 1;
	        return 1;
	    }
	    if (strcmp(cmd, "gun", true) == 0) {//��ǹ
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڶ׼���!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ����û���ڱ���!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 257.5566,77.5511,1003.6406)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڴ����!");
	        return 1;
   		 	}
			if (jybdlinggunzt[playerid] > 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ�����Ѿ�����ˣ��벻Ҫˢ�ӵ�!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:��򿪴����������һ����ǹ�;���.");
			GivePlayerWeaponEx(playerid,22,500);
			GivePlayerWeaponEx(playerid,3,99999);
			jybdlinggunzt[playerid] = 1;
	        return 1;
	    }
	    
	    if (strcmp(cmd, "door", true) == 0) {//����
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻�ڶ׼���!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ����û���ڱ���!");
	        return 1;
   		 	}
			if (jybdyszt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ����û��Կ��!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 246.3270,73.1185,1003.6406)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻���ſ�!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:����Կ�״�����.");
			MoveDynamicObject(gate11,242.80754089355, 72.450500488281, 1002.640625,8);
			MoveDynamicObject(gate12,248.2579498291, 72.445793151855, 1002.640625,8);
	        return 1;
	    }
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}��ʾ��������������� /jybd �鿴����.");
  		return 1;
	}
//===============================================[TLԭ������ϵͳ]====================================
	if (strcmp("/gmqt",	cmdtext, true, 10) == 0)
	{
			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1232.0562,-810.9739,1084.007)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}��ʾ���㲻��GM����ǰ̨��������!");
	        return 1;
   		 	}
		ShowPlayerDialog(playerid,9754,DIALOG_STYLE_LIST,"{00A5FF}GM����ǰ̨��������","{37FF00}����ϵͳ","ȷ��","ȡ��");
		return 1;
	}
//===============================================[��������ͷ]========================================
	if (strcmp("/szsxt",	cmdtext, true, 10) == 0)
	{
		if(playeradmin[playerid]<1338)
		{
			SendClientMessage(playerid,0xffffffff,"����: ����Ȩ��ʹ�ø�����!");
			return 1;
		}
		ShowPlayerDialog(playerid,DIALOG_MAIN,DIALOG_STYLE_LIST,"{00A5FF}��������ͷ	{FFFFFF}- {FFDC00}���˵�","{37FF00}��������ͷ\n\n�õ����������ͷID\n�༭���������ͷ\n{FF1400}ɾ�����������ͷ\n{FF1400}ɾ����������ͷ","ȷ��","ȡ��");
		return 1;
	}
//======================================================================================================'
	if(strcmp(cmd,"/acu")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>=1338)
			{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/acu	[���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û������!");
						return 1;
					}
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"�������㣿���Լ���");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(5,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2�����̫Զ�ˡ���");
						return 1;
					}
					new	name[128];
					new	msg[128];
					if(cu[id]==0)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"�㱻����Ա%s��������!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"���%s���㿽������!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,0);
						cu[id]=1;
						return 1;
					}
					if(cu[id]==1)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"�����ϵĿ��ӱ�����Ա�򾯲�%sŪ����!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"������%s���ϵĿ���Ū����!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,1);
						cu[id]=0;
						return 1;
					}
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�ǹ���Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	
	/*if(strcmp("/gotobluebus", cmdtext, true) ==	0)
	{
		if(playeradmin[playerid]<1337)
		{
			SendClientMessage(playerid,	COLOR_RED, "��û��Ȩ��ʹ�ø�����.");
			return 1;
		}
		if(BusID[playerid] > 0)
		{
			SetPlayerVirtualWorld(playerid,	0);
		}
		PutPlayerInVehicle(playerid, NPCBlueBus, 2);
		SendClientMessage(playerid,	COLOR_DARKAQUA,	"�����͵��˹�������");
		return 1;
	}
	if(strcmp("/gotoblackbus", cmdtext,	true) == 0)
	{
		if(playeradmin[playerid]<1337)
		{
			SendClientMessage(playerid,	COLOR_RED, "��û��Ȩ��ʹ�ø�����.");
			return 1;
		}
		if(BusID[playerid] > 0)
		{
			SetPlayerVirtualWorld(playerid,	0);
		}
		PutPlayerInVehicle(playerid, NPCBlackBus, 2);
		SendClientMessage(playerid,	COLOR_DARKAQUA,	"�����͵��˹�������");
		return 1;
	}
	if(strcmp("/lookout", cmdtext, true) ==	0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 10, 2021.9390,2241.9487,2103.9536))
		{
			SendClientMessage(playerid,	COLOR_RED, "�����ڹ�������");
			return 1;
		}
		GetPlayerPos(playerid, Playerx[playerid], Playery[playerid], Playerz[playerid]);
		GetPlayerFacingAngle(playerid, Playera[playerid]);
		PlayerSkin[playerid] = GetPlayerSkin(playerid);
		SetPlayerInterior(playerid,	0);
		SetPlayerVirtualWorld(playerid,	0);
		TogglePlayerSpectating(playerid, 1);
		if(BusID[playerid] == 1)
		{
			PlayerSpectateVehicle(playerid,	NPCBlueBus);
		}
		else
		{
			PlayerSpectateVehicle(playerid,	NPCBlackBus);
		}
		SetTimerEx("ResetView",	2000, 0, "d", playerid);
		return 1;
	}
	if(strcmp("/busroute", cmdtext,	true) == 0)
	{
		if(IsAtBlueBusStop(playerid))
		{
			SendClientMessage(playerid,	COLOR_TEAL,	"����һ���߽�ͨ��·: ����̲	- ���� - ���� -	СҽԺ - LS�ɻ��� -	��ʿվ");
			return 1;
		}
		else if(IsAtBlackBusStop(playerid))
		{
			SendClientMessage(playerid,	COLOR_TEAL,	"���������߽�ͨ��·: ��ʿվ	- ������ - ����	- ��ҽԺ - �г�վ -	ʥ�����Ǻ�̲");
			return 1;
		}
		else
		{
			SendClientMessage(playerid,	COLOR_RED, "�����ڹ�����վ");
		}
		return 1;
	}
	if(strcmp("/buslocation", cmdtext, true) ==	0)
	{
			new	Float:busx,	Float:busy,	Float:busz;
			if(IsAtBlueBusStop(playerid))
			{
				GetVehiclePos(NPCBlueBus, busx,	busy, busz);
				SetPlayerCheckpoint(playerid, busx,	busy, busz,	0);
				GameTextForPlayer(playerid,	"~w~Locating ~r~Bus~w~.	. .	.",	2000, 3);
				SetTimerEx("CPOff",	3000, 0, "d", playerid);
				return 1;
			}
			else if(IsAtBlackBusStop(playerid))
			{
				GetVehiclePos(NPCBlackBus, busx, busy, busz);
				SetPlayerCheckpoint(playerid, busx,	busy, busz,	0);
				GameTextForPlayer(playerid,	"~w~Locating ~r~Bus~w~.	. .	.",	2000, 3);
				SetTimerEx("CPOff",	3000, 0, "d", playerid);
				return 1;
			}
			else
			{
				SendClientMessage(playerid,	COLOR_RED, "�����ڹ�����վ");
			}
			return 1;
	}*/
//-------------------------------------------�������������Ϸ---
	if	(strcmp(cmd, "/l", true)==0)
	{
			new	string[256];
			new	Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			format(string, sizeof(string), "%d,%d,%d.",x,y,z);
			SendClientMessage(playerid,0xFFFFFFAA,string);
			return 1;
	}
//----------------------------------[W]-----------------------------------------------
	/*if(strcmp(cmd, "/w", true) ==	0)
	{
		new	string[64];
		if(IsPlayerConnected(playerid))
		{
			if(SL[playerid]	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"	����û�е�½ !");
				return 1;
			}
			new	str[160];
			GetPlayerName(playerid,	str, MAX_PLAYER_NAME);
			for	(new i = 0;	i <	MAX_PLAYER_NAME; i++)
			if (str[i] == '_')
			str[i] = ' ';
			new	length = strlen(cmdtext);
			while ((idx	< length) && (cmdtext[idx] <= '	'))
			{
				idx++;
			}
			new	offset = idx;
			new	result[64];
			while ((idx	< length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	/w [��Ϣ]");
				return 1;
			}
			format(str,	sizeof str,	" %s [С��˵]: %s",	str, result);
			ProxDetector(5.0, playerid,	str,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
			printf("%s", string);
//ChatLog(string);
		}
		return 1;
	}*/

//----------------------------------[/B]-----------------------------------------------
	/*if(strcmp(cmd, "/b", true) == 0)//local	ooc
	{
		if(IsPlayerConnected(playerid))
		{
			if(SL[playerid]	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"	����û�е�½ !");
				return 1;
			}
			new	str[160];
			GetPlayerName(playerid,	str, MAX_PLAYER_NAME);
			for	(new i = 0;	i <	MAX_PLAYER_NAME; i++)
			if (str[i] == '_')
			str[i] = ' ';
			new	length = strlen(cmdtext);
			while ((idx	< length) && (cmdtext[idx] <= '	'))
			{
				idx++;
			}
			new	offset = idx;
			new	result[64];
			while ((idx	< length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	/b [��Ϣ]");
				return 1;
			}
			format(str,	sizeof(str), "%s ˵: (( %s ))",	str, result);
			ProxDetector(20.0, playerid, str,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
//LocalLog(string[]);
			printf("%s", str);
		}
		return 1;
	}*/
//----------------------------------[Shout]-----------------------------------------------
	if(strcmp(cmd, "/shout", true) == 0	|| strcmp(cmd, "/s", true) == 0)
	{
		new	string[160];
		if(IsPlayerConnected(playerid))
		{
			if(SL[playerid]	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"	�㻹δ��½ !");
				return 1;
			}
			new	str[160];
			GetPlayerName(playerid,	str, MAX_PLAYER_NAME);
			for	(new i = 0;	i <	MAX_PLAYER_NAME; i++)
			if (str[i] == '_')
			str[i] = ' ';
			new	length = strlen(cmdtext);
			while ((idx	< length) && (cmdtext[idx] <= '	'))
			{
				idx++;
			}
			new	offset = idx;
			new	result[64];
			while ((idx	< length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	(/s)hout [��Ϣ]");
				return 1;
			}
			format(str,	sizeof str,	"%s	��: %s����", str,	result);
			ProxDetector(40.0, playerid, str,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
			printf("%s", string);
//ChatLog(string);
		}
		return 1;
	}
//----------------------------------[ME]-----------------------------------------------
	if(strcmp(cmd, "/me", true)	== 0)
	{
		new	sendername[MAX_PLAYER_NAME], string[128];
		GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(IsPlayerConnected(playerid))
		{
			if(SL[playerid]	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"	����û�е�½ !");
				return 1;
			}
			GetPlayerName(playerid,	sendername,	sizeof(sendername));
			new	length = strlen(cmdtext);
			while ((idx	< length) && (cmdtext[idx] <= '	'))
			{
				idx++;
			}
			new	offset = idx;
			new	result[64];
			while ((idx	< length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	/me	[����]");
				return 1;
			}
/*if(PlayerInfo[playerid][pMaskuse]	== 1)
{
format(string, sizeof(string), "* Stranger %s",	result);
}
else
{*/
			format(string, sizeof(string), "* %s %s", sendername, result);
//}
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			printf("%s", string);
		}
		return 1;
	}
//----------------------------------[Do]-----------------------------------------------
	if(strcmp(cmd, "/do", true)	== 0)
	{
		new	sendername[MAX_PLAYER_NAME], string[128];
		GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(IsPlayerConnected(playerid))
		{
			if(SL[playerid]	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"	����û�е�½ !");
				return 1;
			}
			GetPlayerName(playerid,	sendername,	sizeof(sendername));
			new	length = strlen(cmdtext);
			while ((idx	< length) && (cmdtext[idx] <= '	'))
			{
				idx++;
			}
			new	offset = idx;
			new	result[64];
			while ((idx	< length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	/do	[����]");
				return 1;
			}
/*if(PlayerInfo[playerid][pMaskuse]	== 1)
{
format(string, sizeof(string), "* %s ((	Stranger ))", result);
}
else
{*/
			format(string, sizeof(string), "* %s ((	%s ))",	result,	sendername);
//}
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			printf("%s", string);
		}
		return 1;
	}
//=====================================�ʵ�
	if(strcmp(cmdtext, "/nshp",	true) == 0)
	{
		SetPlayerInterior(playerid,0);
		{
			if(State!=PLAYER_STATE_DRIVER)
			{
				//SetPlayerPos(playerid, 529.618591,-1288.602050,17.334606);
			}
			else
			if(IsPlayerInVehicle(playerid, cartype)	== 1)
			{
				//SetVehiclePos(cartype, 529.618591,-1288.602050,17.334606);
				//SetVehicleZAngle(cartype,180.1530);
			}
			else
			{
				//SetPlayerPos(playerid, 529.618591,-1288.602050,17.334606);
			}
			SendClientMessage(playerid,	COLOR_YELLOW,"�÷� /neon��װ��ϲ���Ĳʵ����!");}
		return 1;
	}
//----------------------------------------------------
	if (strcmp(cmdtext,	"/neon", true)==0)
	{
		if(IsPlayerInRangeOfPoint(playerid,	7.0, 529.618591,-1288.602050,17.334606))
		{
			ShowPlayerDialog(playerid, 8899, DIALOG_STYLE_LIST,	"ѡ����ϲ���Ĳʵư�װ",	"��\n��\n��ɫ\n��\n�ۺ�\n��ɫ\n����Ƶ����\n�����ڵ�\n�󲿺��\nǰ���޺��\n���̵�\nɾ��ȫ���޺��",	"ȷ��",	"����");
			PlayerPlaySound(playerid, 1133,	0.0, 0.0, 10.0);
		}
		
		return 1;
	}
//=====================================�ʵ�
/*if(strcmp(cmd,"/test")==0)
{
SetPlayerAttachedObject(playerid,0,356,1,0.1,-0.15,0,0,200,0);
return 1;
}*/
/*if(strcmp(cmd,"/ban")==0)
{
new	tmp[128],id;
tmp=strtok(cmdtext,idx);
id=strval(tmp);
tmp=strtokp(cmdtext,idx);
BanEx(id,tmp);
return 1;
}*/
	if(strcmp(cmd,"/vlock")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�:/vlock ��ID	//��ID����ͨ��/vstats��/dl�鿴");
				return 1;
			}
			new	vid=strval(tmp);
			if(car[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��Ч�ĳ���ID");
				return 1;
			}
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(strcmp(carname[vid],name)!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�ⲻ���������!");
				return 1;
			}
			if(carlock[vid]==0)
			{
				carlock[vid]=1;
				SendClientMessage(playerid,0x00FF00AA,"�㽫�������������~~");
				SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
				return 1;
			}
			carlock[vid]=0;
			SendClientMessage(playerid,0x00FF00AA,"�㽫�������������~~");
			SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/h")==0)
	{
		if(SL[playerid]==1)
		{
			if(callbuff[playerid]==1)
			{
				new	msg[128];
				if(calls[playerid]!=0)
				{
					playercallmoney[playerid]=playercallmoney[playerid]-calls[playerid];
					format(msg,128,"��Ҷ��˵绰,����ͨ��ʱ��:{FF00FF}%d��{FFC0CB},����ͨ������:{FF00FF}%dԪ{FFC0CB},�ֻ�ʣ�໰��:{FF00FF}%dԪ{FFC0CB}",calls[playerid],calls[playerid],playercallmoney[playerid]);
					SendClientMessage(playerid,0xFFC0CBFF,msg);
					SendClientMessage(call[playerid],0xFFC0CBFF,"�Է��Ҷ��˵绰");
					call[call[playerid]]=0;
					callbuff[call[playerid]]=0;
					call[playerid]=0;
					callbuff[playerid]=0;
					return 1;
				}
				new	id=call[call[playerid]];
				playercallmoney[id]=playercallmoney[id]-calls[id];
				format(msg,128,"��Ҷ��˵绰,����ͨ��ʱ��:{FF00FF}%d��{FFC0CB},����ͨ������:{FF00FF}%dԪ{FFC0CB},�ֻ�ʣ�໰��:{FF00FF}%dԪ{FFC0CB}",calls[id],calls[id],playercallmoney[id]);
				SendClientMessage(playerid,0xFFC0CBFF,msg);
				SendClientMessage(call[playerid],0xFFC0CBFF,"�Է��Ҷ��˵绰");
				call[call[playerid]]=0;
				callbuff[call[playerid]]=0;
				call[playerid]=0;
				callbuff[playerid]=0;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û�д�绰!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/p")==0 || strcmp(cmd,"/pickup")==0)
	{
		if(SL[playerid]==1)
		{
			if(call[playerid]!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"���ͨ�˵绰,��������/h���Ҷϵ绰!");
				SendClientMessage(call[playerid],0x00FF00AA,"�Է���ͨ�˵绰,���������/h���Ҷϵ绰!");
				calls[call[playerid]]=1;
				callbuff[playerid]=1;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"û���˲�����ĵ绰!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/call")==0)
	{
		if(SL[playerid]==1)
		{
			if(playercall[playerid]!=0)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/call [�绰����]");
					return 1;
				}
				if(playercallmoney[playerid]<=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��ĵ绰��Ƿ�ѣ��뾡���ֵ!");
					return 1;
				}
				id=strval(tmp);
				if(id==0)
				{
					return 1;
				}
				if(id==playercall[playerid])
				{
					SendClientMessage(playerid,0x00FF00AA,"�绰¼��:��Ȼ�Һܸ������������Ǯ,���������˷ѷ�������Դ,�벻Ҫ��������.лл!");
					return 1;
				}
				if(id==110)
				{
					SendClientMessage(playerid,0x00FF00AA,"�绰¼��:��Ȼ�Һܸ������������Ǯ,���������˷ѷ�������Դ,�벻Ҫ��������.лл!");
					return 1;
				}
				if(id==10086)
				{
				    new msg[256];
				    format(msg,sizeof(msg),"����ѯ������ʻ������:%dԪ.",playercallmoney[playerid]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"[����]{FF00FF}[����:10086]{FFC0CB}����:{FF00FF}����ʻ������:%dԪ{FFC0CB}",playercallmoney[playerid]);
					SendClientMessage(playerid,0xFFC0CBFF,msg);
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"������~~������~~��ĵ绰����!������ʾ:{FF00FF}%d{FFC0CB},����/(p)ickup ����!",playercall[playerid]);
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(playercall[i]==id)
							{
								SendClientMessage(playerid,0xFFC0CBFF,"�㲦����һ���绰,��ȴ���ͨ,��������/h�Ҷϵ绰!");
								SendClientMessage(i,0xFFC0CBFF,msg);
								call[playerid]=i;
								callbuff[playerid]=1;
								call[i]=playerid;
								callbuff[i]=0;
								return 1;
							}
						}
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"�㲦��ĵ绰��ʱû���˽���.�뿼�ǲ���110��ʧ�ٰ��򲦴�120������!");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û�е绰");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/id")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128],name[128],msg[128],s;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�:/id	[����]");
				return 1;
			}
			format(msg,128,"---�����а���'%s'�����ID����---",tmp);
			SendClientMessage(playerid,0xBA55D3AA,msg);
			for(new	i=0;i<101;i++)
			{
				if(IsPlayerConnected(i)==1)
				{
					if(SL[i]==1)
					{
						s=0;
						GetPlayerName(i,name,128);
						s=strfind(name,tmp);
						if(s!=-1)
						{
							format(msg,128,"ID:%d ����:%s",i,name);
							SendClientMessage(playerid,0xBA55D3AA,msg);
						}
					}
				}
			}
			SendClientMessage(playerid,0xBA55D3AA,"--------------------------------");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
//=======================================================================================
	if(strcmp(cmd,"/zhiliao")==0)
	{
		if(SL[playerid]==1)
		{
			if(healid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"û������Ϊ������!");
				return 1;
			}
			if(playerzuzhi[healid[playerid]]!=6)
			{
				healid[playerid]=0;
				return 1;
			}
			new	Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			if(XY(5,healid[playerid],x,y,z)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�����������̫Զ��!");
				return 1;
			}
			if(playermoney[playerid]<healmoney[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"�㸶�������Ʒ���!");
				return 1;
			}
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"%s�������������,����ȡ��%d~",name,healmoney[playerid]);
			SendClientMessage(healid[playerid],0x00FF00AA,msg);
			GetPlayerName(healid[playerid],name,128);
			format(msg,128,"%�������%s������,�㻨����%d~",name,healmoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			playermoney[playerid]=playermoney[playerid]-healmoney[playerid];
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			playermoney[healid[playerid]]=playermoney[healid[playerid]]+healmoney[playerid];
			ResetPlayerMoney(healid[playerid]);
			GivePlayerMoney(healid[playerid],playermoney[healid[playerid]]);
			SetPlayerHealth(playerid,100);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/heal")==0)
	{
		if(SL[playerid]==1)
		{
			if(ZFJGHU[houseid[playerid]]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"���Ѫ�Ѿ���Ϊ100�� ��Ļ����Ѿ���Ϊ100��~");
				SetPlayerHealth(playerid,100);
				SetPlayerArmour(playerid,100);
				return 1;
			}
			if(playerzuzhi[playerid]==6)
			{
					new	tmp[128],id,money,vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/heal [���id] [�۸�]");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���!");
						return 1;
					}
					if(mod!=416&&mod!=487)
					{
						SendClientMessage(playerid,0x00FF00AA,"�ⲿ����/�ɻ���û��ҽ���þ�!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2������е�Զ��.");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�۸���Ϊ��");
						return 1;
					}
					money=strval(tmp);
					if(money<1||money>150)
					{
						SendClientMessage(playerid,0x00FF00AA,"�۸�Χ����!(1-150)");
						return 1;
					}
					if(KillSpawn[id])
					{
						new	msg[128],name[128];
						GetPlayerName(playerid,name,128);
						format(msg,128,"%s�������ƹ�����!���Ʒ�:%d",name,money);
						SendClientMessage(id,0x00FF00AA,msg);
						SetPlayerHealth(id,50);
						KillSpawn[id] =	false;
						SetPlayerColor(id,0xF8F8FF00);
						TogglePlayerControllable(id,true);
						playermoney[id]=playermoney[id]-money;
						ResetPlayerMoney(id);
						GivePlayerMoney(id,playermoney[id]);
						playermoney[playerid]=playermoney[playerid]+money;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						SendClientMessage(playerid,0x00FF00AA,"���Ƴɹ�!");
						return 1;
					}
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"%s��Ϊ������,���Ʒ�:%d,����/zhiliao����������!",name,money);
					SendClientMessage(id,0x00FF00AA,msg);
					GetPlayerName(id,name,128);
					format(msg,128,"����Ϊ%s����,���Ʒ�:%d",name,money);
					SendClientMessage(playerid,0x00FF00AA,msg);
					healid[id]=playerid;
					healmoney[id]=money;
					healtoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻��ҽ���򲻶�ҽ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
//-----------------------------------------------------------------------------------
	if(strcmp(cmd,"/zhiliao")==0)
	{
		if(SL[playerid]==1)
		{
			if(healid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"û������Ϊ������!");
				return 1;
			}
			if(playerzuzhi[healid[playerid]]!=6)
			{
				healid[playerid]=0;
				return 1;
			}
			new	Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			if(XY(5,healid[playerid],x,y,z)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�����������̫Զ��!");
				return 1;
			}
			if(playermoney[playerid]<healmoney[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"�㸶�������Ʒ���!");
				return 1;
			}
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"%s�������������,����ȡ��%d~",name,healmoney[playerid]);
			SendClientMessage(healid[playerid],0x00FF00AA,msg);
			GetPlayerName(healid[playerid],name,128);
			format(msg,128,"%�������%s������,�㻨����%d~",name,healmoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			playermoney[playerid]=playermoney[playerid]-healmoney[playerid];
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			playermoney[healid[playerid]]=playermoney[healid[playerid]]+healmoney[playerid];
			ResetPlayerMoney(healid[playerid]);
			GivePlayerMoney(healid[playerid],playermoney[healid[playerid]]);
			SetPlayerHealth(playerid,100);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/heal")==0)
	{
		if(SL[playerid]==1)
		{
			if(ZFJGHU[houseid[playerid]]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"���Ѫ�Ѿ���Ϊ100�� ��Ļ����Ѿ���Ϊ100��~");
				SetPlayerHealth(playerid,100);
				SetPlayerArmour(playerid,100);
				return 1;
			}
			if(playerzuzhi[playerid]==6)
			{
					new	tmp[128],id,money,vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/heal [���id] [�۸�]");
						return 1;
					}
					if(vid==0&&houseid[playerid]!=6)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���/ҽԺ��!");
						return 1;
					}
					if(mod!=416&&vid!=110&&vid!=109&&houseid[playerid]!=6)
					{
						SendClientMessage(playerid,0x00FF00AA,"�ⲿ����/�ɻ���û��ҽ���þ�!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2������е�Զ��.");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�۸���Ϊ��");
						return 1;
					}
					money=strval(tmp);
					if(money<1||money>150)
					{
						SendClientMessage(playerid,0x00FF00AA,"�۸�Χ����!(1-150)");
						return 1;
					}
					if(KillSpawn[id])
					{
						new	msg[128],name[128];
						GetPlayerName(playerid,name,128);
						format(msg,128,"%s�������ƹ�����!���Ʒ�:%d",name,money);
						SendClientMessage(id,0x00FF00AA,msg);
						SetPlayerHealth(id,50);
						KillSpawn[id] =	false;
						SetPlayerColor(id,0xF8F8FF00);
						TogglePlayerControllable(id,true);
						playermoney[id]=playermoney[id]-money;
						ResetPlayerMoney(id);
						GivePlayerMoney(id,playermoney[id]);
						playermoney[playerid]=playermoney[playerid]+money;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						SendClientMessage(playerid,0x00FF00AA,"���Ƴɹ�!");
						return 1;
					}
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"%s��Ϊ������,���Ʒ�:%d,����/zhiliao����������!",name,money);
					SendClientMessage(id,0x00FF00AA,msg);
					GetPlayerName(id,name,128);
					format(msg,128,"����Ϊ%s����,���Ʒ�:%d",name,money);
					SendClientMessage(playerid,0x00FF00AA,msg);
					healid[id]=playerid;
					healmoney[id]=money;
					healtoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻��ҽ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/hu")==0)
	{
		if(SL[playerid]==1)
		{
			if(houseid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڷ�����!");
				return 1;
			}
			if(ZFJGLX[houseid[playerid]]==1||ZFJGLX[houseid[playerid]]==2)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������޷�����װ��!");
				return 1;
			}
			if(houseid[playerid]!=playerlock[playerid]&&houseid[playerid]!=playerlock1[playerid]&&houseid[playerid]!=playerlock2[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"�ⲻ����ķ���!");
				return 1;
			}
			if(ZFJGHU[houseid[playerid]]!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷��Ѿ�װ�޹���!");
				return 1;
			}
			if(playermoney[playerid]<100000)
			{
				SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ����!(100000)");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㻨��100000Ԫװ����һ�䷿��~");
			ZFJGHU[houseid[playerid]]=1;
			playermoney[playerid]=playermoney[playerid]-100000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/fill")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(10,playerid, -2272.5703,2394.1760,5.2932)==1)
			{
				new	vid=GetPlayerVehicleID(playerid),fuel,money,zid=GetPlayerVehicleSeat(playerid);
				if(vid==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���!");
					return 1;
				}
				if(zid!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�㲻��˾��......");
					return 1;
				}
				if(carfill[vid]==300)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����������Ѿ�װ��������...");
					return 1;
				}
				fuel=100-carfill[vid];
				money=fuel*3;
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ����~");
					return 1;
				}
				TogglePlayerControllable(playerid,0);
				fills[playerid]=3;
				fillmoney[playerid]=money;
				fillvid[playerid]=vid;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�ڼ���վ!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}

	if(strcmp(cmd,"/jcys")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2547.148925,2300.347900,4.984375)==1)
			{
				new	tmp[128], name[128],msg[128];
				GetPlayerName(playerid,name,128);
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/jcys [���ô���]");
					SendClientMessage(playerid,0x00FF00AA,"	|���ô���:A(300-2500) B(500-4000)");
					SendClientMessage(playerid,0x00FF00AA,"	|����:/jcys	A");
					SendClientMessage(playerid,0x00FF00AA,"	|���÷�ʽ:���ܺ��ͼ�ϻ��к��,����㴦������Ϳ�����");
					SendClientMessage(playerid,0x00FF00AA,"	|����:����A������Ҫ�ɱ�300Ԫ,�����������2500Ԫ,����B������Ҫ�ɱ�500Ԫ,�����������4000Ԫ");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"������Ѿ����ں��ģʽ(�����tofind),���Ƚ������!");
					return 1;
				}
				new	h,m,s;
				if(strcmp(tmp,"A")==0)
				{
					if(playermoney[playerid]<300)
					{
						SendClientMessage(playerid,0x00FF00AA,"��û���㹻��Ѻ��!");
						return 1;
					}
					if(askqtime[playerid]!=0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����Ϣһ������(240s)!");
						return 1;
					}
					gettime(h,m,s);
					format(msg,128,"[����Աע��]:<[%d:%d:%d]A������>%s�����!",h,m,s,name);
					ABroadCast(0x00FF00AA,msg,1);
					jcys[playerid]=1;
					SendClientMessage(playerid,0x00FF00AA,"�������A����������!");
					playermoney[playerid]=playermoney[playerid]-1;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					SetPlayerCheckpoint(playerid,1375.005371 ,475.191253 ,20.050649,3);
					askqtime[playerid]=240;
					return 1;
				}
				if(strcmp(tmp,"B")==0)
				{
					if(playermoney[playerid]<1000)
					{
						SendClientMessage(playerid,0x00FF00AA,"��û���㹻��Ѻ��!");
						return 1;
					}
					if(askqtime[playerid]!=0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����Ϣһ������(240s)!");
						return 1;
					}
					gettime(h,m,s);
					format(msg,128,"[����Աע��]:<[%d:%d:%d]B������>%s�����",h,m,s,name);
					ABroadCast(0x00FF00AA,msg,1);
					jcys[playerid]=2;
					SendClientMessage(playerid,0x00FF00AA,"�������B����������!");
					playermoney[playerid]=playermoney[playerid]-500;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					SetPlayerCheckpoint(playerid, -1055.977661,	-637.489562	,32.007812,3);
					askqtime[playerid]=240;
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"����Ŀ���������.");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻������������ܵ�!(���ú��BUGʵ��ˢ���ϵ����ע���ˣ�����������ͷ�ɣ���BUG���޸�)");
		//SetPlayerCheckpoint(playerid,-2547.148925,2300.347900,4.984375,3);
   return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
//------------------------------------��˽����------
//--------------------------------------------------
	if(strcmp(cmd,"/zscl")==0)
	{
		if(playerjob[playerid]==1)
		{
			if(XY(3,playerid, -1623.986083,-2693.479736,48.742660)==1)
			{
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"������Ѿ����ں��ģʽ,���Ƚ�������/stofind!");
					return 1;
				}
				if(askqtime[playerid]!=0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"����Ϣһ������(240s)!");
					return 1;
				}
				new	name[128],msg[128];
				new	h,m,s;
				gettime(h,m,s);
				format(msg,128,"<[%d:%d:%d]��˽����>%s��ȡ�˲���",h,m,s,name);
				ABroadCast(0x00FF00AA,msg,1);
				jcys[playerid]=4;
				SendClientMessage(playerid,0x00FF00AA,"���������˽��������!");
				playermoney[playerid]=playermoney[playerid]-500;
				ResetPlayerMoney(playerid);
				askqtime[playerid]=240;
				GivePlayerMoney(playerid,playermoney[playerid]);
				SetPlayerCheckpoint(playerid,2230.216796,-2286.343505,14.375131,3);
				return 1;
			}
   			SendClientMessage(playerid,0x00FF00AA,"�㲻�ڲ�����˽�����(���ڵ�ͼ�����ʾ)!");
			SetPlayerCheckpoint(playerid,-1623.986083,-2693.479736,48.742660,3);
   			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"�㲻�ǲ�����˽��");
		return 1;
	}
//---------------------------------------------------------------------------------------
/*if(strcmp(cmd,"/wqzs")==0)
{
if(playerjob[playerid]==5)
{
if(XY(3,playerid, -2659.498291,1530.464721,51.969291)==1)
{
if(jcys[playerid]!=0)
{
SendClientMessage(playerid,0x00FF00AA,"������Ѿ����ں��ģʽ,���Ƚ�������/stofind!");
return 1;
}
if(askqtime[playerid]!=0)
{
SendClientMessage(playerid,	0xDC143CAA,"����Ϣһ������(500s)!");
return 1;
}
new	name[128],msg[128];
new	h,m,s;
gettime(h,m,s);
format(msg,128,"<[%d:%d:%d]������˽>%s��ȡ����������",h,m,s,name);
ABroadCast(0x00FF00AA,msg,1);
jcys[playerid]=6;
SendClientMessage(playerid,0x00FF00AA,"�������������˽����(һ����Ҫ����3500�����������ϵķ���)!");
playermoney[playerid]=playermoney[playerid]-3500;
ResetPlayerMoney(playerid);
askqtime[playerid]=500;
GivePlayerMoney(playerid,playermoney[playerid]);
SetPlayerCheckpoint(playerid,2152.208984,-2270.487792,13.308847,3);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"�㲻���������������!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"�㲻��������˽��");
return 1;
}*/
//---------------------------------------------------------------------------------------
	if(strcmp(cmd,"/t")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128],id;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�:/t [�绰����] [����]");
				return 1;
			}
			if(playercall[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��û���ֻ�!");
				return 1;
			}
			id=strval(tmp);
			if(id==playercall[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"�޷������Լ��ĺ���!");
				return 1;
			}
			if(callbuff[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"������ͨ����!");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			new	msg[128];
			for(new	i=0;i<101;i++)
			{
				if(IsPlayerConnected(i)==1)
				{
					if(SL[i]==1)
					{
						if(playercall[i]==id)
						{
							format(msg,128,"���Ͷ��ŵ�����{FF00FF}[%d]{FFC0CB}����:{FF00FF}%s{FFC0CB},������һ��Ǯ",id,tmp);
							SendClientMessage(playerid,0xFFC0CBFF,msg);
							format(msg,128,"[����]{FF00FF}[����:%d]{FFC0CB}����:{FF00FF}%s{FFC0CB}",playercall[playerid],tmp);
							SendClientMessage(i,0xFFC0CBFF,msg);
							playercallmoney[playerid]=playercallmoney[playerid]-1;
							return 1;
						}
					}
				}
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲦��ĵ绰�����ǿպ�!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/pay")==0)
	{
		if(SL[playerid]==1)
		{
				new	tmp[128],id,money;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/pay [���id] [Ǯ��]");
					return 1;
				}
				id=strval(tmp);
				if(id==playerid)
				{
					SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�Ǯ!");
					return 1;
				}
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(3,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�������̫Զ��");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"Ǯ������Ϊ��");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�������Ǯ?~~");
					return 1;
				}
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û����ô��Ǯ��?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]-money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playermoney[id]=playermoney[id]+money;
				ResetPlayerMoney(id);
				GivePlayerMoney(id,playermoney[id]);
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"%s������$%d!",name,money);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"�����%s$%d!",name1,money);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s����[ID:%d]%s$%d",playerid,name,id,name1,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
//=======================================================����ϵͳ��Ǯ====================
	if(strcmp(cmd,"/cunkuan")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 2316.616699,-15.422499,26.742187)==1)
			{
				new	tmp[128],money;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/cunkuan [��������] [Ǯ��]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"Ǯ������Ϊ��");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����渺Ǯ?~~");
					return 1;
				}
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û����ô��Ǯ��?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]-money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]+money;
				new	msg[128],name[128];
				format(msg,128,"�����Ǯ$%d!",money);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s����Ǯ$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//------------------------------------------------------����ϵͳȡǮ
	if(strcmp(cmd,"/qukuan")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 2316.620605,-7.301870,26.742187)==1)
			{
				new	tmp[128],money;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/qukuan	[��������] [Ǯ��]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"Ǯ������Ϊ��");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����渺Ǯ?~~");
					return 1;
				}
				if(playerbank[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û����ô��Ǯ��?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]+money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]-money;
				new	msg[128],name[128];
				format(msg,128,"��ȡ��Ǯ$%d!",money);
				format(msg,128,"[ID:%d]%sȡ��Ǯ$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//------------------------------------------------------ATMϵͳȡǮ
	if(strcmp(cmd,"/atmqk")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 374.664916,167.774246,1008.382812)==1)
			{
				new	tmp[128],money;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/atmqk	[��������] [Ǯ��]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"Ǯ������Ϊ��");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����渺Ǯ?~~");
					return 1;
				}
				if(playerbank[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û����ô��Ǯ��?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]+money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]-money;
				new	msg[128],name[128];
				format(msg,128,"[ATM����]:��ȡ��Ǯ$%d!",money);
				format(msg,128,"[ID:%d]%sʹ��ATM����ȡ��Ǯ$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻��ATM������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//======================================================[������]--------------------------------
/*if(strcmp(cmd,"/pinvgun")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==3)
			{
					new	tmp[128],id,wuqi;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/pinvgun [���id] [����]");
						return 1;
					}
					id=strval(tmp);
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�����!");
						return 1;
					}
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(3,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�������̫Զ��");
						return 1;
					}
					if(playerinvwuqi[playerid][id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"��������û���κ�����!");
						return 1;
					}
					if(id<0||id>6)
					{
						SendClientMessage(playerid,0x00FF00AA,"��������������(0-6)");
						return 1;
					}
					new	PlayerWeapons[128];
					PlayerWeapons[playerid]=PlayerWeapons[playerid]-wuqi;
					PlayerWeapons[id]=PlayerWeapons[id]+wuqi;
					new	msg[128],name[128],name1[128];
					GetPlayerName(playerid,name,128);
					GetPlayerName(id,name1,128);
					format(msg,128,"%s������һ������!",name);
					SendClientMessage(id,0x00FF00AA,msg);
					format(msg,128,"�����%sһ������!",name1);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"[ID:%d]%s����[ID:%d]%sһ������",playerid,name,id,name1);
					ABroadCast(0x00FF00AA,msg,1);
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻����������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}*/
//======================================================[������]----------------------------------
	if(strcmp(cmd,"/paycl")==0)
	{
		if(SL[playerid]==1)
		{
				new	tmp[128],id,mats;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/paycl [���id]	[����]");
					return 1;
				}
				id=strval(tmp);
				if(id==playerid)
				{
					SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�����!�벻Ҫ����!");
					return 1;
				}
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(3,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�������̫Զ��");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��������Ϊ��");
					return 1;
				}
				mats=strval(tmp);
				if(mats<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����������?~~");
					return 1;
				}
				if(playermats[playerid]<mats)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û����ô����ϰ�?");
					return 1;
				}
				playermats[playerid]=playermats[playerid]-mats;
				playermats[id]=playermats[id]+mats;
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"%s���������,����:%d!",name,mats);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"�����%s����,����:%d!",name1,mats);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s����[ID:%d]%s����,����:%d",playerid,name,id,name1,mats);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/fuel")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���");
				return 1;
			}
			new	msg[128];
			format(msg,128,"��ǰ��������:%d",carfill[vid]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/buycarzhizhao")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(2,playerid,-2033.082397, -117.279785,1035.171875)==1)
			{
				if(playermoney[playerid]<2500)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ����ִ�չ�����!(2500)");
					return 1;
				}
				if(playercarzhizhao[playerid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ѿ��м�ʻִ����!");
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"���ú���ļ�ʻִ��!");
				playermoney[playerid]=playermoney[playerid]-2500;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playercarzhizhao[playerid]=1;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻��ִ������");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/showzhizhao")==0)
	{
		if(SL[playerid]==1)
		{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/showzhizhao [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[128],name[128];
				if(id==playerid)
				{
					SendClientMessage(playerid,0x008040FF,"______|��ӵ�е�ִ��|______");
					format(msg,128,"����ִ��:%s",tg[playergunzhizhao[playerid]]);
					SendClientMessage(playerid,0x708090AA,msg);
					format(msg,128,"��ʻִ��:%s",tg[playercarzhizhao[playerid]]);
					SendClientMessage(playerid,0x708090AA,msg);
					SendClientMessage(playerid,0x008040FF,"----------------------------------------");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(5,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x708090AA,"�������̫Զ��..");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s����չʾ����ӵ�е�ִ��",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"______|%sӵ�е�ִ��|______",name);
				SendClientMessage(id,0x008040FF,msg);
				format(msg,128,"����ִ��:%s",tg[playergunzhizhao[playerid]]);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"��ʻִ��:%s",tg[playercarzhizhao[playerid]]);
				SendClientMessage(id,0x708090AA,msg);
				SendClientMessage(id,0x008040FF,"----------------------------------------");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
 //=======================================================================================
	if(strcmp(cmd,"/showsfz")==0)
	{
		if(SL[playerid]==1)
		{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/showsfz [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[128],name[128];
				if(id==playerid)
				{
					SendClientMessage(playerid,0x008040FF,"______|�������֤|______");
					format(msg,128,"���֤���:%d",playersfz[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					format(msg,128,"����:%d",playerage[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					format(msg,128,"�Ա�:%d",playersex[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					SendClientMessage(playerid,0x008040FF,"----------------------------------------");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(5,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x708090AA,"�������̫Զ��..");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s ����չʾ�������������֤.",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"______|%s���������֤|______",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"���֤���:%d",playersfz[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				format(msg,128,"����:%d",playerage[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				format(msg,128,"�Ա�:%d",playersex[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				SendClientMessage(id,0x008040FF,"----------------------------------------");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	//======================================================================================
//----------------------------------------------------------------------------------------
	if(strcmp(cmd,"/delswat")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(playerzuzhilv[playerid]==4||playerzuzhilv[playerid]==5)
				{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/delswat [���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
						return 1;
					}
					if(playerzuzhi[id]!=3)
					{
						SendClientMessage(playerid,0x00FF00AA,"����Ҳ��Ǿ���");
						return 1;
					}
					if(swat[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����Ҳ���swat");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[swat]%s��%s������swat!",name,name1);
					AdminXX(3,msg,0xFAF0E6FF);
					format(msg,128,"�㳷����%s��swat",name);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"�㱻%s������swat",name1);
					SendClientMessage(id,0x00FF00AA,msg);
					ResetPlayerWeaponEx(id);
					for(new	i=0;i<7;i++)
					{
						playerwuqi[id][i]=0;
					}
					SetPlayerArmour(id,0);
					swat[id]=0;
					duty[id]=0;
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setswat")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(playerzuzhilv[playerid]==4||playerzuzhilv[playerid]==5)
				{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/setswat [���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
						return 1;
					}
					if(playerzuzhi[id]!=3)
					{
						SendClientMessage(playerid,0x00FF00AA,"����Ҳ��Ǿ���");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[swat]%s��%s��Ȩ��swat!",name,name1);
					AdminXX(3,msg,0xFAF0E6FF);
					format(msg,128,"����Ȩ��%sΪswat",name);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"�㱻%s��Ȩ��swat",name1);
					SendClientMessage(id,0x00FF00AA,msg);
					SetPlayerHealth(id,100);
					SetPlayerArmour(id,0);
					for(new	i=0;i<7;i++)
					{
						playerwuqi[id][i]=0;
					}
					ResetPlayerWeaponEx(id);
					swat[id]=1;
					duty[id]=0;
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/m")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
				if(duty[playerid]==1)
				{
						new	tmp[128],msg[128],name[128],Float:x,Float:y,Float:z;
						tmp=strtokp(cmdtext,idx);
						if(strcmp(tmp,"	")==0)
						{
							SendClientMessage(playerid,0x00FF00AA,"�÷�:/m [����]");
							return 1;
						}
						GetPlayerName(playerid,name,128);
						format(msg,128,"[>%s<%s:%s]",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
						GetPlayerPos(playerid,x,y,z);
						for(new	i=0;i<101;i++)
						{
							if(IsPlayerConnected(playerid)==1)
							{
								if(IsPlayerConnected(i)==1)
								{
									if(XY(50,i,x,y,z)==1)
									{
										SendClientMessage(i, 0xFFD700FF,msg);
									}
								}
							}
						}
						return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��������");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/admins")==0)
	{
		if(SL[playerid]==1)
		{
			new	str[2][32];
			format(str[0],128,"����");
			format(str[1],128,"�ϰ�");
			SendClientMessage(playerid,	0x008040FF,"|__________|�ҵ��й���Ŀǰ���߹���Ա|__________|");
			new	msg[128],name[128];
			for(new	i=0;i<101;i++)
			{
				if(IsPlayerConnected(i)==1)
				{
					if(SL[i]==1)
					{
						if(playeradmin[i]>=1)
						{
							GetPlayerName(i,name,128);
							format(msg,128,"[ĿǰID]:%d [����]:%s [�ȼ�]:%d [״̬]:%s",i,name,playeradmin[i],str[adminduty[i]]);
							SendClientMessage(playerid,	0xB0C4DEAA,msg);
						}
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xczb")==0)
	{
		if(SL[playerid]==1)
		{
		if(XY(3,playerid, -2547.148925,2300.347900,4.984375)==1)
		{
		//-2240.870361 2321.937255 7.545368
			if(playerzuzhi[playerid]== 0&&playerzuzhilv[playerid]>=1)
			{
					SendClientMessage(playerid,0x00FF00AA,"*** �����������װ���䣬�ó��˷����ºͷ���װ�� ***");
					SetPlayerHealth(playerid,100);
					SetPlayerArmour(playerid,100);
					GivePlayerWeaponEx(playerid,10,1111111111111111111);
					GivePlayerWeaponEx(playerid,1,1111111111111111111);
					return 1;
			}
	    	SendClientMessage(playerid,0x00FF00AA,"�Բ�������������ί���Ա���Ǹ߼������޷�����������ȨŶ��");
  	    	SendClientMessage(playerid,0x00FF00AA,"ע����ͨ����ί���Ա���Ҿ�ί��᳤����Ŷ��Ŭ���ɰɣ�");
		}
		SendClientMessage(playerid,0x00FF00AA,"�㲻��װ����ȡ�㣡");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/adminduty")==0)
	{
		new	string[64];
		new	sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				if(adminduty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"*** ���ϰ��� ***");
					SetPlayerColor(playerid,0xFF66FF00);
					SetPlayerHealth(playerid,100);
					SetPlayerArmour(playerid,100);
					adminduty[playerid]=1;
					format(string, sizeof(string),"[������]: ����Ա %s ������ֵ�����״̬", sendername);
					ABroadCast(COLOR_LIGHTRED, string, 1);
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"*** ���°��� ***");
				format(string, sizeof(string),"[������]: ����Ա %s �������°����״̬", sendername);
				ABroadCast(COLOR_LIGHTRED, string, 1);
				SetPlayerColor(playerid,COLOR_WHITE);
				adminduty[playerid]=0;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
			return 1;
		}
		return 1;
	}
	if(strcmp(cmd,"/duty")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==5||playerzuzhi[playerid]==4||playerzuzhi[playerid]==3  || playerzuzhi[playerid]==14)
			{
				if(XY(2,playerid,255.083709,76.984054,1003.640625)==1||XY(2,playerid,297.6051,186.0040,1007.1719)==1||XY(2,playerid,376.8839,188.4995,1008.3893)==1||XY(3,playerid,-532.839294,-506.109527,25.517845)==1||XY(3,playerid,-545.311340,-504.001953,25.523437)==1)
				{
					if(swat[playerid]==1&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=3;
						playerwuqi[playerid][1]=24;
						playerwuqi[playerid][2]=27;
						playerwuqi[playerid][3]=29;
						playerwuqi[playerid][4]=31;
						playerwuqi[playerid][5]=17;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,285);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==0&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=25;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==1&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=25;
						playerwuqi[playerid][4]=29;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==2&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=25;
						playerwuqi[playerid][4]=29;
						playerwuqi[playerid][5]=31;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==3&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=25;
						playerwuqi[playerid][4]=29;
						playerwuqi[playerid][5]=31;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==4&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=27;
						playerwuqi[playerid][4]=29;
						playerwuqi[playerid][5]=31;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					if(playerzuzhilv[playerid]==5&&duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"** ���ϰ��� **");
						SetPlayerHealth(playerid,100);
						SetPlayerArmour(playerid,100);
						playerwuqi[playerid][0]=41;
						playerwuqi[playerid][1]=3;
						playerwuqi[playerid][2]=24;
						playerwuqi[playerid][3]=27;
						playerwuqi[playerid][4]=29;
						playerwuqi[playerid][5]=31;
						ResetPlayerWeaponEx(playerid);
						for(new	i=0;i<7;i++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
						}
						SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
						duty[playerid]=1;
						return 1;
					}
					SendClientMessage(playerid,0x00FF00AA,"** ���°��� **");
					SetPlayerHealth(playerid,100);
					SetPlayerArmour(playerid,0);
					for(new	i=0;i<7;i++)
					{
						playerwuqi[playerid][i]=0;
					}
					ResetPlayerWeaponEx(playerid);
					for(new	i=0;i<7;i++)
					{
						GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
					}
					SetPlayerSkin(playerid,playerskin[playerid]);
					duty[playerid]=0;
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڴ������!");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�����֯��������Ҫ�ϰ�!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/takegun")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128],id;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�:/takegun	[���������(0-6)]");
				return 1;
			}
			id=strval(tmp);
			if(playerzuzhi[playerid]==5||playerzuzhi[playerid]==4||playerzuzhi[playerid]==3|| playerzuzhi[playerid]==14&&duty[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"�����ϰ��ڼ䲻����ʹ�������ֿ�!");
				return 1;
			}
			if(id<0||id>6)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������������(0-6)");
				return 1;
			}
			if(playerinvwuqi[playerid][id]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������û���κ�����!");
				return 1;
			}
			for(new	w=0;w<7;w++)
			{
				if(playerwuqi[playerid][w]==0||playerwuqi[playerid][w]==playerinvwuqi[playerid][id])
				{
					playerwuqi[playerid][w]=playerinvwuqi[playerid][id];
					playerinvwuqi[playerid][id]=0;
					ResetPlayerWeaponEx(playerid);
					for(new	i=0;i<7;i++)
					{
						GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],1111111111111111111);
					}
					return 1;
				}
			}
			SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/putgun")==0)
	{
		if(SL[playerid]==1)
		{
			new	wid;
			if(playerzuzhi[playerid]==3&&duty[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"������������ֿ�!");
				return 1;
			}
			new	pd=10;
			wid=GetPlayerWeapon(playerid);
			for(new	i=0;i<7;i++)
			{
				if(playerwuqi[playerid][i]==wid)
				{
					pd=i;
					i=10;
				}
			}
			for(new	i=0;i<7;i++)
			{
				if(playerinvwuqi[playerid][i]==0||playerinvwuqi[playerid][i]==playerwuqi[playerid][pd])
				{
					playerinvwuqi[playerid][i]=playerwuqi[playerid][pd];
					playerwuqi[playerid][pd]=0;
					ResetPlayerWeaponEx(playerid);
					for(new	w=0;w<7;w++)
					{
						GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111111111111);
					}
					return 1;
				}
			}
			SendClientMessage(playerid,0x00FF00AA,"��������ֿ��Ѿ�����!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/inv")==0)
	{
		if(SL[playerid]==1)
		{
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"|_____________|%s�������ֿ�|_____________|",name);
			SendClientMessage(playerid,0x008040FF,msg);
			for(new	i=0;i<7;i++)
			{
			new wqname[32];
		 	GetWeaponName(playerinvwuqi[playerid][i],wqname[i],sizeof(wqname));
				format(msg,128,"[%d��������]:����ID:%d��������:%s",i,playerinvwuqi[playerid][i],wqname[i]);
				SendClientMessage(playerid,0xCECECEFF,msg);
			}
			SendClientMessage(playerid,0xCECECEFF,"����/putgun ����,����/takegun ������IDȡ��");
			SendClientMessage(playerid,0x008040FF,"======================================================");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//--------------------------------------VIP
	if(strcmp(cmd,"/buyvip")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 362.214172,173.700363,1008.382812)==1)
			{
		        if(playervdou[playerid]<10)
	        	{
		            SendClientMessage(playerid,0xDC143CAA,"�Բ���~���V��������VIP��!");
		        	return 1;
	        	}
		        if(playerviplv[playerid]!=0)
	        	{
		            SendClientMessage(playerid,0xDC143CAA,"�Բ���~���Ѿ���VIP�ˣ������ٹ�����Ŷ��");
		        	return 1;
	        	}
					new ak[128],name[128];
				    playervdou[playerid]=playervdou[playerid]-10;
				    playerviplv[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW,"* ��ɹ�������VIP����Ϊ��VIP1�û�������~~");
			        GetPlayerName(playerid,name,128);
				    format(ak,128,"[VIP��Ϣ]%sʹ����10V������Ϊ�������ޱȵ�VIP1����",name);
				    SendClientMessageToAll(0xFFFACDAA,ak);
				    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻��VIP��Ա�����!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/vipcd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerviplv[playerid]!=0)
			{
			    SetPVarInt(playerid, "neon", 1);
   				SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
   				SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
       			AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			    SendClientMessage(playerid,COLOR_YELLOW,"* �����޺�ƣ���ɫ���Ѿ���װ��ϣ�");
  			    return 1;
			}
	     	SendClientMessage(playerid,0x00FF00AA,"��û���㹻��VIP�ȼ���");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}

	if(strcmp(cmd,"/delcd")==0)
	{
		if(SL[playerid]==1)
		{
	   			DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
			    SendClientMessage(playerid,COLOR_YELLOW,"* �����޺���Ѿ��ɹ�������");
			    return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//--------------------------------------------------
//--------------------------------------�ӹ���
	if(strcmp(cmd,"/jgz")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 362.214172,173.700363,1008.382812)==1)
			{
				ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"�����б�","1.��ȥ����\n2.������˽(BUG)\n3.��̽\n4.��������\n5.����������\n6.����վ����Ա\n7.���⳵˾��","��ְ","ȡ��");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"�㲻���칤����!");
			return 1;

		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	//--------------------------------------�������֤
	if(strcmp(cmd,"/bsfz")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 358.342102,164.751647,1008.382812)==1)
			{
				ShowPlayerDialog(playerid,8912,DIALOG_STYLE_LIST,"�ҵ��й������������ - ���֤����ϵͳ","�������֤(��Ҫ����500������)","ȷ�ϰ���","ȡ������");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"�㲻����ݰ����!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//--------------------------------------------------
	if(strcmp(cmd,"/zuogun")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==3)
			{
				ShowPlayerDialog(playerid,100,DIALOG_STYLE_LIST,"�����嵥","С��(125)\nɳӥ(180)\nɢ��(220)\nMP5(350)\nM4A1(560)\nAK47(560)","����","ȡ��");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��Ĳ��ϲ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"�㲻����������!");
		return 1;
	}
	if(strcmp(cmd,"/ao")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ao	[����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[AOOC]����Ա{90FFAA}[%s]˵:{1493FF}%s{1493FF}",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//--------------------------------����ָ��
	if(strcmp(cmd,"/news")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==1)
			{
			if(XY(3,playerid, -2187.459228,2416.550292,5.165121)==1)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/news	[��������]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[����]����%s ����:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�ڵ�̨��");
			return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǽ��ߣ��޷�������Ϣ!");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/ndt")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==1)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ndt	[��̨����]");
					return 1;
				}
					new	vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�����Ų�����/�ɻ���!");
						return 1;
					}
					if(mod!=582&&mod!=488&&mod!=609&&mod!=560)
					{
						SendClientMessage(playerid,0x00FF00AA,"�ⲿ����/�ɻ���û�����ߵ�̨!");
						return 1;
					}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[�й������ߵ�̨]����%s ����:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/nad")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==1)
			{
			if(XY(3,playerid, -2187.459228,2416.550292,5.165121)==1)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/nad	[��������]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[���]%s ������Ϣ:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�ڵ�̨��");
			return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǽ��ߣ��޷�������Ϣ!");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//-----------------------------------------------------------
	/*if(strcmp(cmd,"/admin")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3333)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/admin [����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"*ǰ̨����Ա:%s",tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}*/
/*	if(strcmp(cmd,"/nx")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerlv[playerid]==1||playerlv[playerid]==2)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/nx	[����]");
					return 1;
				}
				if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"��ȴ�10����ٷ�����������~��");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[����Ƶ��]:	%s˵:%s",name,tmp);
				SendClientMessageToAll(0x008040FF,msg);
				askqtime[playerid]=10;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻������!(1~2��)");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}*/
	if(strcmp(cmd,"/nf")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==4)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/nf	[����]");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"��ȴ�5����ٷ���Ƶ����Ϣ~��");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[FBIƵ��]: %s˵:%s",name,tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/nn")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/nn	[����]");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"��ȴ�5����ٷ���Ƶ����Ϣ~��");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[����Ƶ��]:	%s˵:%s",name,tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/aad")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 4)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/aad	[����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin���]:%s",tmp);
				SendClientMessageToAll(0xFFFF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/reloadbans")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>=3333)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�Ѿ�ˢ�·���б�.");
			    SendRconCommand("reloadbans");
		    return 1;
		    }
	    SendClientMessage(playerid,	 0xDC143CAA, "�Բ��������ǹ���Ա���޷�ʹ�ô˹��ܣ�");
		}
        SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
	    return 1;
	}
	if(strcmp(cmd,"/agov")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 4)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/agov	[����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin����]:%s",tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/ahd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 4)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ahd	[����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin�֪ͨ]:%s",tmp);
				SendClientMessageToAll(0xFF00EE00,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//===========================������================================
	if(strcmp(cmd,"/rqq1go1")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 200.3100, 1);
			SendClientMessage(playerid,COLOR_YELLOW,"1���������������");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go2")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 200.3100, 1.5);
			SendClientMessage(playerid,COLOR_YELLOW,"1���������������Ŀ�꣺���ֻ�����");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go2speed")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 200.3100, 99);
			SendClientMessage(playerid,COLOR_YELLOW,"1���������������Ŀ�꣺���ֻ�����");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go3")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 13.546875, 1);
			SendClientMessage(playerid,COLOR_YELLOW,"1��������ͣ������Ŀ�꣺���ֻ�����");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1back")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 11.3100, 1);
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1backspeed")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 11.3100, 99);
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
	  return 1;
	}
//=================================�Դ�MSG����===========================
	if(strcmp(cmd,"/msgy")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
        new	tmp[128];
	    tmp=strtokp(cmdtext,idx);
	    new	msg[128];
	    format(msg,128,"%s",tmp);
	    SendClientMessageToAll(0xFFFF00AA,msg);
	    return 1;
	  }
	SendClientMessage(playerid,0x00FF00AA,"��û�з���MSG��Ϣ��Ȩ��Ŷ~");
	return 1;
	}
	if(strcmp(cmd,"/payday")==0)
	{
      if(playeradmin[playerid]>= 1338)
	  {
        sjd();
	    return 1;
	  }
	SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��Ŷ~");
	return 1;
	}
//==================================���нű�=================================
/*if(strcmp(cmd,"/fx")==0)
{
	if(playeradmin[playerid]>= 3333)

	{
	    StartFly(playerid);
        SendClientMessage(playerid,COLOR_YELLOW2,"==================================================================");
	    SendClientMessage(playerid,COLOR_YELLOW2,"ʹ��˵��:");
	    SendClientMessage(playerid,COLOR_YELLOW2,"ʹ��Wǰ��(û�к���)���������������Ҽ��½����ո���٣���");
	    SendClientMessage(playerid,COLOR_YELLOW2,"��������ˣ���������/exitfxֹͣ����Ŷ��");
	    return 1;
	}
	    SendClientMessage(playerid,COLOR_YELLOW2,"�Բ�����û��Ȩ��Ŷ��");

}
if(strcmp(cmd,"/exitfx")==0)
	{
	    StopFly(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW2,"��ɹ�ͣ������������ɵĻ�������/fx�ɣ�");

	    return 1;
	}*/
//===========================MP3����=======================
if(strcmp(cmd,"/music")==0)
	{
	if(SL[playerid]==1)
	{
	ShowPlayerDialog(playerid,6700,DIALOG_STYLE_LIST,"����ϵͳ����","ֹͣ����\nURL����","ȷ��","ȡ��");
	    return 1;
		}
 SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
 return 1;
	}
if(strcmp(cmd,"/stopmusic")==0)
	{
	if(SL[playerid]==1)
	{
        StopAudioStreamForPlayer(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW,"����������Ϣ�����ֳɹ�ͣ������~");

	    return 1;
		}
 SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
 return 1;
	}
//================================ˢͼ==================
if(strcmp(cmd,"/gmx")==0)
	{
	if(SL[playerid]==1)
	{
		if(playeradmin[playerid]>=3333)
		{
		new ak[128],name[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"����������Ϣ������Ա%s�������������ˣ�",name);
		SendClientMessageToAll(0xFFFACDAA,ak);
		format(ak,128,"���ڣ����Եȼ�����Ŷ�����Ͼ������½�����Ϸ�ģ�",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    SendRconCommand("gmx");
	    return 1;
	    }
    SendClientMessage(playerid,	 0xDC143CAA, "�Բ��������ǹ���Ա���޷�ʹ�ô˹��ܣ�");
	}
 SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
 return 1;
	}
//================================�鿴������Ϣ===========================
	/*if(strcmp(cmd,"/jike")==0)
	{
		if(SL[playerid]==1)
		{
        new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"==============================�ҵļ��ʶ�===========================");
			format(msg,256,"�𾴵�:%s �����ڵļ�������:%d �ڿʶ���:%d",playername[playerid],playerjiedu[playerid],playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
    	}
  SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
		return 1;
	}
*/
//==================================��ʳƷ===============================
	/*if(strcmp(cmd,"/buyfood")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2540.971923,2267.912597,5.026381)==1)
			{
				ShowPlayerDialog(playerid,6667,DIALOG_STYLE_LIST,"ʳƷ�б�","1.VFCȫ��Ͱ+40($100)\n2.��԰���ȱ�+2($20)\n3.����ѩ��+30($100)","����","ȡ��");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڷ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/eatfood")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2540.971923,2267.912597,5.026381)==1)
			{
				ShowPlayerDialog(playerid,6668,DIALOG_STYLE_LIST,"ʳƷ�б�","1.������+1($10)\n2.��԰���ȱ�+2($20)\n3.ѩ��+1($5)\n4.�ͷ�ȫ��Ͱ+30($100)\n5.����װѩ��+30($100)","����","ȡ��");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڷ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/eats")==0)
	{
		if(SL[playerid]==1)
		{
                new list[256];
		    	format(list,256,"1.VFCȫ��Ͱ(%d)\n2.��԰���ȱ�(%d)\n3.����ѩ��(%d)",food3[playerid],food1[playerid],food2[playerid]);
				ShowPlayerDialog(playerid,6669,DIALOG_STYLE_LIST,"ʳƷ�ֿ�",list,"ʹ��","ȡ��");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}*/
//===============================EW����==================================
if(strcmp(cmd,"/xzon")==0)
	{
		if(SL[playerid]==1)
		{
		if(playeradmin[playerid]<3333)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~�����ǹ���Ա��û�취����Ŷ��");
			return 1;
		}
		new name[128],ak[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"����������Ϣ������Ա%s��С������ͨ�����ˣ�",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    	SendClientMessage(playerid,COLOR_BLUE,"* �𾴵Ĺ���Ա:������С������ͨ��");
            DestroyDynamicObject(ewmen1);
            DestroyDynamicObject(ewmen2);
            DestroyDynamicObject(xzmen1);
            DestroyDynamicObject(xzmen2);
            DestroyDynamicObject(xzmen3);
		    return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
if(strcmp(cmd,"/xzoff")==0)
	{
		if(SL[playerid]==1)
		{
		if(playeradmin[playerid]<3333)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~�����ǹ���Ա��û�취����Ŷ��");
			return 1;
		}
		new name[128],ak[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"����������Ϣ������Ա%s��С������ͨ���ر��ˣ�",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    	SendClientMessage(playerid,COLOR_BLUE,"* �𾴵Ĺ���Ա:���ر���С������ͨ��");
            DestroyDynamicObject(ewmen1);
            DestroyDynamicObject(ewmen2);
            DestroyDynamicObject(xzmen1);
            DestroyDynamicObject(xzmen2);
            DestroyDynamicObject(xzmen3);
		ewmen1=CreateDynamicObject(987,-2692.8030, 2399.5242, 59.0000,	0, 0,     165.2742);
		ewmen2=CreateDynamicObject(987,-2681.7197, 2396.6272, 59.0000,	0, 0,     165.2742);
		xzmen1=CreateDynamicObject(972,-2694.5400, 2388.7021, 61.3394,	0, 0,     76.2763);
		xzmen2=CreateDynamicObject(972,-2694.5400, 2388.7021, 68.2381,	0, 0,     76.2763);
		xzmen3=CreateDynamicObject(981,-2514.80, 2436.41, 16.71,   0.00, 0.00, 42.59);

		    return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//==================================����ϵͳ==============================
if(strcmp(cmd,"/jg")==0)
{
	if(SL[playerid]==1)
	{
	    if(playerviplv[playerid]!=0)
	    {
                SetPVarInt(playerid, "laser", 0);
                RemovePlayerAttachedObject(playerid, 0);
                SetPVarInt(playerid, "laser", 1);
                SetPVarInt(playerid, "color", GetPVarInt(playerid, "color"));
	        ShowPlayerDialog(playerid,6670,DIALOG_STYLE_LIST,"����ϵͳ ѡ����ɫ","��ɫ\n��ɫ\n�ۺ�ɫ\n��ɫ\n��ɫ\n��ɫ\nж�ؼ���","ʹ��","ȡ��");
    	    return 1;
    	}
    SendClientMessage(playerid,COLOR_YELLOW,"�Բ���������VIP������ʹ�ñ�����Ŷ��");
	return 1;
	}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}
//==============================NOS=======================================
if(strcmp(cmd,"/noshelp")==0)
	{
		if(SL[playerid]==1)
		{
	SendClientMessage(playerid,	0x008040FF," ==================================������ʹ�ð���=======================");
    SendClientMessage(playerid,	0xCECECEFF," ע��ʹ�ü���������Ҫ�ڳ���Ŷ�����Ҽ��������ܰ�װ��Ħ�к�һЩ���⳵����Ŷ��");
    SendClientMessage(playerid,	0xCECECEFF," /nos2x[��װ2������] /nos5x[��װ5������] /nos10x[��װ10������]");
    SendClientMessage(playerid,	0xCECECEFF," /supernos[��װ����������] �������ϳ��Զ���װ10XN2O,20���Զ����䵪��(��������)");
    SendClientMessage(playerid,	0xCECECEFF," ע��:���������ˢ�£�N2OҲ����ʧŶ~������úñ���~");
    SendClientMessage(playerid,	0xCECECEFF," �շѱ�׼:2��:500 5��:1000 10��:2000");
    SendClientMessage(playerid,	0x008040FF,"========================================================================");
				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}

   if(strcmp(cmd, "/nos10x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
		if(playermoney[playerid]<2000)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~���Ǯ����װN2O��!�ܹ���������(2000)");
		    SendClientMessage(playerid,0xDC143CAA,"[��ʾ]���������/jcys������������׬ǮŶ��");
			return 1;
		}
		 	if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
   			playermoney[playerid]=playermoney[playerid]-2000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[������Ϣ]%s�ɹ�ΪTA�İ�����װ��10��N2O�����Ҳ���԰�~(/noshelp�鿴����������)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS��װ���!");
			return 1;
	}
   if(strcmp(cmd, "/nos5x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
		if(playermoney[playerid]<1000)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~���Ǯ����װN2O��!�ܹ���������(1000)");
		    SendClientMessage(playerid,0xDC143CAA,"��ʾ]���������/jcys������������׬ǮŶ��");
			return 1;
		}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1008);
   			playermoney[playerid]=playermoney[playerid]-1000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[������Ϣ]%s�ɹ�ΪTA�İ�����װ��5��N2O�����Ҳ���԰�~(/noshelp�鿴����������)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS��װ���!");
			return 1;
	}
   if(strcmp(cmd, "/nos2x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
		if(playermoney[playerid]<500)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~���Ǯ����װN2O��!�ܹ���������(500)");
		    SendClientMessage(playerid,0xDC143CAA,"[��ʾ]���������/jcys������������׬ǮŶ��");
			return 1;
		}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1009);
   			playermoney[playerid]=playermoney[playerid]-500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[������Ϣ]%s�ɹ�ΪTA�İ�����װ��2��N2O�����Ҳ���԰�~(/noshelp�鿴����������)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS��װ���!");
			return 1;
	}
   if(strcmp(cmd, "/supernos", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
		if(playermoney[playerid]<500)
		{
		    SendClientMessage(playerid,0xDC143CAA,"�Բ���~���Ǯ����װ����N2O��!�ܹ���������(50000)");
		    SendClientMessage(playerid,0xDC143CAA,"[��ʾ]���������/jcys������������׬ǮŶ��");
			return 1;
		}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
		   NOSTimer[playerid] = SetTimerEx("NOS",20000,1,"d",playerid);
   				SNOS[playerid] = 1;
			playersupernos[playerid]=1;
   			playermoney[playerid]=playermoney[playerid]-500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[������Ϣ]%s�ɹ�ΪTA�İ�����װ�˳���N2O�����Ҳ���԰�~(/noshelp�鿴����������)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS��װ���!");
			return 1;
	}
//=======================================================================
	if(strcmp(cmd,"/ad")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2187.459228,2416.550292,5.165121)==1)
			{
				new	tmp[128],name[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ad	[�������]");
					return 1;
				}
				if(playermoney[playerid]<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ����1500Ԫ!������/888�Ҽ��߲���棬Ҳ���շѸ��ͣ�");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"��ȴ�60����ٷ��͹��~��");
return 1;
}
				GetPlayerName(playerid,name,128);
				playermoney[playerid]=playermoney[playerid]-1500;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				new	msg[128];
				format(msg,128,"[���]%s,�绰:{FF00FF}%d{FFC0CB}",tmp,playercall[playerid]);
				SendClientMessageToAll(0xFFFF00AA,msg);
				askqtime[playerid]=60;
    return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"�㲻�ڴ�ý̨��淢����!");

			return 1;
		}
			SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	/*if(strcmp(cmd,"/net")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid,349.736206,193.539978,1014.179687)==0)
			{
				new	tmp[128],name[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/net [��Ϣ����]");
					return 1;
				}
				if(playermoney[playerid]<10)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ����500Ԫ!");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"��ȴ�5����ٷ���������Ϣ~��");
return 1;
}
    GetPlayerName(playerid,name,128);
				playermoney[playerid]=playermoney[playerid]-150;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				new	msg[128];
				format(msg,128,"[����] %s˵:%s",name,tmp);
				SendClientMessageToAll(0x6495EDFF,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"�㲻�������ϻ���!");
		return 1;
	}*/
	if(strcmp(cmd,"/buygunzhizhao")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(1.5,playerid,	249.660354 ,67.795783, 1003.640625)==1)
			{
				if(playergunzhizhao[playerid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ա:���Ѿ���ִ����!�벻Ҫˣ��!!");
					return 1;
				}
				if(playermoney[playerid]<10000)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ա:���Ǯ��������ִ�յĹ�����!���˾Ͳ�Ҫ��ǹ�(10000)");
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"��Ա:���ú��������ִ��^_^!");
				playergunzhizhao[playerid]=1;
				playermoney[playerid]=playermoney[playerid]-10000;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻������ִ�����۴�!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/stofind")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==5||playerzuzhi[playerid]==14||playerzuzhi[playerid]==15)
			{
				if(tofind[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ŀǰû��׷���κ�һ�����!");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				jcys[playerid]=0;
				tofind[playerid]=0;
				DisablePlayerCheckpoint(playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//=============================jetpack=====================
    if(strcmp(cmd,"/hjfx")==0)
	{
	    new	Float:x,Float:y,Float:z;
	    GetPlayerPos(playerid,x,y,z);
	    CreateDynamicObject(370,x,y,z,0,0,0);
	    playermoney[playerid]=playermoney[playerid]-10000;
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid,playermoney[playerid]);
	    SendClientMessage(playerid,	COLOR_LIGHTBLUE, "����������Ѿ����͵��������~�߶�һ�¾��ܿ�����Ŷ~������ȡ����10000��");
	    return 1;
	}
//--------------------------------=[Roadblock]=-----------------------------------
	if(strcmp(cmd, "/rb", true) ==	0 || strcmp(cmd, "/createroadblock", true) == 0)
	{
		new	tmp[128];
		new	string[128];
		new msg[128];
		new	sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(IsPlayerConnected(playerid) && playerzuzhi[playerid]==3 || playeradmin[playerid]>=1 || playerzuzhi[playerid]==4 || playerzuzhi[playerid]==14)
		{
			tmp	= strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,	COLOR_WHITE, "�÷�:	/rb [·�ϱ��]");
				SendClientMessage(playerid,	COLOR_LIGHTBLUE, "����·��:");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	1: С·�� |	2: ����·��	|");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	3: ����·��	| 4: ��ͨ׶	| 5: ���б�־ |");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	6: ��ֹͨ�еı�־ |	7: �رձ�־�� |");
				return 1;
			}
			new	rb = strval(tmp);
			if (rb == 1)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(1459,plocx,plocy,plocz,ploca);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷�����·��(1), ���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					ABroadCast(0x00FF00AA,msg,1);
     GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
					return 1;
			}
			else if	(rb	== 2)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(978,plocx,plocy,plocz+0.6,ploca);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷�����·��(2), ���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Roadblock ~b~Placed!",3000,1);
					return 1;
			}
			else if	(rb	== 3)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(981,plocx,plocy,plocz+0.9,ploca+180);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷�����·��(3), ���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Roadblock ~g~Placed!",3000,1);
					SetPlayerPos(playerid, plocx, plocy+1.3, plocz);
					return 1;
			}
			else if	(rb	== 4)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(1238,plocx,plocy,plocz+0.2,ploca);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷����˽�ͨ׶��(1), ���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Cone	~g~Placed!",3000,1);
					return 1;
			}
			else if	(rb	== 5)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(1425,plocx,plocy,plocz+0.6,ploca);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷���������·��(4), ���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Sign	~g~Placed!",3000,1);
					return 1;
			}
			else if	(rb	== 6)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(3265,plocx,plocy,plocz-0.5,ploca);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷����˽�ֹͨ�еı�־(5),	���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Sign	~g~Placed!",3000,1);
					return 1;
			}
			else if	(rb	== 7)
			{
					PlayerPlaySound(playerid, 1052,	0.0, 0.0, 0.0);
					new	Float:plocx,Float:plocy,Float:plocz,Float:ploca;
					GetPlayerPos(playerid, plocx, plocy, plocz);
					GetPlayerFacingAngle(playerid,ploca);
					CreateRoadblock(3091,plocx,plocy,plocz+0.5,ploca+180);
					format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������λ�÷����˹رձ�־��(6),	���.",sendername);
					AdminXX(3,string,COLOR_BLUE);
					GameTextForPlayer(playerid,"~w~Sign	~g~Placed!",3000,1);
					return 1;
			}
		}
		return 1;
	}
	if (strcmp(cmd,"/urb",true)	== 0 ||	strcmp(cmd,	"/removeroadblock",	true) == 0)
	{
		new	string[128];
		new	sendername[MAX_PLAYER_NAME];
		new msg[128];
  GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(IsPlayerConnected(playerid) && playerzuzhi[playerid]==3 || playeradmin[playerid]	>= 1 || playerzuzhi[playerid]==4 || playerzuzhi[playerid]==14)
		{
			DeleteClosestRoadblock(playerid);
			format(string,sizeof(string),"[�ܲ�]: ��Ա%s ������һ��·��, ���.",sendername);
			AdminXX(3,string,COLOR_BLUE);
			ABroadCast(0x00FF00AA,msg,1);
   GameTextForPlayer(playerid,"~w~Roadblock ~r~Removed!",3000,1);
		}
		return 1;
	}
	if (strcmp(cmd,"/rrb",true) == 0	|| strcmp(cmd, "/removeroadblockall", true)	== 0)
	{
		new	string[128];
		new	sendername[MAX_PLAYER_NAME];
		new msg[128];
  GetPlayerName(playerid,	sendername,	sizeof(sendername));
		if(IsPlayerConnected(playerid) && playerzuzhi[playerid]==3	|| playeradmin[playerid] >=	1 || playerzuzhi[playerid]==4 || playerzuzhi[playerid]==14)
		{
			if(playerzuzhilv[playerid] >= 3	|| playeradmin[playerid] >=	2) // This being the default Chief rank	in LA-RP change	if neccesary.
			{
				DeleteAllRoadblocks(playerid);
				format(string,sizeof(string),"[�ܲ�]: ��Ա%s ����������·��, ���.",sendername);
				AdminXX(3,string,COLOR_BLUE);
				ABroadCast(0x00FF00AA,msg,1);
    GameTextForPlayer(playerid,"~b~All ~w~Roadblocks ~r~Removed!",3000,1);
			}
		}
		return 1;
	}
//
	if(strcmp(cmd,"/tofind")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/tofind	[���id]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"������Ѿ����ں��ģʽ(��������),����ʹ��/stofind��������!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½!");
					return 1;
				}
				jcys[playerid]=3;
				tofind[playerid]=id;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//======================================================
	if(strcmp(cmd,"/find")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==2||playeradmin[playerid]!=0)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/find [Ŀ��id]");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"������Ѿ����ں��ģʽ(��������),����ʹ��/stofind��������!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½!");
					return 1;
				}
				jcys[playerid]=3;
				tofind[playerid]=id;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻����̽!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//----------------------------
	if(strcmp(cmd,"/tzfind")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==2||playeradmin[playerid]!=0)
			{
				if(tofind[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ŀǰû��׷���κ�һ�����!");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				jcys[playerid]=0;
				tofind[playerid]=0;
				DisablePlayerCheckpoint(playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻����̽!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/guanya")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
					new	tmp[128],id,s,fj;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/guanya	[���id] [ʱ��(��)]	[����]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û������!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"ʱ�䲻��Ϊ��!");
						return 1;
					}
					s=strval(tmp);
					if(s<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"ʱ�䲻��С��1!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"������Ϊ��!");
						return 1;
					}
					fj=strval(tmp);
					if(fj<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"������С��1!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2�����̫Զ�ˡ���");
						return 1;
					}
					if(su[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�б�ͨ��!!");
						return 1;
					}
					if(XY(10,playerid,-2485.5210 ,2271.7466, 4.9844)==0&&XY(10,playerid,267.1739 ,77.6191	,1001.0391)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڹ�Ѻ��/������ſ�!");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[�ܲ�]:	������%s����Ա%s��Ѻ��,ʱ��:%d��,����:%d.",name,name1,s,fj);
					ABroadCast(0x00FF00AA,msg,1);
					AdminXX(3,msg,0x00FF00AA);
					format(msg,128,"[�ܲ�]:	������%s����Ա%s������.",name,name1);
					SendClientMessageToAll(0x00FF00AA,msg);
					for(new	i=0;i<7;i++)
					{
						playerwuqi[id][i]=0;
					}
					ResetPlayerWeaponEx(id);
					SetPlayerPos(id,264.752624,77.582786,1001.039062);
					SetPlayerInterior(id,6);
					SetPlayerSkin(id,252);
					playerjianyutime[id]=s;
					playermoney[id]=playermoney[id]-fj;
					ResetPlayerMoney(id);
					GivePlayerMoney(id,playermoney[id]);
					houseid[id]=3;
					su[id]=0;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------------------------------fbi����
	if(strcmp(cmd,"/guanren")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==4)
			{
					new	tmp[128],id,s,fj;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/guanren [���id] [ʱ��(��)] [����]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û������!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"ʱ�䲻��Ϊ��!");
						return 1;
					}
					s=strval(tmp);
					if(s<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"ʱ�䲻��С��1!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"������Ϊ��!");
						return 1;
					}
					fj=strval(tmp);
					if(fj<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"������С��1!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2�����̫Զ�ˡ���");
						return 1;
					}
					if(su[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�б�ͨ��!!");
						return 1;
					}
					if(XY(10,playerid,1524.820922 ,-1677.945678, 5.890625)==0&&XY(10,playerid,1557.278686 ,-1675.701538	,28.395452)==0&&XY(15,playerid,1539.951660 ,-1675.954101 ,13.549644)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ������/������ſ�/¥�����!");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[�ܲ�]:	������%s����Ա%s��Ѻ��,ʱ��:%d��,����:%d.",name,name1,s,fj);
					ABroadCast(0x00FF00AA,msg,1);
					AdminXX(3,msg,0x00FF00AA);
					format(msg,128,"[�ܲ�]:	������%s����Ա%s������.",name,name1);
					SendClientMessageToAll(0x00FF00AA,msg);
					for(new	i=0;i<7;i++)
					{
						playerwuqi[id][i]=0;
					}
					ResetPlayerWeaponEx(id);
					SetPlayerPos(id,264.752624,77.582786,1001.039062);
					SetPlayerInterior(id,6);
					SetPlayerSkin(id,252);
					playerjianyutime[id]=s;
					playermoney[id]=playermoney[id]-fj;
					ResetPlayerMoney(id);
					GivePlayerMoney(id,playermoney[id]);
					houseid[id]=3;
					su[id]=0;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------------------------------fbi����
	if(strcmp(cmd,"/cu")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==4||playerzuzhilv[playerid]==14)
			{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/cu	[���id]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û������!");
						return 1;
					}
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"�������㣿���Լ���");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(5,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"����2�����̫Զ�ˡ���");
						return 1;
					}
					new	name[128];
					new	msg[128];
					if(cu[id]==0)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"�㱻%s��������!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"%s���㿽������!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,0);
						cu[id]=1;
						return 1;
					}
					if(cu[id]==1)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"�����ϵĿ��ӱ�%sŪ����!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"���%s���ϵĿ���Ū����!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,1);
						cu[id]=0;
						return 1;
					}
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/cktongji")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
				new	msg[128];
				new	name[128];
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				SendClientMessage(playerid,	0x008040FF,"________|�ҵ��й���ͨ������|________");
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(su[i]>=1)
							{
								GetPlayerName(i,name,128);
								format(msg,256,"ID:%d ����:%s ͨ���ȼ�:%d ",i,name,su[i]);
								SendClientMessage(playerid,0x7FFD4AA,msg);
							}
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/su")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==14)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/su	[���id] [ͨ������]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��!");
					return 1;
				}
				if(su[id]>=30)
				{
					SendClientMessage(playerid,0x00FF00AA,"������Ѿ��ﵽ���ͨ��(30)��!!");
					return 1;
				}
				new	msg[128];
				new	name[128];
				new	name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				su[id]=su[id]+1;
				format(msg,128,"[�ܲ�]:	%s��ͨ�����Ѿ������ˣ�ͨ���ȼ�:%d,ͨ������:%s",name,su[id],tmp);
				AdminXX(3,msg,0x00FF00AA);
				ABroadCast(0x00FF00AA,msg,1);
				format(msg,128,"%s�����˶����ͨ��������:%s,ͨ���ȼ�:%d",name1,tmp,su[id]);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"���%s����ͨ�����������Ե���̳�ٱ����ˣ�лл��",name1);
				SendClientMessage(id,0x00FF00AA,msg);

				format(msg,128,"�㷢���˶�%s��ͨ��������:%s,ͨ���ȼ�:%d",name,tmp,su[id]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/unsu")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==14)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/unsu	[���id] [��������]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�������ɲ���Ϊ��!");
					return 1;
				}
				if(su[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�б�ͨ��!!");
					return 1;
				}
				new	msg[128];
				new	name[128];
				new	name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				su[id]=0;
				format(msg,128,"[�ܲ�]:	%s��ͨ���������,����:%s",name,tmp);
				AdminXX(3,msg,0x00FF00AA);
				AdminXX(4,msg,0x00FF00AA);
				format(msg,128,"%s�����˶��㷢����ͨ�������:%s",name1,tmp);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"�㳷���˶�%s������ͨ�������:%s",name,tmp);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/buyskin")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(5,playerid, 161.383590,-83.632690, 1001.804687)==1)
			{
				if(playerzuzhi[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��֯��Ա���������·�~~");
					return 1;
				}
				if(playermoney[playerid]<2000)
				{
					SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ���������㹺���µ��·���(2000)");
					return 1;
				}
				CallRemoteFunction("ChangeSkinCommand","i",playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻���·����̨!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/drag")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
					new	id,tmp[128],a=-1,b=-1,c=-1,d=-1,vid=GetPlayerVehicleID(playerid);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�÷�:/drag [���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�����û�е�½!");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���!");
						return 1;
					}
					if(playerzuzhi[playerid]==3&&GetVehicleModel(vid)!=599&&GetVehicleModel(vid)!=598&&GetVehicleModel(vid)!=490&&GetVehicleModel(vid)!=528&&GetVehicleModel(vid)!=497&&GetVehicleModel(vid)!=427&&GetVehicleModel(vid)!=428&&GetVehicleModel(vid)!=596&&GetVehicleModel(vid)!=523)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ھ�����!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�������̫Զ��..");
						return 1;
					}
					for(new	i=0;i<101;i++)
					{
						if(IsPlayerConnected(i)==1)
						{
							if(SL[i]==1)
							{
								if(IsPlayerInVehicle(i,vid))
								{
									new	zid=GetPlayerVehicleSeat(i);
									if(zid==0)
									{
										a=zid;
									}
									if(zid==1)
									{
										b=zid;
									}
									if(zid==2)
									{
										c=zid;
									}
									if(zid==3)
									{
										d=zid;
									}
								}
							}
						}
					}
					if(GetVehicleModel(vid)==599||GetVehicleModel(vid)==523)
					{
						c=10;
						d=10;
					}
					if(a!=-1&&b!=-1&&c!=-1&&d!=-1)
					{
						SendClientMessage(playerid,0x00FF00AA,"��������Ѿ�������!");
						return 1;
					}
					if(a==-1)
					{
						PutPlayerInVehicle(id,vid,0);
						return 1;
					}
					if(b==-1)
					{
						PutPlayerInVehicle(id,vid,1);
						return 1;
					}
					if(c==-1)
					{
						PutPlayerInVehicle(id,vid,2);
						return 1;
					}
					if(d==-1)
					{
						PutPlayerInVehicle(id,vid,3);
						return 1;
					}
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/jiechuzuche")==0)
	{
		if(SL[playerid]==1)
		{
				new	i=carzuyongkey[playerid];
				if(i==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���⳵ѽ!?");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				SetPlayerPos(playerid,x,y,z+2);
				SetVehiclePos(i,carx[i],cary[i],carz[i]);
				SetVehicleZAngle(i,carmianxiang[i]);
				SetVehicleHealth(i,1000);
				RepairVehicle(i);
				carzuyong[carzuyongkey[playerid]]=0;
				carzuyongkey[playerid]=0;
				SendClientMessage(playerid,0x00FF00AA,"���Ѿ��˻�����ĳ���~");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}

//------------------------------------------------------------------------------------------------------------
 if(strcmp(cmd,"/viplvup")==0)
	{
		if(SL[playerid]==1)
		{
			new	up=playerviplv[playerid]*8;
			if(playerviplv[playerid]==0)
			{
			SendClientMessage(playerid,0x00FF00AA,"�㲻��VIP��");

			return 1;
			}
			if(playervipczz[playerid]>=up)
			{
				new msgg[128];
				new msgd[128];
				new name[128];
				GetPlayerName(playerid,name,128);
				playervipczz[playerid]=playervipczz[playerid]-up;
				playerviplv[playerid]=playerviplv[playerid]+1;
			    format(msgd,128,"��ϲVIP�û���%s��������VIP%d�����ף�����ɣ�",name,playerviplv[playerid]);
			    SendClientMessage(playerid,COLOR_YELLOW,msgd);
			    format(msgg,128,"���VIP�ȼ����������������VIP�ȼ��ǣ�%d",playerviplv[playerid]);
			    SendClientMessage(playerid,0xFFFF00AA,msgg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"���VIP�ɳ�ֵ������");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
 if(strcmp(cmd,"/lvup")==0)
	{
		if(SL[playerid]==1)
		{
			new	up=playerlv[playerid]*8;
			if(playerlvup[playerid]>=up)
			{
				playerlvup[playerid]=playerlvup[playerid]-up;
				playerlv[playerid]=playerlv[playerid]+1;
				SetPlayerScore(playerid,playerlv[playerid]);
				SendClientMessage(playerid,0x00FF00AA,"��������~");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�����������������");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/time")==0)
	{
		if(SL[playerid]==1)
		{
			new	h,m,s,y,r,d;
			new	msg[128];
			gettime(h,m,s);
			getdate(y,r,d);
			format(msg,128,"��ǰ����������:%d-%d-%d	��ǰ������ʱ��:%d:%d:%d",y,r,d,h,m,s);
			SendClientMessage(playerid,0xFFFF00AA,msg);
			if(playerjianyutime[playerid]>0)
			{
				format(msg,128,"����ʣ��ʱ��:%d��",playerjianyutime[playerid]);
				SendClientMessage(playerid,0xFFFF00AA,msg);
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/spawnchange")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128],i;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�/spawnchange	0/1/2/3/4 (0Ϊ��֯�����ػ����ֻ���,1-3Ϊ1-3�ŷ�����,4Ϊ�ⷿ����(�ⷿ��ʱ������)");
				return 1;
			}
			i=strval(tmp);
			if(i<0||i>3)
			{
				SendClientMessage(playerid,0x00FF00AA,"����ķ��ݱ��(0-3)!");
				return 1;
			}
			if(i==0)
			{
				playerspawn[playerid]=0;
				SendClientMessage(playerid,0x00FF00AA,"��������ֻ��ػ���֯���س���!");
				return 1;
			}
			if(i==1)
			{
				if(playerlock[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û��һ�ŷ�!");
					return 1;
				}
				playerspawn[playerid]=1;
				SendClientMessage(playerid,0x00FF00AA,"��������1�ŷ�����!");
				return 1;
			}
			if(i==2)
			{
				if(playerlock1[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û�ж��ŷ�!");
					return 1;
				}
				playerspawn[playerid]=2;
				SendClientMessage(playerid,0x00FF00AA,"��������2�ŷ�����!");
				return 1;
			}
			if(i==3)
			{
				if(playerlock2[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û�����ŷ�!");
					return 1;
				}
				playerspawn[playerid]=3;
				SendClientMessage(playerid,0x00FF00AA,"��������3�ŷ�����!");
				return 1;
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/unsavecar")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(XY(5,playerid,2487.911865,-1464.708251,24.020944)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڸ�װ����������!");
				return 1;
			}
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������������ģ�");
				return 1;
			}
			if(playermoney[playerid]<50000)
			{
				SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ������֧������������!");
				return 1;
			}
			if(cargzbc[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"���������û�б����װ��..");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-50000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,"�����������ĸ�װ!");
			cargzbc[vid]=0;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/savecar")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(XY(15,playerid,-2445.7097,2485.5266,15.3203)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڸ�װ�������!");
				return 1;
			}
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ���!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������������ģ�");
				return 1;
			}
			if(playermoney[playerid]<50000)
			{
				SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ������֧���������!");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-50000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,"�㱣���������ĸ�װ!");
			cargzbc[vid]=1;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vcall")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128];
			new	id;
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0x00BFFFF,"�÷�:/vcall	[����ID]");
				return 1;
			}
			id=strval(tmp);
			GetPlayerName(playerid,name,128);
			if(GetVehicleModel(id)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"����ĳ���ID!");
				return 1;
			}
			if(strcmp(carname[id],name)!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻���ٻز��������������");
				return 1;
			}
			if(playermoney[playerid]<2500)
			{
				SendClientMessage(playerid,0x00FF00AA,"��Ľ�Ǯ������֧���ϳ����ã�");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�ϳ����Ľ���ĳ��ϻ���PARK��!��ȡ��2500Ԫ");
			SetVehiclePos(id,carx[id],cary[id],carz[id]);
			playermoney[playerid]=playermoney[playerid]-2500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/lockhouse")==0)
	{
		if(SL[playerid]==1)
		{
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
					{
						if(playerlock[playerid]==u||playerlock1[playerid]==u||playerlock2[playerid]==u)
						{
							if(ZFJGLOCK[u]==0)
							{
								ZFJGLOCK[u]=1;
								SendClientMessage(playerid,0x00FF00AA,"�㽫��ķ��ӽ����ˣ�");
								return 1;
							}
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"�㽫��ķ��������ˣ�");
							return 1;
						}
						SendClientMessage(playerid,0x00FF00AA,"��û����䷿��Կ�ף�");
						return 1;
					}
				}
				if(ZFJGLX[u]==4)
				{
					if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
					{
						if(playerzuzhi[playerid]==ZFJGZUZHI[u])
						{
							if(ZFJGLOCK[u]==0)
							{
								ZFJGLOCK[u]=1;
								SendClientMessage(playerid,0x00FF00AA,"�㽫��֯���ӽ����ˣ�");
								return 1;
							}
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"�㽫��֯���������ˣ�");
							return 1;
						}
						SendClientMessage(playerid,0x00FF00AA,"��û����䷿��Կ�ף�");
						return 1;
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/sellhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
					{
						if(strcmp(ZFJGSTR[u],"δ����")==0)
						{
							SendClientMessage(playerid,0xDC143CAA,"��䷿�ӻ�û�б�������...");
							return 1;
						}
						if(playeradmin[playerid]>= 9999||playerlock[playerid]==u||playerlock1[playerid]==u||playerlock2[playerid]==u)
						{
							playermoney[playerid]=playermoney[playerid]+ZFJGMONEY[u];
							ResetPlayerMoney(playerid);
							GivePlayerMoney(playerid,playermoney[playerid]);
							if(playerlock[playerid]==u)
							{
								playerlock[playerid]=0;
							}
							if(playerlock1[playerid]==u)
							{
								playerlock1[playerid]=0;
							}
							if(playerlock2[playerid]==u)
							{
								playerlock2[playerid]=0;
							}
							ZFJGTID[u]=1273;
							format(ZFJGSTR[u],128,"δ����");
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"�������һ�䷿�ӣ�");
							u=pickupids+1;
							return 1;
						}
						if(playerlock[playerid]!=u||playerlock1[playerid]!=u||playerlock2[playerid]!=u)
						{
							SendClientMessage(playerid,0xDC143CAA,"�㲻�ܳ��۲�����ķ���!");
							return 1;
						}
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/buyhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	id;
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
					{
						if(strcmp(ZFJGSTR[u],"δ����")!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"��䷿���Ѿ��������ˡ�");
							return 1;
						}
						if(playerlock[playerid]!=0&&playerlock1[playerid]!=0&&playerlock2[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"���Ѿ�ӵ��3�䷿����!�������������һ�䣡����������/sellhouse");
							return 1;
						}
						if(strcmp(ZFJGSTR[u],"δ����")==0)
						{
							id=u;
							u=pickupids+1;
						}
					}
				}
			}
			if(id==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����������˰�");

				return 1;
			}
			if(playermoney[playerid]<ZFJGMONEY[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"��������䷿�ӡ�");
				return 1;
			}
			if(playerlv[playerid]<ZFJGLV[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"��ĵȼ�������");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-ZFJGMONEY[id];
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			new	pd=0;
			if(playerlock[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock[playerid]=id;
			}
			if(playerlock1[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock1[playerid]=id;
			}
			if(playerlock2[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock2[playerid]=id;
			}
			ZFJGTID[id]=1272;
			GetPlayerName(playerid,ZFJGSTR[id],128);
			SendClientMessage(playerid,0x00FF00AA,"������һ���·��ӣ�");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vunreg")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			new	name[128];
			new	msg[128];
			GetPlayerName(playerid,name,128);
			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
				return 1;
			}
			if(carzuzhi[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"��������������κ���֯!");
				return 1;
			}
			if(playermoney[playerid]<carmoney[vid]/3)
			{
				format(msg,128,"��Ľ�Ǯ�����Ի���%s��Ա���ϵ�Կ�ף�",zuzhiname[carzuzhi[vid]]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-carmoney[vid]/3;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			format(msg,128,"�㻨����%d��%s��Ա���ϻ�������������ȫ��Կ��!",carmoney[vid]/3,zuzhiname[carzuzhi[vid]]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			carzuzhi[vid]=0;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/tuichuzz")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û����֯");
				return 1;
			}
			if(playermoney[playerid]<10000)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�����ϵĽ�Ǯ���������㰲ȫ�˳���֯!");
				return 1;
			}
			new	msg[128];
			format(msg,128,"���˳�����֯%s",zuzhiname[playerzuzhi[playerid]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			playermoney[playerid]=playermoney[playerid]-10000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			playerzuzhi[playerid]=0;
			playerzuzhilv[playerid]=0;
			SetPlayerSkin(playerid,playerskin[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/maiche")==0)
	{
		if(SL[playerid]==1)
		{
				new	msg[128];
				new	name[128];
				GetPlayerName(playerid,name,128);
				if(vsellto[playerid]==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"û�����������������!");
					return 1;
				}
				if(vselltomoney[playerid]>playermoney[playerid])
				{
					SendClientMessage(playerid,0xDC143CAA,"����������������");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(vsellto[playerid],x,y,z);
				if(XY(10,playerid,x,y,z)==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"������������̫Զ�ˡ�");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]-vselltomoney[playerid];
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playermoney[vsellto[playerid]]=playermoney[vsellto[playerid]]+vselltomoney[playerid];
				ResetPlayerMoney(vsellto[playerid]);
				GivePlayerMoney(vsellto[playerid],playermoney[vsellto[playerid]]);
				format(msg,128,"%s�������������,������%d!",name,vselltomoney[playerid]);
				SendClientMessage(vsellto[playerid],0xFFFACDAA,msg);
				format(carname[vselltocar[playerid]],128,"%s",name);
				GetPlayerName(vsellto[playerid],name,128);
				format(msg,128,"�㹺����%s������,������%d!",name,vselltomoney[playerid]);
				playercar[vsellto[playerid]]=playercar[vsellto[playerid]]-1;
				playercar[playerid]=playercar[playerid]+1;
				SendClientMessage(playerid,0xFFFACDAA,msg);
				vsellto[playerid]=0;
				vselltocar[playerid]=0;
				vselltomoney[playerid]=0;
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/sellcar")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==4)
			{
					new	tmp[128];
					new	vid=GetPlayerVehicleID(playerid);
					new	name[128];
					new	id;
					new	money;
					new	msg[128];
					new	name1[128];
					GetPlayerName(playerid,name,128);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/sellcar [���ID] [�۸�]");
						return 1;
					}
					id=strval(tmp);
					if(id==playerid)
					{
						SendClientMessage(playerid,0xDC143CAA,"�㲻�ܰѳ������Լ�....");
						return 1;
					}
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"�����û�е�½!");
						return 1;
					}
					GetPlayerName(id,name1,128);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/sellcar [���ID] [�۸�]");
						return 1;
					}
					money=strval(tmp);
					if(money<=100)
					{
						SendClientMessage(playerid,0xDC143CAA,"�۸������100Ԫ����");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
						return 1;
					}
					if(strcmp(name,carname[vid])!=0)
					{
						SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(10,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"������������̫Զ�ˡ�");
						return 1;
					}
					format(msg,128,"%s�����һ����������,�۸�Ϊ%d,������빺��������/maiche",name,money);
					SendClientMessage(id,0xFFFACDAA,msg);
					format(msg,128,"�������һ��������%s,�۸�Ϊ%d�������Ѿ����͸�%s��,��ȴ���Ӧ",name1,money,name1);
					SendClientMessage(playerid,0xFFFACDAA,msg);
					vsellto[id]=playerid;
					vselltocar[id]=vid;
					vselltomoney[id]=money;
					vselltoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"�㲻������������!");
		return 1;
	}
	if(strcmp(cmd,"/vsell")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
				return 1;
			}
			if(XY(8,playerid,-2445.007568,2485.488525,15.320312)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻��������!");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]+carmoney[vid]/4;
			playercar[playerid]=playercar[playerid]-1;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			DestroyVehicle(vid);
			car[vid]=0;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vreg")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			new	vid=GetPlayerVehicleID(playerid);
			new	money=carmoney[vid]/4;
			GetPlayerName(playerid,name,128);
			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
				return 1;
			}
			if(carzuzhi[vid]!=0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"���������Ѿ�����ĳ��֯��!");
				return 1;
			}
			if(playerzuzhi[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û����֯");
				return 1;
			}
			if(playermoney[playerid]<money)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�����ϵĽ�Ǯ������ע����������!");
				return 1;
			}
			carzuzhi[vid]=playerzuzhi[playerid];
			new	msg[128];
			format(msg,128,"�㽫����ע�������֯:%s,������%d",zuzhiname[carzuzhi[vid]],money);
			SendClientMessage(playerid,0xF8F8FFFF,msg);
			playermoney[playerid]=playermoney[playerid]-money;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/buycar")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid,-2445.007568,2485.488525,15.320312)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�㲻���򳵵�!");
				return 1;
			}
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"�ҵ��й���	- ��������ϵͳ","{00F0F0}1.���ֳ���\n{00F0F0}2.���ֳ���\n{00F0F0}3.�ɻ�/ֱ������\n{00F0F0}4.VIP������\n{00F0F0}5.���⳵����","ѡ��","ȡ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vpark")==0)
	{
		new	vid=GetPlayerVehicleID(playerid);
		new	name[128];
		if(SL[playerid]==1)
		{
			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			if(strcmp(name,carname[vid])!=0 && playeradmin[playerid]<9999)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
				return 1;
			}
			SendClientMessage(playerid,0xDC143CAA,"���޸���������ˢ�µ�!");
			GetVehiclePos(vid,carx[vid],cary[vid],carz[vid]);
			GetVehicleZAngle(vid,carmianxiang[vid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vcolor")==0)
	{
		new	tmp[128];
		new	c1,c2;
		new	vid=GetPlayerVehicleID(playerid);
		new	name[128];
		if(SL[playerid]==1)
		{
			GetPlayerName(playerid,name,128);
			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ⲻ���������!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0x00BFFFF,"�÷�:/vcolor	[��ɫ1] [��ɫ2]");
				return 1;
			}
			c1=strval(tmp);
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0x00BFFFF,"�÷�:/vcolor	[��ɫ1] [��ɫ2]");
				return 1;
			}
			if(playermoney[playerid]<1000)
			{
				SendClientMessage(playerid,0xDC143CAA,"��Ľ�Ǯ����(1000)!");
				return 1;
			}
			c2=strval(tmp);
			carcolor1[vid]=c1;
			carcolor2[vid]=c2;
			ChangeVehicleColor(vid,c1,c2);
			playermoney[playerid]=playermoney[playerid]-1000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
/*if (strcmp(cmdtext, "/og", true)==0)
{
if(SL[playerid]==1)
{
if(playerzuzhi[playerid]==4)
{
if(XY(8,playerid,1588.2493,-1637.5610,13.4196))
{
MoveDynamicObject(gate88, 1591.738037, -1638.271606, -2.911936,	0.8);
SendClientMessage(playerid,	0x0D7792AA,	"5���رճ���");
gatetime[1]=5;
return 1;
}
if(XY(8,playerid,1564.3739,-1611.4268,13.3828))
{
MoveDynamicObject(gate89, 1563.911255, -1617.380615, 4.307865, 0.8);
SendClientMessage(playerid,	0x0D7792AA,	"5���رտ���");
gatetime[2]=5;
return 1;
}
SendClientMessage(playerid,0x0D7792AA, "�㸽��û�п��Դ򿪵���");
return 1;
}
SendClientMessage(playerid,0x0D7792AA, "��û��Կ��");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}*/
	if (strcmp(cmdtext,	"/go", true)==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(XY(8,playerid,1544.6227,-1627.1763,13.3828))
				{
					DestroyDynamicObject(gate);
					gate = CreateDynamicObject(968,	1544.746704, -1630.777222, 13.160947, 0.0000, 359.1406,	270.0000);
					SendClientMessage(playerid,0x0D7792AA, "5���ر�����");
					gatetime[0]=5;
					return 1;
				}
				if(XY(8,playerid,1588.2493,-1637.5610,13.4196))
				{
					MoveDynamicObject(gate1, 1591.738037, -1638.271606,	-2.911936, 0.8);
					SendClientMessage(playerid,	0x0D7792AA,	"10���رճ���");
					gatetime[1]=10;
					return 1;
				}
				if(XY(8,playerid,1564.3739,-1611.4268,13.3828))
				{
					MoveDynamicObject(gate2, 1563.911255, -1617.380615,	4.307865, 0.8);
					SendClientMessage(playerid,	0x0D7792AA,	"10���رտ���");
					gatetime[2]=10;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "�㸽��û�п��Դ򿪵���");
				return 1;
			}
			if(playerzuzhi[playerid]==4)
			{
				if(XY(8,playerid,1535.0043,-1451.6725,13.3887))
				{
					MoveDynamicObject(gate3, 1535.4482421875,-1451.5390625,9.160917282104, 1.0);
					SendClientMessage(playerid,	0x0D7792AA,	"10���رճ���");
					gatetime[3]=10;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "�㸽��û�п��Դ򿪵���");
				return 1;
			}
			if(playerzuzhi[playerid]==5)
			{
				if(XY(2,playerid,372.0354,166.7028,1008.3828)==1)
				{
					MoveDynamicObject(gate4, 369.2467956543, 166.54695129395, 1007.3828125,	5);
					SendClientMessage(playerid,	0x0D7792AA,	"2������");
					gatetime[4]=2;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "�㸽��û�п��Դ򿪵���");
				return 1;
			}
			SendClientMessage(playerid,0x0D7792AA, "��û��Կ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}


if(strcmp(cmd,"/gengxin")==0)
	{
		if(SL[playerid]==1)
		{

				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}

 if(strcmp(cmd,"/help")==0)
	{
		if(SL[playerid]==1)
		{
				new	listitems[]	= "1\t����ϵͳ����\n2\t����ָ�����\n3\t����ϵͳ����\n4\t�ֻ�����\n5\t���ݰ���\n6\t��֯�쵼����\n7\tҽ��/����/���߰���\n8\t����/FBI/���Ӱ���\n9\t��������\n10\t����Ա����\n11\tVIP����";
				ShowPlayerDialog(playerid,8536,DIALOG_STYLE_LIST,"��ѡ������Ҫ�鿴�İ���:",listitems,"ȷ��","ȡ��");
				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//=================================================================================================================================================================================================================================================================================
//--------------------------------------[GOV]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//=================================================================================================================================================================================================================================================================================
	if(strcmp(cmd,"/gov")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3&&playerzuzhilv[playerid]==5||playerzuzhi[playerid]==4&&playerzuzhilv[playerid]==5||playerzuzhi[playerid]==5&&playerzuzhilv[playerid]==5||playerzuzhi[playerid]==6&&playerzuzhilv[playerid]==5||playerzuzhi[playerid]==14&&playerzuzhilv[playerid]==5)
			{
				new	tmp[128];
				new	msg[128];
				new	name[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/gov [����]");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"|____________�������Ź���____________|");
				SendClientMessageToAll(0xCECECEFF,msg);
				format(msg,128,"%s%s:%s",zuzhigonggao[playerzuzhi[playerid]],name,tmp);
				SendClientMessageToAll(0x00BFFFF,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//==================================================================================
	if(strcmp(cmd,"/kong")==0)
	{
		if(SL[playerid]==1)
		{
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SendClientMessage(playerid,	0x00BFFFF,"�ռ��Ѿ��޸���ϣ��绹��BUG�뷴������Ա����Ⱥ������Ŷ~");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//--------------------------------admin---------------------------------------------
//==================================DM===================================��
/*	if(strcmp(cmd,"/dm")==0)
	{
		if(playerdm[playerid]==0)
		{
			SetPlayerVirtualWorld(playerid,555);
			playerdm[playerid]=1;
			new name[128],ak[128];
			GetPlayerName(playerid,name,128);
				format(ak,128,"[DM��Ϣ]%s������DMģʽ�����һ����ս���ɣ�'/dm'",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
   					SetPlayerPos(playerid, -783.2614,503.1347,1381.6);
					SetPlayerInterior(playerid,1);
			SendClientMessage(playerid,	0x00BFFFF,"DMģʽ�Ѿ�������������������/dm�˳�DMģʽŶ");
			return 1;
		}
		if(playerdm[playerid]==1)
		{
			SetPlayerVirtualWorld(playerid,0);
			playerdm[playerid]=0;
			new name[128],ak[128];
			GetPlayerName(playerid,name,128);
				format(ak,128,"[DM��Ϣ]%s�˳���DMģʽ",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			ResetPlayerWeaponEx(playerid);
			SendClientMessage(playerid,	0x00BFFFF,"DMģʽ�Ѿ��˳��������Ѿ������������Ž��˾��òֿ⣬ף�������죡");
			SendClientMessage(playerid,	0x00BFFFF,"�����ڵ�λ�ã���ɼ����ִ��ſڣ�");
			SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
			SetPlayerInterior(playerid,0);
			return 1;
		}
		return 1;
	}
*/
//=======================================================================
	if(strcmp(cmd,"/buy")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -26.478111,-177.210235,1003.546875)==1)
			{
				ShowPlayerDialog(playerid, 8900, DIALOG_STYLE_LIST,	"��Ʒ�˵�",	"IPhoneG3(3800Ԫ)\nС��ͨS2(800Ԫ)\n����:10Ԫ���\n����:20Ԫ���\n����:50Ԫ���\n����:100Ԫ���\n����:200Ԫ���\n��Ʊ(50000Ԫ)\n¿����Ѫ����(1500Ԫ)\n�绰��(1000Ԫ)\nƽ�����(6000Ԫ)\n�̻�(1000Ԫ)", "����", "����");
				PlayerPlaySound(playerid, 1135,	0.0, 0.0, 10.0);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻���̵�,�޷�����");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setcallmoney")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3)
			{
				new	tmp[128],id,callmoney;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/setcallmoney [���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ѳ���Ϊ��");
					return 1;
				}
				callmoney=strval(tmp);
				if(callmoney<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ѳ���С��0");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s����ĵ绰�������Ϊ%d",name,callmoney);
				SendClientMessage(id,0x00FF00AA,msg);
				playercallmoney[id]=callmoney;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------------------------------------------------
	if(strcmp(cmd,"/setmats")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 4)
			{
				new	tmp[128],id,mats;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/setmats [���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ϲ���Ϊ��");
					return 1;
				}
				mats=strval(tmp);
				if(mats<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ϲ���С��0");
					return 1;
				}
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"����Ա%s����Ĳ�������Ϊ%d",name,mats);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"����Ա%s�����%s�Ĳ�������Ϊ%d.",name,name1,mats);
				ABroadCast(0x00FF00AA,msg,1);
    playermats[id]=mats;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	//-----------------------------------------------------------------
/*	if(strcmp(cmd,"/xgname")==0)
	{
		if(SL[playerid]==1)
		{
if(playeradmin[playerid]>= 1338)
		{
				new	tmp[128],id,pname;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/xgname [���id] [������]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����ֲ���Ϊ��");
					return 1;
				}
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"����Ա%s��������ָ���Ϊ%d.",name,pname);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"�㽫���%s�����ָ���Ϊ%d.",name1,pname);
				SendClientMessage(id,0x00FF00AA,msg);
				playername[id]=pname;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}*/
//-----------------------------------------------------------------
	if(strcmp(cmd,"/ky")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
				if(adminduty[playerid]==1)
				{
						new	tmp[128],msg[128],name[128],Float:x,Float:y,Float:z;
						tmp=strtokp(cmdtext,idx);
						if(strcmp(tmp,"	")==0)
						{
							SendClientMessage(playerid,0x00FF00AA,"�÷�:/ky	[����]");
							return 1;
						}
						GetPlayerName(playerid,name,128);
						format(msg,128,"[>%s<%s:%s]",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
						GetPlayerPos(playerid,x,y,z);
						for(new	i=0;i<101;i++)
						{
							if(IsPlayerConnected(playerid)==1)
							{
								if(IsPlayerConnected(i)==1)
								{
									if(XY(50,i,x,y,z)==1)
									{
										SendClientMessage(i, 0xFFD700FF,msg);
									}
								}
							}
						}
						return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"��û���ϰ�");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��������");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setcall")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
				new	tmp[128],id,callid;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/setcall [���id]	[����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���벻��Ϊ��");
					return 1;
				}
				callid=strval(tmp);
				if(callid>100&&callid<10087)
				{
					SendClientMessage(playerid,0x00FF00AA,"�绰�������С��100�����1000");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s����ĵ绰��������Ϊ%d",name,callid);
				SendClientMessage(id,0x00FF00AA,msg);
				playercall[id]=callid;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/chm")==0)
	{
		if(SL[playerid]==1)
		{
			new	tmp[128],id;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�÷�:/chm [���id]");
				return 1;
			}
			id=strval(tmp);
			if(SL[id]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
				return 1;
			}
			new	msg[128],name[128];
			new	hm;
			hm=playercall[id];
			GetPlayerName(id,name,128);
			format(msg,128,"[��Ϣ̨]:%s�ĵ绰��Ϊ:%d",name,hm);
			SendClientMessage(playerid,0x00FF00AA,msg);
			playercallmoney[id]=playercallmoney[id]-5;
			GameTextForPlayer(playerid,"-5",5000,1);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckar")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"�÷�:/ckar [���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
						return 1;
					}
					new	Float:ar,msg[128],name[128];
					GetPlayerArmour(id,ar);
					GetPlayerName(id,name,128);
					format(msg,128,"%s�Ļ���(AR)Ϊ%f",name,ar);
					SendClientMessage(playerid,	0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckhp")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
					new	tmp[128],id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"�÷�:/ckhp [���id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
						return 1;
					}
					new	Float:hp,msg[128],name[128];
					GetPlayerHealth(id,hp);
					GetPlayerName(id,name,128);
					format(msg,128,"%s��Ѫ��(HP)Ϊ%f",name,hp);
					SendClientMessage(playerid,	0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/allsellhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128],msg[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1338)
			{
				for(new	u=0;u<pickupids;u++)
				{
					if(ZFJGLX[u]==3)
					{
						format(ZFJGSTR[u],128,"δ����");
						ZFJGTID[u]=1273;
						ZFJGLOCK[u]=0;
						format(msg,128,"<��������>��������:%s",ZFJGSTR1[u]);
						SendClientMessage(playerid,0x00FF00AA,msg);
					}
				}
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/refill")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==5)
			{
				new	tmp[128],id,fill;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/refill	[����ID] [������]");
					return 1;
				}
				id=strval(tmp);
				if(car[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"û��������");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp, " ")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��������Ϊ��");
					return 1;
				}
				fill=strval(tmp);
				if(fill<1||fill>100)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����������1С��100!");
					return 1;
				}
				carfill[id]=fill;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǽ���վ����Ա");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/afill")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>=2)
			{
				new	tmp[128],id,fill;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/afill	[����ID] [������]");
					return 1;
				}
				id=strval(tmp);
				if(car[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"û��������");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp, " ")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"��������Ϊ��");
					return 1;
				}
				fill=strval(tmp);
				if(fill<1||fill>1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����������1С��1000!");
					return 1;
				}
				carfill[id]=fill;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻�Ǽ���վ����Ա");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckzhizhao")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ckzhizhao [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(id,name,128);
				format(msg,128,"----%sӵ�е�ִ��----",name);
				SendClientMessage(playerid,0x708090AA,msg);
				format(msg,128,"����ִ��:%s",tg[playergunzhizhao[id]]);
				SendClientMessage(playerid,0x708090AA,msg);
				format(msg,128,"��ʻִ��:%s",tg[playercarzhizhao[id]]);
				SendClientMessage(playerid,0x708090AA,msg);
				SendClientMessage(playerid,0x708090AA,"--------------------");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
	if(strcmp(cmd,"/ckwuqi")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ckwuqi	[���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½!");
					return 1;
				}
				new	msg[256],name[128];
				GetPlayerName(id,name,128);
				format(msg,128,"|----%s----|",name);
				SendClientMessage(playerid,	0xDC143CAA,msg);
				for(new	i=0;i<7;i++)
				{
					format(msg,256,"����%dID:%d	/�����ֿ�%d������ID:%d",i,playerwuqi[id][i],i,playerinvwuqi[id][i]);
					SendClientMessage(playerid,	0xDC143CAA,msg);
				}
				SendClientMessage(playerid,	0xDC143CAA,"|----�����б�----|");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setlv")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1337)
			{
				new	tmp[128],id,up;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/setlv	[���id] [�ȼ�]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				up=strval(tmp);
				if(up<1)
				{
					SendClientMessage(playerid,0x00FF00AA,"�ȼ��������0");
					return 1;
				}
				playerlv[id]=up;
				SetPlayerScore(playerid,playerlv[id]);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setlvup")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1337)
			{
				new	tmp[128],id,up;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/setlvup [���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				up=strval(tmp);
				if(up<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����������0");
					return 1;
				}
				playerlvup[id]=up;
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/settime")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/settime [ʱ��]");
					return 1;
				}
				id=strval(tmp);
				if(id<0||id>24)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����ʱ��(0-24)");
					return 1;
				}
				SetWorldTime(id);
				new	msg[128];
				format(msg,128,"ʱ�䱻����Ϊ%d��",id);
				SendClientMessageToAll(0xDC143CAA,msg);
//SendClientMessage(playerid, 0xDC143CAA,"�˹���ֹͣʹ��");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/jianjin")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				new	id,t;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/jianjin [���id] [ʱ��(��)] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"����Ҳ�����!");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"��������Ϊ��!");
					return 1;
				}
				t=strval(tmp);
				if(t<1)
				{
					SendClientMessage(playerid,	0xDC143CAA,"��������С��1!");
					return 1;
				}
				if(id == playerid && t<60 && playerjianyutime[id] > 0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"��Ҫ����Ȩ��(���Լ��м���ʱ�䲢���ٴμ���Լ�60������)!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"���ɲ���Ϊ��!");
					return 1;
				}
				for(new	i=0;i<7;i++)
				{
					playerwuqi[id][i]=0;
				}
				ResetPlayerWeaponEx(id);
				SetPlayerPos(id,264.752624,77.582786,1001.039062);
				SetPlayerInterior(id,6);
				SetPlayerSkin(id,252);
				houseid[id]=3;
				playerjianyutime[id]=t;
				su[id]=0;
				new	msg[128];
				new	name[128],name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[���]%s��%s���%d��,����:%s",name,name1,t,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xsld")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==14)
			{
				SetPlayerColor(playerid,0x1229FAFF);
							SendClientMessage(playerid,	0xDC143CAA,"����ǳ���ɫ�Ѿ��ı������ɫ���������λ�����ڵ�ͼ�ϱ��Ŷ~");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻�Ǿ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xsdl")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==1)
			{
				SetPlayerColor(playerid,0x00C2ECFF);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻�Ǽ���!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xssl")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==4)
			{
				SetPlayerColor(playerid,0x00BFFFF);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��FBI!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xsfd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==6)
			{
				SetPlayerColor(playerid,0xE100E1FF);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��ҽ��!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/xshd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				SetPlayerColor(playerid,0xFFFF00FF);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻�ǹ���Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ycd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==1||playerzuzhi[playerid]==4||playerzuzhi[playerid]==6||playerzuzhi[playerid]==14)
			{
				SetPlayerColor(playerid,0xF8F8FF00);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vipycd")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerviplv[playerid]!=0)
			{
				SetPlayerColor(playerid,0xF8F8FF00);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�Բ���������VIP�û����������д���Ȩ����");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vipshow")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerviplv[playerid]!=0)
			{
                SetPlayerColor(playerid,COLOR_RED);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�Բ���������VIP�û����������д���Ȩ����");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/stv")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				TogglePlayerSpectating(playerid,0);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/tv")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/tv [���id");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				TogglePlayerSpectating(playerid, 1);
				PlayerSpectatePlayer(playerid, id);
				SetPlayerInterior(playerid,GetPlayerInterior(id));
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/mypos")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(strcmp(name,"")==0||strcmp(name,"")==0)
			{
					new	Float:x,Float:y,Float:z,h;
					new	msg[128];
					GetPlayerPos(playerid,x,y,z);
					h=GetPlayerInterior(playerid);
					format(msg,128,"�㵱ǰ�Ļ���ID��%d,������%f,%f,%f(x,y,z)",h,x,y,z);
					SendClientMessage(playerid,0x00FF00AA,msg);
					printf("%s��ǰ�Ļ���ID��%d,������%f,%f,%f(x,y,z)",name,h,x,y,z);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------
	if(strcmp(cmd,"/changezzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	id,Float:px,Float:py,Float:pz;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/changezzhouse [ID] [ͼ��ID] [������֯ID]	[����]  [����ID] [��������X] [��������Y] [��������Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"û����䷿��");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==3)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�޸ķ�������/changehouse!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(cmd,"	")!=0)
					{
						ZFJGTID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(cmd,"	")!=0)
					{
						ZFJGZUZHI[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						format(ZFJGSTR[id],128,"%s",tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGHID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCX[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCY[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCZ[id]=floatstr(tmp);
					}
					GetPlayerPos(playerid,px,py,pz);
					ZFJGX[id]=px;
					ZFJGY[id]=py;
					ZFJGZ[id]=pz;
					new	msg[128];
					format(msg,128,"�㽫IDΪ%d����֯����Ϣ�޸���",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"�µ���Ϣ:����:%s ������֯ID:%d ����ID:%d ����x����:%f ����y����:%f ����z����:%f",ZFJGSTR[id],ZFJGZUZHI[id],ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-------
	if(strcmp(cmd,"/changegzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	id,Float:px,Float:py,Float:pz;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/changegzhouse [ID] [ͼ��ID] [����] [���ػ���ID] [����ID]	[��������X] [��������Y]	[��������Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"û����䷿��");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==3)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�޸ķ�������/changehouse!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(cmd,"	")!=0)
					{
						ZFJGTID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						format(ZFJGSTR[id],128,"%s",tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGLOCALHID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGHID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCX[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCY[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCZ[id]=floatstr(tmp);
					}
					GetPlayerPos(playerid,px,py,pz);
					ZFJGX[id]=px;
					ZFJGY[id]=py;
					ZFJGZ[id]=pz;
					new	msg[128];
					format(msg,128,"�㽫IDΪ%d����������Ϣ�޸���",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"�µ���Ϣ:����:%s ���ػ���ID:%d ����ID:%d ����x����:%f ����y����:%f ����z����:%f",ZFJGSTR[id],ZFJGLOCALHID[id],ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//--------
	if(strcmp(cmd,"/changehouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	id,Float:px,Float:py,Float:pz;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/changehouse [����ID]	[����] [�۸�] [�ȼ�] [����ID] [��������X]	[��������Y] [��������Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"û����䷿��");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==1)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�޸�������������/changegzhouse!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						format(ZFJGSTR1[id],128,"%s",tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGMONEY[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGLV[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGHID[id]=strval(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCX[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCY[id]=floatstr(tmp);
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")!=0)
					{
						ZFJGCZ[id]=floatstr(tmp);
					}
					GetPlayerPos(playerid,px,py,pz);
					ZFJGX[id]=px;
					ZFJGY[id]=py;
					ZFJGZ[id]=pz;
					new	msg[128];
					format(msg,128,"�㽫IDΪ%d�ķ�����Ϣ�޸���",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"�µ���Ϣ:����:%s �۸�:%d ����ȼ�:%d",ZFJGSTR1[id],ZFJGMONEY[id],ZFJGLV[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"����ID:%d ����x����:%f ����y����:%f	����z����:%f",ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/gotohouse")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�:/gotohouse	[����id]");
					return 1;
				}
				id=strval(tmp);
				if(ZFJGLX[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�÷�������");
					return 1;
				}
				if(ZFJGLX[id]==2)
				{
					SetPlayerPos(playerid,ZFJGX[id],ZFJGY[id],ZFJGZ[id]);
				}
				if(ZFJGLX[id]!=2)
				{
					houseid[playerid]=id;
					SetPlayerPos(playerid,ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SetPlayerInterior(playerid,ZFJGHID[id]);
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/cktbhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1338)
			{
				new	msg[128];
				for(new	h=0;h<pickupids;h++)
				{
					if(ZFJGLX[h]==2)
					{
						if(XY(1.5,playerid,ZFJGX[h],ZFJGY[h],ZFJGZ[h])==1)
						{
							format(msg,128,"ID:%d,ͼ��ID:%d,����1:%s ����2:%s",h,ZFJGTID[h],ZFJGSTR[h],ZFJGSTR1[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckgzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1338)
			{
				new	msg[128];
				for(new	h=0;h<pickupids;h++)
				{
					if(ZFJGLX[h]==1)
					{
						if(XY(1.5,playerid,ZFJGX[h],ZFJGY[h],ZFJGZ[h])==1)
						{
							format(msg,128,"ID:%d,����:%s,���ػ���ID:%d,����ID:%d,����X:%f,����Y:%f,����Z:%f",h,ZFJGSTR[h],ZFJGLOCALHID[h],ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/kick")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/kick	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[����]%s��%s�߳�������,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				SetTimerEx("KickEx",2000,false,"i",id);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ikick1")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircadmin[playerid]==1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ikick1	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC�߳�]%s��IRC����Ա%s�߳�IRCƵ��,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��IRCƵ��1����Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ikick2")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircadmin[playerid]==1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ikick2	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC�߳�]%s��IRC����Ա%s�߳�IRCƵ��,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��IRCƵ��2����Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ikick3")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircadmin[playerid]==1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ikick3	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC�߳�]%s��IRC����Ա%s�߳�IRCƵ��,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��IRCƵ��3����Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ikick4")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircadmin[playerid]==1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ikick4	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC�߳�]%s��IRC����Ա%s�߳�IRCƵ��,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��IRCƵ��4����Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ikick5")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircadmin[playerid]==1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ikick5	[���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC�߳�]%s��IRC����Ա%s�߳�IRCƵ��,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻��IRCƵ��5����Ա!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ban")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/ban [���id] [����]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����Ҳ�����");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"���ɲ���Ϊ��");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[BAN]%s������Ա%s�������ʺ�,����:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				BanEx(id,tmp);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckzzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1338)
			{
				new	msg[128];
				for(new	h=0;h<pickupids;h++)
				{
					if(ZFJGLX[h]==4)
					{
						if(XY(1.5,playerid,ZFJGX[h],ZFJGY[h],ZFJGZ[h])==1)
						{
							format(msg,128,"����ID:%d,��������:%s,����������֯ID:%d",h,ZFJGSTR[h],ZFJGZUZHI[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
							format(msg,128,"��������ID:%d,��������X:%f,��������Y:%f	,��������Z:%f",ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckhouse")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1338)
			{
				new	msg[128];
				for(new	h=0;h<pickupids;h++)
				{
					if(ZFJGLX[h]==3)
					{
						if(XY(1.5,playerid,ZFJGX[h],ZFJGY[h],ZFJGZ[h])==1)
						{
							format(msg,128,"����ID:%d,��������:%s,���Ӽ۸�:%d,���ӹ���ȼ�:%d",h,ZFJGSTR1[h],ZFJGMONEY[h],ZFJGLV[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
							format(msg,128,"��������ID:%d,��������X:%f,��������Y:%f	,��������Z:%f",ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckhstats")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/ckhstats [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"======================������Ϣ======================");
				new	msg[128];
				for(new	u=0;u<pickupids;u++)
				{
					if(ZFJGLX[u]==3)
					{
						if(playerlock[id]==u||playerlock1[id]==u||playerlock2[id]==u)
						{
							format(msg,128,"����ID:%d ��������:%s ���ݼ۸�:%d ���ݹ���ȼ�:%d ����״̬(0Ϊ����,1Ϊ����):%d",u,ZFJGSTR1[u],ZFJGMONEY[u],ZFJGLV[u],ZFJGLOCK[u]);
							SendClientMessage(playerid,	0xD3D3D3FF,msg);
						}
					}
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckvstats")==0)
	{
		if(SL[playerid]==1)
		{
				if(playeradmin[playerid]>= 1)
			{
				new	tmp[128],id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/ckvstats [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[256];
				SendClientMessage(playerid,	0xD3D3D3FF,"======================������Ϣ======================");
				if(playercar[id]!=0)
				{
					for(new	i=1;i<999;i++)
					{
						if(strcmp(carname[i],playername[id])==0)
						{
							if(car[i]!=0)
							{
								format(msg,128,"����ID:%d ����ģ��:%d ������ɫ1:%d ������ɫ2:%d	����������֯:%s	������ֵ:%d",car[i],carmoxing[i],carcolor1[i],carcolor2[i],zuzhiname[carzuzhi[i]],carmoney[i]);
								SendClientMessage(playerid,	0xD3D3D3FF,msg);
							}
						}
					}
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/ckstats")==0)
	{
		if(SL[playerid]==1)
		{
				if(playeradmin[playerid]>= 1)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/ckstats [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[256];
SendClientMessage(playerid, 0x008040FF,"===================================================================");
format(msg,256,"|����:%s| |��Ǯ:%d |��֯:%s| |��֯�ȼ�:%s| |��������:%d| |VIP�ȼ�:%d| |VIP�ɳ�ֵ:%d/%d|",playername[id],playermoney[id],zuzhiname[playerzuzhi[id]],zuzhilv[playerzuzhi[id]][playerzuzhilv[id]],playercar[id],playerviplv[id],playervipczz[id],playerviplv[id]*8);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|����Կ��1:%d| |����Կ��2:%d| |����Կ��3:%d| |���:%d| |�绰���:%d| |V�����:%d|",playerlock[id],playerlock1[id],playerlock2[id],playerbank[id],playercallmoney[id],playervdou[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|�ȼ�:%d| |������:%d/%d| |�绰����:%d| |����:%s| |����:%d| |ƽ��:%d|",playerlv[id],playerlvup[id],playerlv[id]*8,playercall[id],gongzuoname[playerjob[id]],playermats[id],playeripad[playerid]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|��ǰƤ��:%d| |����ʣ��ʱ��:%d| |ͨ���ȼ�:%d| |��ǰ������:%d|",playerskin[id],playerjianyutime[id],su[id],playerspawn[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|�Ƿ�̳̹�:%d| |�Ա�:%d|	|���֤���:%d| |����:%d|",playerput[id],playersex[id],playersfz[id],playerage[id]);
SendClientMessage(playerid,	0xD3D3D3FF,msg);
SendClientMessage(playerid, 0x008040FF,"===================================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	/*if(strcmp(cmd,"/ckjike")==0)
	{
		if(SL[playerid]==1)
		{
				if(playeradmin[playerid]>= 3333)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/ckjike [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[256];
format(msg,256,"����:%s ����ֵ:%d �ڿ�ֵ:%d",playername[id],playerjiedu[id],playerkouke[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}*/
//-------------------------------------------------[MDC�������Ͽ�ϵͳ]------------
	if(strcmp(cmd,"/mdc")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==14)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/mdc [Ŀ��ID]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
					return 1;
				}
				new	msg[256];
				SendClientMessage(playerid,	0x008040FF,"======================MDC�������Ͽ�======================");
				format(msg,256,"������:[%s]	",playername[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"ͨ���ȼ�:[%d] ",su[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"����ʱ��:[%d] ",playerjianyutime[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"LSPD�����MDC�������Ͽ��ƶ�����ϵͳ");
				SendClientMessage(playerid,	0xFFFFFFFF,msg);
				SendClientMessage(playerid,	0x008040FF,"==============================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"�㲻�Ǿ���/FBI/����");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------------------------------------------------[����AR]-----------------
	if(strcmp(cmd,"/ar")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3)
			{
				new	tmp[128];
				new	id,ar;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/ar	[���id] [ar��]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"ar����Ϊ��");
					return 1;
				}
				ar=strval(tmp);
				SetPlayerArmour(id,ar);
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"���AR��%s����Ϊ��%d!",name,ar);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-----------------------------------------------------------------[����HP]-----------------
	if(strcmp(cmd,"/hp")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 3)
			{
				new	tmp[128];
				new	id,hp;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/hp	[���id] [hp��]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"hp����Ϊ��");
					return 1;
				}
				hp=strval(tmp);
				SetPlayerHealth(id,hp);
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"���HP��%s����Ϊ��%d!",name,hp);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//----------------------------[��������]----------------------------------
	if(strcmp(cmd,"/zuoar")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==3)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/zuoar [���id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				if(playermats[playerid]<100)
				{
					SendClientMessage(playerid,0x00FF00AA,"��û���㹻����������(100)����������!");
					return 1;
				}
				//playerid=strval(tmp);
				SetPlayerArmour(id,100);
				playermats[playerid]=playermats[playerid]-100;
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"���%s�����ֲ��������ɷ�����,��������������!",name);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"�㲻����������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//===========================================================================================
if(strcmp(cmd,"/givegun") == 0)
{
	if(!SL[playerid])
	{
	    SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
	    return 1;
	}
	if(playerjob[playerid] != 3)
	{
	    SendClientMessage(playerid, 0xDC143CAA,"����,����ԭ��:�㲻����������");
		return 1;
	}
	if(playermats[playerid] < 300)
	{
		SendClientMessage(playerid,0x00FF00AA,"����ϲ���");
		return 1;
	}
	new tmp[256];
	new weapid,giveplayid;
	tmp=strtok(cmdtext,idx);
	if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_WHITE, "�÷�: /givegun [����ID] [���ID]");
		return 1;
	}
    weapid=strval(tmp);

    tmp=strtok(cmdtext,idx);
	if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_WHITE, "�÷�: /givegun [����ID] [���ID]");
		return 1;
	}
    giveplayid = strval(tmp);

    if(weapid == 34 || weapid == 28 || weapid == 27 || weapid == 26 || weapid == 17 || weapid == 1 || weapid == 3 || weapid == 9 || weapid == 16 || weapid == 35 || weapid == 36 || weapid == 37 || weapid == 38 || weapid == 39 || weapid == 40 || weapid == 44 || weapid == 23 || weapid == 15 || weapid == 45 || weapid == 34)
    {
  		SendClientMessage(playerid, COLOR_WHITE, "�㲻�����������!");
		return 1;
    }

    for(new i = 0; i < 7; i++)
    {
	    if(playerwuqi[giveplayid][i] == 0 )
		{
 			new msg[128],name[MAX_PLAYER_NAME],name1[MAX_PLAYER_NAME];

			playerwuqi[giveplayid][i] = weapid;
			playermats[playerid] = playermats[playerid] - 300;

			GetPlayerName(playerid,name,MAX_PLAYER_NAME);
			GetPlayerName(giveplayid,name1,MAX_PLAYER_NAME);
			GivePlayerWeaponEx(giveplayid,weapid,450);

			format(msg,128,"%s������һ������[����id %d].!",name,weapid);
			SendClientMessage(giveplayid,COLOR_PURPLE,msg);

			format(msg,128,"�����%sһ������[����id %d].!",name1,weapid);
			SendClientMessage(playerid,COLOR_PURPLE,msg);

			format(msg,128,"[��������][ID:%d]%s����[ID:%d]%sһ������[����id %d]",playerid,name,giveplayid,name1,weapid);
			ABroadCast(0x00FF00AA,msg,1);
			return 1;
		}
	}
}
//------------------------------------------------------------------
/*if(strcmp(cmd,"/hla")==0)
{
if(playeradmin[playerid]>= 5)
			{
new id;
new Float:x,Float:y,Float:z;
if(hdcd[id]==1)
GetPlayerPos(playerid,x,y,z);
SetPlayerPos(to[id],x+1,y+1,z+1);
SetPlayerInterior(to[id],GetPlayerInterior(playerid));
SetPlayerVirtualWorld(to[id],GetPlayerVirtualWorld(playerid));
houseid[to[id]]=houseid[playerid];
SendClientMessage(playerid,0xFFFACDAA,"�ɹ�����");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
if(strcmp(cmd,"/cjhd")==0)
{
if(SL[playerid]==1)
{
if(hdcd=toid)
{
new sc;
new id;
for(sc=0;sc<MAX_PLAYERS;sc++)
hdcd[sc]=1;
SendClientMessage(playerid,0xDC143CAA,"�㱨���μ��˻");
to[id]=sc;
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"������û�д򿪻����");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"��û�е�¼");
return 1;
}
if(strcmp(cmd,"/qxhd")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 5)
			{
new msg[128],id;
hdcd[to[id]]=0;
format(msg,128,"����Ա�����������˻״̬");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"��û�е�¼");
return 1;
}
if(strcmp(cmd,"/gbhd")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 5)
			{
new msg[128];
hdcd=tocar;
format(msg,128,"����Ա�ر��˻����");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"��û�е�¼");
return 1;
}
if(strcmp(cmd,"/dkhd")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 5)
			{
new msg[128];
hdcd=toid;
format(msg,128,"[�ϵͳ]:�����������˻����,��μӻ������/cjhd�μ�.");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"��û�е�¼");
return 1;
}
if(strcmp(cmd,"/szhd")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 5)
			{
new tmp[128];
new id;
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid, 0x00BFFFF,"�÷�:/szhd [���id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"�����û�е�½");
return 1;
}
playerid=strval(tmp);
SetPlayerHealth(id,100);
SetPlayerArmour(id,100);
hdcd[id]=1;
new msg[128],name[128];
GetPlayerName(playerid,name,128);
format(msg,128,"�㱻����Ϊ�˻״̬!");
SendClientMessage(id, 0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}*/
//=============================================================================
if(strcmp(cmd,"/live")==0)
{
if(SL[playerid]==1)
{
if(playerzuzhi[playerid]==1)
{
new tmp[128];
new id;
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid, 0x00BFFFF,"�÷�:/live [���id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"�����û�е�½");
return 1;
}
					new	vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�����Ų�����/�ɻ���!");
						return 1;
					}
					if(mod!=582&&mod!=488)
					{
						SendClientMessage(playerid,0x00FF00AA,"�ⲿ����/�ɻ���û�����ߵ�̨!");
						return 1;
					}
if(playerlive[id]==1)
{
SendClientMessage(playerid,0x00FF00AA,"������Ѿ�������Newsֱ��̨��!");
return 1;
}
playerid=strval(tmp);
playerlive[id]=1;
new msg[128];
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"����%s���������Newsֱ��̨,��������ʹ��/e��ʼ��̸��.",name);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"�㽫���%s������Newsֱ��̨,ʹ��/ulive����ȡ������.",name1);
SendClientMessage(playerid,0xE5C43EAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}
//=============================================================================
if(strcmp(cmd,"/ulive")==0)
{
if(SL[playerid]==1)
{
if(playerzuzhi[playerid]==1)
{
new tmp[128];
new id;
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid, 0x00BFFFF,"�÷�:/live [���id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"�����û�е�½");
return 1;
}
if(playerlive[id]==0)
{
SendClientMessage(playerid,0x00FF00AA,"����Ҳ�û�б�����Newsֱ��̨!");
return 1;
}
playerid=strval(tmp);
playerlive[id]=0;
new msg[128];
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"����%sȡ���˶��������,�ɷý���.",name);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"��ȡ���˶�%s������,�ɷý���.",name1);
SendClientMessage(playerid,0xE5C43EAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}
//=============================================================================
	if(strcmp(cmd,"/e")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerlive[playerid]== 1)
			{
				new	tmp[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"�÷�:/e	[����]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[�ҵ��й������ߵ�̨�ɷ�]:{90FFAA}%s_%s˵:{1493FF}%s{1493FF}",zuzhilv[playerzuzhi[playerid]],name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"��û�б�������������!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//--------------------------------[����ʱ]--------------------------------
/*if (strcmp("/count", cmdtext, true) == 0)//�����/count���Ե���ʱ��
{
if(playeradmin[playerid]>= 2)
			{
shu1 = SetTimer("cj",200,1);
shu2 = SetTimer("cj2",1200,1);
shu3 = SetTimer("cj3",2200,1);
shu4 = SetTimer("cj4",3200,1);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"�㲻�ǹ���Ա!");
return 1;
}*/
if(strcmp(cmd,"/text")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 4)
			{
new tmp[128];
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0x00FF00AA,"�÷�:/text [����(����Ӣ��)]");
return 1;
}
new msg[128],name[128];
GetPlayerName(playerid,name,128);
format(msg,128,"%s",tmp);
GameTextForAll(msg,5000,3);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"��û��Ȩ��!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
return 1;
}
if(strcmp(cmd,"/gtq", true) == 0)
{
	if(IsPlayerConnected(playerid))
	{
		if(playeradmin[playerid]>= 3)
		{
			new tmp[128],sendername[128],string[128];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x00FF00AA, "�÷�:/gtq [����ID]");
			return 1;
			}
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45)
			{
				SendClientMessage(playerid,0x00FF00AA, "����id���� 0~45");
			return 1;
			}
			SetWeather(weather);
			//SendClientMessage(playerid, COLOR_GREY, " �Ҳ�,��E��,���÷���,�ں��� %s KangYee��." , weather);//You have set the weather to
			tmp = strtok(cmdtext,idx);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 256, "[����]����Ա%s���������ñ��Ϊ %d ������.", sendername,weather);
			SendClientMessageToAll(0xDC143CAA,string);
//			DefaultWeather=weather;
		}
	return 1;
	}
SendClientMessage(playerid, 0x00FF00AA, "   �㲻�ǹ���Ա!");
return 1;
}
//----------------------------------------------[APM]---------------------------------------
if(strcmp(cmd,"/apm")==0)
{
if(SL[playerid]==1)
{
if(playeradmin[playerid]>= 1)
			{
new tmp[128],id;
new msg[128];
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0x00FF00AA,"�÷�:/apm [���id] [����]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid,0x00FF00AA,"�����û�е�½");
return 1;
}
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ݲ���Ϊ��");
return 1;
}
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"[APM]����Ա[ID:%d]%s����˵:%s",playerid,name,tmp);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"[APM]������%s˵:%s",name1,tmp);
SendClientMessage(playerid,0xE5C43EAA,msg);
format(msg,128,"[APM]����Ա%s�����%s˵:%s.",name,name1,tmp);
ABroadCast(0x00FF00AA,msg,1);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"�㲻�ǹ���Ա!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}
//-----------------------------------------------[��ɱ]----------------------------------
/*if(strcmp(cmd,"/kill")==0)
{
if(SL[playerid]==1)
{
new	msg[128];
new	id[128];
new	tmp[128];
SetPlayerHealth(playerid, 0.0);
format(msg,128,"��ɹ���ɱ��,�㽫����ҽԺ����,����ϧ����!",id,tmp);
SendClientMessage(playerid,0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
return 1;
}*/
//----------------------------------------------------------------------------------
	if(strcmp(cmd,"/pai")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 2)
			{
					new	tmp[128];
					new	id;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/pai [���id] ����");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
						return 1;
					}
					tmp=strtokp(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"���ɲ���Ϊ��");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					SetPlayerPos(id,x,y,z+10);
					new	name[128],name1[128];
					new	msg[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128," %s��%s��������һ��,����:%s",name,name1,tmp);
					SendClientMessageToAll(0xDC143CAA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/gotocar")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
					new	tmp[128];
					new	id;
					new	Float:x,Float:y,Float:z;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/gotocar [��id]");
						return 1;
					}
					id=strval(tmp);
					if(GetVehicleModel(id)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�ó��������ڣ�");
						return 1;
					}
					GetVehiclePos(id,x,y,z);
					SetPlayerPos(playerid,x+1,y+1,z+1);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/allsc")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 4)
			{
			    if (allscactive == 1)
			    {
			        SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��ȴ���ǰ���ڽ��еĵ���ʱ����.");
			        return 1;
			    }
	            allscactive = 1;
				allscdjstime = SetTimer("daojishi",1000,1);
				new name1[128],ak[128];
				GetPlayerName(playerid,name1,128);
				format(ak,128,"[��������Ϣ]����Ա%s��������ʱ׼��ˢ������δʹ�õĳ���~�ǵ���/vpark�޸���ĳ��ĳ�����Ŷ!",name1);
				SendClientMessageToAll(0xFFFACDAA,ak);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/changetbhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
				new	tmp[128];
				new	id;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/changetbhouse [ID]	[ͼ��ID] [����1] [����2] (Ϊ����ԭ����) ");
					return 1;
				}
				id=strval(tmp);
				if(ZFJGLX[id]!=2)
				{
					SendClientMessage(playerid,	0xDC143CAA,"��ָ��ֻ�����޸�ͼ���෿��!");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")!=0)
				{
					ZFJGTID[id]=strval(tmp);
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")!=0)
				{
					format(ZFJGSTR[id],128,"%s",tmp);
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")!=0)
				{
					format(ZFJGSTR1[id],128,"%s",tmp);
				}
				ZFJGLX[id]=2;
				ZFJGHID[id]=0;
				GetPlayerPos(playerid,ZFJGX[id],ZFJGY[id],ZFJGZ[id]);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/addtbhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
				new	tmp[128];
				new	miaoshu[128],miaoshu1[128],tid;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/addtbhouse	[ͼ��ID] [����1] [����2] ");
					return 1;
				}
				tid=strval(tmp);
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"����1����Ϊ��");
					return 1;
				}
				format(miaoshu,128,"%s",tmp);
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"����2����Ϊ��");
					return 1;
				}
				format(miaoshu1,128,"%s",tmp);
				ZFJGLX[pickupids]=2;
				ZFJGTID[pickupids]=tid;
				format(ZFJGSTR[pickupids],128,"%s",miaoshu);
				format(ZFJGSTR1[pickupids],128,"%s",miaoshu1);
				ZFJGHID[pickupids]=0;
				GetPlayerPos(playerid,ZFJGX[pickupids],ZFJGY[pickupids],ZFJGZ[pickupids]);
				pickupids++;
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//--------------------
	if(strcmp(cmd,"/addzzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	zuzhiid,miaoshu[128],tid,hid,Float:x,Float:y,Float:z,Float:px,Float:py,Float:pz;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/addzzhouse	[�ſ�����ID] [������֯ID] [����] [���һ���ID] [��������X]	[��������Y] [��������Z]");
						return 1;
					}
					tid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"������֯����Ϊ��");
						return 1;
					}
					zuzhiid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Ϊ��");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"���һ���ID����Ϊ��");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������X����Ϊ��");
						return 1;
					}
					x=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Y����Ϊ��");
						return 1;
					}
					y=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Z����Ϊ��");
						return 1;
					}
					z=floatstr(tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=4;
					ZFJGTID[pickupids]=tid;
					format(ZFJGSTR[pickupids],128,"%s",miaoshu);
					ZFJGHID[pickupids]=hid;
					ZFJGX[pickupids]=px;
					ZFJGY[pickupids]=py;
					ZFJGZ[pickupids]=pz;
					ZFJGCX[pickupids]=x;
					ZFJGCY[pickupids]=y;
					ZFJGCZ[pickupids]=z;
					ZFJGZUZHI[pickupids]=zuzhiid;
					ZFJGLOCK[pickupids]=0;
					pickupids++;
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//----------------
	if(strcmp(cmd,"/addgzhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	localhid,miaoshu[128],tid,hid,Float:x,Float:y,Float:z,Float:px,Float:py,Float:pz;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/addgzhouse	[�ſ�����ID] [����]	[���ػ���ID] [���һ���ID] [��������X]	[��������Y] [��������Z]");
						return 1;
					}
					tid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Ϊ��");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(cmd,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"���ػ���ID����Ϊ��");
						return 1;
					}
					localhid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"���һ���ID����Ϊ��");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������X����Ϊ��");
						return 1;
					}
					x=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Y����Ϊ��");
						return 1;
					}
					y=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������Z����Ϊ��");
						return 1;
					}
					z=floatstr(tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=1;
					ZFJGTID[pickupids]=tid;
					format(ZFJGSTR[pickupids],128,"%s",miaoshu);
					ZFJGHID[pickupids]=hid;
					ZFJGLOCALHID[pickupids]=localhid;
					ZFJGX[pickupids]=px;
					ZFJGY[pickupids]=py;
					ZFJGZ[pickupids]=pz;
					ZFJGCX[pickupids]=x;
					ZFJGCY[pickupids]=y;
					ZFJGCZ[pickupids]=z;
					pickupids++;
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/addhouse")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid] >= 1338)
			{
					new	tmp[128];
					new	miaoshu[128];
					new	money,hid,x[128],y[128],z[128],Float:px,Float:py,Float:pz,lv;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/addhouse [����] [�۸�]	[����ȼ�] [���һ���ID]	[��������X] [��������Y]	[��������Z]");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�۸���Ϊ��");
						return 1;
					}
					money=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00BFFFF,"����ȼ�����Ϊ��");
						return 1;
					}
					lv=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"���һ���ID����Ϊ��");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������x����Ϊ��");
						return 1;
					}
					format(x,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������y����Ϊ��");
						return 1;
					}
					format(y,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������z����Ϊ��");
						return 1;
					}
					format(z,128,"%s",tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=3;
					ZFJGTID[pickupids]=1273;
					format(ZFJGSTR[pickupids],128,"δ����");
					format(ZFJGSTR1[pickupids],128,"%s",miaoshu);
					ZFJGHID[pickupids]=hid;
					ZFJGX[pickupids]=px;
					ZFJGY[pickupids]=py;
					ZFJGZ[pickupids]=pz;
					ZFJGCX[pickupids]=floatstr(x);
					ZFJGCY[pickupids]=floatstr(y);
					ZFJGCZ[pickupids]=floatstr(z);
					ZFJGMONEY[pickupids]=money;
					ZFJGLOCK[pickupids]=0;
					ZFJGZJ[pickupids]=99;
					ZFJGLV[pickupids]=lv;
					pickupids++;
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	//============================================================================================
	/*if(strcmp(cmd,"/addcy")==0)
	{
		if(SL[playerid]==1)
		{
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(playeradmin[playerid]>= 1338)
			{
					new	tmp[128];
					new	miaoshu[128];
					new	money,hid,x[128],y[128],z[128],Float:px,Float:py,Float:pz,lv;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/addhouse ���� �۸�	����ȼ� ���һ���ID	��������X ��������Y	��������Z");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�۸���Ϊ��");
						return 1;
					}
					money=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00BFFFF,"����ȼ�����Ϊ��");
						return 1;
					}
					lv=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"���һ���ID����Ϊ��");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������x����Ϊ��");
						return 1;
					}
					format(x,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������y����Ϊ��");
						return 1;
					}
					format(y,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"��������z����Ϊ��");
						return 1;
					}
					format(z,128,"%s",tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=3;
					ZFJGTID[pickupids]=1273;
					format(ZFJGSTR[pickupids],128,"��ҵ-δ����");
					format(ZFJGSTR1[pickupids],128,"%s",miaoshu);
					ZFJGHID[pickupids]=hid;
					ZFJGX[pickupids]=px;
					ZFJGY[pickupids]=py;
					ZFJGZ[pickupids]=pz;
					ZFJGCX[pickupids]=floatstr(x);
					ZFJGCY[pickupids]=floatstr(y);
					ZFJGCZ[pickupids]=floatstr(z);
					ZFJGMONEY[pickupids]=money;
					ZFJGLOCK[pickupids]=0;
					ZFJGZJ[pickupids]=99;
					ZFJGLV[pickupids]=lv;
					pickupids++;
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
		if(strcmp(cmd,"/buycy")==0)
	{
		if(SL[playerid]==1)
		{
			new	id;
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
					{
						if(strcmp(ZFJGSTR[u],"δ����")!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"��䷿���Ѿ��������ˡ�");
							return 1;
						}
						if(playerlock[playerid]!=0&&playerlock1[playerid]!=0&&playerlock2[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"���Ѿ�ӵ��3�䷿����!�������������һ�䣡����������/sellhouse");
							return 1;
						}
						if(strcmp(ZFJGSTR[u],"δ����")==0)
						{
							id=u;
							u=pickupids+1;
						}
					}
				}
			}
			if(id==0)
			{
				return 1;
			}
			if(playermoney[playerid]<ZFJGMONEY[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"��������䷿�ӡ�");
				return 1;
			}
			if(playerlv[playerid]<ZFJGLV[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"��ĵȼ�������");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-ZFJGMONEY[id];
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			new	pd=0;
			if(playerlock[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock[playerid]=id;
			}
			if(playerlock1[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock1[playerid]=id;
			}
			if(playerlock2[playerid]==0&&pd==0)
			{
				pd=1;
				playerlock2[playerid]=id;
			}
			ZFJGTID[id]=1272;
			GetPlayerName(playerid,ZFJGSTR[id],128);
			SendClientMessage(playerid,0x00FF00AA,"������һ���·��ӣ�");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}*/
	//============================================================================================
	if(strcmp(cmd,"/skin")==0)
	{
		if(playeradmin[playerid]>= 3)
		{
			new	tmp[128];
			new	id,sid;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/skin [���id] [Ƥ��id]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/skin ���id Ƥ��id");
				return 1;
			}
			sid=strval(tmp);
			if(sid>299)
			{
				SendClientMessage(playerid,0xDC143CAA,"Ƥ��ID����(0-299)");
				return 1;
			}
			SetPlayerSkin(id,sid);
			playerskin[id]=sid;
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/ckcar")==0)
	{
		if(playeradmin[playerid]>= 1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			if(vid==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�㲻�ڳ���");
				return 1;
			}
			new	msg[128];
			format(msg,128,"[��������]:%s	[����ID]:%d [����ģ��]:%d [������ɫ1]:%d [������ɫ2]:%d	[����������֯]:%s	[������ֵ]:%d",carname[vid],car[vid],carmoxing[vid],carcolor1[vid],carcolor2[vid],zuzhiname[carzuzhi[vid]],carmoney[vid]);
			SendClientMessage(playerid,	0x00BFFFF,msg);
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/km")==0)
	{
		if(playeradmin[playerid]>= 1||playerzuzhi[playerid]==2)
		{
			if(XY(8,playerid,-714.5289,950.5165,12.93273601532)==1)
			{
				MoveDynamicObject(gate5,-715.1565,941.5165,12.93273601532,1.2);
				gatetime[5]=10;
				MoveDynamicObject(gate6,-714.5289,959.5165,12.93273601532,1.2);
				gatetime[6]=10;
				return 1;
			}
			if(XY(8,playerid,-662.64141845703, 921.30737304688,	12.816900253296)==1)
			{
				MoveDynamicObject(gate7, -662.64141845703, 931.30737304688,	12.816900253296,1.2);
				gatetime[7]=10;
				return 1;
			}
			if(XY(8,playerid,-693.50885009766, 966.04644775391,	13.770468711853)==1)
			{
				MoveDynamicObject(gate8,-693.50885009766, 966.04644775391, 8.770468711853,1.2);
				gatetime[8]=10;
				return 1;
			}
//====================================================================================
			if(XY(8,playerid,-670.24908447266, 966.9794921875, 12.752597808838)==1)
			{
				MoveDynamicObject(gate9, -670.24908447266, 966.9794921875, 8.752597808838,1.2);
				gatetime[9]=10;
				MoveDynamicObject(gate10,-670.43908691406, 962.10314941406,	13.897609710693,1.8);
				gatetime[10]=10;
				return 1;
			}
			if(XY(4,playerid,1688.2041015625 ,-1450.962890625 ,14.409767150879)==1)
			{
				MoveDynamicObject(gate16,1688.2041015625, -1450.962890625 ,10.85767150879,0.8);
				gatetime[16]=10;
				return 1;
			}
			if(XY(4,playerid,1142.3973, -2809.1465, 11.6500)==1)
			{
				MoveDynamicObject(gate26,1142.3973, -2809.1465, 8.6500,0.8);
				gatetime[22]=10;
				return 1;
			}
			if(XY(4,playerid,1161.2502, -2825.1479, 11.4450)==1)
			{
				MoveDynamicObject(gate27,1161.2502, -2825.1479, 8.4450,0.8);
				gatetime[23]=10;
				return 1;
			}
			if(XY(4,playerid,1690.296875, -1460.703125 ,19.970973968506)==1)
			{
				MoveDynamicObject(gate17,1686.2861328125, -1460.703125 ,19.970973968506,0.8);
				gatetime[17]=10;
				return 1;
			}
			if(XY(6,playerid,1686.668701,-1457.587158,21.040199)==1)
			{
				MoveDynamicObject(gate18,1696.001953125, -1458.2346191406 ,24.202903747559,0.8);
				gatetime[18]=20;
				MoveDynamicObject(gate19,1696.001953125, -1458.2346191406 ,24.202903747559,0.8);
				gatetime[19]=20;
				MoveDynamicObject(gate20,1678.5317382813 , -1458.1826171875	,24.202903747559,0.8);
				gatetime[20]=20;
				MoveDynamicObject(gate21,1678.5317382813 , -1458.1826171875	,24.202903747559,0.8);
				gatetime[21]=20;
				return 1;
			}
			SendClientMessage(playerid,0x0D7792AA, "�㸽��û�п��Դ򿪵���");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/sc")==0)
	{
		if(playeradmin[playerid]>= 3)
		{
				new	vid;
				vid=GetPlayerVehicleID(playerid);
				if(vid==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"�㲻��������!");
					return 1;
				}
				new	name[128],money,gzbc,gz[10],fill,zuzhi,moxing,Float:x,Float:y,Float:z,Float:mianxiang,c1,c2;
				zuzhi=carzuzhi[vid];
				moxing=carmoxing[vid];
				x=carx[vid];
				y=cary[vid];
				z=carz[vid];
				fill=carfill[vid];
				mianxiang=carmianxiang[vid];
				c1=carcolor1[vid];
				c2=carcolor2[vid];
				format(name,128,"%s",carname[vid]);
				money=carmoney[vid];
				gzbc=cargzbc[vid];
				for(new	i=0;i<10;i++)
				{
					gz[i]=cargz[vid][i];
				}
				DestroyVehicle(vid);
				car[vid]=0;
				vid=AddStaticVehicleEx(moxing,x,y,z,mianxiang,c1,c2,99999999999999999999999999);
				carzuzhi[vid]=zuzhi;
				carmoxing[vid]=moxing;
				carx[vid]=x;
				cary[vid]=y;
				carz[vid]=z;
				carfill[vid]=fill;
				carmianxiang[vid]=mianxiang;
				carcolor1[vid]=c1;
				carcolor2[vid]=c2;
				format(carname[vid],128,"%s",name);
				carmoney[vid]=money;
				cargzbc[vid]=gzbc;
				for(new	i=0;i<10;i++)
				{
					cargz[vid][i]=gz[i];
					AddVehicleComponent(vid,cargz[vid][i]);
				}
				caryinqing[vid]=0;
				cardengguang[vid]=0;
				carlock[vid]=0;
				SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
				car[vid]=vid;
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	/*if(strcmp(cmd,"/skcs")==0)
	{
	    if(playerzuzhilv[playerid]>=2)
		{
          if(playermoney[playerid]<10000)
		  {
 			SendClientMessage(playerid,	COLOR_GRAD1, "��ѽ��ûǮ�ͱ������");
 			return 1;
		  }
			if(SL[playerid]==1)
			{
				ShowPlayerDialog(playerid, GOTOMENU, DIALOG_STYLE_LIST,	"���Ͳ˵�(��û����ʾ����8000����)","��ɼ�����(LSPD)\n�ɽ�ɽ\n��˹ά��˹\n����LS�ɻ�����\n����\n���ڳ���\nǧ��ɽ��\nSASTС��\n���ڳ���2\n����ư�\n������	2\nҽԺ\n�׹�\n�ɻ���\n����\nС��\n���ɳ�\nGM���ش���(20000)\n��������\n�����ڲ�\n�����ص� ", "����", "ȡ��");
				return 1;
			}
			SendClientMessage(playerid,	COLOR_GRAD1, "	 ��δ��½.");
			return 1;
		}
		SendClientMessage(playerid,	COLOR_GRAD1, "	 ��û��Ȩ��.");
		return 1;
	}*/
	if(strcmp(cmd,"/la")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 1)
		{
				new	tmp[128];
				new	Float:x,Float:y,Float:z;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0xFFFACDAA,"�÷�:/la [���id]");
					return 1;
				}
				if(SL[strval(tmp)]==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetPlayerPos(strval(tmp),x+1,y+1,z+1);
				SetPlayerInterior(strval(tmp),GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(strval(tmp),GetPlayerVirtualWorld(playerid));
				houseid[strval(tmp)]=houseid[playerid];
				SendClientMessage(playerid,0xFFFACDAA,"�ɹ�����");
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/goto")==0)
{
if(SL[playerid]==1)
		{
if(playeradmin[playerid]>= 1)
		{
new tmp[128];
new Float:x,Float:y,Float:z;
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xFFFACDAA,"�÷�:/goto [���id]");
return 1;
}
new hid=GetPlayerInterior(strval(tmp));
if(SL[strval(tmp)]==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
return 1;
}
GetPlayerPos(strval(tmp),x,y,z);
SetPlayerPos(playerid,x+1,y+1,z+1);
houseid[playerid]=houseid[strval(tmp)];
SetPlayerInterior(playerid,hid);
SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(strval(tmp)));
SendClientMessage(playerid,0xFFFACDAA,"�ɹ�����");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
 if(strcmp(cmd,"/gq")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 1)
		{
			new	tmp[128];
			new	id,wid;
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/gq	[���id] [����id]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			wid=strval(tmp);
			if(wid>=47)
			{
				SendClientMessage(playerid,0xFFFACDAA,"����,����ԭ��:����ID����(0-46)");
				return 1;
			}
			for(new	i=0;i<7;i++)
			{
				playerwuqi[id][i]=0;
			}
//ResetPlayerWeaponEx(id);
			new	name[128],name1[128];
			new	msg[128];
			GetPlayerName(id,name,128);
			GetPlayerName(playerid,name1,128);
			for(new	i=0;i<7;i++)
			{
				if(playerwuqi[id][i]==0||wid==playerwuqi[id][i])
				{
					playerwuqi[id][i]=wid;
					GivePlayerWeaponEx(id,playerwuqi[id][i],1111111111);
					format(msg,128,"[ID:%d]%s����[ID:%d]%s��һ��IDΪ%d������.",playerid,name1,id,name,wid);
					ABroadCast(0x00FF00AA,msg,1);
					/*if(playergunzhizhao[id]==0&&wid!=0&&wid!=46&&wid!=41&&wid!=43&&wid!=42&&wid!=1&&wid!=2&&wid!=3&&wid!=4&&wid!=5&&wid!=6&&wid!=7&&wid!=8&&wid!=9&&wid!=14&&wid!=10&&wid!=11&&wid!=12&&wid!=13&&wid!=15)
					{
						if(su[id]<10)
						{
							su[id]=su[id]+1;
						}
						format(msg,128,"|+ͨ��+|%s��ͨ����,ͨ���ȼ�:%d,����:�Ƿ�Я��ǹ֧",name,su[id]);
						AdminXX(3,msg,0x00FF00AA);
						format(msg,128,"�����ڷǷ�Я��ǹ֧���Ա�ͨ���ˣ�Ŀǰͨ���ȼ�:%d",su[id]);
						SendClientMessage(id,0x00FF00AA,msg);
					}*/
					return 1;
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/gms")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 1337)
		{
			new	tmp[128];
			new	id,money;
			new	msg[128];
			new	name[128];
			new	name1[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/gms [���id] [Ǯ��] [����]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			id=strval(tmp);
   if(playeradmin[playerid]<3333)
   {
   if(id==playerid)
   {
   SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�����(�벻ҪˢǮ)!");
   return 1;
   }
   }
   tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			GetPlayerName(id,name1,128);
			if(money<0)
			{
				format(msg,128,"[����]%s��%s����%d,����:%s",name1,name,money,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
			}
			if(money>0)
			{
				format(msg,128,"[����]%s��%s������%d,����:%s",name1,name,money,tmp);
				SendClientMessageToAll(0x6495EDAA,msg);
			}
			playermoney[id]=playermoney[id]+money;
			ResetPlayerMoney(id);
			GivePlayerMoney(id,playermoney[id]);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/gmvdou")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 3333)
		{
			new	tmp[128];
			new	id,money;
			new	msg[128];
			new	name[128];
			new	name1[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/gmvdou [���id] [V������] [����]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			id=strval(tmp);
   if(id==playerid)
   {
   SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�����(�벻ҪˢV������)!");
   return 1;
   }
   tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			GetPlayerName(id,name1,128);
			if(money<0)
			{
				format(msg,128,"[V����Ϣ]%s��%s����%d V��,����:%s",name1,name,money,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
			}
			if(money>0)
			{
				format(msg,128,"[V����Ϣ]%s��%s������%d V��,����:%s",name1,name,money,tmp);
				SendClientMessageToAll(0x6495EDAA,msg);
			}
			playervdou[id]=playervdou[id]+money;
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	//=====================================================[���ó�������]===================
if(strcmp(cmd,"/szcar")==0)
{
if(SL[playerid]==1)
		{
if(playeradmin[playerid]>= 1337)
		{
new tmp[128];
new id,money;
new msg[128];
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xFFFACDAA,"�÷�:/szcar [���id] [��������] [����]");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money<0)
{
format(msg,128,"[������]:���%s������Ա%s��������������Ϊ��%d��,ִ������:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
if(money>0)
{
format(msg,128,"[������]:���%s������Ա%s��������������Ϊ��%d��,ִ������:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
playercar[id]=playercar[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
//=====================================================[���ý�Ǯ����]===================
/*if(strcmp(cmd,"/money")==0)
{
if(SL[playerid]==1)
		{
if(playeradmin[playerid]>= 1337)
		{
new tmp[128];
new id,money;
new msg[128];
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xFFFACDAA,"�÷�:/money [���id] [��Ǯ����] [����]");
return 1;
}
tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
format(msg,128,"[��Ϣ]:����Ա %s ������Ľ�Ǯ����Ϊ: %d ,����:%s.",name,money,tmp);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"[��Ϣ]:��������� %s �Ľ�Ǯ����Ϊ: %d ,����%s.",name1,money,tmp);
SendClientMessage(playerid,0xE5C43EAA,msg);
playermoney[id]=playermoney[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}*/
//============================================================[����]=======================
if(strcmp(cmd,"/tax")==0)
{
if(SL[playerid]==1)
		{
if(playerzuzhi[playerid]==5&&playerzuzhilv[playerid]==5)
{
new tmp[128];
new id,money;
new msg[128];
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xFFFACDAA,"�÷�:/tax [���id] [��������] [����]");
return 1;
}
id=strval(tmp);
if(id==playerid)
{
SendClientMessage(playerid,0x00FF00AA,"�޷����Լ�����(��ͳû���ʵ�)!");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
return 1;
}
if(playerzuzhi[id]==1||playerzuzhi[id]==7||playerzuzhi[id]==8||playerzuzhi[id]==9||playerzuzhi[id]==10||playerzuzhi[id]==11||playerzuzhi[id]==12||playerzuzhi[id]==15)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ���������֯��Ա(����/FBI/����/����/ҽԺ)");
return 1;
}
money=strval(tmp);
if(money<1||money>80000)
{
SendClientMessage(playerid,	0xDC143CAA,"������С��1���ܴ���80000!");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money>0)
{
format(msg,128,"[��������]:������֯��Ա %s ����ͳ %s ������ %d Ԫ����,����:%s .",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}

playermoney[id]=playermoney[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"�㲻����ͳ!");
return 1;
}
//=====================================================[����/������]===================
if(strcmp(cmd,"/gmats")==0)
{
if(SL[playerid]==1)
		{
if(playeradmin[playerid]>= 1337)
		{
new tmp[128];
new id,money;
new msg[128];
new name[128];
new name1[128];
tmp=strtok(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xFFFACDAA,"�÷�:/gmats[���id] [����] [����]");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money<0)
{
format(msg,128,"[������]:���%s������Ա%s����%d������,ִ������:%s",name1,name,money,tmp);
SendClientMessageToAll(0xDC143CAA,msg);
}
if(money>0)
{
format(msg,128,"[������]:���%s������Ա%s������%d������,ִ������:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
playermats[id]=playermats[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
return 1;
}
	if(strcmp(cmd,"/lache")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 4)
		{
				new	tmp[128];
				new	Float:x,Float:y,Float:z;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0xFFFACDAA,"�÷�:/lache [����ID]");
					return 1;
				}
				if(GetVehicleModel(strval(tmp))==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"�ó�������!");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetVehiclePos(strval(tmp),x+1,y+1,z+1);
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/shuache")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 1337)
		{
		        CallRemoteFunction("ShuacheCommand","i",playerid);
				SendClientMessage(playerid,COLOR_BLUE,"ˢ���ɹ����ǵ�Ҫ/shancheɾ����Ŷ~");
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
	if(strcmp(cmd,"/shanche")==0)
	{
		if(SL[playerid]==1)
		{
			new	name1[128];
			GetPlayerName(playerid,name1,128);
		if(playeradmin[playerid] >= 1338)
		{
			new	tmp[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/shanche [����ID]");
				return 1;
			}
			if(GetVehicleModel(strval(tmp))==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"�ó�������!");
				return 1;
			}
			new	name[128];
			for(new	i=0;i<101;i++)
			{
				if(IsPlayerConnected(i)==1)
				{
					if(SL[i]==1)
					{
						GetPlayerName(i,name,128);
						if(strcmp(carname[strval(tmp)],name)==0)
						{
							playercar[i]=playercar[i]-1;
						}
					}
				}
			}
			car[strval(tmp)]=0;
			DestroyVehicle(strval(tmp));
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/scld")==0)
	{
		if(SL[playerid]==1)
		{
			new	name1[128];
			GetPlayerName(playerid,name1,128);
			if(playeradmin[playerid] >= 1338)
			{
			new	tmp[128];
			new	id;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/scld ���id ����");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			if(playerzuzhilv[id]!=5)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ�����֯LD");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			if(playerzuzhi[id]==3&&duty[id]==1)
			{
				for(new	i=0;i<7;i++)
				{
					playerwuqi[id][i]=0;
				}
				ResetPlayerWeaponEx(id);
				SetPlayerArmour(id,0);
				duty[id]=0;
			}
			SetPlayerSkin(id,playerskin[id]);
			GetPlayerName(id,name,128);
			format(msg,128,"[��֯]%s������Ա������%s��LDȨ��,����:%s",name,zuzhiname[playerzuzhi[id]],tmp);
			SendClientMessageToAll(0xDC143CAA,msg);
			format(msg,128,"�㽫%s������%s��֯��LD",name,zuzhiname[playerzuzhi[id]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			format(msg,128,"�㱻����Ա������%s��֯��LD",zuzhiname[playerzuzhi[id]]);
			SendClientMessage(id,0xFFFACDAA,msg);
			playerzuzhi[id]=0;
			playerzuzhilv[id]=0;
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
/*----------------------------------[�趨GM]------------------------------*/
	if(strcmp(cmd, "/makeadmin", true) == 0)
	{
		if(SL[playerid]==1)
		{
  new	sendername[MAX_PLAYER_NAME];
		new	giveplayer[MAX_PLAYER_NAME];
		new	string[128];
		new	tmp[128];
		new id;
		if(IsPlayerConnected(playerid))
		{
			tmp	= strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid,	COLOR_GRAD2, "ʹ��:	/makeadmin [���id/�������] [�ȼ�(1-5)]");
				return 1;
			}
			new	para1;
			new	level;
			para1 =	ReturnUser(tmp);
			tmp	= strtok(cmdtext, idx);
			level =	strval(tmp);
			if (playeradmin[playerid] >= 3333)
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 !=	INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid,	sendername,	sizeof(sendername));
						playeradmin[para1] = level;
						printf("[����Ա��Ϣ]: %s ��	%s ������ %d ����Ա.", sendername, giveplayer, level);
						format(string, sizeof(string), "   �㱻	%s������ %d	����Ա ",  sendername,level);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   ������ %s ��	%d ����Ա.", giveplayer,level);
					 SendClientMessage(playerid,	COLOR_LIGHTBLUE, string);
					 SetPlayerSkin(id,26);
//AdminLog(string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid,	COLOR_GRAD1, "	 ��û��Ȩ��(1338)!");
			}
		}
		return 1;
	}
	SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//==================================����VIP===============================
	if(strcmp(cmd,"/szvip")==0)
	{
		if(SL[playerid]==1)
		{
			new	name1[128];
			GetPlayerName(playerid,name1,128);
			if(playeradmin[playerid] >= 1338)
			{
				new	tmp[128];
				new	id,ar;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/szvip	[���id] [VIP�ȼ�]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"�����û�е�½");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"VIP�ȼ�����Ϊ��");
					return 1;
				}
				ar=strval(tmp);
				playerviplv[id]=ar;
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"���VIP�ȼ���%s����Ϊ��%d!",name,ar);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//=================================================[����Leader]==============================
 if(strcmp(cmd,"/szld")==0)
	{
		if(SL[playerid]==1)
		{
			new	name1[128];
			GetPlayerName(playerid,name1,128);
			if(playeradmin[playerid] >= 1338)
			{
			new	tmp[128];
			new	id;
			new	zzid;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/szld [���id] [��֯id]	[����]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			if(playerzuzhi[id]!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"������Ѿ�����֯��!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			zzid=strval(tmp);
			if(zzid<0||zzid>16)
			{
				SendClientMessage(playerid,0xDC143CAA,"�������֯ID~~(1-16)����Ա��֯�Ѿ���");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			playerzuzhi[id]=zzid;
			playerzuzhilv[id]=5;
			GetPlayerName(id,name,128);
			format(msg,128,"[��֯]%s������Ա����Ϊ%s��֯��LD,����:%s",name,zuzhiname[playerzuzhi[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"�㽫��� %s ����Ϊ�� %s ��֯���쵼!",name,zuzhiname[playerzuzhi[id]]);
			SendClientMessage(playerid,0x00C2ECFF,msg);
			format(msg,128,"����Ա��������Ϊ�� %s ��֯���쵼!",zuzhiname[playerzuzhi[id]]);
			SendClientMessage(id,0x00C2ECFF,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}

//=================================================[����IRC����Ա]==============================
 if(strcmp(cmd,"/szircadmin")==0)
	{
		if(SL[playerid]==1)
		{
  new	name1[128];
		GetPlayerName(playerid,name1,128);
		if(playeradmin[playerid]>= 1337)//�ж��ǲ�����֯2�ĳ�Ա,��֯2��GM
		{
			new	tmp[128];
			new	id;
			new	ircid;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/szircadmin [���id] [IRCƵ��ID]	[����]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			if(playerircadmin[id]!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"������Ѿ���IRCƵ������Ա��!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			ircid=strval(tmp);
			if(ircid<0||ircid>6)
			{
				SendClientMessage(playerid,0xDC143CAA,"�����IRCƵ��ID~~(1-5)");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			playerircadmin[id]=ircid;
			playerircid[id]=ircid;
			GetPlayerName(id,name,128);
			format(msg,128,"[����]: %s ������Ա����ΪIRCƵ��IDΪ %d �Ĺ���Ա,����:%s .",name,ircname[playerircid[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"�㽫��� %s ����Ϊ��IRCƵ��IDΪ %d �Ĺ���Ա!",name,ircname[playerircid[id]]);
			SendClientMessage(playerid,0x00C2ECFF,msg);
			format(msg,128,"����Ա��������Ϊ��IRCƵ��IDΪ %d �Ĺ���Ա!",ircname[playerircid[id]]);
			SendClientMessage(id,0x00C2ECFF,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
//---------------------------------------------------------------------------------
	if(strcmp(cmd,"/szgz")==0)
	{
			if(SL[playerid]==1)
		{
  new	name1[128];
		GetPlayerName(playerid,name1,128);
		if(playeradmin[playerid]>= 1337)//�ж��ǲ�����֯2�ĳ�Ա,��֯2��GM
		{
			new	tmp[128];
			new	id;
			new	jobid;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"�÷�:/szgz [���id] [����id]	[����]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			jobid=strval(tmp);
			if(jobid<0||jobid>6)
			{
				SendClientMessage(playerid,0xDC143CAA,"�������֯ID(0~6)~~");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:���ɲ���Ϊ��");
				return 1;
			}
			playerjob[id]=jobid;
			GetPlayerName(id,name,128);
			format(msg,128,"[����]%s������Ա���ù���Ϊ: %s,����:%s",name,gongzuoname[playerjob[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"�㽫%s�Ĺ�������Ϊ��%s",name,gongzuoname[playerjob[id]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			format(msg,128,"����Ա����Ĺ�������Ϊ��%s",gongzuoname[playerjob[id]]);
			SendClientMessage(id,0xFFFACDAA,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
//---------------------------------------------------------------------------------

//-----------------------------------------����------------------------------------
	if(strcmp(cmd,"/lcs")==0)
	{
	if(SL[playerid]==1)
		{
  if(playerzuzhi[playerid]==15&&playerzuzhilv[playerid]==5)
		{
				new	tmp[128];
				new	Float:x,Float:y,Float:z;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0xFFFACDAA,"�÷�:/lache [����ID]");
					return 1;
				}
				if(GetVehicleModel(strval(tmp))==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"�ó�������!");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetVehiclePos(strval(tmp),x+1,y+1,z+1);
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
		return 1;
	}
//-----------------------------110--------------------------------------------------
	if(strcmp(cmd,"/110")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/110 [��������]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ������110��~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"[����֪ͨ][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(3,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��ɹ�����!~��ȴ�����֧Ԯ");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/999")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/999 [��������]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��������������~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"[����֪ͨ][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(1,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���Ѿ����������������!~��ȴ�FBI�ϵ�~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/888")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/888 [��������]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��������������~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"[����][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(1,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���Ѿ����������������!~��ȴ����߲���~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-------------------------------16800------------------------------------------------
	if(strcmp(cmd,"/16800")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/16800	[��������]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ������16800��~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"��֪ͨ��[ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(15,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��ɹ�����!~��ȴ�һ�£�");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ������");
		return 1;
	}
//-----------------------------10086---------------------------------------------------
/*	if(strcmp(cmd,"/10086")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/10086	[��������]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ������10086��~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"��֪ͨ��[ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(14,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��ɹ�����!~��ȴ�һ�£�");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ������");
		return 1;
	}*/
//-----------------------------admin--------------------------------------------------
	if(strcmp(cmd,"/askq")==0)
	{
		if(SL[playerid]==1)
		{
			new	msgg[128];
			new	name[128];
			new	tmp[128];
			GetPlayerName(playerid,name,128);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"�÷�:/askq [����]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"���Ѿ��ύ��������~��ȴ�4������ύ~��");
				return 1;
			}
			format(msgg,128,"[ID:%d]%s:%s",playerid,name,tmp);
			ABroadCast(0x98FB98FF,msgg,1);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"���������Ѿ��ύ�����߹���Ա!~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/unjr")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]>=1)
			{
				if(playerzuzhilv[playerid]==5)
				{
					new	tmp[128];
					new	msg[128];
					new	name[128];
					new	name1[128];
					new	id;
					tmp=strtok(cmdtext,idx);
					id=strval(tmp);
					if(IsPlayerConnected(id)==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ�����");
						return 1;
					}
					if(playerzuzhi[id]!=playerzuzhi[playerid])
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ����������֯");
						return 1;
					}
					if(playerzuzhilv[id]==5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻���߳�LD");
						return 1;
					}
					if(playerzuzhi[id]==3&&duty[id]==1)
					{
						for(new	w=0;w<7;w++)
						{
							playerwuqi[id][w]=0;
						}
						ResetPlayerWeaponEx(id);
						SetPlayerArmour(id,0);
						duty[id]=0;
					}
					GetPlayerName(playerid,name,128);
					GetPlayerName(id,name1,128);
					format(msg,128,"�㽫%s�߳�����֯%s",name1,zuzhiname[playerzuzhi[playerid]]);
					SendClientMessage(playerid,	0xFFFACDAA,msg);
					format(msg,128,"�㱻%s�߳�����֯%s",name,zuzhiname[playerzuzhi[playerid]]);
					SendClientMessage(id, 0xFFFACDAA,msg);
					playerzuzhi[id]=0;
					playerzuzhilv[id]=0;
					SetPlayerSkin(id,playerskin[id]);
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/setzzlv")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]>=1||playerzuzhi[playerid]==0)
			{
				if(playerzuzhilv[playerid]==5)
				{
					new	tmp[128];
					new	id;
					new	lv;
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"�÷�:/setzzlv [���id]	[��֯�׼�(1~5)]");
						return 1;
					}
					id=strval(tmp);
					if(IsPlayerConnected(id)==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ�����");
						return 1;
					}
					if(playerzuzhi[id]!=playerzuzhi[playerid])
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:Ŀ��ID�����������֯");
						return 1;
					}
					if(id!=playerid)
					{
					if(playerzuzhilv[id]==5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻���޸�LD�Ľ׼�");
						return 1;
					}
					}
					tmp=strtok(cmdtext,idx);
					lv=strval(tmp);
					if(lv<1||lv>5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�׼�����(1-5)");
						return 1;
					}
					new	msg[128];
					new	name[128];
					new	name1[128];
					GetPlayerName(playerid,name,128);
					GetPlayerName(id,name1,128);
					format(msg,128,"��֯��Ա %s ������������ %d ��.",name1,lv);
					SendClientMessage(playerid,	0x00BFFFF,msg);
					format(msg,128,"�㱻��֯�쵼 %s �������� %d ��.",name,lv);
					SendClientMessage(id, 0x00BFFFF,msg);
					playerzuzhilv[id]=lv-1;
					SetPlayerSkin(id,zuzhiskin[playerzuzhi[id]][playerzuzhilv[id]]);
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/members")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]>=1)
			{
				new	msg[128];
				new	name[128];
				SendClientMessage(playerid,	0x008040FF,"________|������֯��Ա|________");
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(playerzuzhi[i]==playerzuzhi[playerid])
							{
								GetPlayerName(i,name,128);
								format(msg,128,"�ǳ�:%s	 �׼�:%s",name,zuzhilv[playerzuzhi[i]][playerzuzhilv[i]]);
								SendClientMessage(playerid,0xFFFACDAA,msg);
							}
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/jiaru")==0)
	{
		if(SL[playerid]==1)
		{
			if(yaoqingjiaru[playerid]!=-1)
			{
				if(playerzuzhilv[yaoqingjiaru[playerid]]==5)
				{
					new	msg[128];
					new	name[128];
					new	name1[128];
					GetPlayerName(yaoqingjiaru[playerid],name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"��ɹ�������%s����֯��",name);
					SendClientMessage(playerid,0xFFFACDAA,msg);
					format(msg,128,"%s�����������֯!",name1);
					SendClientMessage(yaoqingjiaru[playerid],0xFFFACDAA,msg);
					playerzuzhi[playerid]=playerzuzhi[yaoqingjiaru[playerid]];
					playerzuzhilv[playerid]=0;
					SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
					yaoqingjiaru[playerid]=-1;
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�����߲�����֯��LD");
				yaoqingjiaru[playerid]=-1;
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:û���������������֯!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/jr")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhilv[playerid]==5)
			{
				new	tmp[128];
				new	msg[128];
				new	name[128];
				new	name1[128];
				tmp=strtok(cmdtext,idx);
				if(playerzuzhi[strval(tmp)]!=0)
				{
					SendClientMessage(playerid,	0xDC143CFF,"����,����ԭ��:Ŀ������Ѿ�����֯��!");
					return 1;
				}
				if(strval(tmp)==0)
				{
					SendClientMessage(playerid,	0xDC143CFF,"����,����ԭ��:Ŀ��ID����Ϊ0");
					return 1;
				}
				if(strval(tmp)!=playerid)
				{
					if(IsPlayerConnected(strval(tmp))==1)
					{
						GetPlayerName(playerid,name,128);
						GetPlayerName(strval(tmp),name1,128);
						format(msg,128,"������%s����%s�������Ѿ����͸�%s��,��ȴ���Ӧ.",name1,zuzhiname[playerzuzhi[playerid]],name1);
						SendClientMessage(playerid,	0xFFFACDAA,msg);
						format(msg,128,"%s���������%s,��������������/jiaru!",name,zuzhiname[playerzuzhi[playerid]]);
						SendClientMessage(strval(tmp),0xFFFACDAA,msg);
						yaoqingjiaru[strval(tmp)]=playerid;
						return 1;
					}
					SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:Ŀ����Ҳ�����");
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:���޷������Լ�");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/d")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]>=1||playerzuzhi[playerid]==0&&playerzuzhilv[playerid]>=1)
			{
				new	tmp[128];
				new	msg[128];
				new	name[128];
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/d [����]");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"**%s %s	%s[�Խ���]:%s ͨ�����**",zuzhiname[playerzuzhi[playerid]],zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
				if(playerzuzhi[playerid]==1||playeradmin[playerid]>= 1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==5||playerzuzhi[playerid]==6||playerzuzhi[playerid]==14)
				{
					AdminXX(1,msg,0xFF1493FF);
					ABroadCast(0xFF1493FF,msg,1);
     AdminXX(3,msg,0xFF1493FF);
					AdminXX(4,msg,0xFF1493FF);
					AdminXX(5,msg,0xFF1493FF);
					AdminXX(6,msg,0xFF1493FF);
					AdminXX(14,msg,0xFF1493FF);
					return 1;
				}
									return 1;
				}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//---------------------------------------------[IRCƵ��]---------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------
	if(strcmp(cmd,"/ircjoin")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeripad[playerid]==1)
			{
				ShowPlayerDialog(playerid,3576,DIALOG_STYLE_LIST,"[IRCƵ�� - ѡ��]","����IRCƵ��1\n����IRCƵ��2\n����IRCƵ��3\n����IRCƵ��4\n����IRCƵ��5\n�˳�IRCƵ��","ȷ��","ȡ��");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"��û�е�½!");
		return 1;
	}
//==============================================================================================
//==============================================================================================
if(strcmp(cmd,"/i1")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircid[playerid]==1)
			{
			 if(playeripad[playerid]==1)
			 {
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/i1 [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRCƵ��1]˵:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ����IRCƵ��1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/i2")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircid[playerid]==2)
			{
			 if(playeripad[playerid]==1)
			 {
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/i2 [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRCƵ��2]˵:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ����IRCƵ��1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/i3")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircid[playerid]==3)
			{
			 if(playeripad[playerid]==1)
			 {
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/i3 [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRCƵ��3]˵:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ����IRCƵ��1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/i4")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircid[playerid]==4)
			{
			 if(playeripad[playerid]==1)
			 {
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/i4 [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRCƵ��4]˵:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ����IRCƵ��1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/i5")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerircid[playerid]==5)
			{
			 if(playeripad[playerid]==1)
			 {
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/i5 [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRCƵ��5]˵:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û��ƽ�����!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㻹δ����IRCƵ��1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//------------------------------------------[��֯�Խ���Ƶ��]--------------------------
	if(strcmp(cmd,"/r")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==1||playerzuzhi[playerid]==3||playerzuzhi[playerid]==4||playerzuzhi[playerid]==5||playerzuzhi[playerid]==6||playerzuzhi[playerid]==7||playerzuzhi[playerid]==8||playerzuzhi[playerid]==9||playerzuzhi[playerid]==10||playerzuzhi[playerid]==11||playerzuzhi[playerid]==12||playerzuzhi[playerid]==14)
			{
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/r [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerzuzhi[i]==playerzuzhi[playerid])
						{
							format(msg,256,"**%s %s[�Խ���]:%s .over**",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
							SendClientMessage(i, 0xFFFF00FF,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//------------------------------------------------------[��֯Ƶ��]-----------------
	if(strcmp(cmd,"/f")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]!=0&&playerzuzhilv[playerid]>=0)
			{
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/f [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerzuzhi[i]==playerzuzhi[playerid])
						{
							format(msg,256,"**%s %s[��֯Ƶ��]:%s .over**",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
							SendClientMessage(i, 0x00C2ECFF,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻����֯��Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//-------------------------------------------[����ԱƵ��]---------------------------
	if(strcmp(cmd,"/a")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>= 1)
			{
				new	tmp[256];
				new	msg[256];
				new	name[256];
				GetPlayerName(playerid,name,256);
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"�÷�:/a [����]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerzuzhi[i]==playerzuzhi[playerid])
						{
							format(msg,256,"**[%s] %s[ADMIN]:%s.**",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:�㲻�ǹ���Ա");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"����,����ԭ��:��û�е�½");
		return 1;
	}
//------------------------------------------------------[LOGIN]---------------------
	if(strcmp(cmd,"/lg")==0)
	{
		if(SL[playerid]==0)
		{
			new	msg[128];
			GetPlayerName(playerid,playername[playerid],128);
			format(msg,128,getINI(playerid),playername[playerid]);
			if (fexist(getINI(playerid))==0)
			{
				format(playermima[playerid],128,"");
				playercar[playerid]=0;
				playermoney[playerid]=0;
				playerzuzhi[playerid]=0;
				playerzuzhilv[playerid]=0;
				playerskin[playerid]=0;
				playerlock[playerid]=0;
				playerlock1[playerid]=0;
				playerlock2[playerid]=0;
				playerspawn[playerid]=0;
				playerlv[playerid]=1;
				playerlvup[playerid]=0;
				playerjob[playerid]=0;
				playermats[playerid]=0;
				playerbank[playerid]=0;
				//playerjiedu[playerid]=0;
				KillSpawn[playerid]	= false;
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"ע��","��������Ҫ���õ�����!","ȷ��","ȡ��");
				return 1;
			}
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"��¼","����������!","ȷ��","ȡ��");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,	"����,����ԭ��:���Ѿ���½");
		return 1;
	}
//==================================�鿴�ҵ�ʳƷ==========================
	if(strcmp(cmd,"/myfood")==0)
	{
		if(SL[playerid]==1)
		{
            new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"===============================ʳƷ�ֿ�==========================");
			format(msg,256," |��԰���ȱ�:%d| |ѩ��:%d| |������:%d|",food1[playerid],food2[playerid],food3[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
		}
  SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
		return 1;
	}
//==========================================================================
	if(strcmp(cmd,"/stats")==0)
	{
		if(SL[playerid]==1)
		{
   new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			format(msg,256,"|����:%s| |��Ǯ:%d |��֯:%s| |��֯�ȼ�:%s| |VIP�ȼ�:%d| |VIP�ɳ�ֵ:%d/%d| |��������:%d|",playername[playerid],playermoney[playerid],zuzhiname[playerzuzhi[playerid]],zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],playerviplv[playerid],playervipczz[playerid],playerviplv[playerid]*8,playercar[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|����Կ��1:%d| |����Կ��2:%d| |����Կ��3:%d| |���:%d| |V�����:%d| |�绰���:%d|",playerlock[playerid],playerlock1[playerid],playerlock2[playerid],playerbank[playerid],playervdou[playerid],playercallmoney[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|�ȼ�:%d| |������:%d/%d| |�绰����:%d| |����:%s| |����:%d| |IPAD:%d| |�̻�:%d|",playerlv[playerid],playerlvup[playerid],playerlv[playerid]*8,playercall[playerid],gongzuoname[playerjob[playerid]],playermats[playerid],playeripad[playerid],playeryanhua[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|��ǰƤ��:%d| |����ʣ��ʱ��:%d|	|ͨ���ȼ�:%d| |��ǰ������:%d|",playerskin[playerid],playerjianyutime[playerid],su[playerid],playerspawn[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|�Ƿ�̳̹�:%d| |�Ա�:%d|	|���֤���:%d| |����:%d|",playerput[playerid],playersex[playerid],playersfz[playerid],playerage[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
	}
  SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/vstats")==0)
	{
		if(SL[playerid]==1)
		{
			new	msg[256];
			SendClientMessage(playerid,	0xD3D3D3FF,"======================����������Ϣ======================");
			if(playercar[playerid]!=0)
			{
				for(new	i=1;i<999;i++)
				{
					if(strcmp(carname[i],playername[playerid])==0)
					{
						if(car[i]!=0)
						{
							format(msg,128,"����ID:%d ����ģ��:%d ������ɫ1:%d ������ɫ2:%d	����������֯:%s	������ֵ:%d",car[i],carmoxing[i],carcolor1[i],carcolor2[i],zuzhiname[carzuzhi[i]],carmoney[i]);
							SendClientMessage(playerid,	0xD3D3D3FF,msg);
						}
					}
				}
			}
			SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
			return 1;
		}
		SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
		return 1;
	}
	if(strcmp(cmd,"/hstats")==0)
	{
		if(SL[playerid]==1)
		{
			SendClientMessage(playerid,	0xD3D3D3FF,"======================���˷�����Ϣ======================");
			new	msg[128];
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(playerlock[playerid]==u||playerlock1[playerid]==u||playerlock2[playerid]==u)
					{
						format(msg,128,"����ID:%d ��������:%s ���ݼ۸�:%d ���ݹ���ȼ�:%d ����״̬(0Ϊ����,1Ϊ����):%d",u,ZFJGSTR1[u],ZFJGMONEY[u],ZFJGLV[u],ZFJGLOCK[u]);
						SendClientMessage(playerid,	0xD3D3D3FF,msg);
					}
				}
			}
			SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
			return 1;
		}
		SendClientMessage(playerid,	 0xDC143CAA, "����,����ԭ��:��û�е�½");
		return 1;
	}
	SendClientMessage(playerid,	 0xF8F8FFFF,"��ʾ����ѽ�����ָ������������ǲ�������Сд������ϸ�������������/help�鿴Ŷ~");
	return 1;
}
public OnPlayerDisconnect(playerid,	reason)//���ߺ�����ID���߱������ID�����ݡ�
{
	PlayerTextDrawDestroy(playerid,TabletWin8UserLog2);
	PlayerTextDrawDestroy(playerid,TabletWin8Pag2);
	for(new i = 0; i < 4; i++) PlayerTextDrawDestroy(playerid,Escritorio[i]);
	for(new i = 0; i < 2; i++) PlayerTextDrawDestroy(playerid,TabletTime[i]);
	for(new i = 0; i < 3; i++) PlayerTextDrawDestroy(playerid,TabletWeather[i]);
	for(new i = 0; i < 5; i++) PlayerTextDrawDestroy(playerid,Tragaperras[i]);
	KillTimer(faretimer[playerid]);
    OnDuty[playerid] = 0;
    IsOnFare[playerid] = 0;

	TotalFare[playerid] = 0.0;
	
	new	msgg[128];
	new	name[128];
	KillSpawn[playerid]	= false;
	GetPlayerName(playerid,name,128);
	format(msgg,128,"[ID:%d]%s�뿪�˷�����",playerid,name);
	    SendClientMessageToAll(0xFFFF00AA,msgg);
	if (SL[playerid]==1)
	{
		new	i=carzuyongkey[playerid];
		if(i!=0)
		{
			SetVehiclePos(i,carx[i],cary[i],carz[i]);
			SetVehicleZAngle(i,carmianxiang[i]);
			SetVehicleHealth(i,1000);
			RepairVehicle(i);
			carzuyong[carzuyongkey[playerid]]=0;
			carzuyongkey[playerid]=0;
        SetPVarInt(playerid, "laser", 0);
        RemovePlayerAttachedObject(playerid, 0);
		}
		if(su[playerid]!=0)
		{
			if(su[playerid]==1)
			{
				playerjianyutime[playerid]=200;
			}
			if(su[playerid]==2)
			{
				playerjianyutime[playerid]=400;
			}
			if(su[playerid]==3)
			{
				playerjianyutime[playerid]=600;
			}
			if(su[playerid]==4)
			{
				playerjianyutime[playerid]=800;
			}
			if(su[playerid]==5)
			{
				playerjianyutime[playerid]=1000;
			}
			if(su[playerid]==6)
			{
				playerjianyutime[playerid]=1200;
			}
			if(su[playerid]==7)
			{
				playerjianyutime[playerid]=1400;
			}
			if(su[playerid]==8)
			{
				playerjianyutime[playerid]=1600;
			}
			if(su[playerid]==9)
			{
				playerjianyutime[playerid]=1800;
			}
			if(su[playerid]==10)
			{
				playerjianyutime[playerid]=2000;
			}
		}
		if(playerzuzhi[playerid]==3&&duty[playerid]==1)
		{
			for(i=0;i<7;i++)
			{
				playerwuqi[playerid][i]=0;
			}
		}
		Aftersave(playerid);
		su[playerid]=0;
		SL[playerid]=0;
		duty[playerid]=0;
		jcys[playerid]=0;
		yaoqingjiaru[playerid]=-1;
		vsellto[vselltoid[playerid]]=0;
		healid[healtoid[playerid]]=0;
		Delete3DTextLabel(liaotiantext[playerid]);
		TextDrawDestroy(Textdraw51[playerid]);
		//BAOCUNACCOUNT();
		return 1;
	}
	return 0;
}
public OnDialogResponse(playerid, dialogid,	response, listitem,	inputtext[])//��ҵ���Ի�����¼�
{
	if(!response) {
		DeletePVar(playerid,"range");
		DeletePVar(playerid,"limit");
		DeletePVar(playerid,"fine");
		DeletePVar(playerid,"selected");
		return 1;
	}
	switch(dialogid)
	{

//======================================================
//						Main menu
//======================================================
		case DIALOG_MAIN:
			{
				switch(listitem)
				{
					case 0:	ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"����һ���Ƕ�","������һ���Ƕ� (��Χ:	20-30)","ȷ��","ȡ��");
					case 1:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"û���ҵ����������!");
							SendClientMessageEx(playerid,COLOR_GREEN,"sis","���������ͷID��:	",cam,".");
						}
					case 2:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"û���ҵ����������!");
							SetPVarInt(playerid,"selected",cam);
							ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,"{00A5FF}��������ͷ	{FFFFFF}- {FFDC00}Editor","�ı�Ƕ�\n�ı䷶Χ\n���ĳ�������\n�������\n�л�Ӣ��ģʽ\n���/�Ƴ�/�༭�ı���ǩ\n{FF1400}ɾ�������","ȷ��","ȡ��");
						}
					case 3:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"û���ҵ����������!");
							DestroySpeedCam(cam);
							SendClientMessage(playerid,COLOR_GREEN,"��������ͷ���Ƴ�����.");
							DeletePVar(playerid,"selected");
						}
					case 4:
						{
							for(new	i =	0;i<loaded_cameras +1;i++)
							{
								if(SpeedCameras[i][_active]	== true)
								{
									DestroySpeedCam(i);
								}
							}
							SendClientMessage(playerid,COLOR_GREEN,"���в�������ͷ���Ƴ�����.");
						}
				}
			}
//======================================================
//					Making a speedcam
//======================================================
		case DIALOG_RANGE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"����һ���Ƕ�","������һ���Ƕ�	(��Χ: 20-30)","ȷ��","ȡ��");
				SetPVarInt(playerid,"range",strval(inputtext));
				ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"����һ���ٶȷ�Χ","������һ���ٶȷ�Χ","ȷ��","ȡ��");
			}
		case DIALOG_LIMIT:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"����һ���ٶȷ�Χ","������һ���ٶȷ�Χ","ȷ��","ȡ��");
				SetPVarInt(playerid,"limit",strval(inputtext));
				ShowPlayerDialog(playerid,DIALOG_FINE,DIALOG_STYLE_INPUT,"���÷���","������һ����������","ȷ��","ȡ��");
			}
		case DIALOG_FINE:
			{
					if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_FINE,DIALOG_STYLE_INPUT,"���÷���","������һ����������","ȷ��","ȡ��");
					SetPVarInt(playerid,"fine",strval(inputtext));
					new	Float:x,Float:y,Float:z,Float:angle;
					GetPlayerPos(playerid,x,y,z);GetPlayerFacingAngle(playerid,angle);
					angle =	angle +	180;if(angle > 360){angle =	angle -	360;}
					new	id = CreateSpeedCam(x,y,z -3,angle,GetPVarInt(playerid,"range"),GetPVarInt(playerid,"limit"),GetPVarInt(playerid,"fine"),CAMERA_USEMPH);
					SetPlayerPos(playerid,x,y+2,z);
					DeletePVar(playerid,"range");
					DeletePVar(playerid,"limit");
					DeletePVar(playerid,"fine");
					SetPVarInt(playerid,"selected",id);
					ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,"{00A5FF}��������ͷ	{FFFFFF}- {FFDC00}Editor","�ı�Ƕ�\n�ı䷶Χ\n���ĳ�������\n�������\n�л�Ӣ��ģʽ\n���/�Ƴ�/�༭�ı���ǩ\n{FF1400}ɾ�������","ȷ��","ȡ��");
			}
//======================================================
//						Edit menu
//======================================================
		case DIALOG_EDIT:
			{
				switch(listitem)
				{
					case 0:	ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������	- Angle","������һ���µĽǶ�","ȷ��","ȡ��");
					case 1:	ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������	- Range","������һ���µķ�Χ","ȷ��","ȡ��");
					case 2:	ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������	- Speedlimit","�����һ���µĵĳ�������","ȷ��","ȡ��");
					case 3:	ShowPlayerDialog(playerid,DIALOG_EFINE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}-	{FFDC00}������ - Fine","�����һ���µĵķ���","ȷ��","ȡ��");
					case 4:	ShowPlayerDialog(playerid,DIALOG_ETYPE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}-	{FFDC00}������ - Mph/Kmh","����1ʹ��Ӣ���0ΪÿСʱ����","ȷ��","ȡ��");
					case 5:	ShowPlayerDialog(playerid,DIALOG_LABEL,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}-	{FFDC00}������ - Textlabel","����д��Ҫ���ӵ����֣���������ɾ�����еı�ǩ!","ȷ��","ȡ��");
					case 6:
						{
							DestroySpeedCam(GetPVarInt(playerid,"selected"));
							SendClientMessage(playerid,COLOR_GREEN,"��������ͷ���Ƴ�����.");
							DeletePVar(playerid,"selected");
						}
				}
			}
//======================================================
//				   Editing a speedcam
//======================================================
		case DIALOG_EANGLE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������ -	Angle","������һ���µĽǶ�","ȷ��","ȡ��");
				new	id = GetPVarInt(playerid,"selected");
				new	rot	= strval(inputtext);
				rot	= rot +	180;
				if (rot	> 360)
				{
					rot	= rot -	360;
				}
				SpeedCameras[id][_rot] = rot;
				SetObjectRot(SpeedCameras[id][_objectid],0,0,rot);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The angle	of cameraID	",id," �ɹ�����Ϊ ",strval(inputtext),".");
			}
		case DIALOG_ERANGE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������ -	Range","������һ���µķ�Χ","ȷ��","ȡ��");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_range] = strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The range	of cameraID	",id," �ɹ�����Ϊ ",strval(inputtext),".");
			}
		case DIALOG_ELIMIT:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ {FFFFFF}- {FFDC00}������ -	Speedlimit","�����һ���µĵĳ�������","ȷ��","ȡ��");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_limit] = strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The speedlimit of	cameraID ",id,"	�ɹ�����Ϊ ",strval(inputtext),".");
			}
		case DIALOG_EFINE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_EFINE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ	{FFFFFF}- {FFDC00}������ - Fine","�����һ���µĵķ���","ȷ��","ȡ��");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_fine]	= strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The fine of cameraID ",GetPVarInt(playerid,"selected")," �ɹ�����Ϊ ",strval(inputtext),".");
			}
		case DIALOG_ETYPE:
			{
				if(!strlen(inputtext) || strval(inputtext) != 0	&& strval(inputtext) !=	1) return ShowPlayerDialog(playerid,DIALOG_ETYPE,DIALOG_STYLE_INPUT,"{00A5FF}��������ͷ	{FFFFFF}- {FFDC00}������ - Mph/Kmh","����1ʹ��Ӣ���0ΪÿСʱ����","ȷ��","ȡ��");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_usemph] =	strval(inputtext);
				if(strval(inputtext) ==	1)
				{
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","CameraID ",GetPVarInt(playerid,"selected")," �����ں���Ӣ����ٶ�.");
				} else {
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","CameraID ",GetPVarInt(playerid,"selected")," �����ں�������ÿСʱ���ٶ�.");
				}
			}
		case DIALOG_LABEL:
			{
				new	id = GetPVarInt(playerid,"selected");
				if(!strlen(inputtext))
				{
					if(SpeedCameras[id][_activelabel] == true)
					{
						Delete3DTextLabel(SpeedCameras[id][_label]);
						SpeedCameras[id][_activelabel] = false;
						SpeedCameras[id][_labeltxt]	= 0;
					}
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","����ͷ������ ",GetPVarInt(playerid,"selected")," ��������ͷ�ɹ����Ƴ�����.");
				} else {
					if(SpeedCameras[id][_activelabel] == true)
					{
						format(SpeedCameras[id][_labeltxt],128,"%s",inputtext);
						UpdateCameraLabel(SpeedCameras[id][_label],inputtext);
					} else {
						SpeedCameras[id][_activelabel] = true;
						format(SpeedCameras[id][_labeltxt],128,"%s",inputtext);
						SpeedCameras[id][_label] = AttachLabelToCamera(id,inputtext);
					}
					SendClientMessageEx(playerid,COLOR_GREEN,"sisss","����ͷ������	",GetPVarInt(playerid,"selected"),"	�ɹ�����Ϊ ",inputtext,".");
				}
				SaveCamera(id);
			}
	}
	
 	if(dialogid == DIALOG_TABLETCHAT)
    {
        if(response)
        {
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}���ID:", "�������ID", "����", "�˳�");
            if(IsNumeric(inputtext))
            {
				new id = strval(inputtext);
				if(id == playerid)
				{
					ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}���ܺ����Լ�˵��.", "�������ID", "����", "�˳�");
				}
    			else
				{
		            if(IsPlayerConnected(id))
		            {
		                chatid[playerid] = 0;
			            chatid[id] = 1;
			            new str[64];
			            new name[MAX_PLAYER_NAME];
			            GetPlayerName(playerid,name,sizeof(name));
						format(str,sizeof(str),"%s",name);
			            ShowPlayerDialog(id, DIALOG_TABLETCHAT+1, DIALOG_STYLE_MSGBOX, "{FF0000}��������", str, "����", "�ܾ�");
			            new name2[MAX_PLAYER_NAME];
			            GetPlayerName(playerid,name2,sizeof(name2));
			            SetPVarString(id, "sendername", name2);
			            new name3[MAX_PLAYER_NAME];
			            GetPlayerName(id,name3,sizeof(name3));
			            SetPVarString(playerid, "sendername2", name3);
			            SetPVarInt(id, "playeronid", playerid);
			            SetPVarInt(playerid, "therplayeronid", id);
					}
					else
					{
                		ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}����: ID����", "�������ID", "����", "�˳�");
					}
				}
			}
			else
			{
			    ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}���ID:", "�������ID", "����", "�˳�");
			}
		}
	}
    if(dialogid == DIALOG_TABLETCHAT+1)
    {
        if(response)
        {
	        if(chatid[playerid] == 1)
	        {
	        new asd[24];
	        GetPVarString(playerid, "sendername",asd,24);
	        new str[64];
	        format(str,sizeof(str),"{FF0000}���� - %s",asd);
	        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, "������Ϣ:", "����", "�˳�");
	        }
        }
        else
        {
			new name[24];
			GetPlayerName(playerid,name,24);
			new str[64];
			chatid[playerid] = 0;
			chatid[GetPVarInt(playerid,"therplayeronid")] = 0;
			format(str,sizeof(str),"%s �����������������.\n\n",name);
			ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}����", str,"�˳�", "");
        }
	}
    if(dialogid == DIALOG_TABLETCHAT+2)
    {
        if(response)
        {
			new string[128];
	        new name[24];
	        GetPlayerName(playerid,name,24);
			if(chatid[playerid] == 1)
			{
		        new str[64];
		        format(string,sizeof(string),"{990099}%s: %s\n",name,inputtext);
		        strcat(chattext[playerid],string);
		        strcat(chattext[GetPVarInt(playerid,"playeronid")],string);
		        new asd[24];
		        GetPVarString(playerid, "sendername",asd,24);
		        format(str,sizeof(str),"{FF0000}���� - %s",asd);
		        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, chattext[playerid], "����", "�˳�");
		        new str2[64];
				format(str2,sizeof(str2),"{FF0000}���� - %s",name);
		        ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str2, chattext[GetPVarInt(playerid,"playeronid")], "����", "�˳�");
			}
			else
			{
		        new str[64];
		        format(string,sizeof(string),"{FF0000}%s: %s\n",name,inputtext);
		        strcat(chattext[playerid],string);
		        strcat(chattext[GetPVarInt(playerid,"therplayeronid")],string);
		        new asd[24];
		        GetPVarString(playerid, "sendername2",asd,24);
		        format(str,sizeof(str),"{FF0000}���� - %s",asd);
		        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, chattext[playerid], "����", "�˳�");
		        new str2[64];
				format(str2,sizeof(str2),"{FF0000}���� - %s",name);
		        ShowPlayerDialog(GetPVarInt(playerid,"therplayeronid"), DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str2, chattext[GetPVarInt(playerid,"therplayeronid")], "����", "�˳�");
			}
		}
		else
		{
			if(chatid[playerid] == 1)
			{
				new name[24];
				GetPlayerName(playerid,name,24);
				new str[64];
				chattext[playerid] = "";
				chattext[GetPVarInt(playerid,"playeronid")] = "";
				format(str,sizeof(str),"%s �˳�����.",name);
				ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}����", str,"�˳�", "");
			}
			else
			{
			    new name[24];
				GetPlayerName(playerid,name,24);
				new str[64];
				chattext[playerid] = "";
				chattext[GetPVarInt(playerid,"therplayeronid")] = "";
				chatid[playerid] = 0;
				chatid[GetPVarInt(playerid,"therplayeronid")] = 0;
				format(str,sizeof(str),"%s �˳�����.",name);
				ShowPlayerDialog(GetPVarInt(playerid,"therplayeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}����", str,"�˳�", "");
			}
		}
	}
	
	if (dialogid == 8889 && response && IsPlayerInAnyVehicle(playerid))
	{
		new	vid=GetPlayerVehicleID(playerid),zid=GetPlayerVehicleSeat(playerid);
		if (listitem == 0)
		{
			if(vid!=0&&zid==0&&carfill[vid]!=0)
			{
				if(caryinqing[vid]==0)
				{
					SendClientMessage(playerid,	0x0D7792AA,	"����ת������Կ�ף�����������������");
					enginevid[playerid]=vid;
					engine[playerid]=2;
					return 1;
				}
			}
		}
		if (listitem == 1)
		{
			if(vid!=0&&zid==0&&carfill[vid]!=0)
			{
				SendClientMessage(playerid,0x0D7792AA,	"����ת������Կ�ף��ر���������������");
				SetVehicleParamsEx(vid,0,cardengguang[vid],0,carlock[vid],0,0,0);
				enginevid[playerid]=vid;
				engine[playerid]=2;
				return 1;
			}
		}
		if (listitem == 2)
		{
			if(vid!=0&&zid==0&&carfill[vid]!=0)
			{
				if(cardengguang[vid]==0)
				{
					cardengguang[vid]=1;
					SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
					SendClientMessage(playerid,	0x0D7792AA,	"��ѳ��ƴ򿪿�~");
					return 1;
				}
			}
		}
		if (listitem == 3)
		{
			if(vid!=0&&zid==0&&carfill[vid]!=0)
			{
				cardengguang[vid]=0;
				SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
				SendClientMessage(playerid,0x0D7792AA,	"��ص��˳���~");
				return 1;
			}
		}
		return 1;
	}
	
	if(dialogid	== 8536)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
					{
						SendClientMessage(playerid,	COLOR_GRAD6,"::����ϵͳ::");
						SendClientMessage(playerid,	COLOR_GREEN,"::{FFFFF0}/jike[�鿴���ʶ�] /eatfood [�ڷ���Է�] /buyfood [������ʳƷ] /eats[ʹ�ñ���ʳƷ]");
					}
				case 1:
					{
						SendClientMessage(playerid,0x99FFFFAA,"�˻�:/lg [��½] /lvup [����] /vstats [�鿴����]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/r [��֯IC����] /f [��֯OOC����]	/d [Ƶ������] ");
						SendClientMessage(playerid,0x99FFFFAA,"����:/i [IRCƵ������] /ircjoin [����IRCƵ��] /ad [���] ");
      SendClientMessage(playerid,0x99FFFFAA,"����:/buycar	[��] /vcolor [������ɫ] /vpark [����]	/vsell [����] /vreg	[ע�����֯] /vunreg[���ע��]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/vcall [����] /savecar [�����װ] /unsavecar[��������װ] /jiechuzuche	[����⳵] /fuel [�鿴����]");
						SendClientMessage(playerid,0x99FFFFAA,"����:��ctrl�� [����/�ر�����] ��ctrl��[����/�رյƹ�] /vlock	[��/��������] /neon[������װ�ʵ�]/noshelp[N2O����]");
      SendClientMessage(playerid,0x99FFFFAA,"����:/kong [�޸��ռ�] /duty [�ϰ�] /pay [��Ǯ] /buyskin [���·�]  /showsfz [չʾ���֤]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/paycl [������] /anims	[�����б�] /jcys [���ܻ�����������] /id [�������ֲ�ѯID] /askq [�ύ����]");
						SendClientMessage(playerid,0x99FFFFAA,"ִ��:/showzhizhao [��ִ��] /buygunzhizhao [������ִ��] /buycarzhizhao [���ʻִ��]");
						SendClientMessage(playerid,0x99FFFFAA,"/stats [�鿴�˻�״̬����] /vstats [�鿴�˻�����״̬] /hstats [�鿴�˻�����״̬]]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/inv [�����ֿ�]	/putgun [�Ž������ֿ�] /takegun [ȡ���ֿ��е�����]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/cunkuan [���]	/qukuan	[ȡ��]");
						SendClientMessage(playerid,0x99FFFFAA,"ATM����:/atmqk	[ȡ��]");
						SendClientMessage(playerid,0x99FFFFAA,"�̻�:/placefw [�����̻�] /launch [�����̻�]");
						SendClientMessage(playerid,0x99FFFFAA,"ƽ��:/tablet [��/��ƽ��]");
      SendClientMessage(playerid,0xE100E1FF,"��ʾ:ָ�����,������Щ������,�밴 'Page Up' �� 'Page	Down' �������·�ҳ���鿴ָ��. ");
					}
				case 2:
					{
						SendClientMessage(playerid,	COLOR_GRAD6,"::����ϵͳ::");
						SendClientMessage(playerid,0x99FFFFAA,"/music [����ϵͳ] /stopmusic [ֹͣ����]");
					}
				case 3:
					{
						if (playercall[playerid] > 0)
						{
							SendClientMessage(playerid,	COLOR_WHITE,"***�ֻ�����***");
							SendClientMessage(playerid,0x99FFFFAA,"�绰:/call [����绰] /p	[�����绰] /h [�Ҷϵ绰] /t	[���Ͷ���] /chm	[���Ӳ����]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_WHITE,"��û���ֻ������ȥ27/7����");
						}
					}
				case 4:
					{
						SendClientMessage(playerid,	COLOR_WHITE,"***���ݰ���***");
						SendClientMessage(playerid,0x99FFFFAA,"����:/buyhouse [��] /sellhouse	[����] /lockhouse [����] /spawnchange [�л�������]");
						SendClientMessage(playerid,0x99FFFFAA,"����:/hu [װ��] /heal [�ָ�]");
      }
				case 5:
					{
						if (playerzuzhi[playerid] >= 1 )
						{
							SendClientMessage(playerid,0x99FFFFAA,"��֯:/members [��ѯ���߳�Ա]	/gov [��֯����] /jr [�������]");
							SendClientMessage(playerid,0x99FFFFAA,"��֯:/unjr [����] /setzzlv [������֯�׼�] /tuichuzz [�˳���֯]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_GREY,	"	�㲻��һ����֯��Ա!");
						}
					}
				case 6:
					{
						if(playerzuzhi[playerid]==1)
						{
							SendClientMessage(playerid,0x6495EDFF,"����:/news	[��������] /live [�ɷ�] /nad [���]	/ndt	[��̨] /xsdl [��ʾ������] /ycd [���ص�����]");
						}
						else if(playerzuzhi[playerid]==5)
						{
							SendClientMessage(playerid,0x6495EDFF,"������:/tax [����] /tofind [����]	/stofind [ֹͣ����]");
						}
						else if(playerzuzhi[playerid]==6)
						{
							SendClientMessage(playerid,0x6495EDFF,"ҽ��: /heal [��Ѫ] /xsfd[��ʾ�۵�] /ycd [���ط۵�]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "��Ŀǰ���ڼ���/������/ҽ����֯��!");
						}
					}
    case 7:
					{
						if(playerzuzhi[playerid]==3)
						{
							SendClientMessage(playerid,0x6495EDFF,"����:/nn	[����Ƶ��]/su [ͨ��] /drag	[Ѻ���ϳ�] /rb [·��] /urb [����·��]");
							SendClientMessage(playerid,0x6495EDFF,"����:/cu	[����] /go [��������] /guanya [����] /m	[������] /cktongji [�鿴ͨ������]");
							SendClientMessage(playerid,0x6495EDFF,"����:/setswat [��ȨSWAT]	/delswat [����SWAT]	/tofind	[����] /stofind	[ֹͣ����]");
							SendClientMessage(playerid,0x6495EDFF,"����:/xsld [��ʾ����]	/ycd [��������]	/unsu [����ͨ����] /rrb [��������·��]");
						}
						else if(playerzuzhi[playerid]==14)
						{
							SendClientMessage(playerid,0x6495EDFF,"����:/nn	[����Ƶ��]/su [ͨ��] /drag	[Ѻ���ϳ�] /rb [·��] /urb [����·��]");
							SendClientMessage(playerid,0x6495EDFF,"����:/cu	[����] /go [��������] /guanya [����] /m	[������] /cktongji [�鿴ͨ������]");
							SendClientMessage(playerid,0x6495EDFF,"����:/setswat [��ȨSWAT]	/delswat [����SWAT]	/tofind	[����] /stofind	[ֹͣ����]");
							SendClientMessage(playerid,0x6495EDFF,"����:/xsld[��ʾ����]	/ycd [��������]	/unsu [����ͨ����] /rrb [��������·��]");
						}
						else if(playerzuzhi[playerid]==4)
						{
							SendClientMessage(playerid,0x6495EDFF,"FBI:/nn	[����Ƶ��]/su [ͨ��] /drag	[Ѻ���ϳ�] /rb [·��] /urb [����·��]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/cu	[����] /go [��������] /guanya [����] /m	[������] /cktongji [�鿴ͨ������]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/setswat [��ȨSWAT]	/delswat [����SWAT]	/tofind	[����] /stofind	[ֹͣ����]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/xsld[��ʾ����]	/ycd [��������]	/unsu [����ͨ����] /rrb [��������·��]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "��Ŀǰ���ھ���/FBI/���ӵ���֯");
						}
					}
				case 8:
					{
						if(playerjob[playerid]==1)
						{
							SendClientMessage(playerid,0xFFFF00AA,"������˽��: /zscl [��˽����] /sellmats [���۲���]");
							return 1;
						}
						if(playerjob[playerid]==2)
						{
							SendClientMessage(playerid,0xFFFF00AA,"��̽: /find [����] /tzfind [ֹͣ����] ");
							return 1;
						}
						if(playerjob[playerid]==3)
						{
							SendClientMessage(playerid,0xFFFF00AA,"��������: /zuogun [��������] /zuoar [�ƻ���] /givegun [������]");
							return 1;
						}
						if(playerjob[playerid]==4)
						{
							SendClientMessage(playerid,0xFFFF00AA,"����������: /sellcar	[���۳���]");
							return 1;
						}
						if(playerjob[playerid]==5)
						{
							SendClientMessage(playerid,0xFFFF00AA,"����վ����Ա: /refill [����]");
							return 1;
						}
						if(playerjob[playerid]==6)
						{
							SendClientMessage(playerid,0xFFFF00AA,"���⳵˾��: /fare [��Ʊ��] /taxiduty [��/�°�]");
							return 1;
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "��û�й���");
      					}
					}
				case 9:
					{
						if(playeradmin[playerid]>=1)
						{
							SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1������Աָ��]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"1��:/tv [�ۿ�] /stv [ֹͣ�ۿ�] /jianjin [���] /ckstats [�鿴�����Ϣ] /ao [AOOC]");
							SendClientMessage(playerid,0x6495EDFF,"1��:/ckvstats	[�鿴����״̬] /ckhstats [�鿴����״̬]	/ckcar [�鿴������Ϣ]");
							SendClientMessage(playerid,0x6495EDFF,"1��:/gotohouse [���͵�����] /ckhouse [�鿴������Ϣ] /km [��GM���ش���]");
							SendClientMessage(playerid,0x6495EDFF,"1��:/kick [����] /la [����] /goto	[���͵����]	/ckwuqi	[�鿴����] /apm [�ش�]");
				   }
        if(playeradmin[playerid]>=2)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[2������Աָ��]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"2��:/sc [��������] /ckhp[�鿴����] /ckar [�鿴����] /ban [BAN��] /ckzhizhao [�鿴ִ��]");
							SendClientMessage(playerid,0x6495EDFF,"2��:/setcall [���ú���] /afill [���ó�����] /count [����ʱ]	/ky [������] /pai [��]	");
							}
        if(playeradmin[playerid]>=3)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[3������Աָ��]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"3��:/hp [��������] /ar [���û���]	/skin [����Ƥ��] /setcallmoney [���û���]");
							SendClientMessage(playerid,0x6495EDFF,"3��:/kick	[����] /sc [�����˳�]	/ckwuqi	[������] /gtq [������] /settime [����ʱ��]");
							}
       	if(playeradmin[playerid]>=4)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[4������Աָ��]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"4��:/setmats [���ò���] /settime [����ʱ��] /aad [���] /agov[����] /ahd [���Ϣ]");
							SendClientMessage(playerid,0x6495EDFF,"4��:/setcallmoney [���û���] /allsc [ˢ��ȫ������] /lache [����] /text [����]");
								}
        if(playeradmin[playerid]>=5)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[5������Աָ��]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"5��: /mypos [�鿴��ǰ����]");
							}
						if(playeradmin[playerid]>=1337)
						{
							SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1337������Աָ��]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"1337��:/gms [����] /gmats [��������] /gotobluebus [ǰ����ɫ��ʿ] /gotoblackbus [ǰ����ɫ��ʿ]");
							SendClientMessage(playerid,0x6495EDFF,"1337��:/szircadmin [����IRC����Ա] /szgz [���ù���] /szsxt [���ò�������ͷ]");
							SendClientMessage(playerid,0x6495EDFF,"1337��:	/szld [������֯�쵼]	/scld [������֯�쵼] ");
									}
        if(playeradmin[playerid]>=1338)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1338������Աָ��]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"1338��:/ckzzhouse [�鿴��֯������Ϣ] /ckgzhouse [�鿴����������Ϣ]	/addhouse [���ӷ���]");
							SendClientMessage(playerid,0x6495EDFF,"1338��:/addtbhouse [���ӷ���TB]	/addgzhouse [������������] /addzzhouse [������֯����]");
							SendClientMessage(playerid,0x6495EDFF,"1338��:/allsellhouse [��������]	/ckhouse [�鿴������Ϣ] /cktbhouse [�鿴����TB]");
							SendClientMessage(playerid,0x6495EDFF,"1338��:/changetbhouse [�޸ķ���TB��Ϣ]/changezzhouse [�޸���֯������Ϣ]");
							SendClientMessage(playerid,0x6495EDFF,"1338��:/changegzhouse [�޸�����������Ϣ] /changehouse [�޸ķ�����Ϣ]/szircadmin[����IRC����Ա]");
							SendClientMessage(playerid,0x6495EDFF,"1338��:/shuache[ˢ��]/shanche[ɾ��]/makeadmin[���ù���Ա]");
       SendClientMessage(playerid,0xDC143CAA,"-----------------------------------------------------------------------------------------");
							}
        if(playeradmin[playerid]>=3333)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[��̨����Աָ��]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"3333��:/makeadmin[���ù���Ա] /gmvdou[����/�ͷ�V��] /ckjike[�鿴��Ҽ���] /reloadbans [���ط���б�]");
							SendClientMessage(playerid,0x6495EDFF,"3333��:/admin [ϵͳ��Ϣ] /msgy[��] /szvip[����VIP] /gmx[����������] /xzon[��С��] /xzoff[����С��]");
       SendClientMessage(playerid,0xDC143CAA,"------------------------------------------------------------------------------------------------------------");
							}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "�㲻�ǹ���Ա!");
      }
					}
				case 10:
					{
						if(playerviplv[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"=================================VIP����==========================================================");
							SendClientMessage(playerid,0xDC143CAA,"VIP1:/vipcd [��ɫ����(���ֳ���)] /vipycd [����������ɫ] /viplvup [VIP����]");
							SendClientMessage(playerid,0xDC143CAA,"VIP1:/vipshow[��ʾVIP���] /delcd[ɾ������] /jg[����ϵͳ]");
							SendClientMessage(playerid,0xDC143CAA,"==================================================================================================");
							return 1;
						}
							SendClientMessage(playerid,0xDC143CAA,"��û��VIPȨ��Ŷ���빺��");

					}
			}
		}
		else
		{
			SendClientMessage(playerid,COLOR_YELLOW2,"��ر��˰����˵�");
		}
		return 1;
	}
//=====================[GM����̨]====================================
	if(dialogid	== 9754)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
					{
						ShowPlayerDialog(playerid,9755,DIALOG_STYLE_LIST,"{00A5FF}����ϵͳ (TLԭ����Xx_DD�߻�������Ʒ)","{FFFF00}�鿴�ҵĻ���\n��ȡ{FF0000}������Ϊ{FFFFF}����\n��ȡ{FF0000}�ܳ�С����{FFFFFF}����\n��ȡ{FF0000}����רҵ{FFFFFF}����\n��ȡ{FF0000}�ƴ�����{FFFFFF}����\n��ȡ{FF0000}�������{FFFFFF}����\n��ȡ{FF0000}���ɵй�{FFFFFF}����\n��ȡ{FF0000}��������{FFFFFF}����\n��ȡ{FF0000}�����Ǿ�{FFFFFF}����\n��ȡ{FF0000}�����ھ�{FFFFFF}����","ȷ��","ȡ��");
					}
			}
		}
		return 1;
	}
//======================[����ϵͳ]===================================
	if(dialogid	== 9755)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
					{
						SendClientMessage(playerid,COLOR_GREEN,"=====��ӵ�еĻ���=====");
						if (hzxtnqyw[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"������Ϊ����:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"������Ϊ����:δӵ��");
						}
						if (hzxtjcxqn[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"�ܳ�С�������:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"�ܳ�С�������:δӵ��");
						}
						if (hzxtwnzy[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"����רҵ����:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"����רҵ����:δӵ��");
						}
						if (hzxtcdqc[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"�ƴ����ֻ���:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"�ƴ����ֻ���:δӵ��");
						}
						if (hzxtycwg[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"����������:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"����������:δӵ��");
						}
						if (hzxtfkdg[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"���ɵй�����:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"���ɵй�����:δӵ��");
						}
						if (hzxtscjj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"������������:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"������������:δӵ��");
						}
						if (hzxtscyj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"�����Ǿ�����:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"�����Ǿ�����:δӵ��");
						}
						if (hzxtscgj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"�����ھ�����:��ӵ��");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"�����ھ�����:δӵ��");
						}
					}
			case 1:
				{
				    if(hzxtnqyw[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ������������Ѿ���ȡ����......");
				        return 1;
				    }
				    if(playerlv[playerid]<5)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ����ĵȼ�����������ȡ�˻��µ���������Ϸ�ȼ�����5������5��.");
				        return 1;
				    }
				    hzxtnqyw[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ���ɹ���ȡ�˻���......");
				    return 1;
				}
			case 2:
				{
				    if(hzxtjcxqn[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ������������Ѿ���ȡ����......");
				        return 1;
				    }
				    if(playerlv[playerid]<10)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ����ĵȼ�����������ȡ�˻��µ���������Ϸ�ȼ�����10������10��.");
				        return 1;
				    }
				    hzxtjcxqn[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ���ɹ���ȡ�˻���......");
				    return 1;
				}
			case 3:
				{
				    if(hzxtwnzy[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ������������Ѿ���ȡ����......");
				        return 1;
				    }
				    if(playerlv[playerid]<20)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ����ĵȼ�����������ȡ�˻��µ���������Ϸ�ȼ�����20������20��.");
				        return 1;
				    }
				    hzxtwnzy[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"����ϵͳ���ɹ���ȡ�˻���......");
				    return 1;
				}
			}
		}
		return 1;
	}
//========================================VIP========================
	if(dialogid	== 6666)
	{
		if(response)
		{
		if(listitem	== 0)
			{

				return 1;
			}
			if(listitem	== 1)
			{

				return 1;
			}
			if(listitem	== 2)
			{

				return 1;
			}
		}
	}
//======================================����ʳ��˵�======================================

	/*if(dialogid	== 6667)
	{
		if(response)
		{
		    if(listitem	== 0)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"�㹺����һͰVFCȫ��Ͱ($100)��");
				playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food3[playerid]=food3[playerid]+1;
			}
			if(listitem	== 1)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"�㹺����һ����԰���ȱ�$20��");
				playermoney[playerid]=playermoney[playerid]-20;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food1[playerid]=food1[playerid]+1;
			}
			if(listitem	== 2)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"�㹺����һƿ����װѩ��$100��");
				playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food2[playerid]=food2[playerid]+1;
			}
			ShowPlayerDialog(playerid,6667,DIALOG_STYLE_LIST,"ʳƷ�б�","1.VFCȫ��Ͱ+30($100)\n2.��԰���ȱ�+2($20)\n3.����ѩ��+30($100)","����","ȡ��");
			return 1;
		}
	}
//======================================��ʳ��˵�======================================
	if(dialogid	== 6668)
	{
		if(response)
		{
			if(listitem	== 0)
			{
            new	msg[256];

			if(playerjiedu[playerid]<300)
			{
	            playerjiedu[playerid]=playerjiedu[playerid]+1;
			playermoney[playerid]=playermoney[playerid]-10;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
			}
			else
			{
			format(msg,256,"[����]�Բ������Ѿ��ԵĹ����ˣ���������������ɣ��ǵò�Ҫ������ʳŶ��Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[����]�㹺����һ���׷���������������������ˣ�Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
			if(listitem	== 1)
			{
            new	msg[256];

			if(playerjiedu[playerid]<300)
			{
	            playerjiedu[playerid]=playerjiedu[playerid]+2;
			playermoney[playerid]=playermoney[playerid]-20;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
			}
			else
			{
			format(msg,256,"[����]�Բ������Ѿ��ԵĹ����ˣ���������������ɣ��ǵò�Ҫ������ʳŶ��Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[����]�㹺����һ����԰���ȱ���������������������ˣ�Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
			if(listitem	== 2)
			{
            new	msg[256];

			if(playerkouke[playerid]<300)
			{
	            playerkouke[playerid]=playerkouke[playerid]+1;
			playermoney[playerid]=playermoney[playerid]-5;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
			}
			else
			{
			format(msg,256,"[����]�Բ������Ѿ��ȵĹ����ˣ���������������ɣ��ǵò�Ҫ���Լ�����ˮͰ��Ŀǰ�ڿʶȣ�%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[����]�㹺����һƿѩ�̣����º󣬼�ֱˬ���ˣ�Ŀǰ�ڿʶȣ�%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
			if(listitem	== 3)
			{
            new	msg[256];

			if(playerjiedu[playerid]<270)
			{
	            playerjiedu[playerid]=playerjiedu[playerid]+30;
			playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
			}
			else
			{
			format(msg,256,"[����]�Բ������Ѿ��ԵĹ����ˣ���������������ɣ��ǵò�Ҫ������ʳŶ��Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[����]�㹺����һͰVFC�ͷ�ȫ��Ͱ��������������������ˣ�Ŀǰ�����ȣ�%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
			if(listitem	== 4)
			{
            new	msg[256];

			if(playerkouke[playerid]<270)
			{
	            playerkouke[playerid]=playerkouke[playerid]+30;
			playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
			}
			else
			{
			format(msg,256,"[����]�Բ������Ѿ��ȵĹ����ˣ���������������ɣ��Ѳ��������򴲣�Ŀǰ�ڿ�ֵ��%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[����]�㹺����һͰ����װѩ�̣�����̫�ʣ���һ���������ˡ�����Ŀǰ�ڿ�ֵ��%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
       	ShowPlayerDialog(playerid,6668,DIALOG_STYLE_LIST,"ʳƷ�б�","1.������+1($10)\n2.��԰���ȱ�+2($20)\n3.ѩ��+1($5)\n4.�ͷ�ȫ��Ͱ+30($100)\n5.����װѩ��+30($100)","����","ȡ��");
		return 1;
		}
	}
//=============================EATFOOD======================================
	if(dialogid	== 6669)
	{
		if(response)
		{
		if(listitem	== 0)
			{
			if(food3[playerid]==0)
			{

					SendClientMessage(playerid,COLOR_YELLOW,"�Բ������ı�����û������ʳƷ�ˣ�");
					return 1;
			}
			new msg[128];
	            food3[playerid]=food3[playerid]-1;
	            playerjiedu[playerid]=playerjiedu[playerid]+30;
			format(msg,256,"�����һͰVFCȫ��Ͱ������ֵ+30��Ŀǰ����ֵ��%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		if(listitem	== 1)
			{
			if(food1[playerid]==0)
			{
					SendClientMessage(playerid,COLOR_YELLOW2,"�Բ������ı�����û������ʳƷ�ˣ�");
					return 1;
			}
			new msg[128];
	            food1[playerid]=food1[playerid]-1;
	            playerjiedu[playerid]=playerjiedu[playerid]+2;
			format(msg,256,"�����һ����԰���ȱ�������ֵ+2��Ŀǰ����ֵ��%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		if(listitem	== 2)
			{
			if(food2[playerid]==0)
			{
					SendClientMessage(playerid,COLOR_YELLOW2,"�Բ������ı�����û������ʳƷ�ˣ�");
					return 1;
			}
			new msg[128];
	            food2[playerid]=food2[playerid]-1;
	            playerkouke[playerid]=playerkouke[playerid]+30;
			format(msg,256,"�����һƿ����ѩ�̣��ڿ�ֵ+30��Ŀǰ�ڿ�ֵ��%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		}
	}*/
//==============================�����б�===============================
	if(dialogid	== 6670)
	{
		if(response)
		{
		    if(listitem	== 0)
			{
			SetPVarInt(playerid, "color", 18643);
			return 1;
			}
		    if(listitem	== 1)
			{
			SetPVarInt(playerid, "color", 19080);
			return 1;
			}
		    if(listitem	== 2)
			{
			SetPVarInt(playerid, "color", 19081);
			return 1;
			}
		    if(listitem	== 3)
			{
			SetPVarInt(playerid, "color", 19082);
			return 1;
			}
		    if(listitem	== 4)
			{
			SetPVarInt(playerid, "color", 19083);
			return 1;
			}
		    if(listitem	== 5)
			{
			SetPVarInt(playerid, "color", 19084);
			return 1;
			}
		    if(listitem	== 6)
			{
                SetPVarInt(playerid, "laser", 0);
                RemovePlayerAttachedObject(playerid, 0);
			return 1;
			}
		}
	}
                /*if (!strcmp(tmp, "red", true)) SetPVarInt(playerid, "color", 18643);
                else if (!strcmp(tmp, "blue", true)) SetPVarInt(playerid, "color", 19080);
                else if (!strcmp(tmp, "pink", true)) SetPVarInt(playerid, "color", 19081);
                else if (!strcmp(tmp, "orange", true)) SetPVarInt(playerid, "color", 19082);
                else if (!strcmp(tmp, "green", true)) SetPVarInt(playerid, "color", 19083);
                else if (!strcmp(tmp, "yellow", true)) SetPVarInt(playerid, "color", 19084);*/
//=========================================================================
//================================MP3ϵͳ==========================
	if(dialogid	== 6700)
	{
		if(response)
		{
			if(listitem	== 0)
			{
                StopAudioStreamForPlayer(playerid);
	            SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ֳɹ�ͣ������~");
				return 1;
			}
			if(listitem	== 1)
			{
                ShowPlayerDialog(playerid,555,DIALOG_STYLE_INPUT,"{00A5FF}�Զ���URL����","���������벥�ŵ�URL(�����ȸ�����CTRL+V)!\n��Ȼ,��Ҫ��Ϸ�ȼ�2������!","�㲥","ȡ��");
				return 1;
			}
		}
	}
	if(dialogid==555)
	{
		if(response==1)
		{
			if(strcmp(inputtext," ")==0)
			{
				ShowPlayerDialog(playerid,555,DIALOG_STYLE_INPUT,"�Զ���URL����","�Բ���,��û������URL!\n�����������ճ����!","�㲥","ȡ��");
				return 1;
			}
		    	if(playerlv[playerid]<1)
		    	{
                SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ĵȼ�������2������Ŭ��������������!���������Ե㲥�Ƽ�����Ŷ!");
		    	return 1;
		    	}
                new af[256];
		    	format(af,256,"���ɹ��ĵ��˸���,��ַ����:\n{FF0000}%s\n{0033CC}������ܲ��Ż򲥷Ż���,�뿴���ǲ���URL���������!",inputtext);
			ShowPlayerDialog(playerid,266,DIALOG_STYLE_MSGBOX,"����̨",af,"ȷ��","");
			PlayAudioStreamForPlayer(playerid,	inputtext);
//Duquplayer(playerid);
			return 1;
		}
        SendClientMessage(playerid,COLOR_YELLOW,"������̨�������û�е�裬�ǵ��´����㲥Ŷ~");
		return 1;
	}
	if(dialogid	== 6701)
	{
		if(response)
		{
		new ak[128],name[128];
		if(listitem	== 0)
			{
			    GetPlayerName(playerid,name,128);
				format(ak,128,"[����̨]%s�㲥��һ��:I don't think I love you �ݳ�:Hoobastank ��Ҷ�ȥ������~/music",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
                PlayAudioStreamForPlayer(playerid, "http://gtasa.8866.org/music/1.mp3");
	            SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ڲ��ţ�I don't think I love you �ݳ�:Hoobastank");
	            SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ڼ��������У����Ժ򡭡����Ͼ�Ϊ�����Ϻ��������֣�");
			}
		if(listitem	== 1)
			{
			    GetPlayerName(playerid,name,128);
				format(ak,128,"[����̨]%s�㲥��һ��:��ս �ݳ�:�Ž� ��Ҷ�ȥ������~/music",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
                PlayAudioStreamForPlayer(playerid, "http://gtasa.8866.org/music/2.mp3");
	            SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ڲ��ţ���ս(��ս������) �ݳ�:�Ž�");
	            SendClientMessage(playerid,COLOR_YELLOW,"������̨�����ڼ��������У����Ժ򡭡����Ͼ�Ϊ�����Ϻ��������֣�");
			}
		}
		return 1;
	}
//===========================================================
	/*if(dialogid	== GOTOMENU)
	{
		if(response)
		{
			if(listitem	== 0) // LS
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1]	= 0.0;
				}
				else
				{
					SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
				}
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}��ɼ����֣�LSPD��{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 1) // SF
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1]	= 0.0;
				}
				else
				{
					SetPlayerPos(playerid, -1417.0,-295.8,14.1);
				}
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}�ɽ�ɽ��SF��{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 2) // LV
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1]	= 0.0;
				}
				else
				{
					SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
				}
				SendClientMessage(playerid,	COLOR_GRAD1, "	 �㱻������!");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 3) // Jet
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1.71875, 30.4062,	1200.34);
				}
				else
				{
					SetPlayerPos(playerid, 1.71875,	30.4062, 1200.34);
				}
				SetPlayerInterior(playerid,1);
							SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}����LS����������{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
			}
			if(listitem	== 4) // Bank
			{
				new	vehicleid;
				vehicleid =	GetPlayerVehicleID(playerid);
				SetVehiclePos(vehicleid, 593.0324,-1241.1177,17.9662);
				SetPlayerPos(playerid, 593.0324,-1241.1177,17.9662);
				SendClientMessage(playerid,	COLOR_ALLDEPT, "�㱻���͵���LS����.");
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			if(listitem	== 5) // Interior
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1416.107000,0.268620,1000.926000);
				}
				else
				{
					SetPlayerPos(playerid, 1416.107000,0.268620,1000.926000);
				}
				SendClientMessage(playerid,	COLOR_GRAD1, "	 �㱻������!");
				SetPlayerInterior(playerid,1);
			}
			if(listitem	== 6) // MC
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -2310.7483,-1636.6708,483.7031);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1]	= 0.0;
				}
				else
				{
					SetPlayerPos(playerid, -2310.7483,-1636.6708,483.7031);
				}
				SendClientMessage(playerid,	COLOR_GRAD1, "	 �㱻������!");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 7) // DPD
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 647.6130,-569.1110,16.2114);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1]	= 0.0;
				}
				else
				{
					SetPlayerPos(playerid, 647.6130,-569.1110,16.2114);
				}
				SendClientMessage(playerid,	COLOR_GRAD1, "	 �㱻������!");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 8) // stad
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -1435.75,	-652.664, 1054.94);
				}
				else
				{
					SetPlayerPos(playerid, -1435.75, -652.664, 1054.94);
				}
				SetPlayerInterior(playerid,4);
			}
			if(listitem	== 9) // Prison
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1811.0902,-1576.8265,13.5222);
				}
				else
				{
					SetPlayerPos(playerid, 1811.0902,-1576.8265,13.5222);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 10) // Stadium 2
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 2685.8931,-1689.8219,9.4348);
				}
				else
				{
					SetPlayerPos(playerid, 2685.8931,-1689.8219,9.4348);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 11) // All Saints
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1188.4399,-1326.0999,13.5596);
				}
				else
				{
					SetPlayerPos(playerid, 1188.4399,-1326.0999,13.5596);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 12) // Presidents house
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1137.4019,-2037.7604,69.0078);
				}
				else
				{
					SetPlayerPos(playerid, 1137.4019,-2037.7604,69.0078);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 13) // Airport
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 1962.2400,-2183.4321,13.5469);
				}
				else
				{
					SetPlayerPos(playerid, 1962.2400,-2183.4321,13.5469);
				}
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}LS����{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 14) // Gym
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 2232.4585,-1740.8671,13.5507);
				}
				else
				{
					SetPlayerPos(playerid, 2232.4585,-1740.8671,13.5507);
				}
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}�˶���{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");

  				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 15) // County
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 2023.4404,-1417.1273,16.9922);
				}
				else
				{
					SetPlayerPos(playerid,2023.4404,-1417.1273,16.9922);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 16) // FBI
			{
				if (GetPlayerState(playerid) ==	2)
				{
     SetPlayerInterior(playerid,1);
	 LinkVehicleToInterior(GetPlayerVehicleID(playerid),1);
     SetVehiclePos(GetPlayerVehicleID(playerid),-783.2614,503.1347,1381.6);
				}
				else
				{
					SetPlayerPos(playerid, -783.2614,503.1347,1381.6);
					SetPlayerInterior(playerid,1);
				}
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}���ɳ�{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
			}
			if(listitem	== 17) // Hitman HQ
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, -716.497863,950.520263,12.174923);
				}
				else
				{
					SetPlayerPos(playerid, -716.497863,950.520263,12.174923);
				}
				SetPlayerInterior(playerid,0);
				SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}GM����ǰ��{FFC0CB} ��ʽ��{FF00FF}��������{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
			SendClientMessage(playerid, COLOR_BLUE, "ע�����δ���Ŀ��Ϊ����ص㣬�����շ�1.2W�ķ��ã�");
			            playermoney[playerid]=playermoney[playerid]-12000;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,playermoney[playerid]);
			}
			if(listitem	== 18) // DMV
			{
				if (GetPlayerState(playerid) ==	2)
				{
					new	tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, 2060.0513,-1913.4083,13.5469);
				}
				else
				{
					SetPlayerPos(playerid, 2060.0513,-1913.4083,13.5469);
				}
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 19) // Lab 1
			{


            SetPlayerPos(playerid, 2316.616699,-15.422499,26.742187);
			SetPlayerInterior(playerid,	5);
			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}�����ڲ�{FFC0CB} ��ʽ��{FF00FF}���˴���{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 20)
			{
				SetPlayerPos(playerid,2124.29882812,-1791.83972168,13.22490692);
   			SendClientMessage(playerid, COLOR_BLUE, "=====================ʱ�ջ���=========================");
			SendClientMessage(playerid, COLOR_BLUE, "��������ʱ�ջ�����Ŀ�꣺{FF00FF}������{FFC0CB} ��ʽ��{FF00FF}���˴���{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "ʱ�ջ��������С���  ������ϣ���");
  			SendClientMessage(playerid, COLOR_BLUE, "����ָ��Ŀ�꣡���δ��ͽ�����лл����ʹ�ã�");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
            SetPlayerInterior(playerid, 6);
			}
            playermoney[playerid]=playermoney[playerid]-8000;
            		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,	COLOR_RED, "���յ���һ������VS Bank���˵����������£�");
			SendClientMessage(playerid,	COLOR_YELLOW2, "VS����:��л����ʹ�ã������Ѿ���ȡ������ʱ�ջ�ʹ�÷ѣ�ף����ÿ��ģ�");
		}
		return 1;
	}*/
	if(dialogid	== 8525)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				playersex[playerid]	= 1;
				SendClientMessage(playerid,	COLOR_YELLOW2, "����Ա�Ϊ��.");
				new	listitems[]	= "{FFFFFF}�����·���д��ĳ�������{55EE55}\n��ʽ(��/��/�� ��:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"��ĳ�������:",listitems,"ȷ��","ȡ��");
				new	maleskin;
				maleskin = random(sizeof(CivMalePeds));
				SetPlayerSkin(playerid,CivMalePeds[maleskin][0]);
				playerskin[playerid] = CivMalePeds[maleskin][0];
				RegistrationStep[playerid] = 2;
				return 1;
			}
			else if(listitem ==	1)
			{
				playersex[playerid]	= 2;
				SendClientMessage(playerid,	COLOR_YELLOW2, "����Ա�ΪŮ.");
				new	listitems[]	= "{FFFFFF}�����·���д��ĳ�������{55EE55}\n��ʽ(��/��/�� ��:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"��ĳ�������:",listitems,"ȷ��","ȡ��");
				new	femaleskin;
				femaleskin = random(sizeof(CivFemalePeds));
				SetPlayerSkin(playerid,	CivFemalePeds[femaleskin][0]);
				playerskin[playerid] = CivFemalePeds[femaleskin][0];
				RegistrationStep[playerid] = 2;
				return 1;
			}
		}
		else
		{
			new	listitems[]	= "{FFFFFF}��\n{FFFFFF}Ů";
			ShowPlayerDialog(playerid,8525,DIALOG_STYLE_LIST,"����Ա�:",listitems,"ȷ��","ȡ��");
		}
	}

	if(dialogid	== 8526)
	{
		new	string[128];
		if(response)
		{
			new	year, month,day;
			getdate(year, month, day);
			new	DateInfo[3][20];
			split(inputtext, DateInfo, '/');
			if(year	- strvalEx(DateInfo[2])	> 100 || strvalEx(DateInfo[2]) < 1 || strvalEx(DateInfo[2])	>= year)
			{
				new	listitems[]	= "{FFFFFF}��д��ʽ����,��������д{55EE55}\n��ʽ(��/��/�� ��:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"��ĳ�������:",listitems,"ȷ��","ȡ��");
				return 1;
			}
			new	check =	year - strvalEx(DateInfo[2]);
			if(check ==	year)
			{
				new	listitems[]	= "{FFFFFF}��д��ʽ����,��������д{55EE55}\n��ʽ(��/��/�� ��:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"��ĳ�������:",listitems,"ȷ��","ȡ��");
				return 1;
			}
			if(strvalEx(DateInfo[1]) > month)
			{
				check -= 1;
			}
			else if(strvalEx(DateInfo[1]) == month && strval(DateInfo[0]) >	day)
			{
				check -= 1;
			}
			playerage[playerid]	= check;
			format(string, sizeof(string), "�õ�,������� %d ��.",playerage[playerid]);
			SendClientMessage(playerid,	COLOR_YELLOW2, string);
			new	packthings[] = "��� 1	\n ���	2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"��ѡ��һ������򿪣�",packthings,"ѡ��","");
			RegistrationStep[playerid] = 3;
		}
		else
		{
			new	listitems[]	= "{FFFFFF}�����·���д��ĳ�������{55EE55}\n��ʽ(��/��/�� ��:7/7/1993)";
			ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"��ĳ�������:",listitems,"ȷ��","ȡ��");
		}
	}
//================================================�ʵ�
	if(dialogid	== 158)
	{
		if(response)
		{
			if (listitem ==	0)
			{
				new	DialogString[1024];
				format(DialogString, sizeof	DialogString, "4 ����������	\n 1000$Ԫ");
				ShowPlayerDialog(playerid,159,DIALOG_STYLE_MSGBOX,"�������	1",	DialogString,"ѡ��","����");
			}
			else if	(listitem == 1)
			{
				new	DialogString[1024];
				format(DialogString, sizeof	DialogString, "�ȼ�	1 \n 4000$Ԫ");
				ShowPlayerDialog(playerid,160,DIALOG_STYLE_MSGBOX,"�������	2",	DialogString,"ѡ��","����");
			}
		}
		else
		{
			SetTimerEx("KickEx",2000,false,"i",playerid);
		}
	}
	if(dialogid	== 159)
	{
		if(response)
		{
			new	playerexp =	playerlvup[playerid];
			playerlvup[playerid] = playerexp + 4;
			GivePlayerMoney(playerid, 1000);
			playerput[playerid]	= 1;
			RegistrationStep[playerid] = 0;
			SendClientMessage(playerid , COLOR_YELLOW,"[�ҵ��й���]:���ɹ����������֤,������������������,ף�����!");
			//SetPlayerPos(playerid, 1613.401000,	-2330.213134, 13.546875);//1.71875,	30.4062, 1200.34
			TogglePlayerControllable(playerid, 1);
		}
		else
		{
			new	packthings[] = "������� 1 \n ������� 2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"��ѡ��һ����ϲ���������ʼ��Ϸ��",packthings,"ȷ��","");
		}
	}
	if(dialogid	== 160)
	{
		if(response)
		{
			GivePlayerMoney(playerid, 4000);
			playerput[playerid]	= 1;
			RegistrationStep[playerid] = 0;
			SendClientMessage(playerid , COLOR_YELLOW,"[�ҵ��й���]:���ɹ����������֤,������������������,ף�����!");
			//SetPlayerPos(playerid, 1613.401000,	-2330.213134, 13.546875);//1.71875,	30.4062, 1200.34
			TogglePlayerControllable(playerid, 1);
		}
		else
		{
			new	packthings[] = "������� 1 \n ������� 2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"��ѡ��һ����ϲ���������ʼ��Ϸ��",packthings,"ȷ��","");
		}
	}
	if(dialogid	== 8899)
	{
		if(response)
		{
			if(listitem	== 0)
			{
			//blue
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon", CreateDynamicObject(18648,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon1", CreateDynamicObject(18648,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon"),	GetPlayerVehicleID(playerid), -0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon1"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
			}
			if(listitem	== 1)
			{
			 //red
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon2", CreateDynamicObject(18647,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon3", CreateDynamicObject(18647,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon2"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon3"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 2)
			{
			//green
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon4", CreateDynamicObject(18649,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon5", CreateDynamicObject(18649,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon4"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon5"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 3)
			{
			//white
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon6", CreateDynamicObject(18652,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon7", CreateDynamicObject(18652,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon6"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon7"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 4)
			{
			//pink
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon8", CreateDynamicObject(18651,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon9", CreateDynamicObject(18651,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon8"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon9"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 5)
			{
			//yellow
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon10", CreateDynamicObject(18650,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon11", CreateDynamicObject(18650,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon10"), GetPlayerVehicleID(playerid),	-0.8, 0.0, -0.70, 0.0, 0.0,	0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon11"), GetPlayerVehicleID(playerid),	0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 6)
			{
			//police
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon12", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon13", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon12"), GetPlayerVehicleID(playerid),	-0.8, 0.0, -0.70, 0.0, 0.0,	0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon13"), GetPlayerVehicleID(playerid),	0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 7)
			{
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "interior", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "interior1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "interior"),	GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0,	3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "interior1"), GetPlayerVehicleID(playerid), 0, -0.0,	0, 2.0,	2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 8)
			{
			//back
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "back", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "back1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "back"),	GetPlayerVehicleID(playerid), -0.0,	-1.5, -1, 2.0, 2.0,	3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "back1"), GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0,	2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 9)
			{
				//front
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "front", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "front1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "front"), GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6,	2.0, 2.0, 3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "front1"), GetPlayerVehicleID(playerid),	-0.0, 1.5, -0.6, 2.0, 2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"��װ���");
			}
			if(listitem	== 10)
			{
				//undercover
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "undercover", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "undercover1",	CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "undercover"), GetPlayerVehicleID(playerid),	-0.5, -0.2,	0.8, 2.0, 2.0, 3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "undercover1"), GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0,	3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"");
			}
			if(listitem	== 11)
			{
			//remove neon
				DestroyDynamicObject(GetPVarInt(playerid, "neon"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon1"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon2"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon3"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon4"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon5"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon6"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon7"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon8"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon9"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon10"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon11"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon12"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "neon13"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "interior"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "interior1"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "back"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "back1"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "front"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "front1"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "undercover"));
				DeletePVar(playerid, "Status");
				DestroyDynamicObject(GetPVarInt(playerid, "undercover1"));
				DeletePVar(playerid, "Status");
			}
		}
	}
//--------------------------------------------��ǹ---------------------------------
	if(dialogid	== 100)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==4)
					{
						if(playermats[playerid]<125)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=4;
						playermats[playerid]=playermats[playerid]-50;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==1)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==24)
					{
						if(playermats[playerid]<180)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=24;
						playermats[playerid]=playermats[playerid]-180;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem	== 2)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==24)
					{
						if(playermats[playerid]<220)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=25;
						playermats[playerid]=playermats[playerid]-220;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem	== 3)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==29)
					{
						if(playermats[playerid]<350)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=29;
						playermats[playerid]=playermats[playerid]-350;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem	== 4)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==31)
					{
						if(playermats[playerid]<50)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=31;
						playermats[playerid]=playermats[playerid]-560;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem	== 5)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==30)
					{
						if(playermats[playerid]<560)
						{
							SendClientMessage(playerid,0x00FF00AA,"�����ϵĲ��ϲ��������������!");
							return 1;
						}
						playerwuqi[playerid][i]=30;
						playermats[playerid]=playermats[playerid]-560;
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem	== 6)
			{
			}
			if(listitem	== 7)
			{
			}
		}
	}



//==============================================================

//===========================================�ӹ���============================================
	if(dialogid	== 200)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				playerjob[playerid]=0;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ��Ĵ�ȥ�˹���!");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem	== 1)
			{
				playerjob[playerid]=1;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ������˽��");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem== 2)
			{
				playerjob[playerid]=2;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ��̽");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem	== 3)
			{
				playerjob[playerid]=3;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ��������");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem	== 4)
			{
				playerjob[playerid]=4;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ����������");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem	== 5)
			{
				playerjob[playerid]=5;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ����վ����Ա");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
			if(listitem	== 6)
			{
				playerjob[playerid]=6;
				SendClientMessage(playerid,0xDC143CAA,"��ɹ���ְ�˹���: ���⳵˾��");
				SendClientMessage(playerid,0xDC143CAA,"�����ڿ�������/help ���鿴��������!");
				return 1;
			}
		}
	}

	//===========================================�������֤============================================
	if(dialogid	== 8912)
	{
		if(response)
		{
			if(listitem	== 0)
			{
			 new	SFZIDB=330000000000000000;
    new	sfzid;
    new	sdi;
	   if (GetPlayerMoney(playerid)<500)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ�������������� (500) !");
					GivePlayerMoney(playerid,-500);
 				GameTextForPlayer(playerid,"shouxufei 500$ okey!",5000,1);
     return 1;
				}
    sdi = GetPlayerPing(playerid);//���֤
	   sfzid = playercall[playerid]+SFZIDB+sdi;//���֤
	   playersfz[playerid] = sfzid+1;//���֤
				SendClientMessage(playerid,0xDC143CAA,"���������֤������/stats�쿴���֤�����,ϣ�����ܹ�����������!");
				return 1;
			}
		}
	}
//================================================================================================
//================================================================================================
	if(dialogid	== 3576)
	{
	if(response)
	{
	if(listitem	== 0)
	{
	playerircid[playerid]=1;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ�������IRCƵ��1,����/i����IRCƵ����˵��!");
	return 1;
	}
	if(listitem	== 1)
	{
	playerircid[playerid]=2;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ�������IRCƵ��2,����/i����IRCƵ����˵��!");
	return 1;
	}
	if(listitem	== 2)
	{
	playerircid[playerid]=3;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ�������IRCƵ��3,����/i����IRCƵ����˵��!");
	return 1;
	}
	if(listitem	== 3)
	{
	playerircid[playerid]=4;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ�������IRCƵ��4,����/i����IRCƵ����˵��!");
	return 1;
	}
	if(listitem	== 4)
	{
	playerircid[playerid]=5;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ�������IRCƵ��5,����/i����IRCƵ����˵��!");
	return 1;
	}
	if(listitem	== 5)
	{
	playerircid[playerid]=0;
	SendClientMessage(playerid,0xDC143CAA,"��ɹ����˳���IRCƵ��,�㽫����ʹ��/i��IRCƵ����˵��!");
	return 1;
			}
		}
	}
//===========================================24/7�̵�===============================
	if(dialogid	== 8900)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				new	msg[128];
				new	CSH=80000;
				new	callid;
				new	pi;
				if (GetPlayerMoney(playerid)<3800)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				callid=playerid+CSH+pi;
				playercall[playerid]=callid+pi+callid;
				format(msg,128,"������һ��IphoneG3	[�绰����Ϊ:%d]*Iphone�ŵ�:�����С,�ü�",playercall[playerid]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				GivePlayerMoney(playerid,-3800);
				//==============================================================

				//==============================================================
				GameTextForPlayer(playerid,"-3800",5000,1);
			}
			if(listitem	== 1)
			{
				new	msg[128];
				new	CSH=8000000;
				new	callid;
				new	pi;
				if (GetPlayerMoney(playerid)<800)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				callid=playercall[playerid]+CSH+pi;
				playercall[playerid]=callid+1;
				format(msg,128,"������һ��С��ͨ [�绰����Ϊ:%d]",playercall[playerid]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				GivePlayerMoney(playerid,-800);
				GameTextForPlayer(playerid,"-800",5000,1);
			}
			if(listitem	== 2)
			{
				if (GetPlayerMoney(playerid)<10)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+10;
				SendClientMessage(playerid,0x00FF00AA,"��Ϊ����ֻ�����ֵ��10Ԫ");
				GivePlayerMoney(playerid,-10);
				GameTextForPlayer(playerid,"-10",5000,1);
			}
			if(listitem	== 3)
			{
				if (GetPlayerMoney(playerid)<20)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+20;
				SendClientMessage(playerid,0x00FF00AA,"��Ϊ����ֻ�����ֵ��20Ԫ");
				GivePlayerMoney(playerid,-20);
				GameTextForPlayer(playerid,"-20",5000,1);
			}
			if(listitem	== 4)
			{
				if (GetPlayerMoney(playerid)<50)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+50;
				SendClientMessage(playerid,0x00FF00AA,"��Ϊ����ֻ�����ֵ��50Ԫ");
				GivePlayerMoney(playerid,-50);
				GameTextForPlayer(playerid,"-50",5000,1);
			}
			if(listitem	== 5)
			{
				if (GetPlayerMoney(playerid)<100)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+100;
				SendClientMessage(playerid,0x00FF00AA,"��Ϊ����ֻ�����ֵ��100Ԫ");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,"-100",5000,1);
			}
			if(listitem	== 6)
			{
				if (GetPlayerMoney(playerid)<200)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+200;
				SendClientMessage(playerid,0x00FF00AA,"��Ϊ����ֻ�����ֵ��200Ԫ");
				GivePlayerMoney(playerid,-200);
				GameTextForPlayer(playerid,"-200",5000,1);
			}
			if(listitem	== 7)
			{
				new	pi;
				if (GetPlayerMoney(playerid)<50000)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				if(pi==50 && pi==55	&& pi==60 && pi==65	&& pi==70 && pi==75	&& pi==80 && pi==85)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"��Ʊ:��ϲ���%s����2�Ƚ�3��Ԫ",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"��ϲ��!������3��Ԫ");
					GivePlayerMoney(playerid,30000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"�ź�~��û�н�~");}
				if(pi==85 && pi==90	&& pi==91 && pi==96	&& pi==92 && pi==98	&& pi==100 && pi==150)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"��Ʊ:��ϲ���%s����1�Ƚ�500��Ԫ",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"��ϲ��!������500��Ԫ");
					GivePlayerMoney(playerid,5000000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"�ź�~��û�н�~");}
				if(pi>130)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"��Ʊ:��ϲ���%s�����صȽ�1000Ԫ",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"��ϲ��!������1000Ԫ");
					GivePlayerMoney(playerid,1000);
					return 1;
				}
				if(pi>100)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"��Ʊ:��ϲ���%s���˰�ο��5Ԫ",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"��ϲ��!������1000Ԫ");
					GivePlayerMoney(playerid,1000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"�ź�~��û�н�~");}
				GivePlayerMoney(playerid,-50000);
				GameTextForPlayer(playerid,"-50000",5000,1);
			}
			if(listitem	== 8)
			{
				if (GetPlayerMoney(playerid)<1500)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				SetPlayerHealth(playerid,100);
				GivePlayerMoney(playerid,-1500);
				GameTextForPlayer(playerid,"-1500",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"������һ��¿����Ѫ��������������������ò���ܼ�Ѫ~");
			}
			if(listitem	== 9)
			{
				if (GetPlayerMoney(playerid)<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				GivePlayerMoney(playerid,-1000);
				GameTextForPlayer(playerid,"-1000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"�㹺���˵��ӵ绰�� �÷�[/chm+���ID���]	ÿ�κķ�5Ԫ����");
			}
			if(listitem	== 10)
			{
				if (GetPlayerMoney(playerid)<6000)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				GivePlayerMoney(playerid,-6000);
				GameTextForPlayer(playerid,"-6000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"�㹺����IPAD	��ʹ��/help�鿴����");
				playeripad[playerid]=1;
			}
			if(listitem	== 11)
			{
				if (GetPlayerMoney(playerid)<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"���Ǯ����");
					return 1;
				}
				GivePlayerMoney(playerid,-1000);
				GameTextForPlayer(playerid,"-1000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"�㹺�����̻�	��ʹ��/help�鿴����");
				playeryanhua[playerid]++;
			}
		}
	}
///////////////////////////////////////////////////////////////////////////////////
/*new cmd[128];
new Account[26];
if(strcmp(cmd, "/payfine", true) == 0)
    {
        if(XY(10,playerid,1524.820922 ,-1677.945678, 5.890625)==0&&XY(10,playerid,1557.278686 ,-1675.701538	,28.395452)==0&&XY(15,playerid,1539.951660 ,-1675.954101 ,13.549644)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"�㲻�ڳ������/������ſ�/¥�����!");
						return 1;
					}
            if(Account[playerid][_fine]==0)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, " ����: �㲻��Ҫ���ɷ���");
            	return 1;
            }
            if(GetPlayerMoney(playerid)<Account[playerid][_fine])
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, " ����: ���ɲ��𷣽�/stats�鿴���ٷ���");
            	return 1;
            }
            if(PlayerToPoint(5.0, playerid, 252.3794,117.5285,1003.2187))
            {
                GiveMoney(playerid, -Account[playerid][_fine]);
                fastdrive[playerid]=0;
	       		format(string, sizeof(string), "   ������� $ %d �ĳ��ٷ���.", Account[playerid][_fine]);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				Govassets+=Account[playerid][_fine];
     			SaveStuff();
     			new tmpstr[255];
				format(tmpstr, sizeof(tmpstr), " ������������ $%d[���: $%d] ���� %s[ID %d] �ĳ��ٷ���", Account[playerid][_fine],Govassets,Account[playerid][pName],playerid);
				ABroadCast(COLOR_GREEN,tmpstr,1);
				//fastdrive[playerid]=0;
	           	Account[playerid][pCarLicS]=0;
				Account[playerid][_fine]=0;
				SendClientMessage(playerid, COLOR_YELLOW2, string);
				SendClientMessage(playerid, COLOR_YELLOW2, " ��ʾ: �Ժ���С�ļ�ʻ");
				return 1;
            }
            else
            {



		}
	}
*/
 if(dialogid==0)
	{
		if(response==1)
		{
			if(strcmp(inputtext," ")==0)
			{
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"����","","ȷ��","ȡ��");
				return 1;
			}
			Onplayerregister(playerid, inputtext);
			return 1;
		}
		SetTimerEx("KickEx",2000,false,"i",playerid);
		return 1;
	}
	if(dialogid==1)
	{
		if(response==1)
		{
			if(strcmp(inputtext," ")==0)
			{
				ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"����","�������!����������!","��¼","�˳�");
				return 1;
			}
			Onplayerlogin(playerid,	inputtext);
//Duquplayer(playerid);
			return 1;
		}
		SetTimerEx("KickEx",2000,false,"i",playerid);
		return 1;
	}
	if(dialogid==2)
	{
		if(response==1)
		{
			if(listitem==0)
			{
			    #define carliststring "[ID:400]Landstalker($120000)\n[ID:500]Mesa($180000)\n[ID:579]Huntley($220000)\n[ID:402]Buffalo($250000)\n[ID:405]Sentinel($250000)\n[ID:412]Voodoo($200000)\n[ID:410]Manana($150000)\n[ID:482]Burrito($230000)\n[ID:578]DFT-30($300000)\n[ID:600]Picador($180000)\n[ID:401]Bravura($130000)\n[ID:426]Premier($200000)"
			    ShowPlayerDialog(playerid,66,DIALOG_STYLE_LIST,"��ϵͳ - ���ֳ���",carliststring,"����","ȡ��");
			}
			if(listitem==1)
			{
			 #define carliststring1 "[ID:509]Bike($8000)\n[ID:481]BMX($12000)\n[ID:510]Mountain Bike($18000)\n[ID:462]Faggio($24000)\n[ID:463]Freeway($35000)\n[ID:461]PCJ-600($45000)\n[ID:581]BF-400($50000)"
				ShowPlayerDialog(playerid,67,DIALOG_STYLE_LIST,"��ϵͳ - ���ֳ���",carliststring1,"����","ȡ��");
			}
			if(listitem==2)
			{
			 #define carliststring2 "[ID:487]Maverick($3200000)\n[ID:469]Sparrow($3000000)"
				ShowPlayerDialog(playerid,68,DIALOG_STYLE_LIST,"��ϵͳ - �ɻ�/ֱ������",carliststring2,"����","ȡ��");
			}
			if(listitem==3)
			{
			 #define carliststring3 "[ID:409]Stretch($300000)\n[ID:411]Infernus($400000)\n[ID:415]Cheetah($400000)\n[ID:429]Banshee($400000)\n[ID:451]Turismo($450000)\n[ID:477]ZR-350($500000)\n[ID:506]Super GT($500000)\n[ID:541]Bullet($500000)"
				ShowPlayerDialog(playerid,69,DIALOG_STYLE_LIST,"��ϵͳ - VIP������",carliststring3,"����","ȡ��");
			}
			if(listitem==4)
			{
				ShowPlayerDialog(playerid,70,DIALOG_STYLE_LIST,"��ϵͳ - ���⳵����","��������δ���,��ȴ��°�","����","");
			}
		}
		return 1;
	}
	if(dialogid==66)
	{
		if(response==1)
		{
			for(new	s=0;s<12;s++)
			{
				if(listitem==s)
				{
					if(playermoney[playerid]<sellcarsilunchemoney[s])
					{
						SendClientMessage(playerid,0xFFFACDAA,"* ���Ǯ��������������!");
						return 1;
					}
					new	vid;
					//-2435.414062,2486.790527,13.781688
					vid=AddStaticVehicleEx(sellcarsilunchemod[s],-2445.007568,2485.488525,15.320312,4.352599,0,0,99999999999999999999999999);
     GetPlayerName(playerid,carname[vid],128);
					carx[vid]=-2445.007568;
					cary[vid]=2485.488525;
					carz[vid]=15.320312;
					carmianxiang[vid]=4.352599;
					carcolor1[vid]=0;
					carcolor2[vid]=0;
					carzuzhi[vid]=0;
					carmoney[vid]=sellcarsilunchemoney[s];
					carmoxing[vid]=sellcarsilunchemod[s];
					car[vid]=vid;
					cargzbc[vid]=0;
					carfill[vid]=150;
					playermoney[playerid]=playermoney[playerid]-carmoney[vid];
					playercar[playerid]=playercar[playerid]+1;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					caryinqing[vid]=0;
					cardengguang[vid]=0;
					carlock[vid]=0;
					SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
					return 1;
				}
			}
			return 1;
		}
		return 1;
	}
	if(dialogid==67)
	{
		if(response==1)
		{
			for(new	s=0;s<7;s++)
			{
				if(listitem==s)
				{
					if(playermoney[playerid]<sellcarlianglunchemoney[s])
					{
						SendClientMessage(playerid,0xFFFACDAA,"* ���Ǯ��������������!");
						return 1;
					}
					new	vid;
    				//-2435.414062,2486.790527,13.781688

					vid=AddStaticVehicleEx(sellcarlianglunchemod[s],-2445.007568,2485.488525,15.320312,4.352599,0,0,99999999999999999999999999);
					GetPlayerName(playerid,carname[vid],128);
					carx[vid]=-2445.007568;
					cary[vid]=2485.488525;
					carz[vid]=15.320312;
					carmianxiang[vid]=4.352599;
					carcolor1[vid]=0;
					carcolor2[vid]=0;
					carzuzhi[vid]=0;
					carmoxing[vid]=sellcarlianglunchemod[s];
					carmoney[vid]=sellcarlianglunchemoney[s];
					car[vid]=vid;
					cargzbc[vid]=0;
					carfill[vid]=150;
					caryinqing[vid]=0;
					cardengguang[vid]=0;
					carlock[vid]=0;
					SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
					playermoney[playerid]=playermoney[playerid]-carmoney[vid];
					playercar[playerid]=playercar[playerid]+1;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					return 1;
				}
			}
			return 1;
		}
		return 1;
	}
		if(dialogid==68)
	{
		if(response==1)
		{
			for(new	s=0;s<2;s++)
			{
				if(listitem==s)
				{
					if(playermoney[playerid] < sellfeijimoney[s])
					{
						SendClientMessage(playerid,0xFFFACDAA,"* ���Ǯ����������ܷɻ�/ֱ����!");
						return 1;
					}
					new	vid;
    				//-2435.414062,2486.790527,13.781688

					vid=AddStaticVehicleEx(sellfeijimod[s],-2445.007568,2485.488525,15.320312,4.352599,0,0,99999999999999999999999999);
					GetPlayerName(playerid,carname[vid],128);
					carx[vid]=-2445.007568;
					cary[vid]=2485.488525;
					carz[vid]=15.320312;
					carmianxiang[vid]=4.352599;
					carcolor1[vid]=0;
					carcolor2[vid]=0;
					carzuzhi[vid]=0;
					carmoxing[vid]=sellfeijimod[s];
					carmoney[vid]=sellfeijimoney[s];
					car[vid]=vid;
					cargzbc[vid]=0;
					carfill[vid]=150;
					caryinqing[vid]=0;
					cardengguang[vid]=0;
					carlock[vid]=0;
					SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
					playermoney[playerid]=playermoney[playerid]-carmoney[vid];
					playercar[playerid]=playercar[playerid]+1;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					return 1;
				}
			}
			return 1;
		}
		return 1;
	}
		if(dialogid==69)
	{
		if(response==1)
		{
			if(playerviplv[playerid]==0)
			{
			SendClientMessage(playerid,0x00FF00AA,"�㲻��VIP!");
			return 1;
			}
   for(new	s=0;s<8;s++)
			{
				if(listitem==s)
				{
					if(playermoney[playerid]<sellvipcarmoney[s])
					{
						SendClientMessage(playerid,0xFFFACDAA,"* ���Ǯ��������������!");
						return 1;
					}
					new	vid;
    				//-2435.414062,2486.790527,13.781688

					vid=AddStaticVehicleEx(sellvipcarmod[s],-2445.007568,2485.488525,15.320312,4.352599,0,0,99999999999999999999999999);
					GetPlayerName(playerid,carname[vid],128);
					carx[vid]=-2445.007568;
					cary[vid]=2485.488525;
					carz[vid]=15.320312;
					carmianxiang[vid]=4.352599;
					carcolor1[vid]=0;
					carcolor2[vid]=0;
					carzuzhi[vid]=0;
					carmoxing[vid]=sellvipcarmod[s];
					carmoney[vid]=sellvipcarmoney[s];
					car[vid]=vid;
					cargzbc[vid]=0;
					carfill[vid]=150;
					caryinqing[vid]=0;
					cardengguang[vid]=0;
					carlock[vid]=0;
					SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
					playermoney[playerid]=playermoney[playerid]-carmoney[vid];
					playercar[playerid]=playercar[playerid]+1;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					return 1;
				}
			}
			return 1;
		}
		return 1;
	}
	if(dialogid==5)
	{
		if(response==1)
		{
			carzuyongkey[playerid]=GetPlayerVehicleID(playerid);
			carzuyong[GetPlayerVehicleID(playerid)]=1;
			SendClientMessage(playerid,0x00FF00AA,"��ʹ��ʱ������/jiechuzuche����!");
			return 1;
		}
		RemovePlayerFromVehicle(playerid);
		return 1;
	}
	if(dialogid==6)
	{
		if(response==1)
		{
			if(listitem==0)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==4)
					{
						if(playermoney[playerid]<5000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=4;
						playermoney[playerid]=playermoney[playerid]-5000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==1)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==24)
					{
						if(playermoney[playerid]<12000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=24;
						playermoney[playerid]=playermoney[playerid]-12000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==2)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==24)
					{
						if(playermoney[playerid]<15000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=25;
						playermoney[playerid]=playermoney[playerid]-15000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==3)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==29)
					{
						if(playermoney[playerid]<18000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=29;
						playermoney[playerid]=playermoney[playerid]-18000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==4)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==31)
					{
						if(playermoney[playerid]<22000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=31;
						playermoney[playerid]=playermoney[playerid]-22000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==5)
			{
				for(new	i=0;i<7;i++)
				{
					if(playerwuqi[playerid][i]==0||playerwuqi[playerid][i]==30)
					{
						if(playermoney[playerid]<22000)
						{
							SendClientMessage(playerid,0x00FF00AA,"�������������");
							return 1;
						}
						playerwuqi[playerid][i]=30;
						playermoney[playerid]=playermoney[playerid]-22000;
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,playermoney[playerid]);
						ResetPlayerWeaponEx(playerid);
						for(new	w=0;w<7;w++)
						{
							GivePlayerWeaponEx(playerid,playerwuqi[playerid][w],1111111111);
						}
						return 1;
					}
				}
				SendClientMessage(playerid,0x00FF00AA,"���ò��˸����������");
				return 1;
			}
			if(listitem==6)
			{
				SendClientMessage(playerid,0x00FF00AA,"����������ȱ����.");
				return 1;
			}
		}
		SendClientMessage(playerid,0x00FF00AA,"�´������! ");
		return 1;
	}
	if(dialogid	== 8520)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"�����ڷǳ�����,���������/120,���򼱾ȵ绰,���ò�����Ԯ,����50��󽫱�����ҽԺ");
				SetTimerEx("SKillSpawn", 50000, 0,	"i", playerid);
			}
			else
			if(listitem	== 1)
			{
				SKillSpawn(playerid);
			}
		}
		else
		{
			SKillSpawn(playerid);
		}
		return 1;
	}
	return 0;
}
public OnPlayerConnect(playerid)//������ӷ�����
{
	TabletWin8UserLog2 = CreatePlayerTextDraw(playerid,223.000000, 303.000000, "NAME");
	PlayerTextDrawAlignment(playerid,TabletWin8UserLog2, 2);
	PlayerTextDrawBackgroundColor(playerid,TabletWin8UserLog2, 255);
	PlayerTextDrawFont(playerid,TabletWin8UserLog2, 1);
	PlayerTextDrawLetterSize(playerid,TabletWin8UserLog2, 0.500000, 1.400004);
	PlayerTextDrawColor(playerid,TabletWin8UserLog2, -1);
	PlayerTextDrawSetOutline(playerid,TabletWin8UserLog2, 0);
	PlayerTextDrawSetProportional(playerid,TabletWin8UserLog2, 1);
	PlayerTextDrawSetShadow(playerid,TabletWin8UserLog2, 1);
	PlayerTextDrawUseBox(playerid,TabletWin8UserLog2, 1);
	PlayerTextDrawBoxColor(playerid,TabletWin8UserLog2, 255);
	PlayerTextDrawTextSize(playerid,TabletWin8UserLog2, 0.000000, 110.000000);
	PlayerTextDrawSetSelectable(playerid,TabletWin8UserLog2, 0);
	//Escritorio [ESTE]
	Escritorio[0] = CreatePlayerTextDraw(playerid,147.000000, 137.000000, "loadsc2:loadsc2");
	PlayerTextDrawAlignment(playerid,Escritorio[0], 2);
	PlayerTextDrawBackgroundColor(playerid,Escritorio[0], 255);
	PlayerTextDrawFont(playerid,Escritorio[0], 4);
	PlayerTextDrawLetterSize(playerid,Escritorio[0], 0.500000, 0.299998);
	PlayerTextDrawColor(playerid,Escritorio[0], -1);
	PlayerTextDrawSetOutline(playerid,Escritorio[0], 0);
	PlayerTextDrawSetProportional(playerid,Escritorio[0], 1);
	PlayerTextDrawSetShadow(playerid,Escritorio[0], 1);
	PlayerTextDrawUseBox(playerid,Escritorio[0], 1);
	PlayerTextDrawBoxColor(playerid,Escritorio[0], -1724671489);
	PlayerTextDrawTextSize(playerid,Escritorio[0], 377.000000, 223.000000);
	PlayerTextDrawSetSelectable(playerid,Escritorio[0], 0);

	Escritorio[1] = CreatePlayerTextDraw(playerid,149.000000, 343.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,Escritorio[1], 255);
	PlayerTextDrawFont(playerid,Escritorio[1], 1);
	PlayerTextDrawLetterSize(playerid,Escritorio[1], 0.500000, 1.600000);
	PlayerTextDrawColor(playerid,Escritorio[1], -1);
	PlayerTextDrawSetOutline(playerid,Escritorio[1], 0);
	PlayerTextDrawSetProportional(playerid,Escritorio[1], 1);
	PlayerTextDrawSetShadow(playerid,Escritorio[1], 1);
	PlayerTextDrawUseBox(playerid,Escritorio[1], 1);
	PlayerTextDrawBoxColor(playerid,Escritorio[1], 869072895);
	PlayerTextDrawTextSize(playerid,Escritorio[1], 522.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Escritorio[1], 0);

	Escritorio[2] = CreatePlayerTextDraw(playerid,475.000000, 343.000000, "00:00");
	PlayerTextDrawBackgroundColor(playerid,Escritorio[2], 255);
	PlayerTextDrawFont(playerid,Escritorio[2], 1);
	PlayerTextDrawLetterSize(playerid,Escritorio[2], 0.390000, 1.300000);
	PlayerTextDrawColor(playerid,Escritorio[2], -1);
	PlayerTextDrawSetOutline(playerid,Escritorio[2], 0);
	PlayerTextDrawSetProportional(playerid,Escritorio[2], 1);
	PlayerTextDrawSetShadow(playerid,Escritorio[2], 0);
	PlayerTextDrawSetSelectable(playerid,Escritorio[2], 0);

	Escritorio[3] = CreatePlayerTextDraw(playerid,173.000000, 343.000000, "START");
	PlayerTextDrawAlignment(playerid,Escritorio[3], 2);
	PlayerTextDrawBackgroundColor(playerid,Escritorio[3], 255);
	PlayerTextDrawFont(playerid,Escritorio[3], 1);
	PlayerTextDrawLetterSize(playerid,Escritorio[3], 0.390000, 1.300000);
	PlayerTextDrawColor(playerid,Escritorio[3], -1);
	PlayerTextDrawSetOutline(playerid,Escritorio[3], 0);
	PlayerTextDrawSetProportional(playerid,Escritorio[3], 1);
	PlayerTextDrawSetShadow(playerid,Escritorio[3], 0);
	PlayerTextDrawTextSize(playerid,Escritorio[3], 10.000000, 30.000000);
	PlayerTextDrawSetSelectable(playerid,Escritorio[3], 1);

	//Tablet Time [ESTE]
	TabletTime[0] = CreatePlayerTextDraw(playerid,270.000000, 201.000000, "00/00/00");
	PlayerTextDrawBackgroundColor(playerid,TabletTime[0], 255);
	PlayerTextDrawFont(playerid,TabletTime[0], 3);
	PlayerTextDrawLetterSize(playerid,TabletTime[0], 0.519999, 1.400000);
	PlayerTextDrawColor(playerid,TabletTime[0], -1);
	PlayerTextDrawSetOutline(playerid,TabletTime[0], 1);
	PlayerTextDrawSetProportional(playerid,TabletTime[0], 1);
	PlayerTextDrawSetSelectable(playerid,TabletTime[0], 0);

	TabletTime[1] = CreatePlayerTextDraw(playerid,270.000000, 179.000000, "00:00:00");
	PlayerTextDrawBackgroundColor(playerid,TabletTime[1], 255);
	PlayerTextDrawFont(playerid,TabletTime[1], 3);
	PlayerTextDrawLetterSize(playerid,TabletTime[1], 0.799999, 2.499999);
	PlayerTextDrawColor(playerid,TabletTime[1], -1);
	PlayerTextDrawSetOutline(playerid,TabletTime[1], 1);
	PlayerTextDrawSetProportional(playerid,TabletTime[1], 1);
	PlayerTextDrawSetSelectable(playerid,TabletTime[1], 0);

	//Tragaperras [ESTE]
	Tragaperras[4] = CreatePlayerTextDraw(playerid,475.000000, 192.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,Tragaperras[4], 255);
	PlayerTextDrawFont(playerid,Tragaperras[4], 1);
	PlayerTextDrawLetterSize(playerid,Tragaperras[4], 0.500000, 14.500001);
	PlayerTextDrawColor(playerid,Tragaperras[4], -1);
	PlayerTextDrawSetOutline(playerid,Tragaperras[4], 0);
	PlayerTextDrawSetProportional(playerid,Tragaperras[4], 1);
	PlayerTextDrawSetShadow(playerid,Tragaperras[4], 1);
	PlayerTextDrawUseBox(playerid,Tragaperras[4], 1);
	PlayerTextDrawBoxColor(playerid,Tragaperras[4], 842150600);
	PlayerTextDrawTextSize(playerid,Tragaperras[4], 180.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Tragaperras[4], 0);

	Tragaperras[0] = CreatePlayerTextDraw(playerid,206.000000, 210.000000, "ld_slot:bar1_o");
	PlayerTextDrawBackgroundColor(playerid,Tragaperras[0], 255);
	PlayerTextDrawFont(playerid,Tragaperras[0], 4);
	PlayerTextDrawLetterSize(playerid,Tragaperras[0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Tragaperras[0], -1);
	PlayerTextDrawSetOutline(playerid,Tragaperras[0], 0);
	PlayerTextDrawSetProportional(playerid,Tragaperras[0], 1);
	PlayerTextDrawSetShadow(playerid,Tragaperras[0], 1);
	PlayerTextDrawUseBox(playerid,Tragaperras[0], 1);
	PlayerTextDrawBoxColor(playerid,Tragaperras[0], 255);
	PlayerTextDrawTextSize(playerid,Tragaperras[0], 70.000000, 100.000000);
	PlayerTextDrawSetSelectable(playerid,Tragaperras[0], 0);

	Tragaperras[1] = CreatePlayerTextDraw(playerid,293.000000, 210.000000, "ld_slot:bar2_o");
	PlayerTextDrawBackgroundColor(playerid,Tragaperras[1], 255);
	PlayerTextDrawFont(playerid,Tragaperras[1], 4);
	PlayerTextDrawLetterSize(playerid,Tragaperras[1], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Tragaperras[1], -1);
	PlayerTextDrawSetOutline(playerid,Tragaperras[1], 0);
	PlayerTextDrawSetProportional(playerid,Tragaperras[1], 1);
	PlayerTextDrawSetShadow(playerid,Tragaperras[1], 1);
	PlayerTextDrawUseBox(playerid,Tragaperras[1], 1);
	PlayerTextDrawBoxColor(playerid,Tragaperras[1], 255);
	PlayerTextDrawTextSize(playerid,Tragaperras[1], 70.000000, 100.000000);
	PlayerTextDrawSetSelectable(playerid,Tragaperras[1], 0);

	Tragaperras[2] = CreatePlayerTextDraw(playerid,380.000000, 210.000000, "ld_slot:bell");
	PlayerTextDrawBackgroundColor(playerid,Tragaperras[2], 255);
	PlayerTextDrawFont(playerid,Tragaperras[2], 4);
	PlayerTextDrawLetterSize(playerid,Tragaperras[2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,Tragaperras[2], -1);
	PlayerTextDrawSetOutline(playerid,Tragaperras[2], 0);
	PlayerTextDrawSetProportional(playerid,Tragaperras[2], 1);
	PlayerTextDrawSetShadow(playerid,Tragaperras[2], 1);
	PlayerTextDrawUseBox(playerid,Tragaperras[2], 1);
	PlayerTextDrawBoxColor(playerid,Tragaperras[2], 255);
	PlayerTextDrawTextSize(playerid,Tragaperras[2], 70.000000, 100.000000);
	PlayerTextDrawSetSelectable(playerid,Tragaperras[2], 0);

	Tragaperras[3] = CreatePlayerTextDraw(playerid,328.000000, 291.000000, "LUCK");
	PlayerTextDrawAlignment(playerid,Tragaperras[3], 2);
	PlayerTextDrawBackgroundColor(playerid,Tragaperras[3], 255);
	PlayerTextDrawFont(playerid,Tragaperras[3], 3);
	PlayerTextDrawLetterSize(playerid,Tragaperras[3], 0.519999, 1.900000);
	PlayerTextDrawColor(playerid,Tragaperras[3], -1);
	PlayerTextDrawSetOutline(playerid,Tragaperras[3], 0);
	PlayerTextDrawSetProportional(playerid,Tragaperras[3], 1);
	PlayerTextDrawSetShadow(playerid,Tragaperras[3], 0);
	PlayerTextDrawUseBox(playerid,Tragaperras[3], 1);
	PlayerTextDrawBoxColor(playerid,Tragaperras[3], 255);
	PlayerTextDrawTextSize(playerid,Tragaperras[3], 10.000000, 240.000000);
	PlayerTextDrawSetSelectable(playerid,Tragaperras[3], 1);

	//Tablet Time [ESTE]
	TabletWeather[0] = CreatePlayerTextDraw(playerid,475.000000, 192.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,TabletWeather[0], 255);
	PlayerTextDrawFont(playerid,TabletWeather[0], 1);
	PlayerTextDrawLetterSize(playerid,TabletWeather[0], 0.500000, 14.500000);
	PlayerTextDrawColor(playerid,TabletWeather[0], -1);
	PlayerTextDrawSetOutline(playerid,TabletWeather[0], 0);
	PlayerTextDrawSetProportional(playerid,TabletWeather[0], 1);
	PlayerTextDrawSetShadow(playerid,TabletWeather[0], 1);
	PlayerTextDrawUseBox(playerid,TabletWeather[0], 1);
	PlayerTextDrawBoxColor(playerid,TabletWeather[0], 842150600);
	PlayerTextDrawTextSize(playerid,TabletWeather[0], 180.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,TabletWeather[0], 0);

	TabletWeather[1] = CreatePlayerTextDraw(playerid,328.000000, 291.000000, "Soleado");
	PlayerTextDrawAlignment(playerid,TabletWeather[1], 2);
	PlayerTextDrawBackgroundColor(playerid,TabletWeather[1], 255);
	PlayerTextDrawFont(playerid,TabletWeather[1], 3);
	PlayerTextDrawLetterSize(playerid,TabletWeather[1], 0.559999, 1.700000);
	PlayerTextDrawColor(playerid,TabletWeather[1], -1);
	PlayerTextDrawSetOutline(playerid,TabletWeather[1], 0);
	PlayerTextDrawSetProportional(playerid,TabletWeather[1], 1);
	PlayerTextDrawSetShadow(playerid,TabletWeather[1], 1);
	PlayerTextDrawUseBox(playerid,TabletWeather[1], 1);
	PlayerTextDrawBoxColor(playerid,TabletWeather[1], 255);
	PlayerTextDrawTextSize(playerid,TabletWeather[1], 0.000000, 240.000000);
	PlayerTextDrawSetSelectable(playerid,TabletWeather[1], 0);

	TabletWeather[2] = CreatePlayerTextDraw(playerid,335.000000, 199.000000, "~y~PLACE~n~~g~SAN ANDREAS~n~~n~~y~TEMPERATURE~n~~g~0 C");
	PlayerTextDrawAlignment(playerid,TabletWeather[2], 2);
	PlayerTextDrawBackgroundColor(playerid,TabletWeather[2], 255);
	PlayerTextDrawFont(playerid,TabletWeather[2], 1);
	PlayerTextDrawLetterSize(playerid,TabletWeather[2], 0.449997, 1.800000);
	PlayerTextDrawColor(playerid,TabletWeather[2], -65281);
	PlayerTextDrawSetOutline(playerid,TabletWeather[2], 0);
	PlayerTextDrawSetProportional(playerid,TabletWeather[2], 1);
	PlayerTextDrawSetShadow(playerid,TabletWeather[2], 0);
	PlayerTextDrawSetSelectable(playerid,TabletWeather[2], 0);

	//
	TabletWin8Pag2 = CreatePlayerTextDraw(playerid,328.000000, 145.000000, "BB~n~AA");
	PlayerTextDrawAlignment(playerid,TabletWin8Pag2, 2);
	PlayerTextDrawBackgroundColor(playerid,TabletWin8Pag2, 255);
	PlayerTextDrawFont(playerid,TabletWin8Pag2, 1);
	PlayerTextDrawLetterSize(playerid,TabletWin8Pag2, 0.679999, 3.000000);
	PlayerTextDrawColor(playerid,TabletWin8Pag2, -1);
	PlayerTextDrawSetOutline(playerid,TabletWin8Pag2, 0);
	PlayerTextDrawSetProportional(playerid,TabletWin8Pag2, 1);
	PlayerTextDrawSetShadow(playerid,TabletWin8Pag2, 0);
	PlayerTextDrawSetSelectable(playerid,TabletWin8Pag2, 0);
    AddPlayerClass(playerid,1679.3274,1447.8716,47.7780,273.2993,-1,-1,-1,-1,-1,-1);
	WritePustPlayerNumber();
	hzxtnqyw[playerid]=0;
	hzxtjcxqn[playerid]=0;
	hzxtwnzy[playerid]=0;
	hzxtcdqc[playerid]=0;
	hzxtycwg[playerid]=0;
	hzxtfkdg[playerid]=0;
    SexOffer[playerid] = 999; SexPrice[playerid] = 0;
	//BusID[playerid]	= 0;
	jybdlinggunzt[playerid]= 0;
	//BusCost[playerid] =	0;
	PlayerSitting[playerid]	= 0;
	playeripad[playerid]=0;
	playerput[playerid]=0;
	playeradmin[playerid]=0;
	playerircadmin[playerid]=0;
	playerbank[playerid]=0;
 RegistrationStep[playerid] = 0;
	playerage[playerid]=0;
	playersex[playerid]=0;
	playersfz[playerid]=0;
	playerzuzhi[playerid]=0;
	playerzuzhilv[playerid]=0;
	playerspawn[playerid]=0;
	playerjianyutime[playerid]=0;
	format(playermima[playerid],128,"");
	playercar[playerid]=0;
	playermoney[playerid]=0;
	jybdyszt[playerid]=0;
	playerviplv[playerid]=0;
	playerlock[playerid]=0;
	playerlock1[playerid]=0;
	playerlock2[playerid]=0;
	playerskin[playerid]=0;
	playerlv[playerid]=1;
	playerlvup[playerid]=0;
	jybdzt[playerid]=0;
	for(new	i=0;i<7;i++)
	{
		playerwuqi[playerid][i]=0;
		playerinvwuqi[playerid][i]=0;
	}
	playergunzhizhao[playerid]=0;
	playercarzhizhao[playerid]=0;
	playercall[playerid]=0;
	playercallmoney[playerid]=0;
	SL[playerid]=0;
	yaoqingjiaru[playerid]=-1;
	vsellto[playerid]=0;
	vselltocar[playerid]=0;
	vselltomoney[playerid]=0;
	houseid[playerid]=0;
	su[playerid]=0;
	cu[playerid]=0;
	tofind[playerid]=0;
	carzuyongkey[playerid]=0;
	jcys[playerid]=0;
	swat[playerid]=0;
	duty[playerid]=0;
	adminduty[playerid]=0;
	healtoid[playerid]=0;
	healid[playerid]=0;
	healmoney[playerid]=0;
	call[playerid]=0;
	callbuff[playerid]=0;
	calls[playerid]=0;
	SetPlayerColor(playerid,0x70809000);
SetPlayerMapIcon(playerid,0,-2494.097167,2272.395263,4.954111 ,56, 0);//Ϊ������ڵ�ͼ�ϴ�������Сͼ��
SetPlayerMapIcon(playerid,1,-2485.685302,2272.334228,4.984375  ,30, 0);//Ϊ������ڵ�ͼ�ϴ��������Сͼ��
SetPlayerMapIcon(playerid,2,1173.634155, -2035.625976 ,68.704116  , 38, 0);//Ϊ������ڵ�ͼ�ϴ������ϻ���֯ͼ��
SetPlayerMapIcon(playerid,3,-693.689147,  949.383056,12.239253  , 4, 0);//Ϊ������ڵ�ͼ�ϴ�������Ա��ͼ��
SetPlayerMapIcon(playerid,4,316.571990, -1784.195800 ,4.674662  , 61, 0);//Ϊ������ڵ�ͼ�ϴ���������֯ͼ��
SetPlayerMapIcon(playerid,5,2340.050537, -1234.563110 ,27.976562  , 62, 0);//Ϊ������ڵ�ͼ�ϴ����̰���֯ͼ��
SetPlayerMapIcon(playerid,6,1997.449951, -1285.688842 ,28.488073  , 59, 0);//Ϊ������ڵ�ͼ�ϴ����ϰ���֯ͼ��
SetPlayerMapIcon(playerid,7,1276.380371, -790.172912 ,92.031250  , 24, 0);//Ϊ������ڵ�ͼ�ϴ������ֵ���֯ͼ��
SetPlayerMapIcon(playerid,8,725.648437, -1451.579467 ,22.210937  , 60, 0);//Ϊ������ڵ�ͼ�ϴ���3K����֯ͼ��
SetPlayerMapIcon(playerid,9,-2386.710449,2446.947021,10.169355  , 22, 0);//Ϊ������ڵ�ͼ�ϴ���ҽԺͼ��
SetPlayerMapIcon(playerid,10,-2445.007568,2485.488525,15.320312  , 55, 0);//Ϊ������ڵ�ͼ�ϴ����򳵵�ͼ��
SetPlayerMapIcon(playerid,11,2244.497070, -1665.593139 ,15.476562  , 45, 0);//Ϊ������ڵ�ͼ�ϴ������·���ͼ��
SetPlayerMapIcon(playerid,12,2495.557617, -1691.032226 ,14.765625  , 15, 0);//Ϊ������ڵ�ͼ�ϴ���cj�ϼҵ�ͼ��
SetPlayerMapIcon(playerid,13,1837.023925, -1682.109375 ,13.323469  , 48, 0);//Ϊ������ڵ�ͼ�ϴ�������ư�ͼ��
SetPlayerMapIcon(playerid,14,1498.498046, -1581.214355 ,13.549827  , 49, 0);//Ϊ������ڵ�ͼ�ϴ�����ʿ�ư�ͼ��
SetPlayerMapIcon(playerid,15,-2501.096679,2319.394287,4.984375  , 52, 0);//Ϊ������ڵ�ͼ�ϴ�������ͼ��
SetPlayerMapIcon(playerid,16,2045.566650, -1913.380737 ,13.546875  , 36, 0);//Ϊ������ڵ�ͼ�ϴ�����Уͼ��
SetPlayerMapIcon(playerid,17,-2187.459228,2416.550292,5.165121  , 44, 0);//Ϊ������ڵ�ͼ�ϴ�����ý̨ͼ��
SetPlayerMapIcon(playerid,18,-2547.148925,2300.347900,4.984375  , 5, 0);//Ϊ������ڵ�ͼ�ϴ������乤��ͼ��
SetPlayerMapIcon(playerid,19,1518.841064, -1452.584960 ,14.203125  ,30, 0);//Ϊ������ڵ�ͼ�ϴ���FBIСͼ��
SetPlayerMapIcon(playerid,20,1457.002929, -1023.099548 ,23.828125  , 17, 0);//Ϊ������ڵ�ͼ�ϴ�������ͼ��
SetPlayerMapIcon(playerid,21,-2540.971923,2267.912597,5.026381  , 12, 0);//Ϊ������ڵ�ͼ�ϴ�������͹�ͼ��
SetPlayerMapIcon(playerid,22,-2479.197753,2317.906250,4.984375  , 52, 0);//Ϊ������ڵ�ͼ�ϴ���24/7 2ͼ��
SetPlayerMapIcon(playerid,23,1310.208374, -1367.452392 ,13.534426  , 52, 0);//Ϊ������ڵ�ͼ�ϴ���24/7 ��ͼ��
SetPlayerMapIcon(playerid,24,1352.428955, -1759.248413 ,13.507812  , 52, 0);//Ϊ������ڵ�ͼ�ϴ���24/7 3ͼ��
	Textdraw51[playerid] = TextDrawCreate(608.000000, 98.000000, " "); // bank money
	TextDrawAlignment(Textdraw51[playerid],	3);
	TextDrawBackgroundColor(Textdraw51[playerid], 255);
	TextDrawFont(Textdraw51[playerid], 3);
	TextDrawLetterSize(Textdraw51[playerid], 0.650000, 2.199999);
	TextDrawColor(Textdraw51[playerid],	43775);
	TextDrawSetOutline(Textdraw51[playerid], 1);
	TextDrawSetProportional(Textdraw51[playerid], 1);
	//InitFly(playerid);
	new	msg[128];
	new	name[128];
	new ip[16];
	GetPlayerName(playerid,name,128);
	GetPlayerIp(playerid,ip,16);
	format(msg,128,"[������]: [ID:%d]%s	�����˷�����(IP:%s)",playerid,name,ip);
	ABroadCast(0x98FB98FF,msg,1);
	if(IsPlayerNPC(playerid))
	{
		SetSpawnInfo(playerid,0,255,1612.7871,-2332.1899,13.5385,270,24,111111111,0,0,0,0);
		SpawnPlayer(playerid);
		return 1;
	}
    PlaySoundForPlayer(playerid,1062);
	GameTextForPlayer(playerid,"My Chinese Heart",5000,1);
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
	SendClientMessage(playerid,	0xFFFF00AA,	"\n");
 	SendClientMessage(playerid, 0xFFFF00AA, "\n");
 	SendClientMessage(playerid, 0xFFFF00AA, "��ӭ���� {FF0000}�����Ϸ���� {FFFF00}���� {FF00FF}�ҵ��й���{FFC0CB} ��Դ���߰������.");
 	SendClientMessage(playerid, 0xFFFF00AA, "������������������ű����棬���������ǡ���ϵQQ: 947585287 �����Ϸ����: www.hcyxsq.cn");
 	SendClientMessage(playerid, COLOR_YELLOW, "===================================================================================");
 	SendClientMessage(playerid, 0x99FFFFAA, "���ڶ�ȡ���ʻ������У����Ժ�......");
 	for(new i; i<44; i++)
	{
	    PlayerWeapons[playerid][i] = 0;
	}
	return 0;
}
//---------------------------------------------------------------------[�绰��]----------------------
public OnPlayerText(playerid,text[])//������벻��"/"�����ݵ��¼�
{
	if(KillSpawn[playerid])
	{
		SendClientMessage(playerid,	COLOR_GREY,	"	������ֻ����ʹ��/120����Ԯ�� !");
		return 0;
	}
	if(SL[playerid]==1)
	{
		new	msg[128];
		new	name[128];
		GetPlayerName(playerid,name,128);
		new	pname[MAX_PLAYER_NAME],	str[128];
		GetPlayerName(playerid,	pname, sizeof(pname));
		strreplace(pname, '_', ' ');
		for(new words; words<sizeof(SwearWords); words++)
		{
		  if(strfind(text,SwearWords[words],false) == 0 )
		  {
				format(str,	sizeof(str), "%s ˵: **********", pname);
				ProxDetector(30.0, playerid, str, COLOR_FADE1, COLOR_FADE2,	COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				return 0;
		  }
		}
		if(playerviplv[playerid]!=0)
		{
		format(str,	sizeof(str), "{FF00FF}[VIP%d]{FFC0CB}%s ˵: %s",playerviplv[playerid], pname, text);
		}
		else
		{
		format(str,	sizeof(str), "%s ˵: %s", pname, text);
		}
		ProxDetector(30.0, playerid, str, COLOR_FADE1, COLOR_FADE2,	COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		if(Playerx[playerid] !=	0)
		{
			return 0;
		}
		if(callbuff[playerid]==0)
		{
			format(msg,128,"%s:%s",name,text);
		}
		if(callbuff[playerid]==1)
		{
			format(msg,128,"%s(�绰��):%s",name,text);
			if(callbuff[call[playerid]]==1)
			{
				SendClientMessage(call[playerid], 0xF8F8FFFF,msg);
			}
		}
		Update3DTextLabelText(liaotiantext[playerid], 0xF8F8FFFF,msg);
		Attach3DTextLabelToPlayer(liaotiantext[playerid],playerid,0,0,0.25);
		liaotiantexts[playerid]=10;
		return 0;
	}
	return 0;
}
public SavePlayer()//�����������,ÿһ������һ��
{
	if(savetime>0)
	{
		savetime=savetime-1;
	}
	if(gatetime[0]>0)
	{
		gatetime[0]=gatetime[0]-1;
		if(gatetime[0]==0)
		{
			DestroyDynamicObject(gate);
			gate = CreateDynamicObject(968,	1544.745605, -1630.961792, 13.177118, 0.0000, 269.7592,	270.0000);
		}
	}
	if(gatetime[1]>0)
	{
		gatetime[1]=gatetime[1]-1;
		if(gatetime[1]==0)
		{
			MoveDynamicObject(gate1, 1591.846802, -1638.013550,	13.491905, 0.8);
		}
	}
	if(gatetime[2]>0)
	{
		gatetime[2]=gatetime[2]-1;
		if(gatetime[2]==0)
		{
			MoveDynamicObject(gate2, 1563.736816, -1617.390381,	12.382813, 0.8);
		}
	}
	if(gatetime[3]>0)
	{
		gatetime[3]=gatetime[3]-1;
		if(gatetime[3]==0)
		{
			MoveDynamicObject(gate3, 1535.4482421875,-1451.5390625,15.160917282104,	1.0);
		}
	}
	if(gatetime[4]>0)
	{
		gatetime[4]=gatetime[4]-1;
		if(gatetime[4]==0)
		{
			MoveDynamicObject(gate4, 371.2467956543, 166.54695129395, 1007.3828125,	5);
		}
	}
	if(gatetime[5]>0)
	{
		gatetime[5]=gatetime[5]-1;
		if(gatetime[5]==0)
		{
            DestroyDynamicObject(gate5);
		gate5=CreateDynamicObject(975,-715.1565,950.5165,12.93273601532, 0,	0, 267.99499511719);
		}
	}
	if(gatetime[6]>0)
	{
		gatetime[6]=gatetime[6]-1;
		if(gatetime[6]==0)
		{
            DestroyDynamicObject(gate6);
		    gate6=CreateDynamicObject(975, -714.5289,950.5165,12.93273601532, 0, 0,	270);
		}
	}
	if(gatetime[7]>0)
	{
		gatetime[7]=gatetime[7]-1;
		if(gatetime[7]==0)
		{
            DestroyDynamicObject(gate7);
		    gate7=CreateDynamicObject(975, -662.64141845703, 921.30737304688, 12.816900253296, 0, 0, 90);
		}
	}
	if(gatetime[8]>0)
	{
		gatetime[8]=gatetime[8]-1;
		if(gatetime[8]==0)
		{
			MoveDynamicObject(gate8, -693.50885009766, 966.04644775391,	13.770468711853,1.2);
		}
	}
	if(gatetime[9]>0)
	{
		gatetime[9]=gatetime[9]-1;
		if(gatetime[9]==0)
		{
            DestroyDynamicObject(gate9);
            		gate9=CreateDynamicObject(2957,	-670.24908447266, 966.9794921875, 12.752597808838, 0, 0, 90);

		}
	}
	if(gatetime[10]>0)
	{
		gatetime[10]=gatetime[10]-1;
		if(gatetime[10]==0)
		{
            DestroyDynamicObject(gate10);
		gate10=CreateDynamicObject(2957, -670.43908691406, 967.10314941406,	13.897609710693, 0,	0, 90);

		}
	}
	if(gatetime[16]>0)
	{
		gatetime[16]=gatetime[16]-1;
		if(gatetime[16]==0)
		{
			MoveDynamicObject(gate16,1688.2041015625, -1450.962890625 ,14.409767150879,0.8);
		}
	}
	if(gatetime[17]>0)
	{
		gatetime[17]=gatetime[17]-1;
		if(gatetime[17]==0)
		{
			MoveDynamicObject(gate17, 1690.296875 ,-1460.703125, 19.970973968506 ,0.8);
		}
	}
	if(gatetime[18]>0)
	{
		gatetime[18]=gatetime[18]-1;
		if(gatetime[18]==0)
		{
			MoveDynamicObject(gate18,1689.0373535156, -1458.2824707031,	24.202903747559	,0.8);
		}
	}
	if(gatetime[19]>0)
	{
		gatetime[19]=gatetime[19]-1;
		if(gatetime[19]==0)
		{
			MoveDynamicObject(gate19,1692.7523193359, -1458.2824707031,	24.202903747559,0.8);
		}
	}
	if(gatetime[20]>0)
	{
		gatetime[20]=gatetime[20]-1;
		if(gatetime[20]==0)
		{
			MoveDynamicObject(gate20,1681.5302734375, -1458.2824707031,	24.202903747559,0.8);
		}
	}
	if(gatetime[21]>0)
	{
		gatetime[21]=gatetime[21]-1;
		if(gatetime[21]==0)
		{
			MoveDynamicObject(gate21, 1685.2802734375, -1458.2824707031, 24.202903747559,0.8);
		}
	}
	if(gatetime[22]>0)
	{
		gatetime[22]=gatetime[22]-1;
		if(gatetime[22]==0)
		{
            DestroyDynamicObject(gate26);
		    gate26=CreateDynamicObject(1537,	1142.3973, -2809.1465, 11.6500, 0, 0, 233.52);
		}
	}
	if(gatetime[23]>0)
	{
		gatetime[23]=gatetime[23]-1;
		if(gatetime[23]==0)
		{
            DestroyDynamicObject(gate27);
		    gate27=CreateDynamicObject(1537,	1161.2502, -2825.1479, 11.4450, 0, 0, 142.4254);
		}
	}
	//===============VAgate========
	for(new	i=0;i<101;i++)
	{
		if(IsPlayerConnected(i)==1)
		{
			if (SL[i]==1)
			{
					if(engine[i]>0)
					{
						engine[i]=engine[i]-1;
						if(engine[i]==0)
						{
							new	vid=enginevid[i],zid=GetPlayerVehicleSeat(i);
							enginevid[i]=0;
							if(vid!=0&&zid==0)
							{
								new	pd=0;
								if(caryinqing[vid]==1&&pd==0)
								{
									caryinqing[vid]=0;
									SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
									pd=1;
								}
								if(caryinqing[vid]==0&&pd==0)
								{
									caryinqing[vid]=1;
									SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
									SendClientMessage(i, 0x0D7792AA, "�����������������!");
									pd=1;
								}
							}
						}
					}
					if(fills[i]>0)
					{
						fills[i]=fills[i]-1;
						if(fills[i]==0)
						{
							new	msg[128];
							format(msg,128,"<����վ>�㽫�������ͼ�����!������%d!",fillmoney[i]);
							SendClientMessage(i,0x00FF00AA,msg);
							carfill[fillvid[i]]=100;
							playermoney[i]=playermoney[i]-fillmoney[i];
							ResetPlayerMoney(i);
							GivePlayerMoney(i,playermoney[i]);
							TogglePlayerControllable(i,1);
							fillvid[i]=0;
							fillmoney[i]=0;
						}
					}
					if(calls[i]>0)
					{
						calls[i]=calls[i]+1;
					}
					if(call[i]!=0&&callbuff[i]==0)
					{
						SendClientMessage(i,0xFFC0CBFF,"``�����塤``�����塤``��ĵ绰����!����/p����!");
					}
					if(liaotiantexts[i]>0)
					{
						liaotiantexts[i]=liaotiantexts[i]-1;
						if(liaotiantexts[i]==0)
						{
							Update3DTextLabelText(liaotiantext[i], 0xF8F8FFFF,"	");
						}
					}
					new	Float:fx,Float:fy,Float:fz,vid=GetPlayerVehicleID(i),zid=GetPlayerVehicleSeat(i);
					GetVehicleVelocity(vid,fx,fy,fz);
					if(carfuel[vid]>0)
					{
						carfuel[vid]=carfuel[vid]-1;
					}
					if(fx!=0||fy!=0)
					{
						if(carfill[vid]>0&&zid==0&&carfuel[vid]==0)
						{
							carfill[vid]=carfill[vid]-1;
							carfuel[vid]=15;
							if(carfill[vid]>0&&carfill[vid]<20)
							{
								SendClientMessage(i, 0xDC143CAA,"<����>�����������������!");
							}
						}
						if(carfill[vid]==0&&zid==0)
						{
         					SendClientMessage(i, 0xDC143CAA,"��������Ѿ�û������!�������VIP�����Խ����������ߣ����������˼���Ŷ��30���ͻ�����ģ�");
         					if(playerviplv[i]==0)
         					{
							caryinqing[vid]=0;
							SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
							}
						}
					}
					/*new	wid=GetPlayerWeapon(i);
					if(wid!=0&&wid!=playerwuqi[i][0]&&wid!=playerwuqi[i][1]&&wid!=playerwuqi[i][2]&&wid!=playerwuqi[i][3]&&wid!=playerwuqi[i][4]&&wid!=playerwuqi[i][5]&&wid!=playerwuqi[i][6])
					{
						new	msg[128],name[128];
						GetPlayerName(i,name,128);
						format(msg,128,"[ID:%d]%s�����쳣,�����Աע��.",i,name);
						ABroadCast(0xDC143CAA,msg,1);
					}*/
					if(playerjianyutime[i]>0)
					{
					    if (jybdzt[i] == 0)
					    {
							playerjianyutime[i]=playerjianyutime[i]-1;
							if(playerjianyutime[i]!=0)
							{
								if(XY(10,i,264.752624,77.582786,1001.039062)==0)
								{
									for(new	w=0;w<7;w++)
									{
										playerwuqi[i][w]=0;
									}
									ResetPlayerWeaponEx(i);
									SendClientMessage(i, 0xDC143CAA,"��ļ��ʱ��δ�����Զ����䵽1�ż���");
									SetPlayerSkin(i,252);
									SetPlayerPos(i,264.752624,77.582786,1001.039062);
									SetPlayerInterior(i,6);
								}
							}
						}
						if(playerjianyutime[i]==0)
						{
							SendClientMessage(i, 0xDC143CAA,"��������������ʱ�䵽��~��ȥ��!");
							SendClientMessage(i, 0xDC143CAA,"���������ú÷�ʡ��֮ǰ���µĴ���Ŭ������������ɣ����ͣ�");
							SetPlayerPos(i,246.129409,69.405105,1003.640625);
							SetPlayerInterior(i,6);
							houseid[i]=3;
							if(playerzuzhi[i]==0)
							{
								SetPlayerSkin(i,playerskin[i]);
							}
							if(playerzuzhi[i]>=1)
							{
								SetPlayerSkin(i,zuzhiskin[playerzuzhi[i]][playerzuzhilv[i]]);
							}
						}
					}
					if(tofind[i]>=1)
					{
						if(SL[tofind[i]]==1)
						{
								new	Float:x,Float:y,Float:z;
								GetPlayerPos(tofind[i],x,y,z);
								DisablePlayerCheckpoint(i);
								SetPlayerCheckpoint(i,x,y,z,3);
						}
						if(SL[tofind[i]]==0)
						{
							tofind[i]=0;
							SendClientMessage(i, 0xDC143CAA,"Ŀ���������,׷��ǿ�ƽ��!");
						}
					}
					if(askqtime[i]>0)
					{
						askqtime[i]=askqtime[i]-1;
					}
					for(new	u=0;u<pickupids;u++)
					{
						if(ZFJGLX[u]==3)
						{
							if(XY(1,i,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
							{
								if(strcmp(ZFJGSTR[u],"δ����")==0)
								{
									//SendClientMessage(i, 0xFFFFF0FF,"������빺����䷿������/buyhouse");
								}
							}
						}
					}
					if(savetime==0)
					{
  /*new	msgg[128];
  new sendername[MAX_PLAYER_NAME];
  GetPlayerName(i, sendername, sizeof(sendername));
  format(msgg,128,"%s������汣�����",sendername[i]);
  print(msgg);*/
//===================================KINI����=========================
						BAOCUNACCOUNT();
						if(KINI_Open(getINI(i))) {
							KINI_WriteString("name",playername[i]);
							KINI_WriteString("mima",playermima[i]);
							KINI_WriteInt("money",playermoney[i]);
							KINI_WriteInt("zuzhi",playerzuzhi[i]);
							KINI_WriteInt("zuzhilv",playerzuzhilv[i]);
							KINI_WriteInt("car",playercar[i]);
							KINI_WriteInt("skin",playerskin[i]);
							KINI_WriteInt("lock",playerlock[i]);
							KINI_WriteInt("lock1",playerlock1[i]);
							KINI_WriteInt("lock2",playerlock2[i]);
							KINI_WriteInt("spawn",playerspawn[i]);
							KINI_WriteInt("jianyutime",playerjianyutime[i]);
							KINI_WriteInt("level",playerlv[i]);
							KINI_WriteInt("levelup",playerlvup[i]);
							KINI_WriteInt("gunzhizhao",playergunzhizhao[i]);
							KINI_WriteInt("supernos",playersupernos[i]);
							KINI_WriteInt("viplv",playerviplv[i]);
							KINI_WriteInt("vdou",playervdou[i]);
							KINI_WriteInt("vipczz",playervipczz[i]);
							//KINI_WriteInt("jiedu",playerjiedu[i]);
							//KINI_WriteInt("kouke",playerkouke[i]);
							KINI_WriteInt("food1",food1[i]);
							KINI_WriteInt("food2",food2[i]);
							KINI_WriteInt("food3",food3[i]);
							KINI_WriteInt("hzxtnqyw",hzxtnqyw[i]);
							KINI_WriteInt("hzxtjcxqn",hzxtjcxqn[i]);
							KINI_WriteInt("hzxtwnzy",hzxtwnzy[i]);
							KINI_WriteInt("hzxtcdqc",hzxtcdqc[i]);
							KINI_WriteInt("hzxtycwg",hzxtycwg[i]);
							KINI_WriteInt("hzxtfkdg",hzxtfkdg[i]);
							/*for(new	w=0;w<7;w++)
							{
								KINI_WriteInt("wuqi",playerwuqi[i][w]);
							}
							for(new	w=0;w<7;w++)
							{
								KINI_WriteInt("invwuqi",playerinvwuqi[i][w]);
							}*/
							for(new	w=0;w<7;w++)
							{
								KINI_WriteInt("wuqi",playerwuqi[i][w]);
							}
							KINI_WriteInt("inv1",playerinvwuqi[i][0]);
							KINI_WriteInt("inv2",playerinvwuqi[i][1]);
							KINI_WriteInt("inv3",playerinvwuqi[i][2]);
							KINI_WriteInt("inv4",playerinvwuqi[i][3]);
							KINI_WriteInt("inv5",playerinvwuqi[i][4]);
							KINI_WriteInt("inv6",playerinvwuqi[i][5]);
							KINI_WriteInt("inv7",playerinvwuqi[i][6]);
							for(new	w=0;w<7;w++)
							{
								KINI_WriteInt("invwuqi",playerinvwuqi[i][w]);
							}
							
							KINI_WriteInt("carzhizhao",playercarzhizhao[i]);
							KINI_WriteInt("phone",playercall[i]);
							KINI_WriteInt("gunzhizhao",playergunzhizhao[i]);
							KINI_WriteInt("job",playerjob[i]);
							KINI_WriteInt("mats",playermats[i]);
							KINI_WriteInt("callmoney",playercallmoney[i]);
							KINI_WriteInt("sex",playersex[i]);
							KINI_WriteInt("age",playerage[i]);
							KINI_WriteInt("sfz",playersfz[i]);
							KINI_WriteInt("put",playerput[i]);
							KINI_WriteInt("adminlevel",playeradmin[i]);
							KINI_WriteInt("ircadminlevel",playerircadmin[i]);
							KINI_WriteInt("bankmoney",playerbank[i]);
       						KINI_WriteInt("ipad",playeripad[i]);
       						KINI_WriteInt("yanhua",playeryanhua[i]);
							KINI_Save();
							KINI_Close();
						}
					}
			}
		}
  //}
	}
	if(savetime==0)
	{
		savetime=30;
 //}
// }
 //}
	}
}
/*public huanming()//��ʱ���¼�
{
SendRconCommand(Randomx[random(sizeof(Randomx))]);
}*/
public OnGameModeExit()//�������ر�ʱ���¼�~
{
		BAOCUNACCOUNT();
		RemoveCameras();
		TextDrawDestroy(flash);
		        new p = GetMaxPlayers();
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "laser", 0);
                RemovePlayerAttachedObject(i, 0);
        }
				print("�������Ѿ��ر�����");
		return 1;
}
public OnGameModeInit()//����������ʱ���¼�~
{
		InitTablet();
        ManualVehicleEngineAndLights();
        CreatePickup(1314, 0, 1232.0562,-810.9739,1084.0078);
        Create3DTextLabel("===GM���ط���̨===\n/gmqt�鿴����",0xFFFF00AA,1232.0562,-810.9739,1084.0078,10,0,0);
    	CreatePickup(1239, 0, 265.6101,76.1229,1001.0391);
    	CreatePickup(1239, 0, 230.7155,71.3590,1005.0391);
    	CreatePickup(1239, 0, -2831.4377,2306.6553,98.3154);
    	CreatePickup(1239, 0, 257.5566,77.5511,1003.6406);
    	Create3DTextLabel("===��������===\n/jybd start��ʼ����",0xFFFF00AA,265.6101,76.1229,1001.0391,10,0,0);
		Create3DTextLabel("===��������===\n/jybd ysȡԿ��",0xFFFF00AA,230.7155,71.3590,1005.0391,50,0,0);
		Create3DTextLabel("===��������===\n����������",0xFFFF00AA,-2831.4377,2306.6553,98.3154,100,0,0);
		Create3DTextLabel("===��������===\n/jybd gun��ǹ",0xFFFF00AA,257.5566,77.5511,1003.6406,50,0,0);
		SetTimer("UpdateCameras",CAMERA_UPDATE_INTERVAL,true);
		flash =	TextDrawCreate(-20.000000,2.000000,"|");
		TextDrawUseBox(flash,1);
		TextDrawBoxColor(flash,0xffffff66);
		TextDrawTextSize(flash,660.000000,22.000000);
		TextDrawAlignment(flash,0);
		TextDrawBackgroundColor(flash,0x000000ff);
		TextDrawFont(flash,3);
		TextDrawLetterSize(flash,1.000000,52.200000);
		TextDrawColor(flash,0xffffffff);
		TextDrawSetOutline(flash,1);
		TextDrawSetProportional(flash,1);
		TextDrawSetShadow(flash,1);
		LoadCameras();
		RandMsg	= 0;
		ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
		ShowNameTags(1);
		SetNameTagDrawDistance(40.0);
		EnableStuntBonusForAll(0);
		DisableInteriorEnterExits();
        new p = GetMaxPlayers();
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "laser", 0);
                SetPVarInt(i, "color", 18643);
        }
TextdrawMav = TextDrawCreate(-105.000000, 437.000000, "    Loading...Please Wait...");
TextDrawBackgroundColor(TextdrawMav, 255);
TextDrawFont(TextdrawMav, 1);
TextDrawLetterSize(TextdrawMav, 0.500000, 1.000000);
TextDrawColor(TextdrawMav, 0xFF0000AA);
TextDrawSetOutline(TextdrawMav, 0);
TextDrawSetProportional(TextdrawMav, 1);
TextDrawSetShadow(TextdrawMav, 1);
TextDrawUseBox(TextdrawMav, 1);
TextDrawBoxColor(TextdrawMav, 255);
TextDrawTextSize(TextdrawMav, 637.000000, 0.000000);
        SetTimer("huanming",3000,1);//��ʱ��
		SetTimer("sjd",1200000,1);
		SetTimer("SavePlayer",1000,1);
		SetTimer("WeatherAndTime", 300000, true);
		SetTimer("GlobalAnnouncement" ,120000,true); //	2����һ�ι��- -
		SetTimer("OtherTimer", 500,	1);
//=======================================����================================//-

	//========
		SetGameModeText(SCRIPT_VERSION);
	//========

//===========================�������=========================

//===========================�������=========================
	//////////////////���ֳ���
		sellcarsilunchemoney[0]=120000;
		sellcarsilunchemoney[1]=180000;
		sellcarsilunchemoney[2]=220000;
		sellcarsilunchemoney[3]=250000;
		sellcarsilunchemoney[4]=250000;
		sellcarsilunchemoney[5]=200000;
		sellcarsilunchemoney[6]=150000;
		sellcarsilunchemoney[7]=230000;
		sellcarsilunchemoney[8]=300000;
		sellcarsilunchemoney[9]=180000;
		sellcarsilunchemoney[10]=130000;
		sellcarsilunchemoney[11]=200000;
		sellcarsilunchemod[0]=400;
		sellcarsilunchemod[1]=500;
		sellcarsilunchemod[2]=579;
		sellcarsilunchemod[3]=402;
		sellcarsilunchemod[4]=405;
		sellcarsilunchemod[5]=412;
		sellcarsilunchemod[6]=410;
		sellcarsilunchemod[7]=482;
		sellcarsilunchemod[8]=578;
		sellcarsilunchemod[9]=600;
		sellcarsilunchemod[10]=401;
		sellcarsilunchemod[11]=426;
	//////////////////���ֳ���
		sellcarlianglunchemoney[0]=8000;
		sellcarlianglunchemoney[1]=12000;
		sellcarlianglunchemoney[2]=18000;
		sellcarlianglunchemoney[3]=24000;
		sellcarlianglunchemoney[4]=35000;
		sellcarlianglunchemoney[5]=45000;
		sellcarlianglunchemoney[6]=50000;
		sellcarlianglunchemod[0]=509;
		sellcarlianglunchemod[1]=481;
		sellcarlianglunchemod[2]=510;
		sellcarlianglunchemod[3]=462;
		sellcarlianglunchemod[4]=463;
		sellcarlianglunchemod[5]=461;
		sellcarlianglunchemod[6]=581;
	//////////////////�ɻ���
	 sellfeijimoney[0]=3200000;
		sellfeijimoney[1]=3000000;
		sellfeijimod[0]=487;
		sellfeijimod[1]=469;
//////////////////VIP������
		sellvipcarmoney[0]=300000;
		sellvipcarmoney[1]=400000;
		sellvipcarmoney[2]=400000;
		sellvipcarmoney[3]=400000;
		sellvipcarmoney[4]=450000;
		sellvipcarmoney[5]=500000;
		sellvipcarmoney[6]=500000;
		sellvipcarmoney[7]=500000;
		sellvipcarmod[0]=409;
		sellvipcarmod[1]=411;
		sellvipcarmod[2]=415;
		sellvipcarmod[3]=429;
		sellvipcarmod[4]=451;
		sellvipcarmod[5]=577;
		sellvipcarmod[6]=506;
		sellvipcarmod[7]=541;
	//--------------------------------------��ϵͳ��ʼ��
//2226.714355,2326.807128,7.546875
		zuzhichushengx[0]=-2211.0603;
		zuzhichushengy[0]=2422.0947;
		zuzhichushengz[0]=2.4847;
		zuzhichushenga[0]=223.8555;
		zuzhichushenghj[0]=0;
		zuzhichushengid[0]=0;
//-2187.459228,2416.550292,5.165121
		zuzhichushengx[1]=-2187.459228;
		zuzhichushengy[1]=2416.550292;
		zuzhichushengz[1]=5.165121;
		zuzhichushenga[1]=359.2966;
		zuzhichushenghj[1]=0;
		zuzhichushengid[1]=0;
		zuzhichushengx[2]=1239.377319;
		zuzhichushengy[2]=-812.377319;
		zuzhichushengz[2]=1084.007812;
		zuzhichushenga[2]=270;
		zuzhichushenghj[2]=5;
		zuzhichushengid[2]=74;
		zuzhichushengx[3]= 217.205093 ;
		zuzhichushengy[3]=79.182601;
		zuzhichushengz[3]=1005.039062;
		zuzhichushenga[3]=270;
		zuzhichushenghj[3]=6;
		zuzhichushengid[3]=3;
		zuzhichushengx[4]=263.326416;
		zuzhichushengy[4]=190.662033;
		zuzhichushengz[4]= 1008.171875;
		zuzhichushenga[4]=270;
		zuzhichushenghj[4]=3;
		zuzhichushengid[4]=7;
		zuzhichushengx[5]=371.082427;
		zuzhichushengy[5]=172.693511;
		zuzhichushengz[5]=1019.984375;
		zuzhichushenga[5]=270;
		zuzhichushenghj[5]=3;
		zuzhichushengid[5]=0;
		zuzhichushengx[6]= 233.612701;
		zuzhichushengy[6]=122.923896;
		zuzhichushengz[6]=1003.218750;
		zuzhichushenga[6]=270;
		zuzhichushenghj[6]=10;
		zuzhichushengid[6]=6;
		zuzhichushengx[7]=1727.577392;
		zuzhichushengy[7]=-1637.835571;
		zuzhichushengz[7]=20.222942;
		zuzhichushenga[7]=270;
		zuzhichushenghj[7]=18;
		zuzhichushengid[7]=67;
		zuzhichushengx[8]=140.367904;
		zuzhichushengy[8]=1367.883666;
		zuzhichushengz[8]=1083.862060;
		zuzhichushenga[8]=270;
		zuzhichushenghj[8]=5;
		zuzhichushengid[8]=78;
		zuzhichushengx[9]=-2636.6826;
		zuzhichushengy[9]=1405.8811;
		zuzhichushengz[9]=906.4609;
		zuzhichushenga[9]=270;
		zuzhichushenghj[9]=3;
		zuzhichushengid[9]=67;
		zuzhichushengx[10]=2816.3748;
		zuzhichushengy[10]=-1166.8040;
		zuzhichushengz[10]=1029.1719;
		zuzhichushenga[10]=270;
		zuzhichushenghj[10]=8;
		zuzhichushengid[10]=79;
		zuzhichushengx[11]=234.0560;
		zuzhichushengy[11]=1063.7161;
		zuzhichushengz[11]=1084.2123;
		zuzhichushenga[11]=270;
		zuzhichushenghj[11]=6;
		zuzhichushengid[11]=71;
		zuzhichushengx[12]=2495.901611;
		zuzhichushengy[12]=-1704.508422;
		zuzhichushengz[12]=1014.742187;
		zuzhichushenga[12]=270;
		zuzhichushenghj[12]=3;
		zuzhichushengid[12]=77;
		zuzhichushengx[13]=-2442.7012;
		zuzhichushengy[13]=754.6975;
		zuzhichushengz[13]=35.1719;
		zuzhichushenga[13]=0;
		zuzhichushenghj[13]=0;
		zuzhichushengid[13]=77;
		zuzhichushengx[14]=-545.311340;
		zuzhichushengy[14]=-504.001953;
		zuzhichushengz[14]=25.523437;
		zuzhichushenga[14]=270;
		zuzhichushenghj[14]=0;
		zuzhichushengid[14]=132;
		zuzhichushengx[15]=2259.7561;
		zuzhichushengy[15]=-1135.9130;
		zuzhichushengz[15]=1050.6328;
		zuzhichushenga[15]=270;
		zuzhichushenghj[15]=10;
		zuzhichushengid[15]=146;
  //-2240.870361 2321.937255 7.545368
	//--------------------------------------------����֯������
		zuzhiskin[0][0]=26;
		zuzhiskin[0][1]=26;
		zuzhiskin[0][2]=26;
		zuzhiskin[0][3]=26;
		zuzhiskin[0][4]=26;
		zuzhiskin[0][5]=26;
	//--------------------------------ƽ��Ƥ��ID
		zuzhiskin[1][0]=188;
		zuzhiskin[1][1]=26;
		zuzhiskin[1][2]=37;
		zuzhiskin[1][3]=91;
		zuzhiskin[1][4]=120;
		zuzhiskin[1][5]=166;
	//--------------------------------����ID
		zuzhiskin[2][0]=16;
		zuzhiskin[2][1]=16;
		zuzhiskin[2][2]=16;
		zuzhiskin[2][3]=16;
		zuzhiskin[2][4]=16;
		zuzhiskin[2][5]=16;
	//--------------------------------������
		zuzhiskin[3][0]=280;
		zuzhiskin[3][1]=267;
		zuzhiskin[3][2]=265;
		zuzhiskin[3][3]=282;
		zuzhiskin[3][4]=283;
		zuzhiskin[3][5]=288;
	//--------------------------------����Ƥ��ID
		zuzhiskin[4][0]=286;
		zuzhiskin[4][1]=286;
		zuzhiskin[4][2]=286;
		zuzhiskin[4][3]=286;
		zuzhiskin[4][4]=286;
		zuzhiskin[4][5]=286;
	//--------------------------------FBI
		zuzhiskin[5][0]=59;
		zuzhiskin[5][1]=186;
		zuzhiskin[5][2]=98;
		zuzhiskin[5][3]=150;
		zuzhiskin[5][4]=295;
		zuzhiskin[5][5]=147;
	//--------------------------------����
		zuzhiskin[6][0]=276;
		zuzhiskin[6][1]=275;
		zuzhiskin[6][2]=274;
		zuzhiskin[6][3]=91;
		zuzhiskin[6][4]=70;
		zuzhiskin[6][5]=228;
	//--------------------------------ҽԺ
		zuzhiskin[7][0]=121;
		zuzhiskin[7][1]=117;
		zuzhiskin[7][2]=118;
		zuzhiskin[7][3]=120;
		zuzhiskin[7][4]=123;
		zuzhiskin[7][5]=294;
	//--------------------------------���ϻ�
		zuzhiskin[8][0]=173;
		zuzhiskin[8][1]=175;
		zuzhiskin[8][2]=174;
		zuzhiskin[8][3]=114;
		zuzhiskin[8][4]=115;
		zuzhiskin[8][5]=116;
	//--------------------------------����
		zuzhiskin[9][0]=28;
		zuzhiskin[9][1]=29;
		zuzhiskin[9][2]=101;
		zuzhiskin[9][3]=102;
		zuzhiskin[9][4]=103;
		zuzhiskin[9][5]=104;
	//--------------------------------�ϰ�
		zuzhiskin[10][0]=106;
		zuzhiskin[10][1]=105;
		zuzhiskin[10][2]=107;
		zuzhiskin[10][3]=269;
		zuzhiskin[10][4]=271;
		zuzhiskin[10][5]=270;
	//--------------------------------�̰�
		zuzhiskin[11][0]=184;
		zuzhiskin[11][1]=185;
		zuzhiskin[11][2]=240;
		zuzhiskin[11][3]=126;
		zuzhiskin[11][4]=127;
		zuzhiskin[11][5]=125;
	//--------------------------------���ֵ�
		zuzhiskin[12][0]=108;
		zuzhiskin[12][1]=109;
		zuzhiskin[12][2]=110;
		zuzhiskin[12][3]=142;
		zuzhiskin[12][4]=222;
		zuzhiskin[12][5]=113;
	//--------------------------------3K��
		zuzhiskin[14][0]=287;
		zuzhiskin[14][1]=287;
		zuzhiskin[14][2]=287;
		zuzhiskin[14][3]=287;
		zuzhiskin[14][4]=287;
		zuzhiskin[14][5]=287;
	//--------------------------------����
		zuzhiskin[15][0]=68;
		zuzhiskin[15][1]=163;
		zuzhiskin[15][2]=164;
		zuzhiskin[15][3]=166;
		zuzhiskin[15][4]=165;
		zuzhiskin[15][5]=154;
	//--------------------------------װ�޹�˾
		zuzhiskin[16][0]=26;
		zuzhiskin[16][1]=26;
		zuzhiskin[16][2]=26;
		zuzhiskin[16][3]=26;
		zuzhiskin[16][4]=26;
		zuzhiskin[16][5]=26;
	//--------------------------------������
		format(zuzhilv[0][0],8,"ССס��");
		format(zuzhilv[0][1],8,"��ʽס��");
		format(zuzhilv[0][2],8,"ţ��ס��");
		format(zuzhilv[0][3],8,"�߼�ס��");
		format(zuzhilv[0][4],8,"�����ȷ�");
		format(zuzhilv[0][5],32,"��ί��᳤");
	//--------------------------------���
		format(zuzhilv[1][0],8,"����");
		format(zuzhilv[1][1],8,"����");
		format(zuzhilv[1][2],8,"����");
		format(zuzhilv[1][3],8,"���ܱ�");
		format(zuzhilv[1][4],8,"�ܱ�");
		format(zuzhilv[1][5],32,"̨��");
	//--------------------------------����
		format(zuzhilv[2][0],8,"����Э��Ա");
		format(zuzhilv[2][1],8,"��ʽGM");
		format(zuzhilv[2][2],8,"�м�GM");
		format(zuzhilv[2][3],8,"�߼�GM");
		format(zuzhilv[2][4],8,"ǰ̨�ܹ�");
		format(zuzhilv[2][5],32,"��̨�ܹ�");
	//--------------------------------������
		format(zuzhilv[3][0],8,"ѧ��");
		format(zuzhilv[3][1],8,"Ѳ��");
		format(zuzhilv[3][2],8,"�̾�");
		format(zuzhilv[3][3],8,"����");
		format(zuzhilv[3][4],32,"���ֳ�");
		format(zuzhilv[3][5],8,"�ֳ�");
	//--------------------------------����
		format(zuzhilv[4][0],32,"ʵϰ̽Ա");
		format(zuzhilv[4][1],32,"��ʽ̽Ա");
		format(zuzhilv[4][2],32,"�߼�̽Ա");
		format(zuzhilv[4][3],8,"̽��");
		format(zuzhilv[4][4],32,"����");
		format(zuzhilv[4][5],32,"��");
	//--------------------------------FBI
		format(zuzhilv[5][0],32,"ʵϰְԱ");
		format(zuzhilv[5][1],8,"˾��");
		format(zuzhilv[5][2],32,"��Ա");
		format(zuzhilv[5][3],32,"�г�");
		format(zuzhilv[5][4],32,"ʡ��");
		format(zuzhilv[5][5],8,"��ͳ");
	//--------------------------------����
		format(zuzhilv[6][0],32,"ʵϰҽ��");
		format(zuzhilv[6][1],8,"ҽ��");
		format(zuzhilv[6][2],32,"�߼�ҽ��");
		format(zuzhilv[6][3],32,"ר��");
		format(zuzhilv[6][4],32,"��Ժ��");
		format(zuzhilv[6][5],8,"Ժ��");
	//--------------------------------ҽԺ
		format(zuzhilv[7][0],8,"С��");
		format(zuzhilv[7][1],8,"��ͽ");
		format(zuzhilv[7][2],8,"����");
		format(zuzhilv[7][3],8,"����");
		format(zuzhilv[7][4],32,"���᳤");
		format(zuzhilv[7][5],8,"�᳤");
	//--------------------------------���ϻ�
		format(zuzhilv[8][0],8,"С��");
		format(zuzhilv[8][1],8,"����");
		format(zuzhilv[8][2],8,"����");
		format(zuzhilv[8][3],8,"С�ӳ�");
		format(zuzhilv[8][4],32,"���");
		format(zuzhilv[8][5],8,"ͳ��");
	//--------------------------------����
		format(zuzhilv[9][0],8,"С��");
		format(zuzhilv[9][1],8,"��ͽ");
		format(zuzhilv[9][2],8,"����");
		format(zuzhilv[9][3],8,"����");
		format(zuzhilv[9][4],32,"������");
		format(zuzhilv[9][5],8,"����");
	//--------------------------------�ϰ�
		format(zuzhilv[10][0],8,"С��");
		format(zuzhilv[10][1],8,"��ͽ");
		format(zuzhilv[10][2],8,"����");
		format(zuzhilv[10][3],8,"����");
		format(zuzhilv[10][4],32,"���峤");
		format(zuzhilv[10][5],8,"�峤");
	//--------------------------------�̰�
		format(zuzhilv[11][0],8,"С��");
		format(zuzhilv[11][1],8,"����");
		format(zuzhilv[11][2],8,"ɱ��");
		format(zuzhilv[11][3],32,"�߼�ɱ��");
		format(zuzhilv[11][4],8,"���");
		format(zuzhilv[11][5],8,"�̸�");
	//--------------------------------���ֵ�
		format(zuzhilv[12][0],8,"С��");
		format(zuzhilv[12][1],8,"ˮ��");
		format(zuzhilv[12][2],32,"����ʿ");
		format(zuzhilv[12][3],8,"�ӳ�");
		format(zuzhilv[12][4],32,"������");
		format(zuzhilv[12][5],8,"����");
	//--------------------------------3K��
		format(zuzhilv[14][0],8,"�б�");
		format(zuzhilv[14][1],8,"��ξ");
		format(zuzhilv[14][2],32,"��У");
		format(zuzhilv[14][3],8,"��У");
		format(zuzhilv[14][4],32,"ָ�ӹ�");
		format(zuzhilv[14][5],8,"��˾��");
	//--------------------------------����
		format(zuzhilv[15][0],8,"����");
		format(zuzhilv[15][1],8,"С��");
		format(zuzhilv[15][2],32,"����");
		format(zuzhilv[15][3],8,"ǹ��");
		format(zuzhilv[15][4],32,"���");
		format(zuzhilv[15][5],8,"�峤");
	//--------------------------------װ�޹�˾
		format(zuzhilv[16][0],8,"��ͨ����");
		format(zuzhilv[16][1],8,"�߼�����");
		format(zuzhilv[16][2],32,"����Ա");
		format(zuzhilv[16][3],8,"���񶽲�");
		format(zuzhilv[16][4],32,"���᳤");
		format(zuzhilv[16][5],8,"�᳤");
	//--------------------------------����
		format(zuzhiname[0],32,"����ί��");
		format(zuzhiname[1],32,"����");
		format(zuzhiname[2],32,"����Ա");
		format(zuzhiname[3],32,"����");
		format(zuzhiname[4],32,"FBI");
		format(zuzhiname[5],32,"����");
		format(zuzhiname[6],32,"ҽԺ");
		format(zuzhiname[7],32,"���ϻ�");
		format(zuzhiname[8],32,"����");
		format(zuzhiname[9],32,"�ϰ�");
		format(zuzhiname[10],32,"�̰�");
		format(zuzhiname[11],32,"���ֵ�");
		format(zuzhiname[12],32,"3K��");
		format(zuzhiname[13],32,"���⳵��˾");
		format(zuzhiname[14],32,"����");
		format(zuzhiname[15],32,"Assassintor����");
		format(zuzhiname[16],32,"���о�ί��");
		format(zuzhigonggao[3],32,"�ֳ�");
		format(zuzhigonggao[4],32,"��");
		format(zuzhigonggao[5],32,"��ͳ");
		format(zuzhigonggao[6],32,"Ժ��");
		format(zuzhigonggao[14],32,"��˾��");
		format(tg[0],128,"��");
		format(tg[1],128,"��");
	//----------------------------------------
		format(gongzuoname[0],32,"��");
		format(gongzuoname[1],32,"������˽");
		format(gongzuoname[2],32,"��̽");
		format(gongzuoname[3],32,"��������");
		format(gongzuoname[4],32,"����������");
		format(gongzuoname[5],32,"����վ����Ա");
	//----------------------------------------
  format(ircname[0],32,"0");
		format(ircname[1],32,"1");
		format(ircname[2],32,"2");
		format(ircname[3],32,"3");
		format(ircname[4],32,"4");
		format(ircname[5],32,"5");
		gate = CreateDynamicObject(968,	1544.745605, -1630.961792, 13.177118, 0.0000, 269.7592,	270.0000);
		gate1 =	CreateDynamicObject(16773, 1591.846802,	-1638.013550, 13.491905, 0.0000, 0.0000, 0.0000);
		gate11=CreateDynamicObject(1500, 244.80754089355, 72.450500488281, 1002.640625,	0, 0, 0);
		gate12=CreateDynamicObject(1500, 246.2579498291, 72.445793151855, 1002.640625, 0, 0, 0);
		gate13=CreateDynamicObject(1500, 250.66600036621, 63.249282836914, 1002.640625,	0, 0, 270);
		gate14=CreateDynamicObject(1500, 250.60919189453, 64.719268798828, 1002.640625,	0, 0, 270);
		gate15=CreateDynamicObject(3354, 250.65625,	67.820426940918, 1005.1415405273, 0, 0,	0);
		gate4=CreateDynamicObject(1538,	371.2467956543,	166.54695129395, 1007.3828125, 0, 0, 0);
		gate9=CreateDynamicObject(2957,	-670.24908447266, 966.9794921875, 12.752597808838, 0, 0, 90);
		gate10=CreateDynamicObject(2957, -670.43908691406, 967.10314941406,	13.897609710693, 0,	0, 90);
		gate8=CreateDynamicObject(11327, -693.50885009766, 966.04644775391,	13.770468711853, 0,	0, 0);
		gate7=CreateDynamicObject(975, -662.64141845703, 921.30737304688, 12.816900253296, 0, 0, 90);
		gate5=CreateDynamicObject(975,-715.1565,950.5165,12.93273601532, 0,	0, 267.99499511719);
		gate6=CreateDynamicObject(975, -714.5289,950.5165,12.93273601532, 0, 0,	270);
	//-------------------------------------����
		gate16=CreateDynamicObject(11327, 1688.2047119141, -1450.9630126953, 14.409767150879, 0, 0,	270);
		gate17=CreateDynamicObject(11327, 1690.2977294922, -1460.7038574219, 19.970973968506, 0, 90, 179.99963378906);
		gate20=CreateDynamicObject(10671, 1681.5302734375, -1458.2824707031, 24.202903747559, 0, 90, 179.99450683594);
		gate21=CreateDynamicObject(10671, 1685.2802734375, -1458.2824707031, 24.202903747559, 0, 90, 179.99450683594);
		gate18=CreateDynamicObject(10671, 1689.0373535156, -1458.2824707031, 24.202903747559, 0, 90, 179.99450683594);
		gate19=CreateDynamicObject(10671, 1692.7523193359, -1458.2824707031, 24.202903747559, 0, 90, 179.99450683594);
		gate23=CreateDynamicObject(1537, 239.50939941406, 117.59090423584, 1002.21875, 0, 0, 270);
		gate25=CreateDynamicObject(1537, 239.62255859375, 125.07441711426, 1002.21875, 0, 0, 270);
		gate24=CreateDynamicObject(1537, 239.56811523438, 123.58466339111, 1002.21875, 0, 0, 270);
		gate22=CreateDynamicObject(1537, 239.55921936035, 116.10925292969, 1002.2504272461,	0, 0, 270);
		gate26=CreateDynamicObject(1537, 1142.3973, -2809.1465, 11.6500,	0, 0, 233.52);
		gate27=CreateDynamicObject(1537, 1161.2502, -2825.1479, 11.4450,	0, 0,  142.4254);
		rqq1=CreateDynamicObject(19335,-134.0300, -4591.5801, 11.3100,	0, 0, 0);
		ewmen1=CreateDynamicObject(987,-2692.8030, 2399.5242, 59.0000,	0, 0,     165.2742);
		ewmen2=CreateDynamicObject(987,-2681.7197, 2396.6272, 59.0000,	0, 0,     165.2742);
		xzmen1=CreateDynamicObject(972,-2694.5400, 2388.7021, 61.3394,	0, 0,     76.2763);
		xzmen2=CreateDynamicObject(972,-2694.5400, 2388.7021, 68.2381,	0, 0,     76.2763);
		xzmen3=CreateDynamicObject(981,-2514.80, 2436.41, 16.71,   0.00, 0.00, 42.59);
  		DestroyDynamicObject(ewmen1);
        DestroyDynamicObject(ewmen2);
        DestroyDynamicObject(xzmen1);
        DestroyDynamicObject(xzmen2);
        DestroyDynamicObject(xzmen3);
		gate2 =	CreateDynamicObject(987, 1563.736816, -1617.390381,	12.382813, 0.0000, 0.0000, 90.0000);
		gate3=	CreateDynamicObject(980,1535.4482421875,-1451.5390625,15.160917282104,0.0000,0.0000,0.0000);
	//====================Ƥ����ʼ
		CreateDynamicPickup(1318, 1, 2.6288,33.2132,1199.5938);	// /�ɻ��뿪- -
		Create3DTextLabel("[�ɻ���]	\n {F0FF00}�밴{F0FFFF}	[{F0000F}�ϳ���{F0FFFF}	]{F0FF00}��������",0xFFFF00AA, 2.6288,33.2132,1199.5938, 20,0,1);
	//NPCs
		ConnectNPC("VGBUS_1","Bus");
		ConnectNPC("BlackBus_Driver","Bus2");
		SetPlayerSkin(0,93);
        SetPlayerSkin(1,11);
        SetPlayerSkin(2,287);
        SetPlayerSkin(3,287);  //����һ��NPC��Ƥ��
	//3DTextLabels
		/*NPCTextBlue	= Create3DTextLabel("[��ѳ� ��G�ϳ�]", 0x6495EDFF, 0.0,	0.0, 0.0, 30.0,0, 0);
		NPCTextBlack = Create3DTextLabel("[����2����]",	0x6495EDFF,	0.0, 0.0, 0.0, 30.0,0, 0);
		Create3DTextLabel("[����F�뿪]", 0x6495EDFF, 2021.9740,2235.6626,2103.9536,	15.0,2);
		Create3DTextLabel("[����F�뿪]", 0x6495EDFF, 2021.9740,2235.6626,2103.9536,	15.0,3);
	//Vehicles
		NPCBlueBus = CreateVehicle(437,	0.0, 0.0, 0.0, 0.0,	125, 125, 1);
		NPCBlackBus	= CreateVehicle(437, 0.0, 0.0, 0.0,	0.0, 0,	0, 1);*/
//=====================Ƥ������
//=============================================
		new	File:player=fopen("ZFJG.cfg",io_read);
		new	nr[128];
		new	idx;
		new	msg[128];
//new tmp[128];
		while(fread(player,nr))//����ȫ������
		{
			ZFJGLX[pickupids]=strval(strtok(nr,idx));
			ZFJGTID[pickupids]=strval(strtok(nr,idx));
			if(ZFJGLX[pickupids]==1)
			{
				format(ZFJGSTR[pickupids],100,"%s",strtok(nr,idx));
			}
			if(ZFJGLX[pickupids]==2	)
			{
				format(ZFJGSTR[pickupids],128,"%s",strtok(nr,idx));
				format(ZFJGSTR1[pickupids],128,"%s",strtok(nr,idx));
			}
			if(ZFJGLX[pickupids]==3)
			{
				format(ZFJGSTR[pickupids],128,"%s",strtok(nr,idx));
				format(ZFJGSTR1[pickupids],128,"%s",strtok(nr,idx));
//format(ZFJGSTR2[pickupids],128,"%s",strtok(nr,idx));
			}
			if(ZFJGLX[pickupids]==4)
			{
				format(ZFJGSTR[pickupids],128,"%s",strtok(nr,idx));
			}
			ZFJGHID[pickupids]=strval(strtok(nr,idx));
			ZFJGX[pickupids]=floatstr(strtok(nr,idx));
			ZFJGY[pickupids]=floatstr(strtok(nr,idx));
			ZFJGZ[pickupids]=floatstr(strtok(nr,idx));
			if(ZFJGLX[pickupids]!=2)
			{
				ZFJGCX[pickupids]=floatstr(strtok(nr,idx));
				ZFJGCY[pickupids]=floatstr(strtok(nr,idx));
				ZFJGCZ[pickupids]=floatstr(strtok(nr,idx));
			}
			if(ZFJGLX[pickupids]==1)
			{
				ZFJGLOCALHID[pickupids]=strval(strtok(nr,idx));
			}
			if(ZFJGLX[pickupids]==1)
			{
				format(msg,128,"%s",ZFJGSTR[pickupids]);
			}
			if(ZFJGLX[pickupids]==2)
			{
				format(msg,128,"%s\n%s",ZFJGSTR[pickupids],ZFJGSTR1[pickupids]);
			}
			if(ZFJGLX[pickupids]==3)
			{
				ZFJGMONEY[pickupids]=strval(strtok(nr,idx));
				ZFJGLOCK[pickupids]=strval(strtok(nr,idx));
				ZFJGZJ[pickupids]=strval(strtok(nr,idx));
				ZFJGLV[pickupids]=strval(strtok(nr,idx));
				ZFJGHU[pickupids]=strval(strtok(nr,idx));
				new	pd=0;
				if(strcmp(ZFJGSTR[pickupids],"δ����")==0)
				{
					pd=1;
					format(msg,128,"{FFFF00}״̬:{1E90FF}%s{FFFF00}\n����ȼ�:{1E90FF}%d{FFFF00}\n�۸�:{1E90FF}%d{FFFF00}\n����:{1E90FF}%s{FFFF00}\n",ZFJGSTR[pickupids],ZFJGLV[pickupids],ZFJGMONEY[pickupids],ZFJGSTR1[pickupids]);
				}
				if(pd==0)
				{
					format(msg,128,"{FFFF00}����:{FF1493}%s{FFFF00}\n���:{FF1493}%d{FFFF00}\n����:{FF1493}%s{FFFF00}\n",ZFJGSTR[pickupids],ZFJGZJ[pickupids],ZFJGSTR1[pickupids]);
				}
			}
			if(ZFJGLX[pickupids]==4)
			{
				ZFJGZUZHI[pickupids]=strval(strtok(nr,idx));
				ZFJGLOCK[pickupids]=strval(strtok(nr,idx));
				format(msg,128,"%s",ZFJGSTR[pickupids]);
				ZFJGHU[pickupids]=strval(strtok(nr,idx));
				ZFJGHU[pickupids]=1;
			}
			ZFJGID[pickupids]=AddStaticPickup(ZFJGTID[pickupids],1,ZFJGX[pickupids],ZFJGY[pickupids],ZFJGZ[pickupids],0);
			if(ZFJGLX[pickupids]==3)
			{
				Create3DTextLabel(msg,0x00000000,ZFJGX[pickupids],ZFJGY[pickupids],ZFJGZ[pickupids],10,0);
			}
			if(ZFJGLX[pickupids]!=3)
			{
				Create3DTextLabel(msg,0xFFFF00FF,ZFJGX[pickupids],ZFJGY[pickupids],ZFJGZ[pickupids],10,0);
			}
			idx=0;
			pickupids++;
		}
		fclose(player);
		player=fopen("CAR.cfg",io_read);
		while(fread(player,nr))//����ȫ������
		{
				new	vid,zuzhi,moxing,Float:x,Float:y,Float:z,Float:mianxiang,c1,c2;
				zuzhi=strval(strtok(nr,idx));
				moxing=strval(strtok(nr,idx));
				x=floatstr(strtok(nr,idx));
				y=floatstr(strtok(nr,idx));
				z=floatstr(strtok(nr,idx));
				mianxiang=floatstr(strtok(nr,idx));
				c1=strval(strtok(nr,idx));
				c2=strval(strtok(nr,idx));
				vid=AddStaticVehicleEx(moxing,x,y,z,mianxiang,c1,c2,99999999999999999999999999);
				carzuzhi[vid]=zuzhi;
				carmoxing[vid]=moxing;
				carx[vid]=x;
				cary[vid]=y;
				carz[vid]=z;
				carmianxiang[vid]=mianxiang;
				carcolor1[vid]=c1;
				carcolor2[vid]=c2;
				format(carname[vid],128,"%s",strtok(nr,idx));
				carmoney[vid]=strval(strtok(nr,idx));
				cargzbc[vid]=strval(strtok(nr,idx));
				for(new	i=0;i<10;i++)
				{
					cargz[vid][i]=strval(strtok(nr,idx));
					AddVehicleComponent(vid,cargz[vid][i]);
				}
				carfill[vid]=strval(strtok(nr,idx));
				caryinqing[vid]=0;
				cardengguang[vid]=0;
				carlock[vid]=0;
				SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
				car[vid]=vid;
				idx=0;
		}
		fclose(player);
		new svrpass[128];
    	GetServerVarAsString("rcon_password", svrpass, sizeof (svrpass));
	    if (strcmp(svrpass, "wdzgx")==0)
	    {
	        for (;;)
	        {
	            print("* Ĭ��RCON���뻹û��, ���server.cfg���޸�rcon_password����ֵ�������������.");
	        }
	    }
		print("������������Ϣ: ");
		SendRconCommand("varlist");
		return 1;
}
public AdminXX(zuzhi,string[],color)//������ADMIN����Ϣ
{
	for(new	i=0;i<101;i++)
	{
		if(IsPlayerConnected(i)==1)
		{
			if(SL[i]==1)
			{
				if(playerzuzhi[i]==zuzhi)
				{
					SendClientMessage(i,color,string);
				}
			}
		}
	}
}
public XY(Float:real,playerid,Float:x,Float:y,Float:z)//�жϾ���ĺ���
{
	if(IsPlayerConnected(playerid)==1)
	{
			new	Float:px,Float:py,Float:pz;
			GetPlayerPos(playerid,px,py,pz);
			if(px<x+real&&px>x-real&&py<y+real&&py>y-real&&pz<z+real&&pz>z-real)
			{
				return 1;
			}
	}
	return 0;
}
strtokp(const string[],	&index)//��ȡ������������/ָ������������ȡ����
{
	new	length = strlen(string);
	while ((index <	length)	&& (string[index] <= ' '))
	{
		index++;
	}
	new	offset = index;
	new	result[128];
	while ((index <	length)	 &&	((index	- offset) <	(sizeof(result)	-1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
public OnPlayerSpawn(playerid)
{
	return 1;
}
//==========================�����Һ�===========================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(playeradmin[playerid]>= 1)
	{
			new	Float:x,Float:y,Float:z;
			new	hid=GetPlayerInterior(clickedplayerid);
			if(SL[clickedplayerid]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:����Ҳ�����");
				return 1;
			}
			GetPlayerPos(clickedplayerid,x,y,z);
			SetPlayerPos(playerid,x+1,y+1,z+1);
			houseid[playerid]=houseid[clickedplayerid];
			SetPlayerInterior(playerid,hid);
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(clickedplayerid));
			SendClientMessage(playerid,0xFFFACDAA,"�ɹ�����");
			return 1;
	}
	SendClientMessage(playerid,0xDC143CAA,"����,����ԭ��:��û��Ȩ��");
	return 1;
}
//==================================����=======================

//===========================================================
public OnPlayerDeath(playerid, killerid, reason) //����������¼�
{
	new	msg[128];
	//new msgdm[128];
	new	name[128];
	new	name1[128];
	GetPlayerName(playerid,name,128);
	GetPlayerName(killerid,name1,128);
	jybdyszt[playerid]=0;
	jybdlinggunzt[playerid]=0;
	jybdyszt[playerid] = 0;
	jybdlinggunzt[playerid] = 0;
	if(killerid==65535)
	{
		format(msg,128,"[ID:%d]%s����,ԭ��:����",playerid,name);
		ABroadCast(0xFF1493FF,msg,1);
	}
	if(killerid!=65535)
	{
/*	if(playerdm[playerid]==1)
	{
				new msgdm[128];
			    format(msgdm,128,"[DM��Ϣ]{FF00FF}%s{FFC0CB}��DMģʽ��սʤ��{FF00FF}%s{FFC0CB},����˽����ʽ�1000�����Ҳ��ս����~(/dm)",name1,name);
				SendClientMessageToAll(0xFFFF00AA,msgdm);
				playermoney[playerid]=playermoney[playerid]+1000;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            return 1;
	}*/
		if(su[playerid]==0||su[playerid]>=1&&playerzuzhi[killerid]!=3)
		{

   //=======================DMKILL
			format(msg,128,"[ID:%d]%s����,����:[ID:%d]%s",playerid,name,killerid,name1);
			ABroadCast(0xFF1493FF,msg,1);
			if(playerzuzhi[playerid]<7||playerzuzhi[killerid]<7)
			{
				if(su[killerid]<10)
				{
					su[killerid]=su[killerid]+1;
				}
				format(msg,128,"[ͨ��]%s��ͨ���ˣ�ͨ���ȼ�:%d,����:ıɱ",name1,su[killerid]);
				AdminXX(3,msg,0x00FF00AA);
				format(msg,128,"������ɱ��%s���Ա�ͨ���ˣ�Ŀǰͨ���ȼ�:%d",name,su[killerid]);
				SendClientMessage(killerid,0x00FF00AA,msg);
			}
		}
		if(su[playerid]>=1&&playerzuzhi[killerid]==3)
		{
			format(msg,128,"[ID:%d]%s����,����:[ID:%d]%s",playerid,name,killerid,name1);
			ABroadCast(0xFF1493FF,msg,1);
			format(msg,128,"[�ܲ�]:�ﷸ%s����Ա%s������!",name,name1);
			AdminXX(3,msg,0x00FF00AA);
		}
	}
	if(playerzuzhi[playerid]==0)
	{
		SetSpawnInfo(playerid,0,playerskin[playerid],zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],0,0,0,0,0,0,0);
	}
	if(jybdzt[playerid]==1)
	{
	    SendClientMessage(playerid,0x00FF00AA,"�������ˣ�����ʧ��.");
	    jybdzt[playerid] = 0;
	}
	if(playerzuzhi[playerid]>=1)
	{
		SetSpawnInfo(playerid,0,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]],zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],0,0,0,0,0,0,0);
	}
	for(new	i=0;i<7;i++)
	{
		playerwuqi[playerid][i]=0;
	}
	if(su[playerid]!=0)
	{
		SendClientMessage(playerid,0x00FF00AA,"����Ϊ��ͨ�������������ͽ��˼���!");
		SetPlayerPos(playerid,264.752624,77.582786,1001.039062);
		SetPlayerInterior(playerid,6);
		SetPlayerSkin(playerid,252);
		if(su[playerid]==1)
		{
			playerjianyutime[playerid]=200;
		}
		if(su[playerid]==2)
		{
			playerjianyutime[playerid]=400;
		}
		if(su[playerid]==3)
		{
			playerjianyutime[playerid]=600;
		}
		if(su[playerid]==4)
		{
			playerjianyutime[playerid]=800;
		}
		if(su[playerid]==5)
		{
			playerjianyutime[playerid]=1000;
		}
		if(su[playerid]==6)
		{
			playerjianyutime[playerid]=1200;
		}
		if(su[playerid]==7)
		{
			playerjianyutime[playerid]=1400;
		}
		if(su[playerid]==8)
		{
			playerjianyutime[playerid]=1600;
		}
		if(su[playerid]==9)
		{
			playerjianyutime[playerid]=1800;
		}
		if(su[playerid]==10)
		{
			playerjianyutime[playerid]=2000;
		}
		su[playerid]=0;
		cu[playerid]=0;
		return 1;
	}
	new	Float:x,Float:y,Float:z;

	GetPlayerPos(playerid,x,y,z);//�ݴ�������ַ
	SpawnPlayer(playerid);
	SetPlayerPos(playerid,x,y,z);//�ָ�������ַ
	SetPlayerHealth(playerid,5);
/*	if(playerdm[playerid]==1)
	{
	SendClientMessage(playerid,COLOR_BLUE,"[ҽԺ��Ϣ]:����DMģʽ�������ˣ����ǽ������˻��������ҽ����ͻ���ԭ�أ�");
	SendClientMessage(playerid,COLOR_BLUE,"[ҽԺ��Ϣ]:DM���Ʒѣ�1000");
	playermoney[playerid]=playermoney[playerid]-1000;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
		SetPlayerHealth(playerid,100);
	return 1;
	}*/
	KillSpawn[playerid]	= true;
	TogglePlayerControllable(playerid, false);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0,	1, 0, 0, 0,	0);
	ShowPlayerDialog(playerid,8520,DIALOG_STYLE_LIST,"��ѡ��:","{FFFFFF}1\t{55EE55}�ȴ�Ԯ�������Ƽ���\n{FFFFFF}2\t{55EE55}����Ԯ��.\n\n\n������ѡ��Ϊ����Ԯ��","ȷ��","ȡ��");
	return 1;
}
forward	SKillSpawn(playerid);
forward	SKSpawn(playerid);
public SKillSpawn(playerid)
{
	GameTextForPlayer(playerid,	"~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~You need	to rest	now	...", 5000,	3);
	if(!KillSpawn[playerid]){return;}
	KillSpawn[playerid]	= false;
	SetPlayerColor(playerid,0xF8F8FF00);
	if(playerviplv[playerid]==0)
	{
	playermoney[playerid]=playermoney[playerid]-3500;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
	SendClientMessage(playerid,0x00FF00AA,"[ҽԺ��Ϣ]:�㱻����ҽԺ������,��ȡ����3500ҽ�Ʒ�!");
	//SendClientMessage(playerid,0x00FF00AA,"[ҽԺ��Ϣ]:�����Ѿ������Ա������ˣ�Ŀǰ����ֵ�Ϳڿ�ֵ��Ϊ20���ǵö�ಹ��Ŷ��");
	//playerjiedu[playerid]=20;
	//playerkouke[playerid]=20;
	}
	if(playerviplv[playerid]!=0)
	{
	playermoney[playerid]=playermoney[playerid]-500;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
	SendClientMessage(playerid,0x00FF00AA,"[ҽԺ��Ϣ]:�㱻����ҽԺ������,��������VIP,����ֻ��ȡ����500ҽ�Ʒ�!");
	//SendClientMessage(playerid,0x00FF00AA,"[ҽԺ��Ϣ]:�����Ѿ������Ա������ˣ�Ŀǰ����ֵ�Ϳڿ�ֵ��Ϊ25���ǵö�ಹ��Ŷ��");
	//playerjiedu[playerid]=25;
	//playerkouke[playerid]=25;
	}
	SetPlayerHealth(playerid,50);
	ResetPlayerWeaponEx(playerid);
	SetPlayerFacingAngle(playerid, 0);
	houseid[playerid]=6;
	SetPlayerPos(playerid, 266.264404 ,119.238403 ,1005.525939);
	SetPlayerInterior(playerid,10);
	SetTimerEx("SKSpawn", 10000, 0,	"i", playerid);
}
public SKSpawn(playerid)
{
	SetPlayerPos(playerid,-2386.710449,2446.947021,10.169355);
	SetPlayerFacingAngle(playerid, 0);
	SetPlayerInterior(playerid,0);
	TogglePlayerControllable(playerid,true);
}

public OnPlayerUpdate(playerid)
{
	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && playeradmin[playerid] <= 0 && Kicking[playerid] == 0)
	{
		new msg[128];
		new name[128];
		new	y,r,d;
		GetPlayerName(playerid,name,128);
		getdate(y,r,d);
		format(msg,128,"[�����Ϸ������ϵͳ]:���%s���������߳�.��ԭ��ˢ��������ִ������:%d��%d��%d��",name,y,r,d);
		SendClientMessageToAll(0xFB0000FF,msg);
		print(msg);
		SetTimerEx("KickEx",2000,false,"i",playerid);
		Kicking[playerid] = 1;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
	 	new speed = floatround(GetVehicleSpeed(vehicleid, 0), floatround_round);
	 	new Float:vhealth;
	 	GetVehicleHealth(vehicleid,vhealth);
	  	if(speed > 500 && playeradmin[playerid] <= 0 && Kicking[playerid] == 0 && GetPlayerVehicleSeat(playerid) == 0)
	    {
  			new msg[128];
			new name[128];
			new	y,r,d;
			GetPlayerName(playerid,name,128);
			getdate(y,r,d);
			format(msg,128,"[�����Ϸ������ϵͳ]:���%s���������߳�.��ԭ�򣺳����ٶȳ�������޶�500KM/H��ִ������:%d��%d��%d��",name,y,r,d);
			SendClientMessageToAll(0xFB0000FF,msg);
			print(msg);
			SetTimerEx("KickEx",2000,false,"i",playerid);
			Kicking[playerid] = 1;
	    }
		if (playeradmin[playerid] <= 0 && Kicking[playerid] == 0 && GetPlayerVehicleSeat(playerid) == 0 && vhealth > 1000.0)
		{
		  	new msg[128];
			new name[128];
			new	y,r,d;
			GetPlayerName(playerid,name,128);
			getdate(y,r,d);
			format(msg,128,"[�����Ϸ������ϵͳ]:���%s���������߳�.��ԭ�򣺳�������ֵ����1000.0��ִ������:%d��%d��%d��",name,y,r,d);
			SendClientMessageToAll(0xFB0000FF,msg);
			print(msg);
			SetTimerEx("KickEx",2000,false,"i",playerid);
			Kicking[playerid] = 1;
		}
	}
	for(new slot; slot<13; slot++)
	{
		new weaponid,wammo;
	    GetPlayerWeaponData(playerid, slot, weaponid, wammo);
	    if(PlayerWeapons[playerid][weaponid] == 0 && weaponid != 0 && wammo != 0 && weaponid != 1  && Kicking[playerid] == 0) //ˢ����
	    {
  			new msg[128];
			new name[128];
			new	y,r,d;
			GetPlayerName(playerid,name,128);
			getdate(y,r,d);
			format(msg,128,"[�����Ϸ������ϵͳ]:���%s���������߳�.��ԭ��ˢ������ִ������:%d��%d��%d��",name,y,r,d);
			SendClientMessageToAll(0xFB0000FF,msg);
			print(msg);
			SetTimerEx("KickEx",2000,false,"i",playerid);
			Kicking[playerid] = 1;
	    }
   }
   
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsPlayerNPC(playerid)) return 1;

	// Handle playing SomaFM at the alhambra
	if(GetPlayerInterior(playerid) == 17) {
	    if(IsPlayerInRangeOfPoint(playerid,70.0,489.5824,-14.7563,1000.6797)) { // alhambra middle
	    	if(!GetPVarInt(playerid,"alhambra")) {
	    	    SetPVarInt(playerid,"alhambra",1);
	    	    //PlayAudioStreamForPlayer(playerid, "http://117.135.129.181/wap/657814.mp3",480.9575,-3.5402,1002.0781,40.0,true);
			}
		}
	}
	else {
		if(GetPVarInt(playerid,"alhambra")) {
	  		DeletePVar(playerid,"alhambra");
	   		//StopAudioStreamForPlayer(playerid);
		}
	}
        if (GetPVarInt(playerid, "laser")) {
                RemovePlayerAttachedObject(playerid, 0);
                if ((IsPlayerInAnyVehicle(playerid)) || (IsPlayerInWater(playerid))) return 1;
                switch (GetPlayerWeapon(playerid)) {
                        case 23: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 350.512573, 364.284240);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched aiming
                                                0.108249, 0.030232, 0.118051, 1.468254, 349.862579, 364.784240);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP standing not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SP crouched not aiming
                                                0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
                        }       }       }
                        case 27: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing aiming
                                                0.588246, -0.022766, 0.138052, -11.531745, 347.712585, 352.784271);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched aiming
                                                0.588246, -0.022766, 0.138052, 1.468254, 350.712585, 352.784271);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS standing not aiming
                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // SPAS crouched not aiming
                                                0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
                        }       }       }
                        case 30: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing aiming
                                                0.628249, -0.027766, 0.078052, -6.621746, 352.552642, 355.084289);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched aiming
                                                0.628249, -0.027766, 0.078052, -1.621746, 356.202667, 355.084289);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK standing not aiming
                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // AK crouched not aiming
                                                0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
                        }       }       }
                        case 31: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing aiming
                                                0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched aiming
                                                0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing not aiming
                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched not aiming
                                                0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                        }       }       }
			case 34: {
				if (IsPlayerAiming(playerid)) {
					/*if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing aiming
						0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
					} else {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched aiming
						0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
					}*/
					return 1;
				} else {
					if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper standing not aiming
						0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
					} else {
						SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // Sniper crouched not aiming
						0.658248, -0.03276, 0.133051, -11.631746, 355.302673, 353.584259);
			}	}	}
                        case 29: {
                                if (IsPlayerAiming(playerid)) {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing aiming
                                                0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched aiming
                                                0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
                                        }
                                } else {
                                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                                        } else {
                                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched not aiming
                                                0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
        }       }       }       }       }
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)//�ı�״̬
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new driver = GetVehicleDriver(vehicleid);
    if(newstate == PLAYER_STATE_DRIVER)
	{

	if(OnDuty[playerid] == 1 && IsATaxi(vehicleid) == 1)
	{

	TextDrawShowForPlayer(playerid, taxiblackbox[playerid]);
	TextDrawShowForPlayer(playerid, taxigreendisplay[playerid]);
	TextDrawShowForPlayer(playerid, taxitimedisplay[playerid]);
	TextDrawShowForPlayer(playerid, taxi100mfare[playerid]);
	TextDrawShowForPlayer(playerid, startfare[playerid]);
	TextDrawShowForPlayer(playerid, taxithisfare[playerid]);
	TextDrawShowForPlayer(playerid, taxilstlogo[playerid]);
	TextDrawShowForPlayer(playerid, taxistatus[playerid]);
	}
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	if(OnDuty[driver] == 1)
	{

	TextDrawShowForPlayer(playerid, taxiblackbox[driver]);
	TextDrawShowForPlayer(playerid, taxigreendisplay[driver]);
	TextDrawShowForPlayer(playerid, taxitimedisplay[driver]);
	TextDrawShowForPlayer(playerid, taxi100mfare[driver]);
	TextDrawShowForPlayer(playerid, taxithisfare[driver]);
	TextDrawShowForPlayer(playerid, taxilstlogo[driver]);
    TextDrawSetString(taxistatus[driver],"This Taxi:Non-Free");
	TextDrawShowForPlayer(playerid, taxistatus[driver]);
	TextDrawShowForPlayer(playerid, startfare[driver]);

	}
	}
 	if(newstate == PLAYER_STATE_ONFOOT)
	{

    TextDrawHideForPlayer(playerid, taxiblackbox[playerid]);
	TextDrawHideForPlayer(playerid, taxigreendisplay[playerid]);
	TextDrawHideForPlayer(playerid, taxitimedisplay[playerid]);
	TextDrawHideForPlayer(playerid, taxi100mfare[playerid]);
	TextDrawHideForPlayer(playerid, taxithisfare[playerid]);
	TextDrawHideForPlayer(playerid, taxilstlogo[playerid]);
	TextDrawHideForPlayer(playerid, taxistatus[playerid]);
	TextDrawHideForPlayer(playerid, startfare[playerid]);

    if(IsOnFare[playerid] == 1)
	{


	SendClientMessage(playerid,COLOR_LIGHTBLUE,"���⳵ֵ����� - ���뿪�˳�����");
	OnDuty[playerid] = 0;
	TotalFare[playerid] = 0.00;
 	TextDrawSetString(taxithisfare[playerid],"N/A");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"Ʊ��ֹͣ");
	IsOnFare[playerid] = 0;
	KillTimer(faretimer[playerid]);
	TextDrawDestroy(taxiblackbox[playerid]);
	TextDrawDestroy(taxigreendisplay[playerid]);
	TextDrawDestroy(taxitimedisplay[playerid]);
	TextDrawDestroy(taxi100mfare[playerid]);
	TextDrawDestroy(taxithisfare[playerid]);
	TextDrawDestroy(taxilstlogo[playerid]);
	TextDrawDestroy(taxistatus[playerid]);
	TextDrawDestroy(startfare[playerid]);
	TextDrawDestroy(taxiblackbox[driver]);
	TextDrawDestroy(taxigreendisplay[driver]);
	TextDrawDestroy(taxitimedisplay[driver]);
	TextDrawDestroy(taxi100mfare[driver]);
	TextDrawDestroy(taxithisfare[driver]);
	TextDrawDestroy(taxilstlogo[driver]);
	TextDrawDestroy(taxistatus[driver]);
	TextDrawDestroy(startfare[driver]);



	}
	}




    // play an internet radio stream when they are in a vehicle
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		//PlayAudioStreamForPlayer(playerid, "http://117.135.129.181/wap/657814.mp3");
	}
	// stop the internet stream
	else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    //StopAudioStreamForPlayer(playerid);
	}
	if(newstate==2)
	{
		new	name[128];
		new	vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
		new	msg[128];
		GetPlayerName(playerid,name,128);
		if(carzuzhi[vid]!=13)
		{
			format(msg,128,"��������%s�İ���Ŷ��",carname[vid]);
			SendClientMessage(playerid,0x1229FAFF,msg);
		}
		if(playercarzhizhao[playerid]==0&&mod!=462&&mod!=461&&mod!=550&&mod!=402&&mod!=507)
		{
			if(su[playerid]<10)
			{
			}
		}
		if(playeradmin[playerid]>= 1||strcmp(name,carname[vid])==0)
		{
			if(caryinqing[vid]==0)
			{
                if(playersupernos[playerid]== 1)
                {
                if(SNOS[playerid]== 1)
                {
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"�����������˳���N2O�������Ѿ��Զ���װN2O��");
				SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
				return 1;
				}
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"�����������˳���N2O�������Ѿ��Զ���װN2O��");
		   NOSTimer[playerid] = SetTimerEx("NOS",20000,1,"d",playerid);
				SNOS[playerid] = 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
			}
			if(caryinqing[vid]==1)
			{
                if(playersupernos[playerid]== 1)
                {
                if(SNOS[playerid]== 1)
                {
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"�����������˳���N2O�������Ѿ��Զ���װN2O��");
				SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
					 return 1;
				}
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"�����������˳���N2O�������Ѿ��Զ���װN2O");
		   NOSTimer[playerid] = SetTimerEx("NOS",20000,1,"d",playerid);
		   				SNOS[playerid] = 1;
				}

				SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
			}
			return 1;
		}
		if(carzuzhi[vid]>=1)
		{
			if(carzuzhi[vid]==playerzuzhi[playerid]||playeradmin[playerid]>= 1)
			{
				format(msg,128,"�ó�ע�����֯:%s,�������Կ���������",zuzhiname[carzuzhi[vid]]);
				SendClientMessage(playerid,0xD3D3D3FF,msg);
				if(caryinqing[vid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
				}
				if(caryinqing[vid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
				}
				return 1;
			}
			if(carzuyongkey[playerid]==vid)
			{
				if(caryinqing[vid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
				}
				if(caryinqing[vid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"����԰���{FF0000}N{00FF00}���鿴�����˵�!");
				}
				return 1;
			}
			if(carzuzhi[vid]==13&&carzuyong[vid]==0)
			{
				ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"�⳵","�˳�Ϊ��ѳ���, ��С�ļ�ʻ!","ȷ��","");
				return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SendClientMessage(playerid,0xD3D3D3FF,"��û������Կ��/Կ��");
			return 1;
		}
		RemovePlayerFromVehicle(playerid);
		SendClientMessage(playerid,0xD3D3D3FF,"��û������Կ��/Կ��");
		return 1;
	}
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)//���¼��Ǹ�װ��ʱ���
{
	new	vid=vehicleid;
	if(cargzbc[vid]==0)
	{
		if(cargz[vid][0]==0)
		{
			cargz[vid][0]=componentid;
			return 1;
		}
		if(cargz[vid][1]==0)
		{
			cargz[vid][1]=componentid;
			return 1;
		}
		if(cargz[vid][2]==0)
		{
			cargz[vid][2]=componentid;
			return 1;
		}
		if(cargz[vid][3]==0)
		{
			cargz[vid][3]=componentid;
			return 1;
		}
		if(cargz[vid][4]==0)
		{
			cargz[vid][4]=componentid;
			return 1;
		}
		if(cargz[vid][5]==0)
		{
			cargz[vid][5]=componentid;
			return 1;
		}
		if(cargz[vid][6]==0)
		{
			cargz[vid][6]=componentid;
			return 1;
		}
		if(cargz[vid][7]==0)
		{
			cargz[vid][7]=componentid;
			return 1;
		}
		if(cargz[vid][8]==0)
		{
			cargz[vid][8]=componentid;
			return 1;
		}
		if(cargz[vid][9]==0)
		{
			cargz[vid][9]=componentid;
			return 1;
		}
	}
	SendClientMessage(playerid,0xFF0000FF,"����!���������װ����û�н��!���ڽ��еĸ�װ������Ч��!");
	SendClientMessage(playerid,0xFF0000FF,"����!���������װ����û�н��!���ڽ��еĸ�װ������Ч��!");
	SendClientMessage(playerid,0xFF0000FF,"����!���������װ����û�н��!���ڽ��еĸ�װ������Ч��!");
	SendClientMessage(playerid,0xFF0000FF,"����!���������װ����û�н��!���ڽ��еĸ�װ������Ч��!");
	return 1;
}
public OnVehicleSpawn(vehicleid)//�����������¼�
{
	new ran,plate[128];
	ran = random(9999);
	format(plate,128,"ZGX-%d",ran);
	SetVehicleNumberPlate(vehicleid,plate);
	SetVehiclePos(vehicleid,carx[vehicleid],cary[vehicleid],carz[vehicleid]);
	ChangeVehicleColor(vehicleid,carcolor1[vehicleid],carcolor2[vehicleid]);
	if(cargzbc[vehicleid]==0)
	{
		for(new	i=0;i<10;i++)
		{
			cargz[vehicleid][i]=0;
		}
	}
	if(cargzbc[vehicleid]==1)
	{
		for(new	i=0;i<10;i++)
		{
			AddVehicleComponent(vehicleid,cargz[vehicleid][i]);
		}
	}
	SetVehicleToRespawn(vehicleid);
	return 1;
}
public OnPlayerKeyStateChange(playerid,	newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
		if(GetPVarInt(playerid,"camara"))
		{
	    	CameraMode(playerid,0);
	    	ShowStartMenuTablet(playerid);
	    	SelectTextDraw(playerid,0x33AA33AA);
			DeletePVar(playerid,"camara");
		}
	}
	if(newkeys == KEY_CROUCH)
	{
		if(IsPlayerNPC(playerid))
		{
			/*new	npcvehicle = GetPlayerVehicleID(playerid);
			if(npcvehicle == NPCBlueBus)
			{
				if(IsPlayerInRangeOfPoint(playerid,	100, 2868.9033,-1416.4062,11.0131))
				{
					format(string, sizeof(string), "[������˾��] ����������	����̲վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 2636.3242,-1693.125,10.9544))
				{
					format(string, sizeof(string), "[������˾��] ����������	����վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 2243.8457,-1725.9121,13.5960))
				{
					format(string, sizeof(string), "[������˾��] ����������	����վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1948.3310,-1454.3525,13.5960))
				{
					format(string, sizeof(string), "[������˾��] ����������	СҽԺվ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1571.0644,-2188.0107,13.6260))
				{
					format(string, sizeof(string), "[������˾��] ����������	LS�ɻ���վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1712.9423,-1818.7148,13.6260))
				{
					format(string, sizeof(string), "[������˾��] ����������	��ʿվ.");
				}
				for(new	i =	0; i < MAX_PLAYERS;	i++)
				{
					if(IsPlayerInRangeOfPoint(i, 10, 2021.9390,2241.9487,2103.9536)	&& BusID[i]	== 1)
					{
						SendClientMessage(i, COLOR_OFFWHITE, string);
						PlayerPlaySound(i, 1147, 0.0, 0.0, 0.0);
					}
				}
			}*/
			/*else if(npcvehicle == NPCBlackBus)
			{
				if(IsPlayerInRangeOfPoint(playerid,	100, 1567.0966,-1725.4755,13.6260))
				{
					format(string, sizeof(string), "[������˾��] ����������	������վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1503.9716,-1027.7617,23.7701))
				{
					format(string, sizeof(string), "[������˾��] ����������	����վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1188.8359,-1354.6279,13.6483))
				{
					format(string, sizeof(string), "[������˾��] ����������	��ҽԺվ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 861.7125,-1313.3009,13.6260))
				{
					format(string, sizeof(string), "[������˾��] ����������	�г�վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 393.6944,-1766.2702,5.6197))
				{
					format(string, sizeof(string), "[������˾��] ����������	ʥ�����Ǻ�̲վ.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1705.5898,-1805.8476,13.5300))
				{
					format(string, sizeof(string), "[������˾��] ����������	��ʿվ.");
				}
				for(new	i =	0; i < MAX_PLAYERS;	i++)
				{
					if(IsPlayerInRangeOfPoint(i, 10, 2021.9390,2241.9487,2103.9536)	&& BusID[i]	== 2)
					{
						SendClientMessage(i, COLOR_OFFWHITE, string);
						PlayerPlaySound(i, 1147, 0.0, 0.0, 0.0);
					}
				}
			}*/
		}
	}
	if(newkeys == KEY_FIRE)
	{
		if(PlayerSitting[playerid] == 1)
		{
			ClearAnimations(playerid, 1);
			PlayerSitting[playerid]	= 0;
		}
	}

	if (newkeys == 131072 && IsPlayerInAnyVehicle(playerid))
	{
  		ShowPlayerDialog(playerid,8889, DIALOG_STYLE_LIST, "�����˵�", "������\n�ر�����\n�򿪳���\n�رճ���", "���", "����");
	}

	if(newkeys==4)
	{
		new	vid=GetPlayerVehicleID(playerid)/*,zid=GetPlayerVehicleSeat(playerid)*/;
		if(playeradmin[playerid]>= 1)
		{
			if(vid!=0)
			{
				SetVehicleHealth(vid,1000);
				RepairVehicle(vid);
				return 1;
			}
			return 1;
		}
		return 1;
	}
	if ( newkeys==16 )
	{
		if(PlayerToPoint(2,	playerid, 2.6288,33.2132,1199.5938))
		{//�ɻ�����
			GameTextForPlayer(playerid,	"~b~Airport", 5000,	3);
			SetPlayerInterior(playerid,	0);
			SetPlayerVirtualWorld(playerid,	0);
			SetPlayerPos(playerid,1612.7871,-2332.1899,13.5385);
//}
			return 1;
		}
		if(XY(2,playerid,240.140090, 117.524360, 1003.225708)==1)
		{
			if(playerzuzhi[playerid]==6)
			{
				if(yymen==0)
				{
					SendClientMessage(playerid,	0x0D7792AA,	"����Ŵ���~��ǵù���");
					MoveDynamicObject(gate22, 239.55921936035, 115.10925292969,	1002.2504272461,8);
					MoveDynamicObject(gate23,  239.50939941406,	118.59090423584, 1002.21875,8);
					yymen=1;
					return 1;
				}
				SendClientMessage(playerid,	0x0D7792AA,	"����Ź�����~лл");
				MoveDynamicObject(gate22, 239.55921936035, 116.10925292969,	1002.2504272461,8);
				MoveDynamicObject(gate23, 239.50939941406, 117.59090423584,	1002.21875,8);
				yymen=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
//else if (	PRESSED(KEY_SECONDARY_ATTACK) )
//{
		if(XY(2,playerid,239.62255859375, 125.07441711426, 1002.21875)==1)
		{
			if(playerzuzhi[playerid]==6)
			{
				if(yymen1==0)
				{
					SendClientMessage(playerid,	0x0D7792AA,	"����Ŵ���~��ǵù���");
					MoveDynamicObject(gate24,  239.56811523438,	122.58466339111, 1002.21875,8);
					MoveDynamicObject(gate25,  239.62255859375,	126.07441711426, 1002.21875,8);
					yymen1=1;
					return 1;
				}
				SendClientMessage(playerid,	0x0D7792AA,	"����Ź�����~лл");
				MoveDynamicObject(gate24,239.56811523438, 123.58466339111, 1002.21875,8);
				MoveDynamicObject(gate25, 239.62255859375, 125.07441711426,	1002.21875,8);
				yymen1=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
/*		if(XY(2,playerid,242.749450	,66.224548,	1003.640625)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				SetPlayerPos(playerid,1557.278686 ,-1675.701538	,28.395452);
				SetPlayerInterior(playerid,0);
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
		if(XY(2,playerid,1557.278686 ,-1675.701538 ,28.395452)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				SetPlayerPos(playerid,242.749450 ,66.224548, 1003.640625);
				SetPlayerInterior(playerid,6);
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}*/
		return 1;
	}
	if(newkeys==8)
	{
/*		if(XY(2,playerid,242.749450	,66.224548,	1003.640625)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				SetPlayerPos(playerid,1524.820922 ,-1677.945678, 5.890625);
				SetPlayerInterior(playerid,0);
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
		if(XY(2,playerid,1524.820922 ,-1677.945678,	5.890625)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				SetPlayerPos(playerid,242.749450 ,66.224548, 1003.640625);
				SetPlayerInterior(playerid,6);
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}*/
		if(XY(2,playerid,245.80754089355, 72.450500488281, 1002.640625)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(pdmen==0)
				{
					MoveDynamicObject(gate11,242.80754089355, 72.450500488281, 1002.640625,8);
					MoveDynamicObject(gate12,248.2579498291, 72.445793151855, 1002.640625,8);
					SendClientMessage(playerid,	0x0D7792AA,	"����Ŵ���~��ǵù���");
					pdmen=1;
					return 1;
				}
				MoveDynamicObject(gate11,244.80754089355, 72.450500488281, 1002.640625,8);
				MoveDynamicObject(gate12, 246.2579498291, 72.445793151855, 1002.640625,8);
				SendClientMessage(playerid,	0x0D7792AA,	"����Ź�����~лл");
				pdmen=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
		if(XY(2,playerid,250.66600036621,64.049282836914, 1002.640625)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(pdmen1==0)
				{

					MoveDynamicObject(gate13,250.66600036621,63.249282836914, 1006.640625,25);
					MoveDynamicObject(gate14,250.60919189453,64.719268798828, 998.640625,25);
					SendClientMessage(playerid,	0x0D7792AA,	"����Ŵ���~��ǵù���");
					pdmen1=1;
					return 1;
				}
				DestroyDynamicObject(gate13);
				DestroyDynamicObject(gate14);
		        gate13=CreateDynamicObject(1500, 250.66600036621, 63.249282836914, 1002.640625,	0, 0, 270);
		        gate14=CreateDynamicObject(1500, 250.60919189453, 64.719268798828, 1002.640625,	0, 0, 270);
				SendClientMessage(playerid,	0x0D7792AA,	"����Ź�����~лл");
				pdmen1=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
		if(XY(2,playerid,250.65625,	67.820426940918, 1005.1415405273)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(pdmen2==0)
				{
					MoveDynamicObject(gate15,250.65625,	67.820426940918, 996.1415405273,24);
					SendClientMessage(playerid,	0x0D7792AA,	"��Ѵ���������~��ǵù���");
					pdmen2=1;
					return 1;
				}
				MoveDynamicObject(gate15,250.65625,	67.820426940918, 1005.1415405273,24);
				SendClientMessage(playerid,	0x0D7792AA,	"��Ѵ���������~лл ");
				pdmen2=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"��û��Կ��");
			return 1;
		}
/*if(playerzuzhi[playerid]==3)
{
If(PlayerToPoint(x,y,z,));//�������
{
SetPlayerPos(playerid,x,y,z);//��������
return 1;
}*/
		for(new	u=0;u<pickupids;u++)
		{
			new	pd1=0;
			new	pd=0;
			if(ZFJGLX[u]==4)
			{
				if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
				{
					if(su[playerid]>=1)
					{
					}
					if(pd1==0&&ZFJGLOCK[u]!=0||pd1==0&&playerzuzhi[playerid]==ZFJGZUZHI[u])
					{
						pd=1;
						houseid[playerid]=u;
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerInterior(playerid,ZFJGHID[u]);
						SetPlayerPos(playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u]);
					}
					if(pd==0)
					{
						SendClientMessage(playerid,	0xFFFFF0FF,"��䷿�ӱ���ס��!");
					}
				}
			}
			if(ZFJGLX[u]==1)
			{
				if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
				{
					if(su[playerid]>=1)
					{
					}
					if(pd1==0)
					{
						houseid[playerid]=u;
						SetPlayerInterior(playerid,ZFJGHID[u]);
						SetPlayerPos(playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u]);
					}
				}
			}
			if(ZFJGLX[u]==3)
			{
				if(XY(1.5,playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u])==1)
				{
					if(strcmp(ZFJGSTR[u],"δ����")!=0)
					{
						if(ZFJGLOCK[u]!=0||playerlock[playerid]==u||playerlock1[playerid]==u||playerlock2[playerid]==u)
						{
							if(su[playerid]>=1)
							{
							}
							if(pd1==0)
							{
								houseid[playerid]=u;
								SetPlayerVirtualWorld(playerid,0);
								pd=1;
								SetPlayerInterior(playerid,ZFJGHID[u]);
								SetPlayerPos(playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u]);
							}
						}
						if(pd==0)
						{
							SendClientMessage(playerid,	0xFFFFF0FF,"��䷿�ӱ������ˣ�");
						}
					}
				}
			}
			if(ZFJGLX[u]==3)
			{
				if(XY(1.5,playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u])==1)
				{
					if(houseid[playerid]==u)
					{
						houseid[playerid]=0;
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerInterior(playerid,0);
						SetPlayerPos(playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u]);
					}
				}
			}
			if(ZFJGLX[u]==4)
			{
				if(XY(1.5,playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u])==1)
				{
					if(houseid[playerid]==u)
					{
						houseid[playerid]=0;
						SetPlayerVirtualWorld(playerid,0);
						SetPlayerInterior(playerid,0);
						SetPlayerPos(playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u]);
					}
				}
			}
			if(ZFJGLX[u]==1)
			{
				if(XY(1.5,playerid,ZFJGCX[u],ZFJGCY[u],ZFJGCZ[u])==1)
				{
					if(houseid[playerid]==u)
					{
						houseid[playerid]=0;
						if(u==75)
						{
							houseid[playerid]=76;
						}
						SetPlayerInterior(playerid,ZFJGLOCALHID[u]);
						SetPlayerPos(playerid,ZFJGX[u],ZFJGY[u],ZFJGZ[u]);
					}
				}
			}
		}
	}
   //}
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	new	h,m,s;
	gettime(h,m,s);
	if (jybdzt[playerid]==1)
	{
		jybdzt[playerid] = 0;
		SendClientMessage(playerid,0x00FF00AA,"����ϵͳ:���������������ɹ�!!!");
		jybdyszt[playerid] = 0;
		jybdlinggunzt[playerid] = 0;
		su[playerid]=0;
		playerjianyutime[playerid]=0;
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(jcys[playerid]==1)
	{
		new	name[128],msg[128];
		GetPlayerName(playerid,name,128);
		format(msg,128,"[����Աע��]:<[%d:%d:%d]A������>%s������",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"��ɹ��Ľ����˵���ָ����,�����2500Ԫ!");
		DisablePlayerCheckpoint(playerid);
		playermoney[playerid]=playermoney[playerid]+2500;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,playermoney[playerid]);
		jcys[playerid]=0;
		return 1;
	}
	if(jcys[playerid]==2)
	{
		new	name[128],msg[128];
		GetPlayerName(playerid,name,128);
		format(msg,128,"[����Աע��]:<[%d:%d:%d]B������>%s������",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"��ɹ��Ľ����˵���ָ����,�����4000Ԫ!");
		DisablePlayerCheckpoint(playerid);
		playermoney[playerid]=playermoney[playerid]+4000;
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,playermoney[playerid]);
		jcys[playerid]=0;
		return 1;
	}
//================================================================================================
//================================================================================================
//================================================================================================
	if(jcys[playerid]==4)
	{
		new	name[128],msg[128];
		GetPlayerName(playerid,name,128);
		format(msg,128,"[����Աע��]:<[%d:%d:%d]50���ϵ�>%s������",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"��ɹ��Ľ����˵���ָ����,�����50����!");
		DisablePlayerCheckpoint(playerid);
		playermats[playerid]=playermats[playerid]+50;
  jcys[playerid]=0;
		return 1;
	}
	return 1;
}
//----------------------------------------
//========================================
//----------------------------------------
public sjd()//������������ BY GTAYY
{
new sc;
for(sc=0;sc<MAX_PLAYERS;sc++)
{
if(SL[sc]==1)
{
playerlvup[sc]=playerlvup[sc]+1;
if(playerviplv[sc]!=0)
{
playervipczz[sc]=playervipczz[sc]+1;
}
SendClientMessage(sc,0xCECECEFF,"���������ש����������ש�����");
SendClientMessage(sc,0xCECECEFF,"�ǩ�������SC�����˵���������");
SendClientMessage(sc,0xCECECEFF,"������Ĺ̶����ʣ�����������");
SendClientMessage(sc,0xCECECEFF,"���������������㣺����������");
if(playerzuzhi[sc]!=0)
{
SendClientMessage(sc,0xCECECEFF,"��������֯�ʽ𣺣�����������");
}
SendClientMessage(sc,0xCECECEFF,"�ǩ�������������������������");
    if(playerzuzhi[sc]!=0)
    {
    SendClientMessage(sc,0xCECECEFF,"�������ù��ʣ���������������");
    }
else
    {
    SendClientMessage(sc,0xCECECEFF,"���������ù��ʣ�������������");
    }
if(playerviplv[sc]!=0)
{
SendClientMessage(sc,0xCECECEFF,"�����֣ɣн��𣺣�����������");
playermoney[sc]=playermoney[sc]+3000;
ResetPlayerMoney(sc);
GivePlayerMoney(sc,playermoney[sc]);
}
SendClientMessage(sc,0xCECECEFF,"����������������������������");
if(playerzuzhi[sc]!=0)
{
playermoney[sc]=playermoney[sc]+1000;
ResetPlayerMoney(sc);
GivePlayerMoney(sc,playermoney[sc]);
}
playermoney[sc]=playermoney[sc]+800;
ResetPlayerMoney(sc);
GivePlayerMoney(sc,playermoney[sc]);
}
}
return 1;
}
//stock
stock strtok(const string[], &index)
{
	new	length = strlen(string);
	while ((index <	length)	&& (string[index] <= ' '))
	{
		index++;
	}
	new	offset = index;
	new	result[20];
	while ((index <	length)	&& (string[index] >	' ') &&	((index	- offset) <	(sizeof(result)	- 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
stock getINI(playerid)
{
	new	account[64];
	new	sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,	sendername,	sizeof(sendername));
	format(account,30,"Users/%s.ini",sendername);
	return account;
}
stock strreplace(string[], find, replace)
{
	for(new	i=0; string[i];	i++) {
		if(string[i] ==	find) {
			string[i] =	replace;
		}
	}
}
																																																																																																																																																																																																																																																															stock CreateRoadblock(Object,Float:x,Float:y,Float:z,Float:Angle)
{
	for(new	i =	0; i < sizeof(Roadblocks); i++)
	{
		if(Roadblocks[i][sCreated] == 0)
		{
			Roadblocks[i][sCreated]	= 1;
			Roadblocks[i][sX] =	x;
			Roadblocks[i][sY] =	y;
			Roadblocks[i][sZ] =	z-0.7;
			Roadblocks[i][sObject] = CreateDynamicObject(Object, x,	y, z-0.9, 0, 0,	Angle);
			return 1;
		}
	}
	return 0;
}
stock IsPlayerInWater(playerid) {
        new anim = GetPlayerAnimationIndex(playerid);
        if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
        return 0;
}

stock IsPlayerAiming(playerid) {
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
	(anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
        return 0;
}
stock DeleteAllRoadblocks(playerid)
{
	for(new	i =	0; i < sizeof(Roadblocks); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,	100, Roadblocks[i][sX],	Roadblocks[i][sY], Roadblocks[i][sZ]))
		{
			if(Roadblocks[i][sCreated] == 1)
			{
				Roadblocks[i][sCreated]	= 0;
				Roadblocks[i][sX] =	0.0;
				Roadblocks[i][sY] =	0.0;
				Roadblocks[i][sZ] =	0.0;
				DestroyDynamicObject(Roadblocks[i][sObject]);
			}
		}
	}
	return 0;
}
stock DeleteClosestRoadblock(playerid)
{
	for(new	i =	0; i < sizeof(Roadblocks); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,	5.0, Roadblocks[i][sX],	Roadblocks[i][sY], Roadblocks[i][sZ]))
		{
			if(Roadblocks[i][sCreated] == 1)
			{
				Roadblocks[i][sCreated]	= 0;
				Roadblocks[i][sX] =	0.0;
				Roadblocks[i][sY] =	0.0;
				Roadblocks[i][sZ] =	0.0;
				DestroyDynamicObject(Roadblocks[i][sObject]);
				return 1;
			}
		}
	}
	return 0;
}
stock strvalEx(	const string[] ) //	fix	for	strval-bug with	> 50 letters.
{
	// written by mabako in	less than a	minute :X
	if(	strlen(	string ) >=	50 ) return	0; // It will just return 0	if the string is too long
	return strval(string);
}
forward	SetPlayerSpawn(playerid);
public SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(playerput[playerid] == 0)
		{
			SetPlayerPos(playerid, 1.71875,	30.4062, 1200.34);
			SetPlayerInterior(playerid,1);
			SetPlayerFacingAngle(playerid, 280);
			RegistrationStep[playerid] = 1;
			SetTimerEx("SpawonDJ", 1000, 0,	"i", playerid);
			GivePlayerMoney(playerid,500);
		}
		return 1;
	}
//}
//return 1;
//}
	return 1;
}
forward	SpawonDJ(playerid);//BY	GTAYY
public SpawonDJ(playerid)//��������
{
	TogglePlayerControllable(playerid,0);
	return 1;
}
forward	split(const	strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
	new	i, li;
	new	aNum;
	new	len;
	while(i	<= strlen(strsrc)){
		if(strsrc[i]==delimiter	|| i==strlen(strsrc)){
			len	= strmid(strdest[aNum],	strsrc,	li,	i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}
forward	Aftersave(playerid);
public Aftersave(playerid)//�������˳�����BY Kiva_Ws
{
	if(KINI_Open(getINI(playerid)))	{
		KINI_WriteString("name",playername[playerid]);
		KINI_WriteString("mima",playermima[playerid]);
		KINI_WriteInt("money",playermoney[playerid]);
		KINI_WriteInt("zuzhi",playerzuzhi[playerid]);
		KINI_WriteInt("zuzhilv",playerzuzhilv[playerid]);
		KINI_WriteInt("car",playercar[playerid]);
		KINI_WriteInt("skin",playerskin[playerid]);
		KINI_WriteInt("lock",playerlock[playerid]);
		KINI_WriteInt("lock1",playerlock1[playerid]);
		KINI_WriteInt("lock2",playerlock2[playerid]);
		KINI_WriteInt("spawn",playerspawn[playerid]);
		KINI_WriteInt("jianyutime",playerjianyutime[playerid]);
		KINI_WriteInt("level",playerlv[playerid]);
		KINI_WriteInt("levelup",playerlvup[playerid]);
		KINI_WriteInt("gunzhizhao",playergunzhizhao[playerid]);
		for(new	w=0;w<7;w++)
		{
			KINI_WriteInt("wuqi",playerwuqi[playerid][w]);
		}
		KINI_WriteInt("inv1",playerinvwuqi[playerid][0]);
		KINI_WriteInt("inv2",playerinvwuqi[playerid][1]);
		KINI_WriteInt("inv3",playerinvwuqi[playerid][2]);
		KINI_WriteInt("inv4",playerinvwuqi[playerid][3]);
		KINI_WriteInt("inv5",playerinvwuqi[playerid][4]);
		KINI_WriteInt("inv6",playerinvwuqi[playerid][5]);
		KINI_WriteInt("inv7",playerinvwuqi[playerid][6]);
		KINI_WriteInt("carzhizhao",playercarzhizhao[playerid]);
		KINI_WriteInt("phone",playercall[playerid]);
		KINI_WriteInt("gunzhizhao",playergunzhizhao[playerid]);
		KINI_WriteInt("job",playerjob[playerid]);
		KINI_WriteInt("mats",playermats[playerid]);
		KINI_WriteInt("callmoney",playercallmoney[playerid]);
		KINI_WriteInt("sex",playersex[playerid]);
		KINI_WriteInt("age",playerage[playerid]);
		KINI_WriteInt("put",playerput[playerid]);
		KINI_WriteInt("sfz",playersfz[playerid]);
		KINI_WriteInt("adminlevel",playeradmin[playerid]);
		KINI_WriteInt("ircadminlevel",playerircadmin[playerid]);
		KINI_WriteInt("bankmoney",playerbank[playerid]);
  		KINI_WriteInt("ipad",playeripad[playerid]);
  		KINI_WriteInt("yanhua",playeryanhua[playerid]);
		KINI_Save();
		KINI_Close();
	}
	return 1;
}
forward	Duquplayer(playerid);
public Duquplayer(playerid)//��ȡ�������- -
{
	if(KINI_Open(getINI(playerid)))	{
		KINI_ReadString(playername[playerid],"name",20);
		playercar[playerid]	= KINI_ReadInt("car");
		playermoney[playerid] =	KINI_ReadInt("money");
		playerzuzhilv[playerid]	= KINI_ReadInt("zuzhilv");
		playerzuzhi[playerid] =	KINI_ReadInt("zuzhi");
		playerskin[playerid] = KINI_ReadInt("skin");
		playerlock[playerid] = KINI_ReadInt("lock");
		playerlock1[playerid] =	KINI_ReadInt("lock1");
		playerlock2[playerid] =	KINI_ReadInt("lock2");
		playerspawn[playerid] =	KINI_ReadInt("spawn");
		playerjianyutime[playerid] = KINI_ReadInt("jianyutime");
		playerlv[playerid] = KINI_ReadInt("level");
		playerlvup[playerid] = KINI_ReadInt("levelup");
		playergunzhizhao[playerid] = KINI_ReadInt("gunzhizhao");
		playersupernos[playerid] = KINI_ReadInt("supernos");
 		playerviplv[playerid] = KINI_ReadInt("viplv");
 		playervdou[playerid] = KINI_ReadInt("vdou");
 		playervipczz[playerid] = KINI_ReadInt("vipczz");
 		//playerjiedu[playerid] = KINI_ReadInt("jiedu");
 		//playerkouke[playerid] = KINI_ReadInt("kouke");
   		food1[playerid] = KINI_ReadInt("food1");
   		food2[playerid] = KINI_ReadInt("food2");
   		food3[playerid] = KINI_ReadInt("food3");
		for(new	i=0;i<7;i++)
		{
			playerwuqi[playerid][i]	= KINI_ReadInt("wuqi");
		}
		/*for(new	i=0;i<7;i++)
		{
			playerinvwuqi[playerid][i] = KINI_ReadInt("invwuqi");
		}*/
		playerinvwuqi[playerid][0] = KINI_ReadInt("inv1");
		playerinvwuqi[playerid][1] = KINI_ReadInt("inv2");
		playerinvwuqi[playerid][2] = KINI_ReadInt("inv3");
		playerinvwuqi[playerid][3] = KINI_ReadInt("inv4");
		playerinvwuqi[playerid][4] = KINI_ReadInt("inv5");
		playerinvwuqi[playerid][5] = KINI_ReadInt("inv6");
		playerinvwuqi[playerid][6] = KINI_ReadInt("inv7");
		playercarzhizhao[playerid] = KINI_ReadInt("carzhizhao");
		playercall[playerid] = KINI_ReadInt("phone");
		playerjob[playerid]	= KINI_ReadInt("job");
		playermats[playerid] = KINI_ReadInt("mats");
		playerbank[playerid] = KINI_ReadInt("bank");
		playersex[playerid]	= KINI_ReadInt("sex");
		playerage[playerid]	= KINI_ReadInt("age");
		playersfz[playerid]	= KINI_ReadInt("sfz");
		playerput[playerid]	= KINI_ReadInt("put");
		playeradmin[playerid] =	KINI_ReadInt("adminlevel");
		playercallmoney[playerid] = KINI_ReadInt("callmoney");
		playerircadmin[playerid] =	KINI_ReadInt("ircadminlevel");
		playerbank[playerid] =	KINI_ReadInt("bankmoney");
  		playeripad[playerid] = KINI_ReadInt("ipad");
   		hzxtnqyw[playerid] = KINI_ReadInt("hzxtnqyw");
   		hzxtjcxqn[playerid] = KINI_ReadInt("hzxtjcxqn");
   		hzxtwnzy[playerid] = KINI_ReadInt("hzxtwnzy");
   		hzxtcdqc[playerid] = KINI_ReadInt("hzxtcdqc");
   		hzxtycwg[playerid] = KINI_ReadInt("hzxtycwg");
   		hzxtfkdg[playerid] = KINI_ReadInt("hzxtfkdg");
   		playeryanhua[playerid] = KINI_ReadInt("yanhua");
		KINI_Close();
	}
	return 1;
}
forward	Onplayerregister(playerid, inputtext[]);
public Onplayerregister(playerid, inputtext[])//�����ע���- -
{
	new	msg[128];
	new	SFZIDB=330000000000000000;
	new	sfzid;
 new	sdi;
 SL[playerid]=1;
	format(playermima[playerid],128,"%s",inputtext);
	playerzuzhi[playerid]=0;
	playerzuzhilv[playerid]=0;
	format(msg,128,"��ɹ��İ��������֤,���Ϊ:%d,����Ϊ:%s .ϣ�����ܹ������ҵ��й��ĵķ��ɷ���",playersfz[playerid],playername[playerid]);
 format(msg,128,"�����������������8500Ԫ�ʽ�,����5000Ԫ��������������˻���.��ע�����.");
 liaotiantext[playerid]=Create3DTextLabel("R	C R	P Y M T",0xF8F8FFFF,30.0,40.0,50.0,15.0,0);
	SendClientMessage(playerid,	0xFFFF00AA,	msg);
	SetSpawnInfo(playerid,0,0,zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],zuzhichushenga[playerzuzhi[playerid]],0,0,0,0,0,0);
	SetPlayerInterior(playerid,zuzhichushenghj[playerzuzhi[playerid]]);
	SpawnPlayer(playerid);
	sdi = GetPlayerPing(playerid);//���֤
	sfzid = playercall[playerid]+SFZIDB+sdi;//���֤
	playersfz[playerid] = sfzid+1;//���֤
 playermoney[playerid]=8500;
    //playerjiedu[playerid]=20;
    //playerkouke[playerid]=20;
	playerbank[playerid]=5000;
 SetPlayerColor(playerid,0xF8F8FF00);
	SetPlayerScore(playerid,playerlv[playerid]);
	GivePlayerMoney(playerid,playermoney[playerid]);
	new	msgg[128];
	new	name[128];
	GetPlayerName(playerid,name,128);
	format(msgg,128,"[ID:%d]%s�������뾳����",playerid,name);
	ABroadCast(0x98FB98FF,msgg,1);
 if(playerskin[playerid]==0)
 {
 SendClientMessage(playerid, COLOR_LIGHTRED, "[ϵͳ��ʾ]:��ӭ�����ҵ��й��ģ��㱻�͵�����ֽ��л����Ǽ�.");
 SendClientMessage(playerid, COLOR_GREY, "���!��ӭ�����������ģ����������㼸������.");
 SendClientMessage(playerid, COLOR_LIGHTRED, "��ʾ: ����������д!���ǲ���й¶������ϵ�!");
 new listitems[] = "{FF0000}��\n{FF00FF}Ů";
 ShowPlayerDialog(playerid,8525,DIALOG_STYLE_LIST,"����Ա�:",listitems,"ȷ��","ȡ��");
 return 1;
 }
 playerskin[playerid]=zuzhiskin[playerzuzhi[playerid]][random(5)];
	SetPlayerSkin(playerid,playerskin[playerid]);
	return 1;
}
forward	Onplayerlogin(playerid,	inputtext[]);
public Onplayerlogin(playerid, inputtext[])//����ҵ�½��- -
{
	if(IsPlayerNPC(playerid)){	 return	1;}
	if(KINI_Open(getINI(playerid)))	{
		KINI_ReadString(playermima[playerid],"mima",20);
		Duquplayer(playerid);
		if(strcmp(playermima[playerid],inputtext)==0)
		{
			new	msg[128];
			SL[playerid]=1;
            PlayerPlaySound(playerid,1186,0.0,0.0,0.0);
			format(msg,128,"===================================================================");
			SendClientMessage(playerid,	0x008040FF,	msg);
			format(msg,128,"��ӭ�ص��ҵ��й���~{FF0000} %s (%d)",playername[playerid],playerid,SCRIPT_VERSION);
			SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			format(msg,128,"[��Ǯ]:%d [�ȼ�]:%d	[��֯]:%s [����]:%d [����]:%s [���]:%d [VIP�ȼ�]:%d [V�����]:%d",playermoney[playerid],playerlv[playerid],zuzhiname[playerzuzhi[playerid]],playermats[playerid],gongzuoname[playerjob[playerid]],playerbank[playerid],playerviplv[playerid],playervdou[playerid]);
			SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			//format(msg,128,"[����]:%d [�ڿ�]:%d",playerjiedu[playerid],playerkouke[playerid]);
			//SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			SendClientMessage(playerid,	0xFFFFFFFF,	"��ϸ������ʹ��'/stats'�鿴��лл��");
			if(playeradmin[playerid]>=1)
			{
				format(msg,128,"����½�� %d �������Ա�˻�.",playeradmin[playerid]);
				SendClientMessage(playerid,	0x008040FF,	msg);
			}
			if(playerviplv[playerid]>=1)
			{
				format(msg,128,"����½�� %d ��VIP�˻�.",playerviplv[playerid]);
				SendClientMessage(playerid,	0x008040FF,	msg);

			}
			format(msg,128,"===================================================================");
			SendClientMessage(playerid,	0x008040FF,	msg);
		    //kouchujike[playerid] = SetTimerEx("koujike",240000,1,"d",playerid);
			ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"�˴θ���:","{FF0000}�ҵ��й��ģ�ǿ�ƹ��������н��գ�һ·���㣡","����","");
			TextDrawShowForPlayer(playerid,	Textdraw51[playerid]);
			liaotiantext[playerid]=Create3DTextLabel(" ",0xF8F8FFFF,30,40,50,15,0);
   if(playerzuzhi[playerid]==0)
			{
				SetSpawnInfo(playerid,0,playerskin[playerid],zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],zuzhichushenga[playerzuzhi[playerid]],0,0,0,0,0,0);
				SetPlayerInterior(playerid,0);
			}
			if(playerzuzhi[playerid]>=1)
			{
				SetSpawnInfo(playerid,0,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]],zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],zuzhichushenga[playerzuzhi[playerid]],0,0,0,0,0,0);
				SetPlayerInterior(playerid,zuzhichushenghj[playerzuzhi[playerid]]);
			}
			SpawnPlayer(playerid);
			SetPlayerColor(playerid,0xF8F8FF00);
			SetPlayerScore(playerid,playerlv[playerid]);
			GivePlayerMoney(playerid,playermoney[playerid]);
			for(new	i=0;i<7;i++)
			{
				GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],11111111111111);
			}
			new	name1[128];
			GetPlayerName(playerid,name1,128);
			for(new	i=0;i<7;i++)
			{
				new	wid=playerwuqi[playerid][i];
				if(playerwuqi[playerid][i]!=0&&playergunzhizhao[playerid]==0&&wid!=0&&wid!=46&&wid!=41&&wid!=43&&wid!=42&&wid!=1&&wid!=2&&wid!=3&&wid!=4&&wid!=5&&wid!=6&&wid!=7&&wid!=8&&wid!=9&&wid!=14&&wid!=10&&wid!=11&&wid!=12&&wid!=13&&wid!=15)
				{
					if(su[playerid]<10)
					{
//su[playerid]=su[playerid]+1;
					}
//format(msg,128,"|+ͨ��+|%s��ͨ����,ͨ���ȼ�:%d,����:�Ƿ�Я��ǹ֧",name1,su[playerid]);
//AdminXX(3,msg,COLOR_RED);
//format(msg,128,"�����ڷǷ�Я��ǹ֧���Ա�ͨ���ˣ�Ŀǰͨ���ȼ�:%d",su[playerid]);
//SendClientMessage(playerid,COLOR_RED,msg);
				}
				GivePlayerWeaponEx(playerid,playerwuqi[playerid][i],11111111111111);
			}
			new	msgg[128];
			new name[128];
			if(playerviplv[playerid]>=1)
			{
		        new ak[128];
			    GetPlayerName(playerid,name,128);
				format(ak,128,"����VIP:%s �������й���С��.",name);
				SendClientMessageToAll(0xFFFF00AA,ak);
				SetPlayerColor(playerid,COLOR_RED);
			}
			else
			{
                GetPlayerName(playerid,name,128);
			    format(msgg,128,"[ID:%d]%s �������й���С��.",playerid,name);
	            SendClientMessageToAll(0xFFFF00AA,msgg);
			}

			if(playerspawn[playerid]==0)
			{
				SetPlayerPos(playerid,zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]]);
				SetPlayerInterior(playerid,zuzhichushenghj[playerzuzhi[playerid]]);
				houseid[playerid]=zuzhichushengid[playerzuzhi[playerid]];
			}
			if(playerspawn[playerid]==1)
			{
				SetPlayerPos(playerid,ZFJGCX[playerlock[playerid]],ZFJGCY[playerlock[playerid]],ZFJGCZ[playerlock[playerid]]);
				SetPlayerInterior(playerid,ZFJGHID[playerlock[playerid]]);
				houseid[playerid]=playerlock[playerid];
			}
			if(playerspawn[playerid]==2)
			{
				SetPlayerPos(playerid,ZFJGCX[playerlock1[playerid]],ZFJGCY[playerlock1[playerid]],ZFJGCZ[playerlock1[playerid]]);
				SetPlayerInterior(playerid,ZFJGHID[playerlock1[playerid]]);
				houseid[playerid]=playerlock1[playerid];
			}
			if(playerspawn[playerid]==3)
			{
				SetPlayerPos(playerid,ZFJGCX[playerlock2[playerid]],ZFJGCY[playerlock2[playerid]],ZFJGCZ[playerlock2[playerid]]);
				SetPlayerInterior(playerid,ZFJGHID[playerlock2[playerid]]);
				houseid[playerid]=playerlock2[playerid];
			}
			return 1;
		}
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"����","�����������������!","��¼","�˳�");
		return 1;
	}
	return 1;
}
																																																																																																																																																																																																																																																															ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
			new	Float:posx,	Float:posy,	Float:posz;
			new	Float:oldposx, Float:oldposy, Float:oldposz;
			new	Float:tempposx,	Float:tempposy,	Float:tempposz;
			GetPlayerPos(playerid, oldposx,	oldposy, oldposz);
			for(new	i =	0; i < MAX_PLAYERS;	i++) {
				if(IsPlayerConnected(i)) {
					GetPlayerPos(i,	posx, posy,	posz);
					tempposx = (oldposx	-posx);
					tempposy = (oldposy	-posy);
					tempposz = (oldposz	-posz);
					if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))	{
						if (((tempposx < radi/16) && (tempposx > -radi/16))	&& ((tempposy <	radi/16) &&	(tempposy >	-radi/16)) && ((tempposz < radi/16)	&& (tempposz > -radi/16))) {
							SendClientMessage(i, col1, string);
						}
						else if	(((tempposx	< radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy	> -radi/8))	&& ((tempposz <	radi/8)	&& (tempposz > -radi/8))) {
							SendClientMessage(i, col2, string);
						}
						else if	(((tempposx	< radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy	> -radi/4))	&& ((tempposz <	radi/4)	&& (tempposz > -radi/4))) {
							SendClientMessage(i, col3, string);
						}
						else if	(((tempposx	< radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy	> -radi/2))	&& ((tempposz <	radi/2)	&& (tempposz > -radi/2))) {
							SendClientMessage(i, col4, string);
						}
						else if	(((tempposx	< radi)	&& (tempposx > -radi)) && ((tempposy < radi) &&	(tempposy >	-radi))	&& ((tempposz <	radi) && (tempposz > -radi))) {
							SendClientMessage(i, col5, string);
						}
					}
				}
			}
	}
	return 1;
}
forward	ABroadCast(color,const string[],level);
public ABroadCast(color,const string[],level)
{
	for(new	i =	0; i < MAX_PLAYERS;	i++)
	{
		if(IsPlayerConnected(i))
		{
			if (playeradmin[i] >= level	|| IsPlayerAdmin(i))
			{
				//if(ViewAdmin[i] == 1)
				//{
					//if(PlayerInfo[i][pAdminDuty] == 1	|| UcAdmin[i] == 1)
					//{
				SendClientMessage(i, color,	string);
					//}
				//}
			}
		}
	}
	printf("%s", string);
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if (SL[playerid] ==	0)
	{
		//SetPlayerPos(playerid,	15.3637, -4573.9014, 27.4383);
		SetPlayerCameraPos(playerid, -2203.6138,2346.5046,55.8927);
		SetPlayerCameraLookAt(playerid,	-2475.8545,2425.1589,51.2561);
		SetPlayerPos(playerid,	-2379.9106,2449.3259,18.2168);

			new	msg[128];
			GetPlayerName(playerid,playername[playerid],128);
			format(msg,128,getINI(playerid),playername[playerid]);
			if (fexist(getINI(playerid))==0)
			{
				format(playermima[playerid],128,"");
				playercar[playerid]=0;
				playermoney[playerid]=0;
				playerzuzhi[playerid]=0;
				playerzuzhilv[playerid]=0;
				playerskin[playerid]=0;
				playerlock[playerid]=0;
				playerlock1[playerid]=0;
				playerlock2[playerid]=0;
				playerspawn[playerid]=0;
				playerlv[playerid]=1;
				playerlvup[playerid]=0;
				playerjob[playerid]=0;
				playermats[playerid]=0;
				playerbank[playerid]=0;
				playerviplv[playerid]=0;
				//playerjiedu[playerid]=0;
				KillSpawn[playerid]	= false;
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"��ӭ�����ҵ��й���","����������ע�������ʺ�!","ע��","�˳�");
				return 1;
			}

		SendClientMessage(playerid, 0x99FFFFAA, "������ϣ��Ͽ��������������Ϸ�ɣ�");
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"��ӭ�����ҵ��й���","��������������,������Ϸ��!","��¼","�˳�");
			return 1;
	}
	else
	{
		SpawnPlayer(playerid);
	}
	return false;
}
																																																																																																																																																																																																																																																															forward	PlayerToPoint(Float:radi, playerid,	Float:x, Float:y, Float:z);
																																																																																																																																																																																																																																																															public PlayerToPoint(Float:radi, playerid, Float:x,	Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
			new	Float:oldposx, Float:oldposy, Float:oldposz;
			new	Float:tempposx,	Float:tempposy,	Float:tempposz;
			GetPlayerPos(playerid, oldposx,	oldposy, oldposz);
			tempposx = (oldposx	-x);
			tempposy = (oldposy	-y);
			tempposz = (oldposz	-z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
			if (((tempposx < radi) && (tempposx	> -radi)) && ((tempposy	< radi)	&& (tempposy > -radi)) && ((tempposz < radi) &&	(tempposz >	-radi)))
			{
				return 1;
			}
	}
	return 0;
}
public WeatherAndTime()
{
	//new	rwt	= random(sizeof	RandomWorldTime);
	//SetWorldTime(RandomWorldTime[rwt][0]);
	//new	rw = random(sizeof RandomWeather);
	//SetWeather(RandomWeather[rw][0]);
}
forward	OtherTimer();
public OtherTimer()
{
	new	string[128];
	for(new	i =	0; i < MAX_PLAYERS;	i++)
	{
		if(IsPlayerConnected(i))
		{
				new	Float:armor;
				GetPlayerArmour(i, armor);
				if(armor > 0.0 )
				{
					SetPlayerAttachedObject( i,	ATTACH_ARMOR, 373, 1, 0.286006,	-0.038657, -0.158132, 67.128456, 21.916156,	33.972290, 1.000000, 1.000000, 1.000000	);
				}
				else if( armor == 0.0 && IsPlayerAttachedObjectSlotUsed(i, ATTACH_ARMOR))
				{
					RemovePlayerAttachedObject(i, ATTACH_ARMOR);
				}
				format(string, sizeof(string),"$%d",playerbank[i]);
				TextDrawSetString(Textdraw51[i], string);
		}
	}
	return 1;
}
public IsAtBlueBusStop(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,2868.9033,-1416.4062,11.0131) ||	IsPlayerInRangeOfPoint(playerid,2.0,2636.3242,-1693.125,10.9544) ||	IsPlayerInRangeOfPoint(playerid,2.0,2649.0073,-1710.6044,11.1854)
		|| IsPlayerInRangeOfPoint(playerid,2.0,2243.8457,-1725.9121,13.5960) ||	IsPlayerInRangeOfPoint(playerid,2.0,2252.8876,-1738.8710,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1948.3310,-1454.3525,13.5960)
		|| IsPlayerInRangeOfPoint(playerid,2.0,1926.4199,-1472.3593,13.6260) ||	IsPlayerInRangeOfPoint(playerid,2.0,1571.0644,-2188.0107,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1712.9423,-1818.7148,13.6260))
		{
			return 1;
		}
	}
	return 0;
}
public IsAtBlackBusStop(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,1567.0966,-1725.4755,13.6260) ||	IsPlayerInRangeOfPoint(playerid,2.0,1544.9990,-1739.0458,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1503.9716,-1027.7617,23.7701)
		|| IsPlayerInRangeOfPoint(playerid,2.0,1440.3242,-1040.7060,23.9073) ||	IsPlayerInRangeOfPoint(playerid,2.0,1188.8359,-1354.6279,13.6483) || IsPlayerInRangeOfPoint(playerid,2.0,1212.8427,-1327.8398,13.6470)
		|| IsPlayerInRangeOfPoint(playerid,2.0,861.7125,-1313.3009,13.6260)	|| IsPlayerInRangeOfPoint(playerid,2.0,850.6757,-1333.9707,13.6153)	|| IsPlayerInRangeOfPoint(playerid,2.0,393.6944,-1766.2702,5.6197)
		|| IsPlayerInRangeOfPoint(playerid,2.0,1705.5898,-1805.8476,13.5300))
		{
			return 1;
		}
	}
	return 0;
}
public ResetView(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	SetPlayerInterior(playerid,	1);
	SetPlayerPos(playerid, Playerx[playerid], Playery[playerid], Playerz[playerid]);
	SetPlayerFacingAngle(playerid, Playera[playerid]);
	SetPlayerSkin(playerid,	PlayerSkin[playerid]);
	SetCameraBehindPlayer(playerid);
	if(PlayerSitting[playerid] == 1)
	{
		ApplyAnimation(playerid,"PED","SEAT_idle",30.0,1,0,0,0,0);
	}
	Playerx[playerid] =	0;
}
public CPOff(playerid)
{
	DisablePlayerCheckpoint(playerid);
}
/*forward	CheckPlayerName(const name[]);
CheckPlayerName(const name[]) // by	Luk0r
{
	if (strlen(name) < 6) return 0;
	if (strfind(name, "_", true) ==	-1)	return 0;
	new	underscorecount, expectinguppercase	= 1;
	for	(new i = 0,	j =	strlen(name); i	< j; i++)
	{
		if (expectinguppercase == 1)
		{
			if (name[i]	< 'a' || name[i] > 'z')	return 0;
			expectinguppercase = 0;
			continue;
		}
		switch (name[i])
		{
			case '_':
				{
					if (underscorecount	== 1) return 0;
					else
					{
						underscorecount	= 1;
						expectinguppercase = 1;
					}
					continue;
				}
			case 'A' ..	'Z': continue;
			case 'a' ..	'z': continue;
			default: return	0;
		}
	}
	return 1;
}
*/




/*public cj()
{
GameTextForAll("~w~3 ~r~Three", 5000, 3 );
KillTimer(shu1);
}

public cj2()
{
GameTextForAll("~w~2 ~r~Two", 5000, 3 );
KillTimer(shu2);
}

public cj3()
{
GameTextForAll("~w~1 ~r~One", 5000, 3 );
KillTimer(shu3);
}

public cj4()
{
GameTextForAll("~g~G~w~O!!!", 5000, 3 );
KillTimer(shu4);
}*/


//===================================================================================================
//											  Functions
//===================================================================================================
stock LoadCameras()
{
	new	file[64];
	for(new	i =	0;i<CAMERA_LIMIT;i++)
	{
		format(file,sizeof file,"/SpeedCameras/%i.cfg",i);
		if(fexist(file))
		{
			INI_ParseFile(file,"LoadCam",.bExtra = true,.extra = i);
#if	STREAMER_ENABLED ==	true
			SpeedCameras[i][_objectid] = STREAMER_ADD(18880,SpeedCameras[i][_x],SpeedCameras[i][_y],SpeedCameras[i][_z],0,0,SpeedCameras[i][_rot]);
#else
			SpeedCameras[i][_objectid] = CreateObject(18880,SpeedCameras[i][_x],SpeedCameras[i][_y],SpeedCameras[i][_z],0,0,SpeedCameras[i][_rot]);
#endif
			SpeedCameras[i][_active] = true;
			if(SpeedCameras[i][_activelabel] ==	true)
			{
				SpeedCameras[i][_label]	= AttachLabelToCamera(i,SpeedCameras[i][_labeltxt]);
			}
			loaded_cameras++;
		}
	}
	printf("�ɹ���ȡ %i �����ٱ�.",loaded_cameras);
}
forward	LoadCam(cameraid,name[],value[]);
public LoadCam(cameraid,name[],value[])
{
	INI_Float("_x",SpeedCameras[cameraid][_x]);
	INI_Float("_y",SpeedCameras[cameraid][_y]);
	INI_Float("_z",SpeedCameras[cameraid][_z]);
	INI_Float("_rot",SpeedCameras[cameraid][_rot]);
	INI_Int("_range",SpeedCameras[cameraid][_range]);
	INI_Int("_limit",SpeedCameras[cameraid][_limit]);
	INI_Int("_fine",SpeedCameras[cameraid][_fine]);
	INI_Int("_usemph",SpeedCameras[cameraid][_usemph]);
	INI_Bool("_activelabel",SpeedCameras[cameraid][_activelabel]);
	INI_String("_labeltxt",SpeedCameras[cameraid][_labeltxt],128);
	return 1;
}
stock RemoveCameras()
{
	for(new	i =	0;i<loaded_cameras +1;i++)
	{
		if(SpeedCameras[i][_active]	== true)
		{
#if	STREAMER_ENABLED ==	true
			STREAMER_REMOVE(SpeedCameras[i][_objectid]);
#else
			DestroyObject(SpeedCameras[i][_objectid]);
#endif
			if(SpeedCameras[i][_activelabel] ==	true)
			{
				Delete3DTextLabel(SpeedCameras[i][_label]);
			}
		}
	}
	return 1;
}
stock generate_id()
{
	new	file[64];
	for(new	i =	0;i<CAMERA_LIMIT;i++)
	{
		format(file,sizeof file,"/SpeedCameras/%i.cfg",i);
		if(!fexist(file)) return i;
	}
	return -1;
}
stock CreateSpeedCam(Float:x,Float:y,Float:z,Float:rot,range,limit,fine,use_mph	= 0)
{
		new	newid =	generate_id();
		if(newid ==	-1)
		{
			print("gSpeedcam: ERROR! Cannot	create speedcam, max ammount of	speedcameras has been reached!");
			return 1;
		}
		if (newid == loaded_cameras	|| newid > loaded_cameras)
		{
			loaded_cameras++;
		}
		SpeedCameras[newid][_x]	= x;
		SpeedCameras[newid][_y]	= y;
		SpeedCameras[newid][_z]	= z;
		SpeedCameras[newid][_rot] =	rot;
		SpeedCameras[newid][_range]	= range;
		SpeedCameras[newid][_limit]	= limit;
		SpeedCameras[newid][_fine] = fine;
		SpeedCameras[newid][_usemph] = use_mph;
	#if	STREAMER_ENABLED ==	true
		SpeedCameras[newid][_objectid] = STREAMER_ADD(18880,x,y,z,0,0,rot);
	#else
		SpeedCameras[newid][_objectid] = CreateObject(18880,x,y,z,0,0,rot);
	#endif
		SpeedCameras[newid][_active] = true;
		SpeedCameras[newid][_activelabel] =	false;
		SpeedCameras[newid][_labeltxt] = 0;
		new	file[64];format(file,sizeof	file,"/SpeedCameras/%i.cfg",newid);
		new	INI:handler	= INI_Open(file);
		INI_WriteFloat(handler,"_x",SpeedCameras[newid][_x]);
		INI_WriteFloat(handler,"_y",SpeedCameras[newid][_y]);
		INI_WriteFloat(handler,"_z",SpeedCameras[newid][_z]);
		INI_WriteFloat(handler,"_rot",SpeedCameras[newid][_rot]);
		INI_WriteInt(handler,"_range",SpeedCameras[newid][_range]);
		INI_WriteInt(handler,"_limit",SpeedCameras[newid][_limit]);
		INI_WriteInt(handler,"_fine",SpeedCameras[newid][_fine]);
		INI_WriteInt(handler,"_usemph",SpeedCameras[newid][_usemph]);
		INI_WriteBool(handler,"_activelabel",SpeedCameras[newid][_activelabel]);
		INI_WriteString(handler,"_labeltxt",SpeedCameras[newid][_labeltxt]);
		INI_Close(handler);
		return newid;
}
stock SaveCamera(cameraid)
{
		new	file[64];format(file,sizeof	file,"/SpeedCameras/%i.cfg",cameraid);
		new	INI:handler	= INI_Open(file);
		INI_WriteFloat(handler,"_x",SpeedCameras[cameraid][_x]);
		INI_WriteFloat(handler,"_y",SpeedCameras[cameraid][_y]);
		INI_WriteFloat(handler,"_z",SpeedCameras[cameraid][_z]);
		INI_WriteFloat(handler,"_rot",SpeedCameras[cameraid][_rot]);
		INI_WriteInt(handler,"_range",SpeedCameras[cameraid][_range]);
		INI_WriteInt(handler,"_limit",SpeedCameras[cameraid][_limit]);
		INI_WriteInt(handler,"_fine",SpeedCameras[cameraid][_fine]);
		INI_WriteInt(handler,"_usemph",SpeedCameras[cameraid][_usemph]);
		INI_WriteBool(handler,"_activelabel",SpeedCameras[cameraid][_activelabel]);
		INI_WriteString(handler,"_labeltxt",SpeedCameras[cameraid][_labeltxt]);
		INI_Close(handler);
}
stock DestroySpeedCam(cameraid)
{
	SpeedCameras[cameraid][_active]	= false;
#if	STREAMER_ENABLED ==	true
	STREAMER_REMOVE(SpeedCameras[cameraid][_objectid]);
#else
	DestroyObject(SpeedCameras[cameraid][_objectid]);
#endif
	if(SpeedCameras[cameraid][_activelabel]	== true)
	{
		Delete3DTextLabel(SpeedCameras[cameraid][_label]);
	}
	SpeedCameras[cameraid][_activelabel] = false;
	SpeedCameras[cameraid][_labeltxt] =	0;
	new	file[64];format(file,sizeof	file,"/SpeedCameras/%i.cfg",cameraid);
	if(fexist(file)){fremove(file);}
	return 1;
}
stock SetSpeedCamRange(cameraid,limit)
{
	SpeedCameras[cameraid][_limit] = limit;
	return 1;
}
stock SetSpeedCamFine(cameraid,fine)
{
	SpeedCameras[cameraid][_fine] =	fine;
	return 1;
}

stock Float:GetDistanceBetweenPoints(Float:x,Float:y,Float:tx,Float:ty)
{
		new	Float:temp1, Float:temp2;
		temp1 =	x-tx;temp2 = y-ty;
		return floatsqroot(temp1*temp1+temp2*temp2);
}
stock GetClosestCamera(playerid)
{
		new	Float:distance = 10,Float:temp,Float:x,Float:y,Float:z,current = -1;GetPlayerPos(playerid,x,y,z);
		for(new	i =	0;i<loaded_cameras +1;i++)
		{
			if(SpeedCameras[i][_active]	== true)
			{
				temp = GetDistanceBetweenPoints(x,y,SpeedCameras[i][_x],SpeedCameras[i][_y]);
				if(temp	< distance)
				{
					distance = temp;
					current	= i;
				}
			}
		}
		return current;
}
stock SendClientMessageEx(playerid,color,type[],{Float,_}:...)
{
	new	string[128];
	for(new	i =	0;i<numargs() -2;i++)
	{
		switch(type[i])
		{
			case 's':
				{
					new	result[128];
					for(new	a= 0;getarg(i +3,a)	!= 0;a++)
					{
						result[a] =	getarg(i +3,a);
					}
					if(!strlen(string))
					{
						format(string,sizeof string,"%s",result);
					} else format(string,sizeof	string,"%s%s",string,result);
				}
			case 'i':
				{
					new	result = getarg(i +3);
					if(!strlen(string))
					{
						format(string,sizeof string,"%i",result);
					} else format(string,sizeof	string,"%s%i",string,result);
				}
			case 'f':
				{
						new	Float:result = Float:getarg(i +3);
						if(!strlen(string))
						{
							format(string,sizeof string,"%f",result);
						} else format(string,sizeof	string,"%s%f",string,result);
				}
		}
	}
	SendClientMessage(playerid,color,string);
	return 1;
}
forward	UpdateCameras();
public UpdateCameras()
{
	for(new	a =	0;a<MAX_PLAYERS;a++)
	{
		if(!IsPlayerConnected(a)) continue;
		if(!IsPlayerInAnyVehicle(a)) continue;
		if(GetPVarInt(a,"PlayerHasBeenFlashed")	== 1)
		{
			continue;
		} else if (GetPVarInt(a,"PlayerHasBeenFlashed")	== 2)
		{
			DeletePVar(a,"PlayerHasBeenFlashed");
			continue;
		}
		for(new	b =	0;b<loaded_cameras +1;b++)
		{
			if(SpeedCameras[b][_active]	== false) continue;
			if(IsPlayerInRangeOfPoint(a,SpeedCameras[b][_range],SpeedCameras[b][_x],SpeedCameras[b][_y],SpeedCameras[b][_z]))
			{
				new	speed =	floatround(GetVehicleSpeed(GetPlayerVehicleID(a),SpeedCameras[b][_usemph]));
				new	limit =	SpeedCameras[b][_limit];
				if(speed > limit)
				{
						TextDrawShowForPlayer(a,flash);
	#if	CAMERA_PERSPECTIVE == true
						SetPlayerCameraPos(a,SpeedCameras[b][_x],SpeedCameras[b][_y],SpeedCameras[b][_z] + 5);
						new	Float:x,Float:y,Float:z;GetPlayerPos(a,x,y,z);
						SetPlayerCameraLookAt(a,x,y,z);
	#endif
						SetPVarInt(a,"PlayerHasBeenFlashed",1);
						SetTimerEx("RemoveFlash",CAMERA_FLASH_TIME,false,"i",a);
						if(GetPlayerState(a) ==	PLAYER_STATE_DRIVER)
						{
							if(SpeedCameras[b][_usemph]	== 0)
							{
								SendClientMessageEx(a,0xFF1E00FF,"sisis","���ʻ�ٶȴﵽ ",speed,"km/h	�㳬����,���������,��������Ϊ	",limit, "km/h.");
								SendClientMessageEx(a,0xFF1E00FF,"sis","���γ��ٷ��� $",SpeedCameras[b][_fine],".");
							 //SendClientMessageEx(a,0xFF1E00FF,"sis"," ���Ѿ��ۼƷ��� $",Account[a][_fine],",�뾡��ȥ���ִ��ڽ��ɷ����Ա�����ձ�����/payfine.");
       } else {
								SendClientMessageEx(a,0xFF1E00FF,"sisis","���ʻ�ٶȴﵽ ",speed,"mp/h	�㳬����,���������,��������Ϊ	",limit, "mp/h.");
								SendClientMessageEx(a,0xFF1E00FF,"sis","���γ��ٷ��� $",SpeedCameras[b][_fine],".");
							 //SendClientMessageEx(a,0xFF1E00FF,"sis"," ���Ѿ��ۼƷ��� $",Account[a][_fine],",�뾡��ȥ���ִ��ڽ��ɷ����Ա�����ձ�����/payfine.");
       }
							//GivePlayerMoney(a, - SpeedCameras[b][_fine]);
							if (playerbank[a] <= SpeedCameras[b][_fine])
							{
							new tjmsg[256];
							new name1[256];
							SendClientMessage(a,0x00FF00AA,"������д���Ѿ������Խ��ɷ���㱻ͨ����!");
							GetPlayerName(a,name1,256);
							su[a]=su[a]+1;
							format(tjmsg,128,"[ͨ��]%s��ͨ���ˣ�ͨ���ȼ�:%d,����:���д����Խ��ɽ�ͨ����!",name1,su[a]);
							AdminXX(3,tjmsg,0x00FF00AA);
							}
							else
							{
							playerbank[a] = playerbank[a]- SpeedCameras[b][_fine];
							}
						}
				}
			}
		}
	}
}

forward	BAOCUNACCOUNT();
public BAOCUNACCOUNT()
{
	if(fexist("ZFJG.cfg")==1)
	{
		fremove("ZFJG.cfg");
	}

	new	File:ZFJGtxt=fopen("ZFJG.cfg",io_write);
	new	msgg[128];
	for(new	i=0;i<999;i++)
	{
	if(ZFJGLX[i]==1)
	{
		format(msgg,128,"%d	%d %s %d %f	%f %f %f %f	%f %d\n",ZFJGLX[i],ZFJGTID[i],ZFJGSTR[i],ZFJGHID[i],ZFJGX[i],ZFJGY[i],ZFJGZ[i],ZFJGCX[i],ZFJGCY[i],ZFJGCZ[i],ZFJGLOCALHID[i]);
		fwrite(ZFJGtxt,msgg);
	}
	if(ZFJGLX[i]==2)
	{
		format(msgg,128,"%d	%d %s %s %d	%f %f %f\n",ZFJGLX[i],ZFJGTID[i],ZFJGSTR[i],ZFJGSTR1[i],ZFJGHID[i],ZFJGX[i],ZFJGY[i],ZFJGZ[i]);
		fwrite(ZFJGtxt,msgg);
	}
	if(ZFJGLX[i]==3)
	{
		format(msgg,128,"%d	%d %s %s %d	%f %f %f %f	%f %f %d %d	%d %d\n",ZFJGLX[i],ZFJGTID[i],ZFJGSTR[i],ZFJGSTR1[i],ZFJGHID[i],ZFJGX[i],ZFJGY[i],ZFJGZ[i],ZFJGCX[i],ZFJGCY[i],ZFJGCZ[i],ZFJGMONEY[i],ZFJGLOCK[i],ZFJGZJ[i],ZFJGLV[i]);
		fwrite(ZFJGtxt,msgg);
	}
	if(ZFJGLX[i]==4)
	{
		format(msgg,128,"%d	%d %s %d %f	%f %f %f %f	%f %d %d\n",ZFJGLX[i],ZFJGTID[i],ZFJGSTR[i],ZFJGHID[i],ZFJGX[i],ZFJGY[i],ZFJGZ[i],ZFJGCX[i],ZFJGCY[i],ZFJGCZ[i],ZFJGZUZHI[i],ZFJGLOCK[i]);
		fwrite(ZFJGtxt,msgg);
	}
	}
	fclose(ZFJGtxt);
    if(fexist("CAR.cfg")==1)
	{
		fremove("CAR.cfg");
	}
	new	File:cartxt=fopen("CAR.cfg",io_write);

	for(new	i=1;i<999;i++)
	{
		new	msg[128];
		if(car[i]!=0)
		{
			format(msg,128,"%d %d %f %f	%f %f %d %d	%s %d %d %d	%d %d %d %d	%d %d %d %d	%d %d\n",carzuzhi[i],carmoxing[i],carx[i],cary[i],carz[i],carmianxiang[i],carcolor1[i],carcolor2[i],carname[i],carmoney[i],cargzbc[i],cargz[i][0],cargz[i][1],cargz[i][2],cargz[i][3],cargz[i][4],cargz[i][5],cargz[i][6],cargz[i][7],cargz[i][8],cargz[i][9],carfill[i]);
			fwrite(cartxt,msg);
		}
	}
	fclose(cartxt);
}

forward	RemoveFlash(playerid);
public RemoveFlash(playerid)
{
	TextDrawHideForPlayer(playerid,flash);
	SetPVarInt(playerid,"PlayerHasBeenFlashed",2);
#if	CAMERA_PERSPECTIVE == true
	SetCameraBehindPlayer(playerid);
#endif
}

forward ProxDetectorS(Float:radi, playerid, targetid);
public ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}


public daojishi()
{
 		if (djssjbl > 0)
 		{
 			djssjbl  = djssjbl - 1;
			new mingzi[256];
			format(mingzi,sizeof(mingzi),"allsc %d",djssjbl);
			GameTextForAll(mingzi,1000,3);
 		}
 		else
 		{
 		    djssjbl = 10;
			for(new	vid=1;vid<999;vid++)
			{
				if(car[vid]!=0)
				{
					carfill[vid]=100;
					new	pd=0;
						for(new	u=0;u<101;u++)
						{
							if(IsPlayerConnected(u)==1)
							{
								if(SL[u]==1)
								{
									if(GetPlayerVehicleID(u)==vid)
									{
										u=102;
										pd=1;
									}
								}
							}
						}
						if(pd==0)
						{
								new	name[128],svid,money,gzbc,gz[10],fill,zuzhi,moxing,Float:x,Float:y,Float:z,Float:mianxiang,c1,c2;
								zuzhi=carzuzhi[vid];
								moxing=carmoxing[vid];
								x=carx[vid];
								y=cary[vid];
								z=carz[vid];
								fill=carfill[vid];
								mianxiang=carmianxiang[vid];
								c1=carcolor1[vid];
								c2=carcolor2[vid];
								format(name,128,"%s",carname[vid]);
								money=carmoney[vid];
								gzbc=cargzbc[vid];
								for(new	i=0;i<10;i++)
								{
									gz[i]=cargz[vid][i];
								}
								DestroyVehicle(vid);
								car[vid]=0;
								svid=AddStaticVehicleEx(moxing,x,y,z,mianxiang,c1,c2,99999999999999999999999999);
								carzuzhi[svid]=zuzhi;
								carmoxing[svid]=moxing;
								carx[svid]=x;
								cary[svid]=y;
								carz[svid]=z;
								carfill[svid]=fill;
								carmianxiang[svid]=mianxiang;
								carcolor1[svid]=c1;
								carcolor2[svid]=c2;
								format(carname[svid],128,"%s",name);
								carmoney[svid]=money;
								cargzbc[svid]=gzbc;
								for(new	i=0;i<10;i++)
								{
									cargz[svid][i]=gz[i];
									AddVehicleComponent(vid,cargz[svid][i]);
								}
								caryinqing[svid]=0;
								cardengguang[svid]=0;
								carlock[svid]=0;
								SetVehicleParamsEx(svid,caryinqing[svid],cardengguang[svid],0,carlock[svid],0,0,0);
								car[svid]=svid;
								KillTimer(allscdjstime);
								allscactive = 0;
						}
				}
			}
 		}
}


stock Float:GetVehicleSpeed(vehicleid,UseMPH = 0)
{
	new Float:speed_x,Float:speed_y,Float:speed_z,Float:temp_speed;
	GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
	if(UseMPH == 0)
	{
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*136.666667;
	}
	else
	{
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*85.4166672;
	}
	floatround(temp_speed,floatround_round);
	return temp_speed;
}


forward PlaySoundForPlayer(playerid, soundid);
public PlaySoundForPlayer(playerid, soundid)
{
new Float:pX, Float:pY, Float:pZ;
GetPlayerPos(playerid, pX, pY, pZ);
PlayerPlaySound(playerid, soundid,pX, pY, pZ);
}


public Shuache(id,playerid)
{
	new vid,Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	vid=AddStaticVehicleEx(id,x+1,y+1,z+1,180,1,1,99999999999999999999999999);
	car[vid]=vid;
	carx[vid]=x+1;
	cary[vid]=y+1;
	carz[vid]=z+1;
	carfill[vid]=100;
	carmianxiang[vid]=180;
	carcolor1[vid]=1;
	carcolor2[vid]=1;
	carzuzhi[vid]=0;
	carmoxing[vid]=id;
	GetPlayerName(playerid,carname[vid],128);
	carmoney[vid]=1;
	cargzbc[vid]=0;
	playercar[playerid]=playercar[playerid]+1;
}

public ChangeSkin(skinid, playerid)
{
	playerskin[playerid]=skinid;
	SetPlayerSkin(playerid,playerskin[playerid]);
	playermoney[playerid]=playermoney[playerid]-2000;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
	SendClientMessage(playerid,0x00FF00AA,"�㻨��2000Ԫ����һ�����·�!");
}

public OnPlayerExitVehicle(playerid, vehicleid)
{

    new driver = GetVehicleDriver(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && TotalFare[driver] > 0)
	{
	new money = floatround(TotalFare[driver]);
	new message[128];
    format(message,sizeof(message),"����֧�� %d Ԫ�����⳵˾��",money);
	GivePlayerMoney(playerid,-money);
	playermoney[playerid] -= money;
	TotalFare[driver] = 0;
	TextDrawSetString(taxithisfare[driver],"All money: N/A");
	GivePlayerMoney(driver,money);
	playermoney[playerid] += money;
	SendClientMessage(playerid,COLOR_LIGHTBLUE,message);
	format(message,sizeof(message),"%s �Ѿ�֧���� %d Ԫ������ĳ��⳵.",GetPlayerNameEx(playerid),money);
	SendClientMessage(driver,COLOR_LIGHTBLUE,message);
	TotalFare[driver] = 0.00;
	IsOnFare[driver] = 0;
	KillTimer(faretimer[driver]);
	}
	for(new i=0; i < MAX_PLAYERS; i++)
	{
	TextDrawHideForPlayer(playerid, taxiblackbox[i]);
	TextDrawHideForPlayer(playerid, startfare[i]);
	TextDrawHideForPlayer(playerid, taxigreendisplay[i]);
	TextDrawHideForPlayer(playerid, taxitimedisplay[i]);
	TextDrawHideForPlayer(playerid, taxi100mfare[i]);
	TextDrawHideForPlayer(playerid, taxithisfare[i]);
	TextDrawHideForPlayer(playerid, taxilstlogo[i]);
	TextDrawHideForPlayer(playerid, taxistatus[i]);
	TextDrawHideForPlayer(playerid, startfare[i]);
	}
 	TextDrawSetString(taxistatus[driver],"This Taxi:Free");
	return 1;
}














forward Clock();
public Clock()
{
    new hour,minute;
	gettime(hour,minute);
	new string[128];
	if(minute < 10)
	{
	format(string,sizeof(string),"Time: %d : 0%d",hour,minute);
	}
	else
	{
	format(string,sizeof(string),"Time: %d : %d",hour,minute);
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i))
	{
	if(OnDuty[i] == 1)
	{
	TextDrawSetString(taxitimedisplay[i],string);
	}
	}
	}
	KillTimer(clockupdate);
	clockupdate = SetTimer("Clock",60000,0);
}
forward IsATaxi(vehicleid);
public IsATaxi(vehicleid)
{
	new vmodel = GetVehicleModel(vehicleid);
	if(vmodel == 420 || vmodel == 438)
	{
		return 1;
	}
	return 0;
}
forward FareUpdate(playerid);
public FareUpdate(playerid)
{
	new farestring[128];
	GetPlayerPos(playerid,NewX[playerid],NewY[playerid],NewZ[playerid]);
	new Float:totdistance;
	totdistance = GetDistanceBetweenPoints(OldX[playerid], OldY[playerid], NewX[playerid], NewY[playerid]);
    if(totdistance > 100.0)
    {
    TotalFare[playerid] = TotalFare[playerid]+MONEYPER100;
	format(farestring,sizeof(farestring),"All money: %.2f $",TotalFare[playerid]);
	TextDrawSetString(taxithisfare[playerid],farestring);
	GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
	}


	return 1;

}
stock CheckPassengers(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerInAnyVehicle(i))
	{
	if(GetPlayerVehicleID(i) == vehicleid && i != GetVehicleDriver(vehicleid))
	{

	return 1;

	}
	}
	}
	return 0;
}
stock GetPlayerNameEx(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	return pname;
}

forward GivePlayerWeaponEx(playerid, weaponid, ammos);
public GivePlayerWeaponEx(playerid, weaponid, ammos)
{
	PlayerWeapons[playerid][weaponid] = 1;
	GivePlayerWeapon(playerid, weaponid, ammos);
}
forward ResetPlayerWeaponEx(playerid);
public ResetPlayerWeaponEx(playerid)
{
	for(new i; i<44; i++)
	{
	    PlayerWeapons[playerid][i] = 0;
	}
	ResetPlayerWeapons(playerid);
}

forward KickEx(playerid);
public KickEx(playerid)
{
	Kick(playerid);
	Kicking[playerid] = 0;
	return 1;
}

forward Exit(playerid);
public Exit(playerid)
{
	SendRconCommand("exit");
	return 1;
}


forward Firework(i);
public Firework(i)
{
	new Float:x, Float:y, Float:z;
	x = rx[i];
	y = ry[i];
	z = rz[i];
	z += RocketHeight;
	if (RocketExplosions[i] == 0)
	{
	    DestroyDynamicObject(Rocket[i]);
	    DestroyDynamicObject(RocketLight[i]);
	    DestroyDynamicObject(RocketSmoke[i]);
	    CreateExplosion(x ,y, z, 4, 10);
	    CreateExplosion(x ,y, z, 5, 10);
	    CreateExplosion(x ,y, z, 6, 10);
	}
	else if (RocketExplosions[i] >= MAX_FIREWORKS)
	{
	    for (new j = 0; j <= RocketSpread; j++)
	    {
	    	CreateExplosion(x + float(j - (RocketSpread / 2)), y, z, 7, 10);
	    	CreateExplosion(x, y + float(j - (RocketSpread / 2)), z, 7, 10);
	    	CreateExplosion(x, y, z + float(j - (RocketSpread / 2)), 7, 10);
	    }
	    RocketExplosions[i] = -1;
	    FireworkTotal = 0;
	    Fired = 0;
	    return 1;
	}
	else
	{
		x += float(random(RocketSpread) - (RocketSpread / 2));
		y += float(random(RocketSpread) - (RocketSpread / 2));
		z += float(random(RocketSpread) - (RocketSpread / 2));
	    CreateExplosion(x, y, z, 7, 10);
	}
	RocketExplosions[i]++;
	SetTimerEx("Firework", 250, 0, "i", i);
	return 1;
}


stock IsPlayerOnline(username[])
{
    new pName[MAX_PLAYER_NAME];
    for(new i=0; i < MAX_PLAYERS; i++)
    {
        GetPlayerName(i,pName, sizeof(pName));
        if(strcmp(pName,username,false) == 0) return i;//player online
    }
    return -1;//player offline
}


stock GivePlayerMoneyEx(name[], money)
{
	new pid = IsPlayerOnline(name);
	if (pid != -1)
	{
 		playermoney[pid] += money;
 		GivePlayerMoney(pid,money);
	}
	else
	{
		new mo, string[256];
		format(string,256,"Users/%s.ini",name);
		if(KINI_Open(string))
		{
		 	mo = KINI_ReadInt("money");
			format(string,256,"%d",mo+money);
			KINI_WriteString("money",string);
			KINI_Save();
			KINI_Close();
		}
	}
}


stock InitTablet()
{

	TabletWin8[0] = TextDrawCreate(122.000000, 93.000000, "O____________iiO~n~~n~~n~O____________iiO~n~~n~~n~O____________iiO");
	TextDrawBackgroundColor(TabletWin8[0], 255);
	TextDrawFont(TabletWin8[0], 1);
	TextDrawLetterSize(TabletWin8[0], 1.600000, 8.299999);
	TextDrawColor(TabletWin8[0], 255);
	TextDrawSetOutline(TabletWin8[0], 1);
	TextDrawSetProportional(TabletWin8[0], 1);
	TextDrawSetSelectable(TabletWin8[0], 0);

	TabletWin8[1] = TextDrawCreate(122.000000, 139.000000, "_");
	TextDrawBackgroundColor(TabletWin8[1], 255);
	TextDrawFont(TabletWin8[1], 1);
	TextDrawLetterSize(TabletWin8[1], 0.500000, 24.300001);
	TextDrawColor(TabletWin8[1], -1);
	TextDrawSetOutline(TabletWin8[1], 0);
	TextDrawSetProportional(TabletWin8[1], 1);
	TextDrawSetShadow(TabletWin8[1], 1);
	TextDrawUseBox(TabletWin8[1], 1);
	TextDrawBoxColor(TabletWin8[1], 255);
	TextDrawTextSize(TabletWin8[1], 549.000000, 10.000000);
	TextDrawSetSelectable(TabletWin8[1], 0);

	TabletWin8[2] = TextDrawCreate(120.000000, 387.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8[2], 255);
	TextDrawFont(TabletWin8[2], 4);
	TextDrawLetterSize(TabletWin8[2], 0.500000, 1.000000);
	TextDrawColor(TabletWin8[2], -1);
	TextDrawSetOutline(TabletWin8[2], 0);
	TextDrawSetProportional(TabletWin8[2], 1);
	TextDrawSetShadow(TabletWin8[2], 1);
	TextDrawUseBox(TabletWin8[2], 1);
	TextDrawBoxColor(TabletWin8[2], 255);
	TextDrawTextSize(TabletWin8[2], 27.000000, -33.000000);
	TextDrawSetSelectable(TabletWin8[2], 0);

	TabletWin8[3] = TextDrawCreate(551.000000, 388.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8[3], 255);
	TextDrawFont(TabletWin8[3], 4);
	TextDrawLetterSize(TabletWin8[3], 0.500000, 1.000000);
	TextDrawColor(TabletWin8[3], -1);
	TextDrawSetOutline(TabletWin8[3], 0);
	TextDrawSetProportional(TabletWin8[3], 1);
	TextDrawSetShadow(TabletWin8[3], 1);
	TextDrawUseBox(TabletWin8[3], 1);
	TextDrawBoxColor(TabletWin8[3], 255);
	TextDrawTextSize(TabletWin8[3], -27.000000, -33.000000);
	TextDrawSetSelectable(TabletWin8[3], 0);

	TabletWin8[4] = TextDrawCreate(551.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8[4], 255);
	TextDrawFont(TabletWin8[4], 4);
	TextDrawLetterSize(TabletWin8[4], 0.500000, 1.000000);
	TextDrawColor(TabletWin8[4], -1);
	TextDrawSetOutline(TabletWin8[4], 0);
	TextDrawSetProportional(TabletWin8[4], 1);
	TextDrawSetShadow(TabletWin8[4], 1);
	TextDrawUseBox(TabletWin8[4], 1);
	TextDrawBoxColor(TabletWin8[4], 255);
	TextDrawTextSize(TabletWin8[4], -27.000000, 33.000000);
	TextDrawSetSelectable(TabletWin8[4], 0);

	TabletWin8[5] = TextDrawCreate(120.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8[5], 255);
	TextDrawFont(TabletWin8[5], 4);
	TextDrawLetterSize(TabletWin8[5], 0.500000, 1.000000);
	TextDrawColor(TabletWin8[5], -1);
	TextDrawSetOutline(TabletWin8[5], 0);
	TextDrawSetProportional(TabletWin8[5], 1);
	TextDrawSetShadow(TabletWin8[5], 1);
	TextDrawUseBox(TabletWin8[5], 1);
	TextDrawBoxColor(TabletWin8[5], 255);
	TextDrawTextSize(TabletWin8[5], 27.000000, 33.000000);
	TextDrawSetSelectable(TabletWin8[5], 0);

	TabletWin8[6] = TextDrawCreate(148.000000, 106.000000, "_");
	TextDrawBackgroundColor(TabletWin8[6], 255);
	TextDrawFont(TabletWin8[6], 1);
	TextDrawLetterSize(TabletWin8[6], 0.500000, 30.999998);
	TextDrawColor(TabletWin8[6], -1);
	TextDrawSetOutline(TabletWin8[6], 0);
	TextDrawSetProportional(TabletWin8[6], 1);
	TextDrawSetShadow(TabletWin8[6], 1);
	TextDrawUseBox(TabletWin8[6], 1);
	TextDrawBoxColor(TabletWin8[6], 255);
	TextDrawTextSize(TabletWin8[6], 522.000000, 0.000000);
	TextDrawSetSelectable(TabletWin8[6], 0);

	TabletWin8[7] = TextDrawCreate(149.000000, 139.000000, "_");
	TextDrawBackgroundColor(TabletWin8[7], 255);
	TextDrawFont(TabletWin8[7], 1);
	TextDrawLetterSize(TabletWin8[7], 0.500000, 24.200004);
	TextDrawColor(TabletWin8[7], -1);
	TextDrawSetOutline(TabletWin8[7], 0);
	TextDrawSetProportional(TabletWin8[7], 1);
	TextDrawSetShadow(TabletWin8[7], 1);
	TextDrawUseBox(TabletWin8[7], 1);
	TextDrawBoxColor(TabletWin8[7], 1718026239);
	TextDrawTextSize(TabletWin8[7], 522.000000, 10.000000);
	TextDrawSetSelectable(TabletWin8[7], 0);

	TabletWin8[8] = TextDrawCreate(203.000000, 208.000000, "_");
	TextDrawAlignment(TabletWin8[8], 2);
	TextDrawBackgroundColor(TabletWin8[8], 255);
	TextDrawFont(TabletWin8[8], 1);
	TextDrawLetterSize(TabletWin8[8], 0.500000, 2.900000);
	TextDrawColor(TabletWin8[8], -1);
	TextDrawSetOutline(TabletWin8[8], 0);
	TextDrawSetProportional(TabletWin8[8], 1);
	TextDrawSetShadow(TabletWin8[8], 1);
	TextDrawUseBox(TabletWin8[8], 1);
	TextDrawBoxColor(TabletWin8[8], -1);
	TextDrawTextSize(TabletWin8[8], 0.000000, 39.000000);
	TextDrawSetSelectable(TabletWin8[8], 0);

	TabletWin8[9] = TextDrawCreate(203.000000, 241.000000, "_");
	TextDrawAlignment(TabletWin8[9], 2);
	TextDrawBackgroundColor(TabletWin8[9], 255);
	TextDrawFont(TabletWin8[9], 1);
	TextDrawLetterSize(TabletWin8[9], 0.500000, 2.900000);
	TextDrawColor(TabletWin8[9], -1);
	TextDrawSetOutline(TabletWin8[9], 0);
	TextDrawSetProportional(TabletWin8[9], 1);
	TextDrawSetShadow(TabletWin8[9], 1);
	TextDrawUseBox(TabletWin8[9], 1);
	TextDrawBoxColor(TabletWin8[9], -1);
	TextDrawTextSize(TabletWin8[9], 0.000000, 39.000000);
	TextDrawSetSelectable(TabletWin8[9], 0);

	TabletWin8[10] = TextDrawCreate(248.000000, 241.000000, "_");
	TextDrawAlignment(TabletWin8[10], 2);
	TextDrawBackgroundColor(TabletWin8[10], 255);
	TextDrawFont(TabletWin8[10], 1);
	TextDrawLetterSize(TabletWin8[10], 0.500000, 2.900000);
	TextDrawColor(TabletWin8[10], -1);
	TextDrawSetOutline(TabletWin8[10], 0);
	TextDrawSetProportional(TabletWin8[10], 1);
	TextDrawSetShadow(TabletWin8[10], 1);
	TextDrawUseBox(TabletWin8[10], 1);
	TextDrawBoxColor(TabletWin8[10], -1);
	TextDrawTextSize(TabletWin8[10], 0.000000, 39.000000);
	TextDrawSetSelectable(TabletWin8[10], 0);

	TabletWin8[11] = TextDrawCreate(248.000000, 208.000000, "_");
	TextDrawAlignment(TabletWin8[11], 2);
	TextDrawBackgroundColor(TabletWin8[11], 255);
	TextDrawFont(TabletWin8[11], 1);
	TextDrawLetterSize(TabletWin8[11], 0.500000, 2.900000);
	TextDrawColor(TabletWin8[11], -1);
	TextDrawSetOutline(TabletWin8[11], 0);
	TextDrawSetProportional(TabletWin8[11], 1);
	TextDrawSetShadow(TabletWin8[11], 1);
	TextDrawUseBox(TabletWin8[11], 1);
	TextDrawBoxColor(TabletWin8[11], -1);
	TextDrawTextSize(TabletWin8[11], 0.000000, 39.000000);
	TextDrawSetSelectable(TabletWin8[11], 0);

	TabletWin8[12] = TextDrawCreate(281.000000, 208.000000, "Windows 8");
	TextDrawBackgroundColor(TabletWin8[12], 255);
	TextDrawFont(TabletWin8[12], 1);
	TextDrawLetterSize(TabletWin8[12], 1.159999, 5.799995);
	TextDrawColor(TabletWin8[12], -1);
	TextDrawSetOutline(TabletWin8[12], 0);
	TextDrawSetProportional(TabletWin8[12], 1);
	TextDrawSetShadow(TabletWin8[12], 0);
	TextDrawSetSelectable(TabletWin8[12], 0);

	TabletWin8[13] = TextDrawCreate(332.000000, 301.000000, ".");
	TextDrawBackgroundColor(TabletWin8[13], 255);
	TextDrawFont(TabletWin8[13], 1);
	TextDrawLetterSize(TabletWin8[13], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[13], -1);
	TextDrawSetOutline(TabletWin8[13], 0);
	TextDrawSetProportional(TabletWin8[13], 1);
	TextDrawSetShadow(TabletWin8[13], 0);
	TextDrawSetSelectable(TabletWin8[13], 0);

	TabletWin8[14] = TextDrawCreate(328.000000, 304.000000, ".");
	TextDrawBackgroundColor(TabletWin8[14], 255);
	TextDrawFont(TabletWin8[14], 1);
	TextDrawLetterSize(TabletWin8[14], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[14], -1);
	TextDrawSetOutline(TabletWin8[14], 0);
	TextDrawSetProportional(TabletWin8[14], 1);
	TextDrawSetShadow(TabletWin8[14], 0);
	TextDrawSetSelectable(TabletWin8[14], 0);

	TabletWin8[15] = TextDrawCreate(326.000000, 309.000000, ".");
	TextDrawBackgroundColor(TabletWin8[15], 255);
	TextDrawFont(TabletWin8[15], 1);
	TextDrawLetterSize(TabletWin8[15], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[15], -1);
	TextDrawSetOutline(TabletWin8[15], 0);
	TextDrawSetProportional(TabletWin8[15], 1);
	TextDrawSetShadow(TabletWin8[15], 0);
	TextDrawSetSelectable(TabletWin8[15], 0);

	TabletWin8[16] = TextDrawCreate(328.000000, 314.000000, ".");
	TextDrawBackgroundColor(TabletWin8[16], 255);
	TextDrawFont(TabletWin8[16], 1);
	TextDrawLetterSize(TabletWin8[16], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[16], -1);
	TextDrawSetOutline(TabletWin8[16], 0);
	TextDrawSetProportional(TabletWin8[16], 1);
	TextDrawSetShadow(TabletWin8[16], 0);
	TextDrawSetSelectable(TabletWin8[16], 0);

	TabletWin8[17] = TextDrawCreate(332.000000, 316.000000, ".");
	TextDrawBackgroundColor(TabletWin8[17], 255);
	TextDrawFont(TabletWin8[17], 1);
	TextDrawLetterSize(TabletWin8[17], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[17], -1);
	TextDrawSetOutline(TabletWin8[17], 0);
	TextDrawSetProportional(TabletWin8[17], 1);
	TextDrawSetShadow(TabletWin8[17], 0);
	TextDrawSetSelectable(TabletWin8[17], 0);

	TabletWin8[18] = TextDrawCreate(336.000000, 314.000000, ".");
	TextDrawBackgroundColor(TabletWin8[18], 255);
	TextDrawFont(TabletWin8[18], 1);
	TextDrawLetterSize(TabletWin8[18], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[18], -1);
	TextDrawSetOutline(TabletWin8[18], 0);
	TextDrawSetProportional(TabletWin8[18], 1);
	TextDrawSetShadow(TabletWin8[18], 0);
	TextDrawSetSelectable(TabletWin8[18], 0);

	TabletWin8[19] = TextDrawCreate(338.000000, 309.000000, ".");
	TextDrawBackgroundColor(TabletWin8[19], 255);
	TextDrawFont(TabletWin8[19], 1);
	TextDrawLetterSize(TabletWin8[19], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[19], -1);
	TextDrawSetOutline(TabletWin8[19], 0);
	TextDrawSetProportional(TabletWin8[19], 1);
	TextDrawSetShadow(TabletWin8[19], 0);
	TextDrawSetSelectable(TabletWin8[19], 0);

	TabletWin8[20] = TextDrawCreate(337.000000, 304.000000, ".");
	TextDrawBackgroundColor(TabletWin8[20], 255);
	TextDrawFont(TabletWin8[20], 1);
	TextDrawLetterSize(TabletWin8[20], 0.300000, 0.800000);
	TextDrawColor(TabletWin8[20], -1);
	TextDrawSetOutline(TabletWin8[20], 0);
	TextDrawSetProportional(TabletWin8[20], 1);
	TextDrawSetShadow(TabletWin8[20], 0);
	TextDrawSetSelectable(TabletWin8[20], 0);

	TabletWin8[21] = TextDrawCreate(137.000000, 124.000000, "_");
	TextDrawBackgroundColor(TabletWin8[21], 255);
	TextDrawFont(TabletWin8[21], 1);
	TextDrawLetterSize(TabletWin8[21], 0.500000, 1.200000);
	TextDrawColor(TabletWin8[21], -1);
	TextDrawSetOutline(TabletWin8[21], 0);
	TextDrawSetProportional(TabletWin8[21], 1);
	TextDrawSetShadow(TabletWin8[21], 1);
	TextDrawUseBox(TabletWin8[21], 1);
	TextDrawBoxColor(TabletWin8[21], 255);
	TextDrawTextSize(TabletWin8[21], 539.000000, 192.000000);
	TextDrawSetSelectable(TabletWin8[21], 0);

	TabletWin8[22] = TextDrawCreate(137.000000, 362.000000, "_");
	TextDrawBackgroundColor(TabletWin8[22], 255);
	TextDrawFont(TabletWin8[22], 1);
	TextDrawLetterSize(TabletWin8[22], 0.500000, 1.200000);
	TextDrawColor(TabletWin8[22], -1);
	TextDrawSetOutline(TabletWin8[22], 0);
	TextDrawSetProportional(TabletWin8[22], 1);
	TextDrawSetShadow(TabletWin8[22], 1);
	TextDrawUseBox(TabletWin8[22], 1);
	TextDrawBoxColor(TabletWin8[22], 255);
	TextDrawTextSize(TabletWin8[22], 539.000000, 192.000000);
	TextDrawSetSelectable(TabletWin8[22], 0);

	//Inicio
	TabletWin8Start[0] = TextDrawCreate(122.000000, 93.000000, "O____________iiO~n~~n~~n~O____________iiO~n~~n~~n~O____________iiO");
	TextDrawBackgroundColor(TabletWin8Start[0], 255);
	TextDrawFont(TabletWin8Start[0], 1);
	TextDrawLetterSize(TabletWin8Start[0], 1.600000, 8.299999);
	TextDrawColor(TabletWin8Start[0], 255);
	TextDrawSetOutline(TabletWin8Start[0], 1);
	TextDrawSetProportional(TabletWin8Start[0], 1);
	TextDrawSetSelectable(TabletWin8Start[0], 0);

	TabletWin8Start[1] = TextDrawCreate(122.000000, 139.000000, "_");
	TextDrawBackgroundColor(TabletWin8Start[1], 255);
	TextDrawFont(TabletWin8Start[1], 1);
	TextDrawLetterSize(TabletWin8Start[1], 0.500000, 24.300001);
	TextDrawColor(TabletWin8Start[1], -1);
	TextDrawSetOutline(TabletWin8Start[1], 0);
	TextDrawSetProportional(TabletWin8Start[1], 1);
	TextDrawSetShadow(TabletWin8Start[1], 1);
	TextDrawUseBox(TabletWin8Start[1], 1);
	TextDrawBoxColor(TabletWin8Start[1], 255);
	TextDrawTextSize(TabletWin8Start[1], 549.000000, 10.000000);
	TextDrawSetSelectable(TabletWin8Start[1], 0);

	TabletWin8Start[2] = TextDrawCreate(120.000000, 387.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8Start[2], 255);
	TextDrawFont(TabletWin8Start[2], 4);
	TextDrawLetterSize(TabletWin8Start[2], 0.500000, 1.000000);
	TextDrawColor(TabletWin8Start[2], -1);
	TextDrawSetOutline(TabletWin8Start[2], 0);
	TextDrawSetProportional(TabletWin8Start[2], 1);
	TextDrawSetShadow(TabletWin8Start[2], 1);
	TextDrawUseBox(TabletWin8Start[2], 1);
	TextDrawBoxColor(TabletWin8Start[2], 255);
	TextDrawTextSize(TabletWin8Start[2], 27.000000, -33.000000);
	TextDrawSetSelectable(TabletWin8Start[2], 0);

	TabletWin8Start[3] = TextDrawCreate(551.000000, 388.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8Start[3], 255);
	TextDrawFont(TabletWin8Start[3], 4);
	TextDrawLetterSize(TabletWin8Start[3], 0.500000, 1.000000);
	TextDrawColor(TabletWin8Start[3], -1);
	TextDrawSetOutline(TabletWin8Start[3], 0);
	TextDrawSetProportional(TabletWin8Start[3], 1);
	TextDrawSetShadow(TabletWin8Start[3], 1);
	TextDrawUseBox(TabletWin8Start[3], 1);
	TextDrawBoxColor(TabletWin8Start[3], 255);
	TextDrawTextSize(TabletWin8Start[3], -27.000000, -33.000000);
	TextDrawSetSelectable(TabletWin8Start[3], 0);

	TabletWin8Start[4] = TextDrawCreate(551.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8Start[4], 255);
	TextDrawFont(TabletWin8Start[4], 4);
	TextDrawLetterSize(TabletWin8Start[4], 0.500000, 1.000000);
	TextDrawColor(TabletWin8Start[4], -1);
	TextDrawSetOutline(TabletWin8Start[4], 0);
	TextDrawSetProportional(TabletWin8Start[4], 1);
	TextDrawSetShadow(TabletWin8Start[4], 1);
	TextDrawUseBox(TabletWin8Start[4], 1);
	TextDrawBoxColor(TabletWin8Start[4], 255);
	TextDrawTextSize(TabletWin8Start[4], -27.000000, 33.000000);
	TextDrawSetSelectable(TabletWin8Start[4], 0);

	TabletWin8Start[5] = TextDrawCreate(120.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(TabletWin8Start[5], 255);
	TextDrawFont(TabletWin8Start[5], 4);
	TextDrawLetterSize(TabletWin8Start[5], 0.500000, 1.000000);
	TextDrawColor(TabletWin8Start[5], -1);
	TextDrawSetOutline(TabletWin8Start[5], 0);
	TextDrawSetProportional(TabletWin8Start[5], 1);
	TextDrawSetShadow(TabletWin8Start[5], 1);
	TextDrawUseBox(TabletWin8Start[5], 1);
	TextDrawBoxColor(TabletWin8Start[5], 255);
	TextDrawTextSize(TabletWin8Start[5], 27.000000, 33.000000);
	TextDrawSetSelectable(TabletWin8Start[5], 0);

	TabletWin8Start[6] = TextDrawCreate(148.000000, 106.000000, "_");
	TextDrawBackgroundColor(TabletWin8Start[6], 255);
	TextDrawFont(TabletWin8Start[6], 1);
	TextDrawLetterSize(TabletWin8Start[6], 0.500000, 30.999998);
	TextDrawColor(TabletWin8Start[6], -1);
	TextDrawSetOutline(TabletWin8Start[6], 0);
	TextDrawSetProportional(TabletWin8Start[6], 1);
	TextDrawSetShadow(TabletWin8Start[6], 1);
	TextDrawUseBox(TabletWin8Start[6], 1);
	TextDrawBoxColor(TabletWin8Start[6], 255);
	TextDrawTextSize(TabletWin8Start[6], 522.000000, 0.000000);
	TextDrawSetSelectable(TabletWin8Start[6], 0);

	TabletWin8Start[7] = TextDrawCreate(149.000000, 139.000000, "_");
	TextDrawBackgroundColor(TabletWin8Start[7], 255);
	TextDrawFont(TabletWin8Start[7], 1);
	TextDrawLetterSize(TabletWin8Start[7], 0.500000, 24.200004);
	TextDrawColor(TabletWin8Start[7], -1);
	TextDrawSetOutline(TabletWin8Start[7], 0);
	TextDrawSetProportional(TabletWin8Start[7], 1);
	TextDrawSetShadow(TabletWin8Start[7], 1);
	TextDrawUseBox(TabletWin8Start[7], 1);
	TextDrawBoxColor(TabletWin8Start[7], 1711315455);
	TextDrawTextSize(TabletWin8Start[7], 522.000000, 10.000000);
	TextDrawSetSelectable(TabletWin8Start[7], 0);

	TabletWin8Start[8] = TextDrawCreate(201.000000, 173.000000, "_");
	TextDrawAlignment(TabletWin8Start[8], 2);
	TextDrawBackgroundColor(TabletWin8Start[8], 255);
	TextDrawFont(TabletWin8Start[8], 1);
	TextDrawLetterSize(TabletWin8Start[8], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[8], -1);
	TextDrawSetOutline(TabletWin8Start[8], 0);
	TextDrawSetProportional(TabletWin8Start[8], 1);
	TextDrawSetShadow(TabletWin8Start[8], 1);
	TextDrawUseBox(TabletWin8Start[8], 1);
	TextDrawBoxColor(TabletWin8Start[8], 1724697855);
	TextDrawTextSize(TabletWin8Start[8], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[8], 0);

	TabletWin8Start[9] = TextDrawCreate(201.000000, 220.000000, "_");
	TextDrawAlignment(TabletWin8Start[9], 2);
	TextDrawBackgroundColor(TabletWin8Start[9], 255);
	TextDrawFont(TabletWin8Start[9], 1);
	TextDrawLetterSize(TabletWin8Start[9], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[9], -1);
	TextDrawSetOutline(TabletWin8Start[9], 0);
	TextDrawSetProportional(TabletWin8Start[9], 1);
	TextDrawSetShadow(TabletWin8Start[9], 1);
	TextDrawUseBox(TabletWin8Start[9], 1);
	TextDrawBoxColor(TabletWin8Start[9], -6749953);
	TextDrawTextSize(TabletWin8Start[9], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[9], 0);

	TabletWin8Start[10] = TextDrawCreate(201.000000, 266.000000, "_");
	TextDrawAlignment(TabletWin8Start[10], 2);
	TextDrawBackgroundColor(TabletWin8Start[10], 255);
	TextDrawFont(TabletWin8Start[10], 1);
	TextDrawLetterSize(TabletWin8Start[10], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[10], -1);
	TextDrawSetOutline(TabletWin8Start[10], 0);
	TextDrawSetProportional(TabletWin8Start[10], 1);
	TextDrawSetShadow(TabletWin8Start[10], 1);
	TextDrawUseBox(TabletWin8Start[10], 1);
	TextDrawBoxColor(TabletWin8Start[10], -1724671489);
	TextDrawTextSize(TabletWin8Start[10], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[10], 0);

	TabletWin8Start[11] = TextDrawCreate(165.000000, 310.000000, "loadsc2:loadsc2");
	TextDrawAlignment(TabletWin8Start[11], 2);
	TextDrawBackgroundColor(TabletWin8Start[11], 255);
	TextDrawFont(TabletWin8Start[11], 4);
	TextDrawLetterSize(TabletWin8Start[11], 0.500000, 0.299998);
	TextDrawColor(TabletWin8Start[11], -1);
	TextDrawSetOutline(TabletWin8Start[11], 0);
	TextDrawSetProportional(TabletWin8Start[11], 1);
	TextDrawSetShadow(TabletWin8Start[11], 1);
	TextDrawUseBox(TabletWin8Start[11], 1);
	TextDrawBoxColor(TabletWin8Start[11], -1724671489);
	TextDrawTextSize(TabletWin8Start[11], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletWin8Start[11], 0);

	TabletWin8Start[12] = TextDrawCreate(163.000000, 139.000000, "Start");
	TextDrawBackgroundColor(TabletWin8Start[12], 255);
	TextDrawFont(TabletWin8Start[12], 1);
	TextDrawLetterSize(TabletWin8Start[12], 0.759999, 3.299999);
	TextDrawColor(TabletWin8Start[12], -1);
	TextDrawSetOutline(TabletWin8Start[12], 0);
	TextDrawSetProportional(TabletWin8Start[12], 1);
	TextDrawSetShadow(TabletWin8Start[12], 0);
	TextDrawSetSelectable(TabletWin8Start[12], 0);

	TabletWin8Start[13] = TextDrawCreate(277.000000, 173.000000, "_");
	TextDrawAlignment(TabletWin8Start[13], 2);
	TextDrawBackgroundColor(TabletWin8Start[13], 255);
	TextDrawFont(TabletWin8Start[13], 1);
	TextDrawLetterSize(TabletWin8Start[13], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[13], -1);
	TextDrawSetOutline(TabletWin8Start[13], 0);
	TextDrawSetProportional(TabletWin8Start[13], 1);
	TextDrawSetShadow(TabletWin8Start[13], 1);
	TextDrawUseBox(TabletWin8Start[13], 1);
	TextDrawBoxColor(TabletWin8Start[13], -1728013825);
	TextDrawTextSize(TabletWin8Start[13], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[13], 0);

	TabletWin8Start[14] = TextDrawCreate(241.000000, 218.000000, "load0uk:load0uk");
	TextDrawAlignment(TabletWin8Start[14], 2);
	TextDrawBackgroundColor(TabletWin8Start[14], 255);
	TextDrawFont(TabletWin8Start[14], 4);
	TextDrawLetterSize(TabletWin8Start[14], 0.500000, 0.299998);
	TextDrawColor(TabletWin8Start[14], -1);
	TextDrawSetOutline(TabletWin8Start[14], 0);
	TextDrawSetProportional(TabletWin8Start[14], 1);
	TextDrawSetShadow(TabletWin8Start[14], 1);
	TextDrawUseBox(TabletWin8Start[14], 1);
	TextDrawBoxColor(TabletWin8Start[14], -1724671489);
	TextDrawTextSize(TabletWin8Start[14], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletWin8Start[14], 0);

	TabletWin8Start[15] = TextDrawCreate(277.000000, 266.000000, "_");
	TextDrawAlignment(TabletWin8Start[15], 2);
	TextDrawBackgroundColor(TabletWin8Start[15], 255);
	TextDrawFont(TabletWin8Start[15], 1);
	TextDrawLetterSize(TabletWin8Start[15], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[15], -1);
	TextDrawSetOutline(TabletWin8Start[15], 0);
	TextDrawSetProportional(TabletWin8Start[15], 1);
	TextDrawSetShadow(TabletWin8Start[15], 1);
	TextDrawUseBox(TabletWin8Start[15], 1);
	TextDrawBoxColor(TabletWin8Start[15], 16711935);
	TextDrawTextSize(TabletWin8Start[15], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[15], 0);

	TabletWin8Start[16] = TextDrawCreate(277.000000, 313.000000, "_");
	TextDrawAlignment(TabletWin8Start[16], 2);
	TextDrawBackgroundColor(TabletWin8Start[16], 255);
	TextDrawFont(TabletWin8Start[16], 1);
	TextDrawLetterSize(TabletWin8Start[16], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[16], -1);
	TextDrawSetOutline(TabletWin8Start[16], 0);
	TextDrawSetProportional(TabletWin8Start[16], 1);
	TextDrawSetShadow(TabletWin8Start[16], 1);
	TextDrawUseBox(TabletWin8Start[16], 1);
	TextDrawBoxColor(TabletWin8Start[16], 16777215);
	TextDrawTextSize(TabletWin8Start[16], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[16], 0);

	TabletWin8Start[17] = TextDrawCreate(334.000000, 173.000000, "_");
	TextDrawAlignment(TabletWin8Start[17], 2);
	TextDrawBackgroundColor(TabletWin8Start[17], 255);
	TextDrawFont(TabletWin8Start[17], 1);
	TextDrawLetterSize(TabletWin8Start[17], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[17], -1);
	TextDrawSetOutline(TabletWin8Start[17], 0);
	TextDrawSetProportional(TabletWin8Start[17], 1);
	TextDrawSetShadow(TabletWin8Start[17], 1);
	TextDrawUseBox(TabletWin8Start[17], 1);
	TextDrawBoxColor(TabletWin8Start[17], -1721316097);
	TextDrawTextSize(TabletWin8Start[17], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[17], 0);

	TabletWin8Start[18] = TextDrawCreate(372.000000, 173.000000, "_");
	TextDrawAlignment(TabletWin8Start[18], 2);
	TextDrawBackgroundColor(TabletWin8Start[18], 255);
	TextDrawFont(TabletWin8Start[18], 1);
	TextDrawLetterSize(TabletWin8Start[18], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[18], -1);
	TextDrawSetOutline(TabletWin8Start[18], 0);
	TextDrawSetProportional(TabletWin8Start[18], 1);
	TextDrawSetShadow(TabletWin8Start[18], 1);
	TextDrawUseBox(TabletWin8Start[18], 1);
	TextDrawBoxColor(TabletWin8Start[18], 16711935);
	TextDrawTextSize(TabletWin8Start[18], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[18], 0);

	TabletWin8Start[19] = TextDrawCreate(372.000000, 219.000000, "_");
	TextDrawAlignment(TabletWin8Start[19], 2);
	TextDrawBackgroundColor(TabletWin8Start[19], 255);
	TextDrawFont(TabletWin8Start[19], 1);
	TextDrawLetterSize(TabletWin8Start[19], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[19], -1);
	TextDrawSetOutline(TabletWin8Start[19], 0);
	TextDrawSetProportional(TabletWin8Start[19], 1);
	TextDrawSetShadow(TabletWin8Start[19], 1);
	TextDrawUseBox(TabletWin8Start[19], 1);
	TextDrawBoxColor(TabletWin8Start[19], 65535);
	TextDrawTextSize(TabletWin8Start[19], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[19], 0);

	TabletWin8Start[20] = TextDrawCreate(334.000000, 220.000000, "_");
	TextDrawAlignment(TabletWin8Start[20], 2);
	TextDrawBackgroundColor(TabletWin8Start[20], 255);
	TextDrawFont(TabletWin8Start[20], 1);
	TextDrawLetterSize(TabletWin8Start[20], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[20], -1);
	TextDrawSetOutline(TabletWin8Start[20], 0);
	TextDrawSetProportional(TabletWin8Start[20], 1);
	TextDrawSetShadow(TabletWin8Start[20], 1);
	TextDrawUseBox(TabletWin8Start[20], 1);
	TextDrawBoxColor(TabletWin8Start[20], -1724671489);
	TextDrawTextSize(TabletWin8Start[20], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[20], 0);

	TabletWin8Start[21] = TextDrawCreate(137.000000, 124.000000, "_");
	TextDrawBackgroundColor(TabletWin8Start[21], 255);
	TextDrawFont(TabletWin8Start[21], 1);
	TextDrawLetterSize(TabletWin8Start[21], 0.500000, 1.200000);
	TextDrawColor(TabletWin8Start[21], -1);
	TextDrawSetOutline(TabletWin8Start[21], 0);
	TextDrawSetProportional(TabletWin8Start[21], 1);
	TextDrawSetShadow(TabletWin8Start[21], 1);
	TextDrawUseBox(TabletWin8Start[21], 1);
	TextDrawBoxColor(TabletWin8Start[21], 255);
	TextDrawTextSize(TabletWin8Start[21], 539.000000, 192.000000);
	TextDrawSetSelectable(TabletWin8Start[21], 0);

	TabletWin8Start[22] = TextDrawCreate(137.000000, 362.000000, "_");
	TextDrawBackgroundColor(TabletWin8Start[22], 255);
	TextDrawFont(TabletWin8Start[22], 1);
	TextDrawLetterSize(TabletWin8Start[22], 0.500000, 1.200000);
	TextDrawColor(TabletWin8Start[22], -1);
	TextDrawSetOutline(TabletWin8Start[22], 0);
	TextDrawSetProportional(TabletWin8Start[22], 1);
	TextDrawSetShadow(TabletWin8Start[22], 1);
	TextDrawUseBox(TabletWin8Start[22], 1);
	TextDrawBoxColor(TabletWin8Start[22], 255);
	TextDrawTextSize(TabletWin8Start[22], 539.000000, 192.000000);
	TextDrawSetSelectable(TabletWin8Start[22], 0);

	TabletWin8Start[23] = TextDrawCreate(353.000000, 266.000000, "_");
	TextDrawAlignment(TabletWin8Start[23], 2);
	TextDrawBackgroundColor(TabletWin8Start[23], 255);
	TextDrawFont(TabletWin8Start[23], 1);
	TextDrawLetterSize(TabletWin8Start[23], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[23], -1);
	TextDrawSetOutline(TabletWin8Start[23], 0);
	TextDrawSetProportional(TabletWin8Start[23], 1);
	TextDrawSetShadow(TabletWin8Start[23], 1);
	TextDrawUseBox(TabletWin8Start[23], 1);
	TextDrawBoxColor(TabletWin8Start[23], -1728013825);
	TextDrawTextSize(TabletWin8Start[23], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[23], 0);

	TabletWin8Start[24] = TextDrawCreate(353.000000, 313.000000, "_");
	TextDrawAlignment(TabletWin8Start[24], 2);
	TextDrawBackgroundColor(TabletWin8Start[24], 255);
	TextDrawFont(TabletWin8Start[24], 1);
	TextDrawLetterSize(TabletWin8Start[24], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[24], -1);
	TextDrawSetOutline(TabletWin8Start[24], 0);
	TextDrawSetProportional(TabletWin8Start[24], 1);
	TextDrawSetShadow(TabletWin8Start[24], 1);
	TextDrawUseBox(TabletWin8Start[24], 1);
	TextDrawBoxColor(TabletWin8Start[24], -16776961);
	TextDrawTextSize(TabletWin8Start[24], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[24], 0);

	TabletWin8Start[25] = TextDrawCreate(419.000000, 170.000000, "ld_dual:backgnd");
	TextDrawBackgroundColor(TabletWin8Start[25], 255);
	TextDrawFont(TabletWin8Start[25], 4);
	TextDrawLetterSize(TabletWin8Start[25], 0.500000, 1.000000);
	TextDrawColor(TabletWin8Start[25], -1);
	TextDrawSetOutline(TabletWin8Start[25], 0);
	TextDrawSetProportional(TabletWin8Start[25], 1);
	TextDrawSetShadow(TabletWin8Start[25], 1);
	TextDrawUseBox(TabletWin8Start[25], 1);
	TextDrawBoxColor(TabletWin8Start[25], 255);
	TextDrawTextSize(TabletWin8Start[25], 72.000000, 43.000000);
	TextDrawSetSelectable(TabletWin8Start[25], 0);

	TabletWin8Start[26] = TextDrawCreate(455.000000, 220.000000, "_");
	TextDrawAlignment(TabletWin8Start[26], 2);
	TextDrawBackgroundColor(TabletWin8Start[26], 255);
	TextDrawFont(TabletWin8Start[26], 1);
	TextDrawLetterSize(TabletWin8Start[26], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[26], -1);
	TextDrawSetOutline(TabletWin8Start[26], 0);
	TextDrawSetProportional(TabletWin8Start[26], 1);
	TextDrawSetShadow(TabletWin8Start[26], 1);
	TextDrawUseBox(TabletWin8Start[26], 1);
	TextDrawBoxColor(TabletWin8Start[26], 65535);
	TextDrawTextSize(TabletWin8Start[26], 5.000000, 68.000000);
	TextDrawSetSelectable(TabletWin8Start[26], 0);

	TabletWin8Start[27] = TextDrawCreate(437.000000, 266.000000, "_");
	TextDrawAlignment(TabletWin8Start[27], 2);
	TextDrawBackgroundColor(TabletWin8Start[27], 255);
	TextDrawFont(TabletWin8Start[27], 1);
	TextDrawLetterSize(TabletWin8Start[27], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[27], -1);
	TextDrawSetOutline(TabletWin8Start[27], 0);
	TextDrawSetProportional(TabletWin8Start[27], 1);
	TextDrawSetShadow(TabletWin8Start[27], 1);
	TextDrawUseBox(TabletWin8Start[27], 1);
	TextDrawBoxColor(TabletWin8Start[27], 16711935);
	TextDrawTextSize(TabletWin8Start[27], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[27], 0);

	TabletWin8Start[28] = TextDrawCreate(437.000000, 313.000000, "_");
	TextDrawAlignment(TabletWin8Start[28], 2);
	TextDrawBackgroundColor(TabletWin8Start[28], 255);
	TextDrawFont(TabletWin8Start[28], 1);
	TextDrawLetterSize(TabletWin8Start[28], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[28], -1);
	TextDrawSetOutline(TabletWin8Start[28], 0);
	TextDrawSetProportional(TabletWin8Start[28], 1);
	TextDrawSetShadow(TabletWin8Start[28], 1);
	TextDrawUseBox(TabletWin8Start[28], 1);
	TextDrawBoxColor(TabletWin8Start[28], -6749953);
	TextDrawTextSize(TabletWin8Start[28], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[28], 0);

	TabletWin8Start[29] = TextDrawCreate(474.000000, 266.000000, "_");
	TextDrawAlignment(TabletWin8Start[29], 2);
	TextDrawBackgroundColor(TabletWin8Start[29], 255);
	TextDrawFont(TabletWin8Start[29], 1);
	TextDrawLetterSize(TabletWin8Start[29], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[29], -1);
	TextDrawSetOutline(TabletWin8Start[29], 0);
	TextDrawSetProportional(TabletWin8Start[29], 1);
	TextDrawSetShadow(TabletWin8Start[29], 1);
	TextDrawUseBox(TabletWin8Start[29], 1);
	TextDrawBoxColor(TabletWin8Start[29], -872375809);
	TextDrawTextSize(TabletWin8Start[29], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[29], 0);

	TabletWin8Start[30] = TextDrawCreate(474.000000, 313.000000, "_");
	TextDrawAlignment(TabletWin8Start[30], 2);
	TextDrawBackgroundColor(TabletWin8Start[30], 255);
	TextDrawFont(TabletWin8Start[30], 1);
	TextDrawLetterSize(TabletWin8Start[30], 0.500000, 4.199998);
	TextDrawColor(TabletWin8Start[30], -1);
	TextDrawSetOutline(TabletWin8Start[30], 0);
	TextDrawSetProportional(TabletWin8Start[30], 1);
	TextDrawSetShadow(TabletWin8Start[30], 1);
	TextDrawUseBox(TabletWin8Start[30], 1);
	TextDrawBoxColor(TabletWin8Start[30], -16776961);
	TextDrawTextSize(TabletWin8Start[30], 273.000000, 31.000000);
	TextDrawSetSelectable(TabletWin8Start[30], 0);

	TabletWin8Start[31] = TextDrawCreate(187.000000, 198.000000, "Mail");
	TextDrawBackgroundColor(TabletWin8Start[31], 255);
	TextDrawAlignment(TabletWin8Start[31], 2);
	TextDrawFont(TabletWin8Start[31], 1);
	TextDrawLetterSize(TabletWin8Start[31], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[31], -1);
	TextDrawSetOutline(TabletWin8Start[31], 0);
	TextDrawSetProportional(TabletWin8Start[31], 1);
	TextDrawSetShadow(TabletWin8Start[31], 0);
	TextDrawTextSize(TabletWin8Start[31],10,40);
	TextDrawSetSelectable(TabletWin8Start[31], 1);

	TabletWin8Start[32] = TextDrawCreate(193.000000, 245.000000, "Contacts");
	TextDrawBackgroundColor(TabletWin8Start[32], 255);
	TextDrawAlignment(TabletWin8Start[32], 2);
	TextDrawFont(TabletWin8Start[32], 1);
	TextDrawLetterSize(TabletWin8Start[32], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[32], -1);
	TextDrawSetOutline(TabletWin8Start[32], 0);
	TextDrawSetProportional(TabletWin8Start[32], 1);
	TextDrawSetShadow(TabletWin8Start[32], 0);
	TextDrawTextSize(TabletWin8Start[32],10,40);
	TextDrawSetSelectable(TabletWin8Start[32], 1);

	TabletWin8Start[33] = TextDrawCreate(193.000000, 291.000000, "Messages");
	TextDrawBackgroundColor(TabletWin8Start[33], 255);
	TextDrawAlignment(TabletWin8Start[33], 2);
	TextDrawFont(TabletWin8Start[33], 1);
	TextDrawLetterSize(TabletWin8Start[33], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[33], -1);
	TextDrawSetOutline(TabletWin8Start[33], 0);
	TextDrawSetProportional(TabletWin8Start[33], 1);
	TextDrawSetShadow(TabletWin8Start[33], 0);
	TextDrawTextSize(TabletWin8Start[33],10,40);
	TextDrawSetSelectable(TabletWin8Start[33], 1);

	TabletWin8Start[34] = TextDrawCreate(193.000000, 337.000000, "Desktop");
	TextDrawBackgroundColor(TabletWin8Start[34], 255);
	TextDrawAlignment(TabletWin8Start[34], 2);
	TextDrawFont(TabletWin8Start[34], 1);
	TextDrawLetterSize(TabletWin8Start[34], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[34], -1);
	TextDrawSetOutline(TabletWin8Start[34], 0);
	TextDrawSetProportional(TabletWin8Start[34], 1);
	TextDrawSetShadow(TabletWin8Start[34], 0);
	TextDrawTextSize(TabletWin8Start[34],10,40);
	TextDrawSetSelectable(TabletWin8Start[34], 1);

	TabletWin8Start[35] = TextDrawCreate(273.000000, 198.000000, "Clock");
	TextDrawBackgroundColor(TabletWin8Start[35], 255);
	TextDrawAlignment(TabletWin8Start[35], 2);
	TextDrawFont(TabletWin8Start[35], 1);
	TextDrawLetterSize(TabletWin8Start[35], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[35], -1);
	TextDrawSetOutline(TabletWin8Start[35], 0);
	TextDrawSetProportional(TabletWin8Start[35], 1);
	TextDrawSetShadow(TabletWin8Start[35], 0);
	TextDrawTextSize(TabletWin8Start[35],10,40);
	TextDrawSetSelectable(TabletWin8Start[35], 1);

	TabletWin8Start[36] = TextDrawCreate(273.000000, 246.000000, "Photos");
	TextDrawBackgroundColor(TabletWin8Start[36], 255);
	TextDrawAlignment(TabletWin8Start[36], 2);
	TextDrawFont(TabletWin8Start[36], 1);
	TextDrawLetterSize(TabletWin8Start[36], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[36], -1);
	TextDrawSetOutline(TabletWin8Start[36], 0);
	TextDrawSetProportional(TabletWin8Start[36], 1);
	TextDrawSetShadow(TabletWin8Start[36], 0);
	TextDrawTextSize(TabletWin8Start[36],10,40);
	TextDrawSetSelectable(TabletWin8Start[36], 1);

	TabletWin8Start[37] = TextDrawCreate(273.000000, 291.000000, "Finanzes");
	TextDrawBackgroundColor(TabletWin8Start[37], 255);
	TextDrawAlignment(TabletWin8Start[37], 2);
	TextDrawFont(TabletWin8Start[37], 1);
	TextDrawLetterSize(TabletWin8Start[37], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[37], -1);
	TextDrawSetOutline(TabletWin8Start[37], 0);
	TextDrawSetProportional(TabletWin8Start[37], 1);
	TextDrawSetShadow(TabletWin8Start[37], 0);
	TextDrawTextSize(TabletWin8Start[37],10,40);
	TextDrawSetSelectable(TabletWin8Start[37], 1);

	TabletWin8Start[38] = TextDrawCreate(273.000000, 338.000000, "Weather");
	TextDrawBackgroundColor(TabletWin8Start[38], 255);
	TextDrawAlignment(TabletWin8Start[38], 2);
	TextDrawFont(TabletWin8Start[38], 1);
	TextDrawLetterSize(TabletWin8Start[38], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[38], -1);
	TextDrawSetOutline(TabletWin8Start[38], 0);
	TextDrawSetProportional(TabletWin8Start[38], 1);
	TextDrawSetShadow(TabletWin8Start[38], 0);
	TextDrawTextSize(TabletWin8Start[38],10,55);
	TextDrawSetSelectable(TabletWin8Start[38], 1);

	TabletWin8Start[39] = TextDrawCreate(324.000000, 198.000000, "IE");
	TextDrawBackgroundColor(TabletWin8Start[39], 255);
	TextDrawAlignment(TabletWin8Start[39], 2);
	TextDrawFont(TabletWin8Start[39], 1);
	TextDrawLetterSize(TabletWin8Start[39], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[39], -1);
	TextDrawSetOutline(TabletWin8Start[39], 0);
	TextDrawSetProportional(TabletWin8Start[39], 1);
	TextDrawSetShadow(TabletWin8Start[39], 0);
	TextDrawTextSize(TabletWin8Start[39],10,40);
	TextDrawSetSelectable(TabletWin8Start[39], 1);

	TabletWin8Start[40] = TextDrawCreate(333.000000, 245.000000, "Maps");
	TextDrawBackgroundColor(TabletWin8Start[40], 255);
	TextDrawAlignment(TabletWin8Start[40], 2);
	TextDrawFont(TabletWin8Start[40], 1);
	TextDrawLetterSize(TabletWin8Start[40], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[40], -1);
	TextDrawSetOutline(TabletWin8Start[40], 0);
	TextDrawSetProportional(TabletWin8Start[40], 1);
	TextDrawSetShadow(TabletWin8Start[40], 0);
	TextDrawTextSize(TabletWin8Start[40],10,40);
	TextDrawSetSelectable(TabletWin8Start[40], 1);

	TabletWin8Start[41] = TextDrawCreate(341.000000, 291.000000, "Sports");
	TextDrawBackgroundColor(TabletWin8Start[41], 255);
	TextDrawAlignment(TabletWin8Start[41], 2);
	TextDrawFont(TabletWin8Start[41], 1);
	TextDrawLetterSize(TabletWin8Start[41], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[41], -1);
	TextDrawSetOutline(TabletWin8Start[41], 0);
	TextDrawSetProportional(TabletWin8Start[41], 1);
	TextDrawSetShadow(TabletWin8Start[41], 0);
	TextDrawTextSize(TabletWin8Start[41],10,40);
	TextDrawSetSelectable(TabletWin8Start[41], 1);

	TabletWin8Start[42] = TextDrawCreate(339.000000, 338.000000, "News");
	TextDrawBackgroundColor(TabletWin8Start[42], 255);
	TextDrawAlignment(TabletWin8Start[42], 2);
	TextDrawFont(TabletWin8Start[42], 1);
	TextDrawLetterSize(TabletWin8Start[42], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[42], -1);
	TextDrawSetOutline(TabletWin8Start[42], 0);
	TextDrawSetProportional(TabletWin8Start[42], 1);
	TextDrawSetShadow(TabletWin8Start[42], 0);
	TextDrawTextSize(TabletWin8Start[42],10,40);
	TextDrawSetSelectable(TabletWin8Start[42], 1);

	TabletWin8Start[43] = TextDrawCreate(371.000000, 198.000000, "Store");
	TextDrawBackgroundColor(TabletWin8Start[43], 255);
	TextDrawAlignment(TabletWin8Start[43], 2);
	TextDrawFont(TabletWin8Start[43], 1);
	TextDrawLetterSize(TabletWin8Start[43], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[43], -1);
	TextDrawSetOutline(TabletWin8Start[43], 0);
	TextDrawSetProportional(TabletWin8Start[43], 1);
	TextDrawSetShadow(TabletWin8Start[43], 0);
	TextDrawTextSize(TabletWin8Start[43],10,40);
	TextDrawSetSelectable(TabletWin8Start[43], 1);

	TabletWin8Start[44] = TextDrawCreate(371.000000, 245.000000, "SkyDw");
	TextDrawBackgroundColor(TabletWin8Start[44], 255);
	TextDrawAlignment(TabletWin8Start[44], 2);
	TextDrawFont(TabletWin8Start[44], 1);
	TextDrawLetterSize(TabletWin8Start[44], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[44], -1);
	TextDrawSetOutline(TabletWin8Start[44], 0);
	TextDrawSetProportional(TabletWin8Start[44], 1);
	TextDrawSetShadow(TabletWin8Start[44], 0);
	TextDrawTextSize(TabletWin8Start[44],10,40);
	TextDrawSetSelectable(TabletWin8Start[44], 1);

	TabletWin8Start[45] = TextDrawCreate(435.000000, 198.000000, "Bing");
	TextDrawBackgroundColor(TabletWin8Start[45], 255);
	TextDrawAlignment(TabletWin8Start[45], 2);
	TextDrawFont(TabletWin8Start[45], 1);
	TextDrawLetterSize(TabletWin8Start[45], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[45], -1);
	TextDrawSetOutline(TabletWin8Start[45], 0);
	TextDrawSetProportional(TabletWin8Start[45], 1);
	TextDrawSetShadow(TabletWin8Start[45], 0);
	TextDrawTextSize(TabletWin8Start[45],10,40);
	TextDrawSetSelectable(TabletWin8Start[45], 1);

	TabletWin8Start[46] = TextDrawCreate(440.000000, 245.000000, "Travels");
	TextDrawBackgroundColor(TabletWin8Start[46], 255);
	TextDrawAlignment(TabletWin8Start[46], 2);
	TextDrawFont(TabletWin8Start[46], 1);
	TextDrawLetterSize(TabletWin8Start[46], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[46], -1);
	TextDrawSetOutline(TabletWin8Start[46], 0);
	TextDrawSetProportional(TabletWin8Start[46], 1);
	TextDrawSetShadow(TabletWin8Start[46], 0);
	TextDrawTextSize(TabletWin8Start[46],10,40);
	TextDrawSetSelectable(TabletWin8Start[46], 1);

	TabletWin8Start[47] = TextDrawCreate(436.000000, 293.000000, "Games");
	TextDrawBackgroundColor(TabletWin8Start[47], 255);
	TextDrawAlignment(TabletWin8Start[47], 2);
	TextDrawFont(TabletWin8Start[47], 1);
	TextDrawLetterSize(TabletWin8Start[47], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[47], -1);
	TextDrawSetOutline(TabletWin8Start[47], 0);
	TextDrawSetProportional(TabletWin8Start[47], 1);
	TextDrawSetShadow(TabletWin8Start[47], 0);
	TextDrawTextSize(TabletWin8Start[47],10,40);
	TextDrawSetSelectable(TabletWin8Start[47], 1);

	TabletWin8Start[48] = TextDrawCreate(474.000000, 293.000000, "Camera");
	TextDrawBackgroundColor(TabletWin8Start[48], 255);
	TextDrawAlignment(TabletWin8Start[48], 2);
	TextDrawFont(TabletWin8Start[48], 1);
	TextDrawLetterSize(TabletWin8Start[48], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[48], -1);
	TextDrawSetOutline(TabletWin8Start[48], 0);
	TextDrawSetProportional(TabletWin8Start[48], 1);
	TextDrawSetShadow(TabletWin8Start[48], 0);
	TextDrawTextSize(TabletWin8Start[48],10,40);
	TextDrawSetSelectable(TabletWin8Start[48], 1);

	TabletWin8Start[49] = TextDrawCreate(436.000000, 338.000000, "Music");
	TextDrawBackgroundColor(TabletWin8Start[49], 255);
	TextDrawAlignment(TabletWin8Start[49], 2);
	TextDrawFont(TabletWin8Start[49], 1);
	TextDrawLetterSize(TabletWin8Start[49], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[49], -1);
	TextDrawSetOutline(TabletWin8Start[49], 0);
	TextDrawSetProportional(TabletWin8Start[49], 1);
	TextDrawSetShadow(TabletWin8Start[49], 0);
	TextDrawTextSize(TabletWin8Start[49],10,40);
	TextDrawSetSelectable(TabletWin8Start[49], 1);

	TabletWin8Start[50] = TextDrawCreate(473.000000, 338.000000, "Video");
	TextDrawBackgroundColor(TabletWin8Start[50], 255);
	TextDrawAlignment(TabletWin8Start[50], 2);
	TextDrawFont(TabletWin8Start[50], 1);
	TextDrawLetterSize(TabletWin8Start[50], 0.300000, 1.200000);
	TextDrawColor(TabletWin8Start[50], -1);
	TextDrawSetOutline(TabletWin8Start[50], 0);
	TextDrawSetProportional(TabletWin8Start[50], 1);
	TextDrawSetShadow(TabletWin8Start[50], 0);
	TextDrawTextSize(TabletWin8Start[50],10,40);
	TextDrawSetSelectable(TabletWin8Start[50], 1);

	//PAGES [ESTE]
	TabletWin8Pag[0] = TextDrawCreate(152.000000, 143.000000, "_");
	TextDrawBackgroundColor(TabletWin8Pag[0], 255);
	TextDrawFont(TabletWin8Pag[0], 1);
	TextDrawLetterSize(TabletWin8Pag[0], 0.600000, 23.200004);
	TextDrawColor(TabletWin8Pag[0], -1);
	TextDrawSetOutline(TabletWin8Pag[0], 0);
	TextDrawSetProportional(TabletWin8Pag[0], 1);
	TextDrawSetShadow(TabletWin8Pag[0], 1);
	TextDrawUseBox(TabletWin8Pag[0], 1);
	TextDrawBoxColor(TabletWin8Pag[0], -859006465);
	TextDrawTextSize(TabletWin8Pag[0], 517.000000, 80.000000);
	TextDrawSetSelectable(TabletWin8Pag[0], 0);

	TabletWin8Pag[1] = TextDrawCreate(328.000000, 262.000000, "In Development!");
	TextDrawAlignment(TabletWin8Pag[1], 2);
	TextDrawBackgroundColor(TabletWin8Pag[1], 255);
	TextDrawFont(TabletWin8Pag[1], 1);
	TextDrawLetterSize(TabletWin8Pag[1], 0.310000, 1.599999);
	TextDrawColor(TabletWin8Pag[1], -1);
	TextDrawSetOutline(TabletWin8Pag[1], 0);
	TextDrawSetProportional(TabletWin8Pag[1], 1);
	TextDrawSetShadow(TabletWin8Pag[1], 0);
	TextDrawUseBox(TabletWin8Pag[1], 1);
	TextDrawBoxColor(TabletWin8Pag[1], 255);
	TextDrawTextSize(TabletWin8Pag[1], 2.000000, 268.000000);
	TextDrawSetSelectable(TabletWin8Pag[1], 0);

	TabletWin8Pag[2] = TextDrawCreate(508.000000, 144.000000, "X");
	TextDrawAlignment(TabletWin8Pag[2], 2);
	TextDrawBackgroundColor(TabletWin8Pag[2], 255);
	TextDrawFont(TabletWin8Pag[2], 1);
	TextDrawLetterSize(TabletWin8Pag[2], 0.509999, 2.400000);
	TextDrawColor(TabletWin8Pag[2], -16776961);
	TextDrawSetOutline(TabletWin8Pag[2], 0);
	TextDrawSetProportional(TabletWin8Pag[2], 1);
	TextDrawSetShadow(TabletWin8Pag[2], 0);
	TextDrawTextSize(TabletWin8Pag[2],20,10);
	TextDrawSetSelectable(TabletWin8Pag[2], 1);
	//Fotos
	TabletPhotos[0] = TextDrawCreate(165.000000, 178.000000, "loadsc2:loadsc2");
	TextDrawAlignment(TabletPhotos[0], 2);
	TextDrawBackgroundColor(TabletPhotos[0], 255);
	TextDrawFont(TabletPhotos[0], 4);
	TextDrawLetterSize(TabletPhotos[0], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[0], -1);
	TextDrawSetOutline(TabletPhotos[0], 0);
	TextDrawSetProportional(TabletPhotos[0], 1);
	TextDrawSetShadow(TabletPhotos[0], 1);
	TextDrawUseBox(TabletPhotos[0], 1);
	TextDrawBoxColor(TabletPhotos[0], -1724671489);
	TextDrawTextSize(TabletPhotos[0], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[0], 0);

	TabletPhotos[1] = TextDrawCreate(246.000000, 178.000000, "loadsc1:loadsc1");
	TextDrawAlignment(TabletPhotos[1], 2);
	TextDrawBackgroundColor(TabletPhotos[1], 255);
	TextDrawFont(TabletPhotos[1], 4);
	TextDrawLetterSize(TabletPhotos[1], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[1], -1);
	TextDrawSetOutline(TabletPhotos[1], 0);
	TextDrawSetProportional(TabletPhotos[1], 1);
	TextDrawSetShadow(TabletPhotos[1], 1);
	TextDrawUseBox(TabletPhotos[1], 1);
	TextDrawBoxColor(TabletPhotos[1], -1724671489);
	TextDrawTextSize(TabletPhotos[1], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[1], 0);

	TabletPhotos[2] = TextDrawCreate(327.000000, 178.000000, "loadsc10:loadsc10");
	TextDrawAlignment(TabletPhotos[2], 2);
	TextDrawBackgroundColor(TabletPhotos[2], 255);
	TextDrawFont(TabletPhotos[2], 4);
	TextDrawLetterSize(TabletPhotos[2], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[2], -1);
	TextDrawSetOutline(TabletPhotos[2], 0);
	TextDrawSetProportional(TabletPhotos[2], 1);
	TextDrawSetShadow(TabletPhotos[2], 1);
	TextDrawUseBox(TabletPhotos[2], 1);
	TextDrawBoxColor(TabletPhotos[2], -1724671489);
	TextDrawTextSize(TabletPhotos[2], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[2], 0);

	TabletPhotos[3] = TextDrawCreate(409.000000, 178.000000, "loadsc11:loadsc11");
	TextDrawAlignment(TabletPhotos[3], 2);
	TextDrawBackgroundColor(TabletPhotos[3], 255);
	TextDrawFont(TabletPhotos[3], 4);
	TextDrawLetterSize(TabletPhotos[3], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[3], -1);
	TextDrawSetOutline(TabletPhotos[3], 0);
	TextDrawSetProportional(TabletPhotos[3], 1);
	TextDrawSetShadow(TabletPhotos[3], 1);
	TextDrawUseBox(TabletPhotos[3], 1);
	TextDrawBoxColor(TabletPhotos[3], -1724671489);
	TextDrawTextSize(TabletPhotos[3], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[3], 0);

	TabletPhotos[4] = TextDrawCreate(409.000000, 232.000000, "loadsc12:loadsc12");
	TextDrawAlignment(TabletPhotos[4], 2);
	TextDrawBackgroundColor(TabletPhotos[4], 255);
	TextDrawFont(TabletPhotos[4], 4);
	TextDrawLetterSize(TabletPhotos[4], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[4], -1);
	TextDrawSetOutline(TabletPhotos[4], 0);
	TextDrawSetProportional(TabletPhotos[4], 1);
	TextDrawSetShadow(TabletPhotos[4], 1);
	TextDrawUseBox(TabletPhotos[4], 1);
	TextDrawBoxColor(TabletPhotos[4], -1724671489);
	TextDrawTextSize(TabletPhotos[4], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[4], 0);

	TabletPhotos[5] = TextDrawCreate(327.000000, 232.000000, "loadsc13:loadsc13");
	TextDrawAlignment(TabletPhotos[5], 2);
	TextDrawBackgroundColor(TabletPhotos[5], 255);
	TextDrawFont(TabletPhotos[5], 4);
	TextDrawLetterSize(TabletPhotos[5], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[5], -1);
	TextDrawSetOutline(TabletPhotos[5], 0);
	TextDrawSetProportional(TabletPhotos[5], 1);
	TextDrawSetShadow(TabletPhotos[5], 1);
	TextDrawUseBox(TabletPhotos[5], 1);
	TextDrawBoxColor(TabletPhotos[5], -1724671489);
	TextDrawTextSize(TabletPhotos[5], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[5], 0);

	TabletPhotos[6] = TextDrawCreate(246.000000, 232.000000, "loadsc14:loadsc14");
	TextDrawAlignment(TabletPhotos[6], 2);
	TextDrawBackgroundColor(TabletPhotos[6], 255);
	TextDrawFont(TabletPhotos[6], 4);
	TextDrawLetterSize(TabletPhotos[6], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[6], -1);
	TextDrawSetOutline(TabletPhotos[6], 0);
	TextDrawSetProportional(TabletPhotos[6], 1);
	TextDrawSetShadow(TabletPhotos[6], 1);
	TextDrawUseBox(TabletPhotos[6], 1);
	TextDrawBoxColor(TabletPhotos[6], -1724671489);
	TextDrawTextSize(TabletPhotos[6], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[6], 0);

	TabletPhotos[7] = TextDrawCreate(165.000000, 232.000000, "loadsc3:loadsc3");
	TextDrawAlignment(TabletPhotos[7], 2);
	TextDrawBackgroundColor(TabletPhotos[7], 255);
	TextDrawFont(TabletPhotos[7], 4);
	TextDrawLetterSize(TabletPhotos[7], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[7], -1);
	TextDrawSetOutline(TabletPhotos[7], 0);
	TextDrawSetProportional(TabletPhotos[7], 1);
	TextDrawSetShadow(TabletPhotos[7], 1);
	TextDrawUseBox(TabletPhotos[7], 1);
	TextDrawBoxColor(TabletPhotos[7], -1724671489);
	TextDrawTextSize(TabletPhotos[7], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[7], 0);

	TabletPhotos[8] = TextDrawCreate(165.000000, 289.000000, "loadsc4:loadsc4");
	TextDrawAlignment(TabletPhotos[8], 2);
	TextDrawBackgroundColor(TabletPhotos[8], 255);
	TextDrawFont(TabletPhotos[8], 4);
	TextDrawLetterSize(TabletPhotos[8], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[8], -1);
	TextDrawSetOutline(TabletPhotos[8], 0);
	TextDrawSetProportional(TabletPhotos[8], 1);
	TextDrawSetShadow(TabletPhotos[8], 1);
	TextDrawUseBox(TabletPhotos[8], 1);
	TextDrawBoxColor(TabletPhotos[8], -1724671489);
	TextDrawTextSize(TabletPhotos[8], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[8], 0);

	TabletPhotos[9] = TextDrawCreate(247.000000, 289.000000, "loadsc5:loadsc5");
	TextDrawAlignment(TabletPhotos[9], 2);
	TextDrawBackgroundColor(TabletPhotos[9], 255);
	TextDrawFont(TabletPhotos[9], 4);
	TextDrawLetterSize(TabletPhotos[9], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[9], -1);
	TextDrawSetOutline(TabletPhotos[9], 0);
	TextDrawSetProportional(TabletPhotos[9], 1);
	TextDrawSetShadow(TabletPhotos[9], 1);
	TextDrawUseBox(TabletPhotos[9], 1);
	TextDrawBoxColor(TabletPhotos[9], -1724671489);
	TextDrawTextSize(TabletPhotos[9], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[9], 0);

	TabletPhotos[10] = TextDrawCreate(327.000000, 289.000000, "loadsc6:loadsc6");
	TextDrawAlignment(TabletPhotos[10], 2);
	TextDrawBackgroundColor(TabletPhotos[10], 255);
	TextDrawFont(TabletPhotos[10], 4);
	TextDrawLetterSize(TabletPhotos[10], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[10], -1);
	TextDrawSetOutline(TabletPhotos[10], 0);
	TextDrawSetProportional(TabletPhotos[10], 1);
	TextDrawSetShadow(TabletPhotos[10], 1);
	TextDrawUseBox(TabletPhotos[10], 1);
	TextDrawBoxColor(TabletPhotos[10], -1724671489);
	TextDrawTextSize(TabletPhotos[10], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[10], 0);

	TabletPhotos[11] = TextDrawCreate(410.000000, 289.000000, "loadsc7:loadsc7");
	TextDrawAlignment(TabletPhotos[11], 2);
	TextDrawBackgroundColor(TabletPhotos[11], 255);
	TextDrawFont(TabletPhotos[11], 4);
	TextDrawLetterSize(TabletPhotos[11], 0.500000, 0.299998);
	TextDrawColor(TabletPhotos[11], -1);
	TextDrawSetOutline(TabletPhotos[11], 0);
	TextDrawSetProportional(TabletPhotos[11], 1);
	TextDrawSetShadow(TabletPhotos[11], 1);
	TextDrawUseBox(TabletPhotos[11], 1);
	TextDrawBoxColor(TabletPhotos[11], -1724671489);
	TextDrawTextSize(TabletPhotos[11], 72.000000, 42.000000);
	TextDrawSetSelectable(TabletPhotos[11], 0);

	//Music Player
	TabletMusicPlayer[0] = TextDrawCreate(330.000000, 184.000000, "PSY - Gangnam Style");
	TextDrawAlignment(TabletMusicPlayer[0], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[0], 255);
	TextDrawFont(TabletMusicPlayer[0], 1);
	TextDrawLetterSize(TabletMusicPlayer[0], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[0], -1);
	TextDrawSetOutline(TabletMusicPlayer[0], 0);
	TextDrawSetProportional(TabletMusicPlayer[0], 1);
	TextDrawSetShadow(TabletMusicPlayer[0], 0);
	TextDrawTextSize(TabletMusicPlayer[0], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[0], 1);

	TabletMusicPlayer[1] = TextDrawCreate(330.000000, 198.000000, "Eric Prydz - Pjanoo");
	TextDrawAlignment(TabletMusicPlayer[1], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[1], 255);
	TextDrawFont(TabletMusicPlayer[1], 1);
	TextDrawLetterSize(TabletMusicPlayer[1], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[1], -1);
	TextDrawSetOutline(TabletMusicPlayer[1], 0);
	TextDrawSetProportional(TabletMusicPlayer[1], 1);
	TextDrawSetShadow(TabletMusicPlayer[1], 0);
	TextDrawTextSize(TabletMusicPlayer[1], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[1], 1);

	TabletMusicPlayer[2] = TextDrawCreate(330.000000, 211.000000, "Tacabro - Tacata");
	TextDrawAlignment(TabletMusicPlayer[2], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[2], 255);
	TextDrawFont(TabletMusicPlayer[2], 1);
	TextDrawLetterSize(TabletMusicPlayer[2], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[2], -1);
	TextDrawSetOutline(TabletMusicPlayer[2], 0);
	TextDrawSetProportional(TabletMusicPlayer[2], 1);
	TextDrawSetShadow(TabletMusicPlayer[2], 0);
	TextDrawTextSize(TabletMusicPlayer[2], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[2], 1);

	TabletMusicPlayer[3] = TextDrawCreate(330.000000, 225.000000, "P Holla - Do it for love");
	TextDrawAlignment(TabletMusicPlayer[3], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[3], 255);
	TextDrawFont(TabletMusicPlayer[3], 1);
	TextDrawLetterSize(TabletMusicPlayer[3], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[3], -1);
	TextDrawSetOutline(TabletMusicPlayer[3], 0);
	TextDrawSetProportional(TabletMusicPlayer[3], 1);
	TextDrawSetShadow(TabletMusicPlayer[3], 0);
	TextDrawTextSize(TabletMusicPlayer[3], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[3], 1);

	TabletMusicPlayer[4] = TextDrawCreate(330.000000, 238.000000, "Gustavo Lima - Balada Boa");
	TextDrawAlignment(TabletMusicPlayer[4], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[4], 255);
	TextDrawFont(TabletMusicPlayer[4], 1);
	TextDrawLetterSize(TabletMusicPlayer[4], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[4], -1);
	TextDrawSetOutline(TabletMusicPlayer[4], 0);
	TextDrawSetProportional(TabletMusicPlayer[4], 1);
	TextDrawSetShadow(TabletMusicPlayer[4], 0);
	TextDrawTextSize(TabletMusicPlayer[4], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[4], 1);

	TabletMusicPlayer[5] = TextDrawCreate(330.000000, 251.000000, "LMFAO - Party Rock");
	TextDrawAlignment(TabletMusicPlayer[5], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[5], 255);
	TextDrawFont(TabletMusicPlayer[5], 1);
	TextDrawLetterSize(TabletMusicPlayer[5], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[5], -1);
	TextDrawSetOutline(TabletMusicPlayer[5], 0);
	TextDrawSetProportional(TabletMusicPlayer[5], 1);
	TextDrawSetShadow(TabletMusicPlayer[5], 0);
	TextDrawTextSize(TabletMusicPlayer[5], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[5], 1);

	TabletMusicPlayer[6] = TextDrawCreate(330.000000, 265.000000, "LMFAO - Sexy and I know");
	TextDrawAlignment(TabletMusicPlayer[6], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[6], 255);
	TextDrawFont(TabletMusicPlayer[6], 1);
	TextDrawLetterSize(TabletMusicPlayer[6], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[6], -1);
	TextDrawSetOutline(TabletMusicPlayer[6], 0);
	TextDrawSetProportional(TabletMusicPlayer[6], 1);
	TextDrawSetShadow(TabletMusicPlayer[6], 0);
	TextDrawTextSize(TabletMusicPlayer[6], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[6], 1);

	TabletMusicPlayer[7] = TextDrawCreate(330.000000, 279.000000, "Played a live - Safari Duo");
	TextDrawAlignment(TabletMusicPlayer[7], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[7], 255);
	TextDrawFont(TabletMusicPlayer[7], 1);
	TextDrawLetterSize(TabletMusicPlayer[7], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[7], -1);
	TextDrawSetOutline(TabletMusicPlayer[7], 0);
	TextDrawSetProportional(TabletMusicPlayer[7], 1);
	TextDrawSetShadow(TabletMusicPlayer[7], 0);
	TextDrawTextSize(TabletMusicPlayer[7], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[7], 1);

	TabletMusicPlayer[8] = TextDrawCreate(330.000000, 293.000000, "Guru Josh Project - Infinity");
	TextDrawAlignment(TabletMusicPlayer[8], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[8], 255);
	TextDrawFont(TabletMusicPlayer[8], 1);
	TextDrawLetterSize(TabletMusicPlayer[8], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[8], -1);
	TextDrawSetOutline(TabletMusicPlayer[8], 0);
	TextDrawSetProportional(TabletMusicPlayer[8], 1);
	TextDrawSetShadow(TabletMusicPlayer[8], 0);
	TextDrawTextSize(TabletMusicPlayer[8], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[8], 1);

	TabletMusicPlayer[9] = TextDrawCreate(330.000000, 307.000000, "Quiero rayos de sol - Jose..");
	TextDrawAlignment(TabletMusicPlayer[9], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[9], 255);
	TextDrawFont(TabletMusicPlayer[9], 1);
	TextDrawLetterSize(TabletMusicPlayer[9], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[9], -1);
	TextDrawSetOutline(TabletMusicPlayer[9], 0);
	TextDrawSetProportional(TabletMusicPlayer[9], 1);
	TextDrawSetShadow(TabletMusicPlayer[9], 0);
	TextDrawTextSize(TabletMusicPlayer[9], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[9], 1);

	TabletMusicPlayer[10] = TextDrawCreate(330.000000, 321.000000, "II");
	TextDrawAlignment(TabletMusicPlayer[10], 2);
	TextDrawBackgroundColor(TabletMusicPlayer[10], 255);
	TextDrawFont(TabletMusicPlayer[10], 1);
	TextDrawLetterSize(TabletMusicPlayer[10], 0.460000, 1.500000);
	TextDrawColor(TabletMusicPlayer[10], -1);
	TextDrawSetOutline(TabletMusicPlayer[10], 0);
	TextDrawSetProportional(TabletMusicPlayer[10], 1);
	TextDrawSetShadow(TabletMusicPlayer[10], 0);
	TextDrawTextSize(TabletMusicPlayer[10], 10.000000, 250.000000);
	TextDrawSetSelectable(TabletMusicPlayer[10], 1);

	//TwoBut
	TwoBut[0] = TextDrawCreate(149.000000, 139.000000, "_");
	TextDrawBackgroundColor(TwoBut[0], 255);
	TextDrawFont(TwoBut[0], 1);
	TextDrawLetterSize(TwoBut[0], 0.500000, 24.200000);
	TextDrawColor(TwoBut[0], -1);
	TextDrawSetOutline(TwoBut[0], 0);
	TextDrawSetProportional(TwoBut[0], 1);
	TextDrawSetShadow(TwoBut[0], 1);
	TextDrawUseBox(TwoBut[0], 1);
	TextDrawBoxColor(TwoBut[0], 842150655);
	TextDrawTextSize(TwoBut[0], 522.000000, 30.000000);
	TextDrawSetSelectable(TwoBut[0], 0);

	TwoBut[1] = TextDrawCreate(526.000000, 238.000000, "LD_BEAT:square");
	TextDrawAlignment(TwoBut[1], 2);
	TextDrawBackgroundColor(TwoBut[1], 255);
	TextDrawFont(TwoBut[1], 4);
	TextDrawLetterSize(TwoBut[1], 0.460000, 1.700000);
	TextDrawColor(TwoBut[1], -1);
	TextDrawSetOutline(TwoBut[1], 0);
	TextDrawSetProportional(TwoBut[1], 1);
	TextDrawSetShadow(TwoBut[1], 0);
	TextDrawUseBox(TwoBut[1], 1);
	TextDrawBoxColor(TwoBut[1], 255);
	TextDrawTextSize(TwoBut[1], 18.000000, 22.000000);
	TextDrawSetSelectable(TwoBut[1], 1);

	//Camara TextDraw
	CameraTD[0] = TextDrawCreate(122.000000, 93.000000, "O____________iiO~n~~n~~n~O____________iiO~n~~n~~n~O____________iiO");
	TextDrawBackgroundColor(CameraTD[0], 255);
	TextDrawFont(CameraTD[0], 1);
	TextDrawLetterSize(CameraTD[0], 1.600000, 8.299999);
	TextDrawColor(CameraTD[0], 255);
	TextDrawSetOutline(CameraTD[0], 1);
	TextDrawSetProportional(CameraTD[0], 1);
	TextDrawSetSelectable(CameraTD[0], 0);

	CameraTD[1] = TextDrawCreate(122.000000, 132.000000, "_");
	TextDrawBackgroundColor(CameraTD[1], 255);
	TextDrawFont(CameraTD[1], 1);
	TextDrawLetterSize(CameraTD[1], 0.050000, 24.400005);
	TextDrawColor(CameraTD[1], -1);
	TextDrawSetOutline(CameraTD[1], 0);
	TextDrawSetProportional(CameraTD[1], 1);
	TextDrawSetShadow(CameraTD[1], 1);
	TextDrawUseBox(CameraTD[1], 1);
	TextDrawBoxColor(CameraTD[1], 255);
	TextDrawTextSize(CameraTD[1], 146.000000, 10.000000);
	TextDrawSetSelectable(CameraTD[1], 0);

	CameraTD[2] = TextDrawCreate(120.000000, 387.000000, "hud:radardisc");
	TextDrawBackgroundColor(CameraTD[2], 255);
	TextDrawFont(CameraTD[2], 4);
	TextDrawLetterSize(CameraTD[2], 0.500000, 1.000000);
	TextDrawColor(CameraTD[2], -1);
	TextDrawSetOutline(CameraTD[2], 0);
	TextDrawSetProportional(CameraTD[2], 1);
	TextDrawSetShadow(CameraTD[2], 1);
	TextDrawUseBox(CameraTD[2], 1);
	TextDrawBoxColor(CameraTD[2], 255);
	TextDrawTextSize(CameraTD[2], 27.000000, -33.000000);
	TextDrawSetSelectable(CameraTD[2], 0);

	CameraTD[3] = TextDrawCreate(551.000000, 388.000000, "hud:radardisc");
	TextDrawBackgroundColor(CameraTD[3], 255);
	TextDrawFont(CameraTD[3], 4);
	TextDrawLetterSize(CameraTD[3], 0.500000, 1.000000);
	TextDrawColor(CameraTD[3], -1);
	TextDrawSetOutline(CameraTD[3], 0);
	TextDrawSetProportional(CameraTD[3], 1);
	TextDrawSetShadow(CameraTD[3], 1);
	TextDrawUseBox(CameraTD[3], 1);
	TextDrawBoxColor(CameraTD[3], 255);
	TextDrawTextSize(CameraTD[3], -27.000000, -33.000000);
	TextDrawSetSelectable(CameraTD[3], 0);

	CameraTD[4] = TextDrawCreate(551.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(CameraTD[4], 255);
	TextDrawFont(CameraTD[4], 4);
	TextDrawLetterSize(CameraTD[4], 0.500000, 1.000000);
	TextDrawColor(CameraTD[4], -1);
	TextDrawSetOutline(CameraTD[4], 0);
	TextDrawSetProportional(CameraTD[4], 1);
	TextDrawSetShadow(CameraTD[4], 1);
	TextDrawUseBox(CameraTD[4], 1);
	TextDrawBoxColor(CameraTD[4], 255);
	TextDrawTextSize(CameraTD[4], -27.000000, 33.000000);
	TextDrawSetSelectable(CameraTD[4], 0);

	CameraTD[5] = TextDrawCreate(120.000000, 104.000000, "hud:radardisc");
	TextDrawBackgroundColor(CameraTD[5], 255);
	TextDrawFont(CameraTD[5], 4);
	TextDrawLetterSize(CameraTD[5], 0.500000, 1.000000);
	TextDrawColor(CameraTD[5], -1);
	TextDrawSetOutline(CameraTD[5], 0);
	TextDrawSetProportional(CameraTD[5], 1);
	TextDrawSetShadow(CameraTD[5], 1);
	TextDrawUseBox(CameraTD[5], 1);
	TextDrawBoxColor(CameraTD[5], 255);
	TextDrawTextSize(CameraTD[5], 27.000000, 33.000000);
	TextDrawSetSelectable(CameraTD[5], 0);

	CameraTD[6] = TextDrawCreate(537.000000, 134.000000, "_");
	TextDrawAlignment(CameraTD[6], 2);
	TextDrawBackgroundColor(CameraTD[6], 255);
	TextDrawFont(CameraTD[6], 1);
	TextDrawLetterSize(CameraTD[6], 0.050000, 24.400005);
	TextDrawColor(CameraTD[6], -1);
	TextDrawSetOutline(CameraTD[6], 0);
	TextDrawSetProportional(CameraTD[6], 1);
	TextDrawSetShadow(CameraTD[6], 1);
	TextDrawUseBox(CameraTD[6], 1);
	TextDrawBoxColor(CameraTD[6], 255);
	TextDrawTextSize(CameraTD[6], 146.000000, 24.000000);
	TextDrawSetSelectable(CameraTD[6], 0);

	CameraTD[7] = TextDrawCreate(149.000000, 139.000000, "_");
	TextDrawBackgroundColor(CameraTD[7], 255);
	TextDrawFont(CameraTD[7], 1);
	TextDrawLetterSize(CameraTD[7], 0.470000, -0.099999);
	TextDrawColor(CameraTD[7], -1);
	TextDrawSetOutline(CameraTD[7], 0);
	TextDrawSetProportional(CameraTD[7], 1);
	TextDrawSetShadow(CameraTD[7], 1);
	TextDrawUseBox(CameraTD[7], 1);
	TextDrawBoxColor(CameraTD[7], 1711315455);
	TextDrawTextSize(CameraTD[7], 522.000000, 10.000000);
	TextDrawSetSelectable(CameraTD[7], 0);

	CameraTD[8] = TextDrawCreate(526.000000, 106.000000, "_");
	TextDrawBackgroundColor(CameraTD[8], 255);
	TextDrawFont(CameraTD[8], 1);
	TextDrawLetterSize(CameraTD[8], 0.060000, 3.200005);
	TextDrawColor(CameraTD[8], -1);
	TextDrawSetOutline(CameraTD[8], 0);
	TextDrawSetProportional(CameraTD[8], 1);
	TextDrawSetShadow(CameraTD[8], 1);
	TextDrawUseBox(CameraTD[8], 1);
	TextDrawBoxColor(CameraTD[8], 255);
	TextDrawTextSize(CameraTD[8], 145.000000, 10.000000);
	TextDrawSetSelectable(CameraTD[8], 0);

	CameraTD[9] = TextDrawCreate(526.000000, 355.000000, "_");
	TextDrawBackgroundColor(CameraTD[9], 255);
	TextDrawFont(CameraTD[9], 1);
	TextDrawLetterSize(CameraTD[9], 0.060000, 3.200005);
	TextDrawColor(CameraTD[9], -1);
	TextDrawSetOutline(CameraTD[9], 0);
	TextDrawSetProportional(CameraTD[9], 1);
	TextDrawSetShadow(CameraTD[9], 1);
	TextDrawUseBox(CameraTD[9], 1);
	TextDrawBoxColor(CameraTD[9], 255);
	TextDrawTextSize(CameraTD[9], 145.000000, 10.000000);
	TextDrawSetSelectable(CameraTD[9], 0);

	CameraTD[10] = TextDrawCreate(149.000000, 352.000000, "_");
	TextDrawBackgroundColor(CameraTD[10], 255);
	TextDrawFont(CameraTD[10], 1);
	TextDrawLetterSize(CameraTD[10], 0.470000, -0.099999);
	TextDrawColor(CameraTD[10], -1);
	TextDrawSetOutline(CameraTD[10], 0);
	TextDrawSetProportional(CameraTD[10], 1);
	TextDrawSetShadow(CameraTD[10], 1);
	TextDrawUseBox(CameraTD[10], 1);
	TextDrawBoxColor(CameraTD[10], 1711315455);
	TextDrawTextSize(CameraTD[10], 522.000000, 10.000000);
	TextDrawSetSelectable(CameraTD[10], 0);

	CameraTD[11] = TextDrawCreate(152.000000, 334.000000, "_");
	TextDrawBackgroundColor(CameraTD[11], 255);
	TextDrawFont(CameraTD[11], 1);
	TextDrawLetterSize(CameraTD[11], 0.570000, 1.400006);
	TextDrawColor(CameraTD[11], -1);
	TextDrawSetOutline(CameraTD[11], 0);
	TextDrawSetProportional(CameraTD[11], 1);
	TextDrawSetShadow(CameraTD[11], 1);
	TextDrawUseBox(CameraTD[11], 1);
	TextDrawBoxColor(CameraTD[11], -859006465);
	TextDrawTextSize(CameraTD[11], 518.000000, 80.000000);
	TextDrawSetSelectable(CameraTD[11], 0);

	CameraTD[12] = TextDrawCreate(149.000000, 142.000000, "_");
	TextDrawBackgroundColor(CameraTD[12], 255);
	TextDrawFont(CameraTD[12], 1);
	TextDrawLetterSize(CameraTD[12], 0.470000, 23.000007);
	TextDrawColor(CameraTD[12], -1);
	TextDrawSetOutline(CameraTD[12], 0);
	TextDrawSetProportional(CameraTD[12], 1);
	TextDrawSetShadow(CameraTD[12], 1);
	TextDrawUseBox(CameraTD[12], 1);
	TextDrawBoxColor(CameraTD[12], 1711315455);
	TextDrawTextSize(CameraTD[12], 148.000000, 20.000000);
	TextDrawSetSelectable(CameraTD[12], 0);

	CameraTD[13] = TextDrawCreate(526.000000, 141.000000, "_");
	TextDrawBackgroundColor(CameraTD[13], 255);
	TextDrawFont(CameraTD[13], 1);
	TextDrawLetterSize(CameraTD[13], 0.470000, 23.000007);
	TextDrawColor(CameraTD[13], -1);
	TextDrawSetOutline(CameraTD[13], 0);
	TextDrawSetProportional(CameraTD[13], 1);
	TextDrawSetShadow(CameraTD[13], 1);
	TextDrawUseBox(CameraTD[13], 1);
	TextDrawBoxColor(CameraTD[13], 1711315455);
	TextDrawTextSize(CameraTD[13], 518.000000, 20.000000);
	TextDrawSetSelectable(CameraTD[13], 0);

	CameraTD[14] = TextDrawCreate(328.000000, 334.000000, "Press F8 to take photo, press Y to exit");
	TextDrawAlignment(CameraTD[14], 2);
	TextDrawBackgroundColor(CameraTD[14], 255);
	TextDrawFont(CameraTD[14], 1);
	TextDrawLetterSize(CameraTD[14], 0.309999, 1.200000);
	TextDrawColor(CameraTD[14], -1);
	TextDrawSetOutline(CameraTD[14], 0);
	TextDrawSetProportional(CameraTD[14], 1);
	TextDrawSetShadow(CameraTD[14], 0);
	TextDrawSetSelectable(CameraTD[14], 0);

	CameraTD[15] = TextDrawCreate(130.000000, 116.000000, "I");
	TextDrawBackgroundColor(CameraTD[15], 255);
	TextDrawFont(CameraTD[15], 1);
	TextDrawLetterSize(CameraTD[15], 1.970000, 2.299999);
	TextDrawColor(CameraTD[15], 255);
	TextDrawSetOutline(CameraTD[15], 0);
	TextDrawSetProportional(CameraTD[15], 1);
	TextDrawSetShadow(CameraTD[15], 0);
	TextDrawSetSelectable(CameraTD[15], 0);

	CameraTD[16] = TextDrawCreate(129.000000, 344.000000, "I");
	TextDrawBackgroundColor(CameraTD[16], 255);
	TextDrawFont(CameraTD[16], 1);
	TextDrawLetterSize(CameraTD[16], 1.970000, 4.199998);
	TextDrawColor(CameraTD[16], 255);
	TextDrawSetOutline(CameraTD[16], 0);
	TextDrawSetProportional(CameraTD[16], 1);
	TextDrawSetShadow(CameraTD[16], 0);
	TextDrawSetSelectable(CameraTD[16], 0);

	CameraTD[17] = TextDrawCreate(517.000000, 344.000000, "I");
	TextDrawBackgroundColor(CameraTD[17], 255);
	TextDrawFont(CameraTD[17], 1);
	TextDrawLetterSize(CameraTD[17], 1.970000, 4.199998);
	TextDrawColor(CameraTD[17], 255);
	TextDrawSetOutline(CameraTD[17], 0);
	TextDrawSetProportional(CameraTD[17], 1);
	TextDrawSetShadow(CameraTD[17], 0);
	TextDrawSetSelectable(CameraTD[17], 0);

	CameraTD[18] = TextDrawCreate(517.000000, 103.000000, "I");
	TextDrawBackgroundColor(CameraTD[18], 255);
	TextDrawFont(CameraTD[18], 1);
	TextDrawLetterSize(CameraTD[18], 1.970000, 4.199998);
	TextDrawColor(CameraTD[18], 255);
	TextDrawSetOutline(CameraTD[18], 0);
	TextDrawSetProportional(CameraTD[18], 1);
	TextDrawSetShadow(CameraTD[18], 0);
	TextDrawSetSelectable(CameraTD[18], 0);

	CameraTD[19] = TextDrawCreate(328.000000, 222.000000, "I");
	TextDrawBackgroundColor(CameraTD[19], 255);
	TextDrawFont(CameraTD[19], 1);
	TextDrawLetterSize(CameraTD[19], 0.210000, 3.299999);
	TextDrawColor(CameraTD[19], -1);
	TextDrawSetOutline(CameraTD[19], 0);
	TextDrawSetProportional(CameraTD[19], 1);
	TextDrawSetShadow(CameraTD[19], 0);
	TextDrawSetSelectable(CameraTD[19], 0);

	CameraTD[20] = TextDrawCreate(311.000000, 236.000000, "I");
	TextDrawBackgroundColor(CameraTD[20], 255);
	TextDrawFont(CameraTD[20], 1);
	TextDrawLetterSize(CameraTD[20], 2.999999, 0.299999);
	TextDrawColor(CameraTD[20], -1);
	TextDrawSetOutline(CameraTD[20], 0);
	TextDrawSetProportional(CameraTD[20], 1);
	TextDrawSetShadow(CameraTD[20], 0);
	TextDrawSetSelectable(CameraTD[20], 0);

	CameraTD[21] = TextDrawCreate(152.000000, 143.000000, "_");
	TextDrawBackgroundColor(CameraTD[21], 255);
	TextDrawFont(CameraTD[21], 1);
	TextDrawLetterSize(CameraTD[21], 0.570000, 1.400006);
	TextDrawColor(CameraTD[21], -1);
	TextDrawSetOutline(CameraTD[21], 0);
	TextDrawSetProportional(CameraTD[21], 1);
	TextDrawSetShadow(CameraTD[21], 1);
	TextDrawUseBox(CameraTD[21], 1);
	TextDrawBoxColor(CameraTD[21], -859006465);
	TextDrawTextSize(CameraTD[21], 518.000000, 80.000000);
	TextDrawSetSelectable(CameraTD[21], 0);

	CameraTD[22] = TextDrawCreate(328.000000, 141.000000, "CAMERA");
	TextDrawAlignment(CameraTD[22], 2);
	TextDrawBackgroundColor(CameraTD[22], 255);
	TextDrawFont(CameraTD[22], 1);
	TextDrawLetterSize(CameraTD[22], 0.459999, 1.600000);
	TextDrawColor(CameraTD[22], -1);
	TextDrawSetOutline(CameraTD[22], 0);
	TextDrawSetProportional(CameraTD[22], 1);
	TextDrawSetShadow(CameraTD[22], 0);
	TextDrawSetSelectable(CameraTD[22], 0);

	CameraTD[23] = TextDrawCreate(508.000000, 138.000000, "X");
	TextDrawAlignment(CameraTD[23], 2);
	TextDrawBackgroundColor(CameraTD[23], 255);
	TextDrawFont(CameraTD[23], 1);
	TextDrawLetterSize(CameraTD[23], 0.509998, 2.400000);
	TextDrawColor(CameraTD[23], -16776961);
	TextDrawSetOutline(CameraTD[23], 0);
	TextDrawSetProportional(CameraTD[23], 1);
	TextDrawSetShadow(CameraTD[23], 0);
	TextDrawSetSelectable(CameraTD[23], 1);

	//Maps TD
	MapsTD[0] = TextDrawCreate(250.000000, 182.000000, "samaps:gtasamapbit1");
	TextDrawAlignment(MapsTD[0], 2);
	TextDrawBackgroundColor(MapsTD[0], 255);
	TextDrawFont(MapsTD[0], 4);
	TextDrawLetterSize(MapsTD[0], 0.470000, 0.699999);
	TextDrawColor(MapsTD[0], -1);
	TextDrawSetOutline(MapsTD[0], 0);
	TextDrawSetProportional(MapsTD[0], 1);
	TextDrawSetShadow(MapsTD[0], 1);
	TextDrawUseBox(MapsTD[0], 1);
	TextDrawBoxColor(MapsTD[0], 255);
	TextDrawTextSize(MapsTD[0], 80.000000, 80.000000);
	TextDrawSetSelectable(MapsTD[0], 1);

	MapsTD[1] = TextDrawCreate(330.000000, 182.000000, "samaps:gtasamapbit2");
	TextDrawAlignment(MapsTD[1], 2);
	TextDrawBackgroundColor(MapsTD[1], 255);
	TextDrawFont(MapsTD[1], 4);
	TextDrawLetterSize(MapsTD[1], 0.470000, 0.699999);
	TextDrawColor(MapsTD[1], -1);
	TextDrawSetOutline(MapsTD[1], 0);
	TextDrawSetProportional(MapsTD[1], 1);
	TextDrawSetShadow(MapsTD[1], 1);
	TextDrawUseBox(MapsTD[1], 1);
	TextDrawBoxColor(MapsTD[1], 255);
	TextDrawTextSize(MapsTD[1], 80.000000, 80.000000);
	TextDrawSetSelectable(MapsTD[1], 1);

	MapsTD[2] = TextDrawCreate(250.000000, 262.000000, "samaps:gtasamapbit3");
	TextDrawAlignment(MapsTD[2], 2);
	TextDrawBackgroundColor(MapsTD[2], 255);
	TextDrawFont(MapsTD[2], 4);
	TextDrawLetterSize(MapsTD[2], 0.470000, 0.699999);
	TextDrawColor(MapsTD[2], -1);
	TextDrawSetOutline(MapsTD[2], 0);
	TextDrawSetProportional(MapsTD[2], 1);
	TextDrawSetShadow(MapsTD[2], 1);
	TextDrawUseBox(MapsTD[2], 1);
	TextDrawBoxColor(MapsTD[2], 255);
	TextDrawTextSize(MapsTD[2], 80.000000, 80.000000);
	TextDrawSetSelectable(MapsTD[2], 1);

	MapsTD[3] = TextDrawCreate(330.000000, 262.000000, "samaps:gtasamapbit4");
	TextDrawAlignment(MapsTD[3], 2);
	TextDrawBackgroundColor(MapsTD[3], 255);
	TextDrawFont(MapsTD[3], 4);
	TextDrawLetterSize(MapsTD[3], 0.470000, 0.699999);
	TextDrawColor(MapsTD[3], -1);
	TextDrawSetOutline(MapsTD[3], 0);
	TextDrawSetProportional(MapsTD[3], 1);
	TextDrawSetShadow(MapsTD[3], 1);
	TextDrawUseBox(MapsTD[3], 1);
	TextDrawBoxColor(MapsTD[3], 255);
	TextDrawTextSize(MapsTD[3], 80.000000, 80.000000);
	TextDrawSetSelectable(MapsTD[3], 1);

	MapsTD[4] = TextDrawCreate(250.000000, 182.000000, "samaps:gtasamapbit1");
	TextDrawAlignment(MapsTD[4], 2);
	TextDrawBackgroundColor(MapsTD[4], 255);
	TextDrawFont(MapsTD[4], 4);
	TextDrawLetterSize(MapsTD[4], 0.470000, 0.699999);
	TextDrawColor(MapsTD[4], -1);
	TextDrawSetOutline(MapsTD[4], 0);
	TextDrawSetProportional(MapsTD[4], 1);
	TextDrawSetShadow(MapsTD[4], 1);
	TextDrawUseBox(MapsTD[4], 1);
	TextDrawBoxColor(MapsTD[4], 255);
	TextDrawTextSize(MapsTD[4], 160.000000, 160.000000);
	TextDrawSetSelectable(MapsTD[4], 1);

	MapsTD[5] = TextDrawCreate(250.000000, 182.000000, "samaps:gtasamapbit2");
	TextDrawAlignment(MapsTD[5], 2);
	TextDrawBackgroundColor(MapsTD[5], 255);
	TextDrawFont(MapsTD[5], 4);
	TextDrawLetterSize(MapsTD[5], 0.470000, 0.699999);
	TextDrawColor(MapsTD[5], -1);
	TextDrawSetOutline(MapsTD[5], 0);
	TextDrawSetProportional(MapsTD[5], 1);
	TextDrawSetShadow(MapsTD[5], 1);
	TextDrawUseBox(MapsTD[5], 1);
	TextDrawBoxColor(MapsTD[5], 255);
	TextDrawTextSize(MapsTD[5], 160.000000, 160.000000);
	TextDrawSetSelectable(MapsTD[5], 1);

	MapsTD[6] = TextDrawCreate(250.000000, 182.000000, "samaps:gtasamapbit3");
	TextDrawAlignment(MapsTD[6], 2);
	TextDrawBackgroundColor(MapsTD[6], 255);
	TextDrawFont(MapsTD[6], 4);
	TextDrawLetterSize(MapsTD[6], 0.470000, 0.699999);
	TextDrawColor(MapsTD[6], -1);
	TextDrawSetOutline(MapsTD[6], 0);
	TextDrawSetProportional(MapsTD[6], 1);
	TextDrawSetShadow(MapsTD[6], 1);
	TextDrawUseBox(MapsTD[6], 1);
	TextDrawBoxColor(MapsTD[6], 255);
	TextDrawTextSize(MapsTD[6], 160.000000, 160.000000);
	TextDrawSetSelectable(MapsTD[6], 1);

	MapsTD[7] = TextDrawCreate(250.000000, 182.000000, "samaps:gtasamapbit4");
	TextDrawAlignment(MapsTD[7], 2);
	TextDrawBackgroundColor(MapsTD[7], 255);
	TextDrawFont(MapsTD[7], 4);
	TextDrawLetterSize(MapsTD[7], 0.470000, 0.699999);
	TextDrawColor(MapsTD[7], -1);
	TextDrawSetOutline(MapsTD[7], 0);
	TextDrawSetProportional(MapsTD[7], 1);
	TextDrawSetShadow(MapsTD[7], 1);
	TextDrawUseBox(MapsTD[7], 1);
	TextDrawBoxColor(MapsTD[7], 255);
	TextDrawTextSize(MapsTD[7], 160.000000, 160.000000);
	TextDrawSetSelectable(MapsTD[7], 1);

	//Games
 	Games = TextDrawCreate(328.000000, 192.000000, "slot machine");
	TextDrawAlignment(Games, 2);
	TextDrawBackgroundColor(Games, 255);
	TextDrawFont(Games, 3);
	TextDrawLetterSize(Games, 0.450000, 1.600001);
	TextDrawColor(Games, -1);
	TextDrawSetOutline(Games, 0);
	TextDrawSetProportional(Games, 1);
	TextDrawSetShadow(Games, 0);
	TextDrawUseBox(Games, 1);
	TextDrawBoxColor(Games, 255);
	TextDrawTextSize(Games, 10.000000, 112.000000);
	TextDrawSetSelectable(Games, 1);

	//User loader [ESTE]
	TabletWin8UserLog[0] = TextDrawCreate(223.000000, 173.000000, "_");
	TextDrawAlignment(TabletWin8UserLog[0], 2);
	TextDrawBackgroundColor(TabletWin8UserLog[0], 255);
	TextDrawFont(TabletWin8UserLog[0], 1);
	TextDrawLetterSize(TabletWin8UserLog[0], 0.500000, 16.100004);
	TextDrawColor(TabletWin8UserLog[0], -1);
	TextDrawSetOutline(TabletWin8UserLog[0], 0);
	TextDrawSetProportional(TabletWin8UserLog[0], 1);
	TextDrawSetShadow(TabletWin8UserLog[0], 1);
	TextDrawUseBox(TabletWin8UserLog[0], 1);
	TextDrawBoxColor(TabletWin8UserLog[0], -859006465);
	TextDrawTextSize(TabletWin8UserLog[0], 0.000000, 112.000000);
	TextDrawSetSelectable(TabletWin8UserLog[0], 0);

	TabletWin8UserLog[1] = TextDrawCreate(217.000000, 151.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[1], 255);
	TextDrawFont(TabletWin8UserLog[1], 1);
	TextDrawLetterSize(TabletWin8UserLog[1], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[1], -1);
	TextDrawSetOutline(TabletWin8UserLog[1], 0);
	TextDrawSetProportional(TabletWin8UserLog[1], 1);
	TextDrawSetShadow(TabletWin8UserLog[1], 0);
	TextDrawSetSelectable(TabletWin8UserLog[1], 0);

	TabletWin8UserLog[2] = TextDrawCreate(211.000000, 196.000000, "I");
	TextDrawBackgroundColor(TabletWin8UserLog[2], 255);
	TextDrawFont(TabletWin8UserLog[2], 1);
	TextDrawLetterSize(TabletWin8UserLog[2], 1.700000, 7.299999);
	TextDrawColor(TabletWin8UserLog[2], -1);
	TextDrawSetOutline(TabletWin8UserLog[2], 0);
	TextDrawSetProportional(TabletWin8UserLog[2], 1);
	TextDrawSetShadow(TabletWin8UserLog[2], 0);
	TextDrawSetSelectable(TabletWin8UserLog[2], 0);

	TabletWin8UserLog[3] = TextDrawCreate(200.000000, 236.000000, "I");
	TextDrawBackgroundColor(TabletWin8UserLog[3], 255);
	TextDrawFont(TabletWin8UserLog[3], 1);
	TextDrawLetterSize(TabletWin8UserLog[3], 1.700000, 7.299999);
	TextDrawColor(TabletWin8UserLog[3], -1);
	TextDrawSetOutline(TabletWin8UserLog[3], 0);
	TextDrawSetProportional(TabletWin8UserLog[3], 1);
	TextDrawSetShadow(TabletWin8UserLog[3], 0);
	TextDrawSetSelectable(TabletWin8UserLog[3], 0);

	TabletWin8UserLog[4] = TextDrawCreate(223.000000, 236.000000, "I");
	TextDrawBackgroundColor(TabletWin8UserLog[4], 255);
	TextDrawFont(TabletWin8UserLog[4], 1);
	TextDrawLetterSize(TabletWin8UserLog[4], 1.700000, 7.299999);
	TextDrawColor(TabletWin8UserLog[4], -1);
	TextDrawSetOutline(TabletWin8UserLog[4], 0);
	TextDrawSetProportional(TabletWin8UserLog[4], 1);
	TextDrawSetShadow(TabletWin8UserLog[4], 0);
	TextDrawSetSelectable(TabletWin8UserLog[4], 0);

	TabletWin8UserLog[5] = TextDrawCreate(174.000000, 217.000000, "I");
	TextDrawBackgroundColor(TabletWin8UserLog[5], 255);
	TextDrawFont(TabletWin8UserLog[5], 1);
	TextDrawLetterSize(TabletWin8UserLog[5], 7.959995, 2.299999);
	TextDrawColor(TabletWin8UserLog[5], -1);
	TextDrawSetOutline(TabletWin8UserLog[5], 0);
	TextDrawSetProportional(TabletWin8UserLog[5], 1);
	TextDrawSetShadow(TabletWin8UserLog[5], 0);
	TextDrawSetSelectable(TabletWin8UserLog[5], 0);

	TabletWin8UserLog[6] = TextDrawCreate(208.000000, 157.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[6], 255);
	TextDrawFont(TabletWin8UserLog[6], 1);
	TextDrawLetterSize(TabletWin8UserLog[6], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[6], -1);
	TextDrawSetOutline(TabletWin8UserLog[6], 0);
	TextDrawSetProportional(TabletWin8UserLog[6], 1);
	TextDrawSetShadow(TabletWin8UserLog[6], 0);
	TextDrawSetSelectable(TabletWin8UserLog[6], 0);

	TabletWin8UserLog[7] = TextDrawCreate(298.000000, 211.000000, "Loading...~n~ Homepage");
	TextDrawBackgroundColor(TabletWin8UserLog[7], 255);
	TextDrawFont(TabletWin8UserLog[7], 1);
	TextDrawLetterSize(TabletWin8UserLog[7], 0.580000, 2.600000);
	TextDrawColor(TabletWin8UserLog[7], -1);
	TextDrawSetOutline(TabletWin8UserLog[7], 0);
	TextDrawSetProportional(TabletWin8UserLog[7], 1);
	TextDrawSetShadow(TabletWin8UserLog[7], 0);
	TextDrawSetSelectable(TabletWin8UserLog[7], 0);

	TabletWin8UserLog[8] = TextDrawCreate(208.000000, 170.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[8], 255);
	TextDrawFont(TabletWin8UserLog[8], 1);
	TextDrawLetterSize(TabletWin8UserLog[8], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[8], -1);
	TextDrawSetOutline(TabletWin8UserLog[8], 0);
	TextDrawSetProportional(TabletWin8UserLog[8], 1);
	TextDrawSetShadow(TabletWin8UserLog[8], 0);
	TextDrawSetSelectable(TabletWin8UserLog[8], 0);

	TabletWin8UserLog[9] = TextDrawCreate(217.000000, 179.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[9], 255);
	TextDrawFont(TabletWin8UserLog[9], 1);
	TextDrawLetterSize(TabletWin8UserLog[9], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[9], -1);
	TextDrawSetOutline(TabletWin8UserLog[9], 0);
	TextDrawSetProportional(TabletWin8UserLog[9], 1);
	TextDrawSetShadow(TabletWin8UserLog[9], 0);
	TextDrawSetSelectable(TabletWin8UserLog[9], 0);

	TabletWin8UserLog[10] = TextDrawCreate(227.000000, 170.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[10], 255);
	TextDrawFont(TabletWin8UserLog[10], 1);
	TextDrawLetterSize(TabletWin8UserLog[10], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[10], -1);
	TextDrawSetOutline(TabletWin8UserLog[10], 0);
	TextDrawSetProportional(TabletWin8UserLog[10], 1);
	TextDrawSetShadow(TabletWin8UserLog[10], 0);
	TextDrawSetSelectable(TabletWin8UserLog[10], 0);

	TabletWin8UserLog[11] = TextDrawCreate(227.000000, 157.000000, ".");
	TextDrawBackgroundColor(TabletWin8UserLog[11], 255);
	TextDrawFont(TabletWin8UserLog[11], 1);
	TextDrawLetterSize(TabletWin8UserLog[11], 0.870000, 3.700000);
	TextDrawColor(TabletWin8UserLog[11], -1);
	TextDrawSetOutline(TabletWin8UserLog[11], 0);
	TextDrawSetProportional(TabletWin8UserLog[11], 1);
	TextDrawSetShadow(TabletWin8UserLog[11], 0);
	TextDrawSetSelectable(TabletWin8UserLog[11], 0);
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == TwoBut[1])
	{
		if(!GetPVarInt(playerid,"onoff"))
		{
		    SetPVarInt(playerid,"onoff",1);
			TextDrawHideForPlayer(playerid,TabletWin8Start[0]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[1]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[2]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[3]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[4]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[5]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[6]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[7]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[8]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[9]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[10]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[21]);
			TextDrawHideForPlayer(playerid,TabletWin8Start[22]);
	        TextDrawHideForPlayer(playerid,TwoBut[0]);
	        CancelSelectTextDraw(playerid);
			ShowTabletForPlayer(playerid);
			TabletTimer[playerid][0] = SetTimerEx("LoaderAnimation",50,1,"i",playerid);
			TabletTimer[playerid][4] = SetTimerEx("StartWin8",5000,0,"i",playerid);
		}
		else
		{
			if(GetPVarInt(playerid,"onoff"))
			{
  				HidePagForItems(playerid);
		    	HideTabletForPlayer(playerid);
		    	HidePhotosForPlayer(playerid);
		    	HideTabletWeather(playerid);
		    	HideClockForPlayer(playerid);
		    	HideTabletMusicPlayer(playerid);
    			HideGames(playerid);
				HideSlotMachine(playerid);
		    	HideStartMenuTablet(playerid);
		    	HideUserLogTablet(playerid);
		    	CameraMode(playerid,2);
				HideEscritorioForPlayer(playerid);
		    	KillTimer(TabletTimer[playerid][0]);
		    	KillTimer(TabletTimer[playerid][1]);
		    	KillTimer(TabletTimer[playerid][2]);
		    	KillTimer(TabletTimer[playerid][3]);
		    	KillTimer(TabletTimer[playerid][4]);
		    	KillTimer(TabletTimer[playerid][5]);
			    DeletePVar(playerid,"onoff");
				TextDrawShowForPlayer(playerid,TabletWin8Start[0]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[1]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[2]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[3]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[4]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[5]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[6]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[7]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[8]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[9]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[10]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[21]);
				TextDrawShowForPlayer(playerid,TabletWin8Start[22]);
				TextDrawShowForPlayer(playerid,TwoBut[0]);
				TextDrawShowForPlayer(playerid,TwoBut[1]);
				SelectTextDraw(playerid,0x33AA33AA);
			}
		}
	}
    if(clickedid == TabletWin8Start[31])ShowPage(playerid,0);
    if(clickedid == TabletWin8Start[32])ShowPage(playerid,1);
    if(clickedid == TabletWin8Start[33])ShowPage(playerid,2);
    if(clickedid == TabletWin8Start[34])ShowPage(playerid,3);
    if(clickedid == TabletWin8Start[35])ShowPage(playerid,4);
    if(clickedid == TabletWin8Start[36])ShowPage(playerid,5);
    if(clickedid == TabletWin8Start[37])ShowPage(playerid,6);
    if(clickedid == TabletWin8Start[38])ShowPage(playerid,7);
    if(clickedid == TabletWin8Start[39])ShowPage(playerid,8);
    if(clickedid == TabletWin8Start[40])ShowPage(playerid,9);
    if(clickedid == TabletWin8Start[41])ShowPage(playerid,10);
    if(clickedid == TabletWin8Start[42])ShowPage(playerid,11);
    if(clickedid == TabletWin8Start[43])ShowPage(playerid,12);
    if(clickedid == TabletWin8Start[44])ShowPage(playerid,13);
    if(clickedid == TabletWin8Start[45])ShowPage(playerid,14);
    if(clickedid == TabletWin8Start[46])ShowPage(playerid,15);
    if(clickedid == TabletWin8Start[47])ShowPage(playerid,16);
    if(clickedid == TabletWin8Start[48])ShowPage(playerid,17);
    if(clickedid == TabletWin8Start[49])ShowPage(playerid,18);
    if(clickedid == TabletWin8Start[50])ShowPage(playerid,19);
   	if(clickedid == TabletMusicPlayer[0]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/toc6d0gmwyf6m52/gangnamstyle.mp3?dl=1");  //PSY - Gangnam Style
	if(clickedid == TabletMusicPlayer[1]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/3lj9dv77pp15opc/Pjanoo.mp3?dl=1");		//Eric Prydz - Pjanoo
	if(clickedid == TabletMusicPlayer[2]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/atfmpu8eupiv138/Tacata.mp3?dl=1");		//Tacabro - Tacata
	if(clickedid == TabletMusicPlayer[3]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/bxh0ap2k7nkk3za/DoitForLove.mp3?dl=1");	//P Holla - Do it for love
	if(clickedid == TabletMusicPlayer[4]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/i5xrqh704s4zo2j/Balada.mp3?dl=1");		//Gustavo Lima - Balada Boa
	if(clickedid == TabletMusicPlayer[5]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/xmo5nrwc6uvx90e/PartyLMFAO.mp3?dl=1");	//LMFAO - Party Rock
	if(clickedid == TabletMusicPlayer[6]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/pgjx0r47wma4yvd/SexyLMFAO.mp3?dl=1");		//LMFAO - Sexy and I know
	if(clickedid == TabletMusicPlayer[7]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/sx1pjsyp1u1v4lq/Safari.mp3?dl=1");		//Played a live - Safari Duo
	if(clickedid == TabletMusicPlayer[8]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/xca4p49hvjtfajo/Inifinity.mp3?dl=1");		//Guru Josh Project - Infinity
	if(clickedid == TabletMusicPlayer[9]) PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/s/eopqegiekf5p09a/Rayos.mp3?dl=1");			//Quiero rayos de sol - Jose de rico
    if(clickedid == TabletMusicPlayer[10]) StopAudioStreamForPlayer(playerid);
	//Maps TD
    if(clickedid == MapsTD[0])
	{
		TextDrawHideForPlayer(playerid,MapsTD[0]);
		TextDrawHideForPlayer(playerid,MapsTD[1]);
		TextDrawHideForPlayer(playerid,MapsTD[2]);
		TextDrawHideForPlayer(playerid,MapsTD[3]);
		TextDrawShowForPlayer(playerid,MapsTD[4]);
	}
    if(clickedid == MapsTD[1])
	{
		TextDrawHideForPlayer(playerid,MapsTD[0]);
		TextDrawHideForPlayer(playerid,MapsTD[1]);
		TextDrawHideForPlayer(playerid,MapsTD[2]);
		TextDrawHideForPlayer(playerid,MapsTD[3]);
		TextDrawShowForPlayer(playerid,MapsTD[5]);
	}
    if(clickedid == MapsTD[2])
	{
		TextDrawHideForPlayer(playerid,MapsTD[0]);
		TextDrawHideForPlayer(playerid,MapsTD[1]);
		TextDrawHideForPlayer(playerid,MapsTD[2]);
		TextDrawHideForPlayer(playerid,MapsTD[3]);
		TextDrawShowForPlayer(playerid,MapsTD[6]);
	}
    if(clickedid == MapsTD[3])
	{
		TextDrawHideForPlayer(playerid,MapsTD[0]);
		TextDrawHideForPlayer(playerid,MapsTD[1]);
		TextDrawHideForPlayer(playerid,MapsTD[2]);
		TextDrawHideForPlayer(playerid,MapsTD[3]);
		TextDrawShowForPlayer(playerid,MapsTD[7]);
	}
    if(clickedid == MapsTD[4])
	{
	TextDrawShowForPlayer(playerid,MapsTD[0]);
	TextDrawShowForPlayer(playerid,MapsTD[1]);
	TextDrawShowForPlayer(playerid,MapsTD[2]);
	TextDrawShowForPlayer(playerid,MapsTD[3]);
	TextDrawHideForPlayer(playerid,MapsTD[4]);
	}
    if(clickedid == MapsTD[5])
	{
	TextDrawShowForPlayer(playerid,MapsTD[0]);
	TextDrawShowForPlayer(playerid,MapsTD[1]);
	TextDrawShowForPlayer(playerid,MapsTD[2]);
	TextDrawShowForPlayer(playerid,MapsTD[3]);
	TextDrawHideForPlayer(playerid,MapsTD[5]);
	}
    if(clickedid == MapsTD[6])
	{
	TextDrawShowForPlayer(playerid,MapsTD[0]);
	TextDrawShowForPlayer(playerid,MapsTD[1]);
	TextDrawShowForPlayer(playerid,MapsTD[2]);
	TextDrawShowForPlayer(playerid,MapsTD[3]);
	TextDrawHideForPlayer(playerid,MapsTD[6]);
	}
    if(clickedid == MapsTD[7])
	{
	TextDrawShowForPlayer(playerid,MapsTD[0]);
	TextDrawShowForPlayer(playerid,MapsTD[1]);
	TextDrawShowForPlayer(playerid,MapsTD[2]);
	TextDrawShowForPlayer(playerid,MapsTD[3]);
	TextDrawHideForPlayer(playerid,MapsTD[7]);
	}
	if(clickedid == Games) HideGames(playerid),ShowSlotMachine(playerid);
    if(clickedid == TabletWin8Pag[2])
    {
    	HidePagForItems(playerid);
    	HidePhotosForPlayer(playerid);
    	HideClockForPlayer(playerid);
    	HideTabletMusicPlayer(playerid);
    	HideTabletMap(playerid);
		HideSlotMachine(playerid);
		HideTabletWeather(playerid);
    	ShowStartMenuTablet(playerid);
    }
	return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == Escritorio[3])
    {
    	HidePagForItems(playerid);
    	HideEscritorioForPlayer(playerid);
    	ShowStartMenuTablet(playerid);
    }
	if(playertextid == Tragaperras[3])
	{
		if(!GetPVarInt(playerid,"tragagoes"))
		{
		    SetPVarInt(playerid,"tragagoes",1);
			TabletTimer[playerid][6] = SetTimerEx("TragaperrasGO",100,1,"i",playerid);
		    TabletTimer[playerid][7] = SetTimerEx("TragaperrasEND",8000,0,"i",playerid);
		}
	}
	return 1;
}
forward TragaperrasGO(playerid);
public TragaperrasGO(playerid)
{
	randomvar[0] = random(6);
	randomvar[1] = random(6);
	randomvar[2] = random(6);
    PlayerTextDrawSetString(playerid,Tragaperras[0],slots[randomvar[0]]);
    PlayerTextDrawSetString(playerid,Tragaperras[1],slots[randomvar[1]]);
    PlayerTextDrawSetString(playerid,Tragaperras[2],slots[randomvar[2]]);
    return 1;
}
forward TragaperrasEND(playerid);
public TragaperrasEND(playerid)
{
	KillTimer(TabletTimer[playerid][6]);
	DeletePVar(playerid,"tragagoes");
	if(randomvar[0] == randomvar[1] && randomvar[1] == randomvar[2])
	{
		PlayerTextDrawSetString(playerid,Tragaperras[3],"YOU WIN");
	}
	else
	{
	    PlayerTextDrawSetString(playerid,Tragaperras[3],"LOSER");
	}
    return 1;
}
forward LoaderAnimation(playerid);
public LoaderAnimation(playerid)
{
	if(lda[playerid] == 0) TextDrawShowForPlayer(playerid,TabletWin8[13]), lda[playerid] = 1;
	else if(lda[playerid] == 1) TextDrawShowForPlayer(playerid,TabletWin8[14]), lda[playerid] = 2;
	else if(lda[playerid] == 2) TextDrawShowForPlayer(playerid,TabletWin8[15]), lda[playerid] = 3;
	else if(lda[playerid] == 3) TextDrawShowForPlayer(playerid,TabletWin8[16]), lda[playerid] = 4;
	else if(lda[playerid] == 4) TextDrawShowForPlayer(playerid,TabletWin8[17]), lda[playerid] = 5;
	else if(lda[playerid] == 5) TextDrawShowForPlayer(playerid,TabletWin8[18]), lda[playerid] = 6;
	else if(lda[playerid] == 6) TextDrawShowForPlayer(playerid,TabletWin8[19]), lda[playerid] = 7;
	else if(lda[playerid] == 7) TextDrawShowForPlayer(playerid,TabletWin8[20]), lda[playerid] = 9;
	else if(lda[playerid] == 9) TextDrawHideForPlayer(playerid,TabletWin8[13]), lda[playerid] = 10;
	else if(lda[playerid] == 10) TextDrawHideForPlayer(playerid,TabletWin8[14]), lda[playerid] = 11;
	else if(lda[playerid] == 11) TextDrawHideForPlayer(playerid,TabletWin8[15]), lda[playerid] = 12;
	else if(lda[playerid] == 12) TextDrawHideForPlayer(playerid,TabletWin8[16]), lda[playerid] = 13;
	else if(lda[playerid] == 13) TextDrawHideForPlayer(playerid,TabletWin8[17]), lda[playerid] = 14;
	else if(lda[playerid] == 14) TextDrawHideForPlayer(playerid,TabletWin8[18]), lda[playerid] = 15;
	else if(lda[playerid] == 15) TextDrawHideForPlayer(playerid,TabletWin8[19]), lda[playerid] = 16;
	else if(lda[playerid] == 16) TextDrawHideForPlayer(playerid,TabletWin8[20]), lda[playerid] = 0;
	return 1;
}
forward StartWin8(playerid);
public StartWin8(playerid)
{
    lda[playerid] = 0;
	KillTimer(TabletTimer[playerid][0]);
	HideTabletForPlayer(playerid);
	ShowUserLogTablet(playerid);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	PlayerTextDrawSetString(playerid,TabletWin8UserLog2,name);
	TabletTimer[playerid][1] = SetTimerEx("LoaderAnimation2",50,1,"i",playerid);
	TabletTimer[playerid][5] = SetTimerEx("Win8GO",3000,0,"i",playerid);
	TextDrawShowForPlayer(playerid,TabletWin8Start[0]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[1]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[2]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[3]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[4]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[5]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[6]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[7]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[8]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[9]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[10]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[21]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[22]);
	return 1;
}
forward LoaderAnimation2(playerid);
public LoaderAnimation2(playerid)
{
	if(lda[playerid] == 0) TextDrawShowForPlayer(playerid,TabletWin8UserLog[1]), lda[playerid] = 1;
	else if(lda[playerid] == 1) TextDrawShowForPlayer(playerid,TabletWin8UserLog[6]), lda[playerid] = 2;
	else if(lda[playerid] == 2) TextDrawShowForPlayer(playerid,TabletWin8UserLog[8]), lda[playerid] = 3;
	else if(lda[playerid] == 3) TextDrawShowForPlayer(playerid,TabletWin8UserLog[9]), lda[playerid] = 4;
	else if(lda[playerid] == 4) TextDrawShowForPlayer(playerid,TabletWin8UserLog[10]), lda[playerid] = 5;
	else if(lda[playerid] == 5) TextDrawShowForPlayer(playerid,TabletWin8UserLog[11]), lda[playerid] = 6;
	else if(lda[playerid] == 6) TextDrawHideForPlayer(playerid,TabletWin8UserLog[1]), lda[playerid] = 7;
	else if(lda[playerid] == 7) TextDrawHideForPlayer(playerid,TabletWin8UserLog[6]), lda[playerid] = 8;
	else if(lda[playerid] == 8) TextDrawHideForPlayer(playerid,TabletWin8UserLog[8]), lda[playerid] = 9;
	else if(lda[playerid] == 9) TextDrawHideForPlayer(playerid,TabletWin8UserLog[9]), lda[playerid] = 10;
	else if(lda[playerid] == 10) TextDrawHideForPlayer(playerid,TabletWin8UserLog[10]), lda[playerid] = 11;
	else if(lda[playerid] == 11) TextDrawHideForPlayer(playerid,TabletWin8UserLog[11]), lda[playerid] = 0;
	return 1;
}
forward Win8GO(playerid);
public Win8GO(playerid)
{
	KillTimer(TabletTimer[playerid][1]);
	lda[playerid] = 0;
	HideUserLogTablet(playerid);
	ShowStartMenuTablet(playerid);
	SelectTextDraw(playerid,0x33AA33AA);
	return 1;
}
forward UpdateTime(playerid);
public UpdateTime(playerid)
{
	new Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	new str[64];
	format(str,sizeof(str),"%02d:%02d",Hour,Minute);
	PlayerTextDrawSetString(playerid,Escritorio[2],str);
	return 1;
}
forward UpdateTime2(playerid);
public UpdateTime2(playerid)
{
	new Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	new Year, Month, Day;
	getdate(Year, Month, Day);
	new str2[64];
	format(str2,sizeof(str2),"%02d/%s/%s",Day,GetMonth(Month),GetYearFormat00(Year));
	PlayerTextDrawSetString(playerid,TabletTime[0],str2);
	new str[64];
	format(str,sizeof(str),"%02d:%02d:%02d",Hour,Minute,Second);
	PlayerTextDrawSetString(playerid,TabletTime[1],str);
	return 1;
}
//Tablet ON/OFF
stock ShowTabletForPlayer(playerid)
{
	for(new i = 0; i < 23; i++) TextDrawShowForPlayer(playerid,TabletWin8[i]);
	TextDrawHideForPlayer(playerid,TabletWin8[13]);
	TextDrawHideForPlayer(playerid,TabletWin8[14]);
	TextDrawHideForPlayer(playerid,TabletWin8[15]);
	TextDrawHideForPlayer(playerid,TabletWin8[16]);
	TextDrawHideForPlayer(playerid,TabletWin8[17]);
	TextDrawHideForPlayer(playerid,TabletWin8[18]);
	TextDrawHideForPlayer(playerid,TabletWin8[19]);
	TextDrawHideForPlayer(playerid,TabletWin8[20]);
	return 1;
}
stock HideTabletForPlayer(playerid)
{
	for(new i = 0; i < 23; i++) TextDrawHideForPlayer(playerid,TabletWin8[i]);
	return 1;
}

//UserLogin
stock ShowUserLogTablet(playerid)
{
	PlayerTextDrawShow(playerid,TabletWin8UserLog2);
	for(new i = 0; i < 12; i++) TextDrawShowForPlayer(playerid,TabletWin8UserLog[i]);
	TextDrawHideForPlayer(playerid,TabletWin8UserLog[1]);
	TextDrawHideForPlayer(playerid,TabletWin8UserLog[6]);
	TextDrawHideForPlayer(playerid,TabletWin8UserLog[8]);
	TextDrawHideForPlayer(playerid,TabletWin8UserLog[9]);
    TextDrawHideForPlayer(playerid,TabletWin8UserLog[10]);
    TextDrawHideForPlayer(playerid,TabletWin8UserLog[11]);
	return 1;
}
stock HideUserLogTablet(playerid)
{
	for(new i = 0; i < 12; i++) TextDrawHideForPlayer(playerid,TabletWin8UserLog[i]);
	PlayerTextDrawHide(playerid,TabletWin8UserLog2);
	return 1;
}

//StartMenu
stock ShowStartMenuTablet(playerid)
{
	for(new i = 0; i < 51; i++) TextDrawShowForPlayer(playerid,TabletWin8Start[i]);
	return 1;
}
stock HideStartMenuTablet(playerid)
{
	for(new i = 0; i < 51; i++) TextDrawHideForPlayer(playerid,TabletWin8Start[i]);
	return 1;
}

//PagForItem
stock ShowPagForItems(playerid)
{
	PlayerTextDrawShow(playerid,TabletWin8Pag2);
	for(new i = 0; i < 3; i++) TextDrawShowForPlayer(playerid,TabletWin8Pag[i]);
	return 1;
}
stock HidePagForItems(playerid)
{
	PlayerTextDrawHide(playerid,TabletWin8Pag2);
	for(new i = 0; i < 3; i++) TextDrawHideForPlayer(playerid,TabletWin8Pag[i]);
	return 1;
}

//Escritorio
stock ShowEscritorioForPlayer(playerid)
{
	for(new i = 0; i < 4; i++) PlayerTextDrawShow(playerid,Escritorio[i]);
	TabletTimer[playerid][2] = SetTimerEx("UpdateTime",1000,1,"i",playerid);
	return 1;
}
stock HideEscritorioForPlayer(playerid)
{
	for(new i = 0; i < 4; i++) PlayerTextDrawHide(playerid,Escritorio[i]);
	KillTimer(TabletTimer[playerid][2]);
	return 1;
}

//Photos
stock ShowPhotosForPlayer(playerid)
{
	for(new i = 0; i < 12; i++) TextDrawShowForPlayer(playerid,TabletPhotos[i]);
	return 1;
}
stock HidePhotosForPlayer(playerid)
{
	for(new i = 0; i < 12; i++) TextDrawHideForPlayer(playerid,TabletPhotos[i]);
	return 1;
}
//Reloj
stock ShowClockForPlayer(playerid)
{
	for(new i = 0; i < 2; i++) PlayerTextDrawShow(playerid,TabletTime[i]);
	TabletTimer[playerid][3] = SetTimerEx("UpdateTime2",1000,1,"i",playerid);
	return 1;
}
stock HideClockForPlayer(playerid)
{
	for(new i = 0; i < 2; i++) PlayerTextDrawHide(playerid,TabletTime[i]);
	KillTimer(TabletTimer[playerid][3]);
	return 1;
}

//TabletMusicPlayer
stock ShowTabletMusicPlayer(playerid)
{
	for(new i = 0; i < 11; i++) TextDrawShowForPlayer(playerid,TabletMusicPlayer[i]);
	return 1;
}
stock HideTabletMusicPlayer(playerid)
{
	for(new i = 0; i < 11; i++) TextDrawHideForPlayer(playerid,TabletMusicPlayer[i]);
	StopAudioStreamForPlayer(playerid);
	return 1;
}

//CameraMode:
stock CameraMode(playerid,type)
{
  	if(type == 0)
  	{
    	ShowStartMenuTablet(playerid);
        SelectTextDraw(playerid,0x33AA33AA);
  	    for(new i = 0; i < 24; i++) TextDrawHideForPlayer(playerid,CameraTD[i]);
	  	SetCameraBehindPlayer(playerid);
    	DestroyObject(firstperson[playerid]);
	}
	else if(type == 1)
	{
    	CancelSelectTextDraw(playerid);
    	SetPVarInt(playerid,"camara",1);
	    HideStartMenuTablet(playerid);
        for(new i = 0; i < 24; i++) TextDrawShowForPlayer(playerid,CameraTD[i]);
		firstperson[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        AttachObjectToPlayer(firstperson[playerid],playerid, 0.0, 0.12, 0.7, 0.0, 0.0, 0.0);
        AttachCameraToObject(playerid, firstperson[playerid]);
	}
  	else if(type == 2)
  	{
  	    for(new i = 0; i < 24; i++) TextDrawHideForPlayer(playerid,CameraTD[i]);
	  	SetCameraBehindPlayer(playerid);
    	DestroyObject(firstperson[playerid]);
	}
	return 1;
}

//Maps TD
stock ShowTabletMap(playerid)
{
	TextDrawShowForPlayer(playerid,MapsTD[0]);
	TextDrawShowForPlayer(playerid,MapsTD[1]);
	TextDrawShowForPlayer(playerid,MapsTD[2]);
	TextDrawShowForPlayer(playerid,MapsTD[3]);
	return 1;
}
stock HideTabletMap(playerid)
{
	for(new i = 0; i < 8; i++) TextDrawHideForPlayer(playerid,MapsTD[i]);
	return 1;
}

//Games TD
stock ShowGames(playerid)
{
    TextDrawShowForPlayer(playerid,Games);
	return 1;
}
stock HideGames(playerid)
{
	TextDrawHideForPlayer(playerid,Games);
	return 1;
}
//SlotMachine TD
stock ShowSlotMachine(playerid)
{
	PlayerTextDrawShow(playerid,Tragaperras[4]);
    for(new i = 0; i < 4; i++) PlayerTextDrawShow(playerid,Tragaperras[i]);
	return 1;
}
stock HideSlotMachine(playerid)
{
    PlayerTextDrawSetString(playerid,Tragaperras[3],"LUCK");
    DeletePVar(playerid,"tragagoes");
	for(new i = 0; i < 4; i++) PlayerTextDrawHide(playerid,Tragaperras[i]);
	PlayerTextDrawHide(playerid,Tragaperras[4]);
    KillTimer(TabletTimer[playerid][6]);
	KillTimer(TabletTimer[playerid][7]);
	return 1;
}
//Show Weather
stock ShowTabletWeather(playerid)
{
	new str[64];
	format(str,sizeof(str),"~y~PLACE~n~~g~SAN ANDREAS~n~~n~~y~TEMPERATURE~n~~g~%s",temperature[random(sizeof(temperature))]);
	PlayerTextDrawSetString(playerid,TabletWeather[2],str);
 	new weather[64],id;
	GetServerVarAsString("weather", weather, sizeof(weather));
	id = strval(weather);
	if(id >= 0 && id <= 7) PlayerTextDrawSetString(playerid,TabletWeather[1],"SUNNY");
	else if(id == 8) PlayerTextDrawSetString(playerid,TabletWeather[1],"STORMY");
	else if(id == 9) PlayerTextDrawSetString(playerid,TabletWeather[1],"FOG");
	else if(id == 10) PlayerTextDrawSetString(playerid,TabletWeather[1],"SUNNY");
	else if(id == 11) PlayerTextDrawSetString(playerid,TabletWeather[1],"VERY HOT");
	else if(id >= 12 && id <= 15) PlayerTextDrawSetString(playerid,TabletWeather[1],"BORRING");
	else if(id == 16) PlayerTextDrawSetString(playerid,TabletWeather[1],"FOG AND RAIN");
	else if(id >= 17 && id <= 18) PlayerTextDrawSetString(playerid,TabletWeather[1],"HOT");
	else if(id == 19) PlayerTextDrawSetString(playerid,TabletWeather[1],"SANDSTORM");
	else if(id == 20) PlayerTextDrawSetString(playerid,TabletWeather[1],"GREEN FOG");
	else if(id == 21) PlayerTextDrawSetString(playerid,TabletWeather[1],"DARK");
	else if(id == 22) PlayerTextDrawSetString(playerid,TabletWeather[1],"DARK");
	else if(id >= 23 && id <= 26) PlayerTextDrawSetString(playerid,TabletWeather[1],"PALID ORANGE");
	else if(id >= 27 && id <= 29) PlayerTextDrawSetString(playerid,TabletWeather[1],"FRESH BLUE");
	else if(id >= 30 && id <= 32) PlayerTextDrawSetString(playerid,TabletWeather[1],"DARK");
	else if(id == 33) PlayerTextDrawSetString(playerid,TabletWeather[1],"DARK");
	else if(id == 34) PlayerTextDrawSetString(playerid,TabletWeather[1],"BLUE");
	else if(id == 35) PlayerTextDrawSetString(playerid,TabletWeather[1],"BROWN");
	else if(id >= 36 && id <= 38) PlayerTextDrawSetString(playerid,TabletWeather[1],"BRIGHT");
	else if(id == 39) PlayerTextDrawSetString(playerid,TabletWeather[1],"VERY BRIGHT");
	else if(id >= 40 && id <= 42) PlayerTextDrawSetString(playerid,TabletWeather[1],"BLUE/PURPLE");
	else if(id == 43) PlayerTextDrawSetString(playerid,TabletWeather[1],"TOXIC");
	else if(id == 44) PlayerTextDrawSetString(playerid,TabletWeather[1],"BLACK");
	else if(id == 45) PlayerTextDrawSetString(playerid,TabletWeather[1],"BLACK");
    for(new i = 0; i < 3; i++) PlayerTextDrawShow(playerid,TabletWeather[i]);
	return 1;
}
stock HideTabletWeather(playerid)
{
    for(new i = 0; i < 3; i++) PlayerTextDrawHide(playerid,TabletWeather[i]);
    return 1;
}
//Only for menu no bug
stock ShowPage(playerid,page)
{
    HideStartMenuTablet(playerid);
	TextDrawShowForPlayer(playerid,TabletWin8Start[0]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[1]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[2]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[3]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[4]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[5]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[6]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[7]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[8]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[9]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[10]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[21]);
	TextDrawShowForPlayer(playerid,TabletWin8Start[22]);
	if(page == 0)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"EMAIL");
	else if(page == 1)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"CONTACTS");
	else if(page == 2)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"MESSAGES"), ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}���ID", "�������ID", "����", "ȡ��"),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 3)return ShowEscritorioForPlayer(playerid);
	else if(page == 4)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"CLOCK"),ShowClockForPlayer(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 5)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"PHOTOS"),ShowPhotosForPlayer(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 6)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"FINANZES");
	else if(page == 7)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"WEATHER"),ShowTabletWeather(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 8)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"INTERNET~n~EXPLORER");
	else if(page == 9)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"MAPS"),ShowTabletMap(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 10)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"SPORTS");
	else if(page == 11)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"NEWS");
	else if(page == 12)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"STORE");
	else if(page == 13)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"SkyDrive");
	else if(page == 14)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"BING");
	else if(page == 15)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"TRAVELS");
	else if(page == 16)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"GAMES"),ShowGames(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 17)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"CAMERA"), CameraMode(playerid,1);
	else if(page == 18)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"MUSIC"),ShowTabletMusicPlayer(playerid),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
	else if(page == 19)PlayerTextDrawSetString(playerid,TabletWin8Pag2,"VIDEO");
    ShowPagForItems(playerid);
	return 1;
}
//
stock GetMonth(Month)
{
    new MonthStr[15];
    switch(Month)
    {
        case 1:  MonthStr = "JANUAR";
        case 2:  MonthStr = "FEBRUA";
        case 3:  MonthStr = "MARCH ";
        case 4:  MonthStr = "APRIL ";
        case 5:  MonthStr = "MAY   ";
        case 6:  MonthStr = "JUNE  ";
        case 7:  MonthStr = "JULE  ";
        case 8:  MonthStr = "AGOUST";
        case 9:  MonthStr = "SEPTEM";
        case 10: MonthStr = "OCTOBE";
        case 11: MonthStr = "NOVEMB";
        case 12: MonthStr = "DECEMB";
    }
    return MonthStr;
}
stock GetYearFormat00(Year)
{
    new YearStr[3];
    switch(Year)
    {
        case 2012:  YearStr = "12";
        case 2013:  YearStr = "13";
        case 2014:  YearStr = "14";
        case 2015:  YearStr = "15";
        case 2016:  YearStr = "16";
        case 2017:  YearStr = "17";
        case 2018:  YearStr = "18";
        case 2019:  YearStr = "19";
        case 2020:  YearStr = "20";
        case 2021: 	YearStr = "21";
        case 2022: 	YearStr = "22";
        case 2023: 	YearStr = "23";
        case 2024: 	YearStr = "24";
        case 2025: 	YearStr = "25";
        case 2026: 	YearStr = "26";
        case 2027: 	YearStr = "27";
        case 2028: 	YearStr = "28";
        case 2029: 	YearStr = "29";
        case 2030: 	YearStr = "30";
    }
    return YearStr;
}
