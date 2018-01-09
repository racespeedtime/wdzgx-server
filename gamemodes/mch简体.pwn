/*
================================================================================
                	我      的      中      国      心
                	开      源      第      七      版
                	----------------------------------
                       ＳＡＭＰ．ＨＣＹＸＳＱ．ＣＮ
================================================================================

-----------------------------[简   体   中   文]--------------------------------
|* 如发现BUG，请到samp.hcyxsq.cn发帖或Q群198412914寻求帮助, 注明版本, BUG位置  |
|                                                                              |
|*提示: 你可以修改filterscripts下的djs.pwn并编译来设置倒计时开服的等待时间     |
|                                                                              |
|如果你喜欢这个地图，请赞助我们，以便让我们有动力继续开源下去。联系QQ:947585287|
|                                                                              |
|==============================================================================|

|==============================================================================|
| =====    本版主要是对上一版本的BUG修复, 更新至0.3z, 以及一些安全更新   ===== |
|==============================================================================|
|本版更新简略提要:                                                             |
|1、修复ID0的玩家邀请别人进入组织提示没有人邀请的bug                           |
|2、修复一些已知的编译Warning                                                  |
|3、修复管理员/ky提示没有上班的BUG (感谢论坛会员1156183796的反馈)              |
|4、增加一个RCON默认密码没有修改的提示信息                                     |
|5、增加服务器初始化时的服务器信息                                             |
|6、增加/reloadbans用于解封玩家后的手动刷新列表                                |
|7、去除NDVDS(无人车辆损伤), ac(视觉检测)脚本                                  |
|------------------------------------------------------------------------------|

																TL_GTASA
														      汇诚游戏社区
										                   汇诚游戏社区技术组
                                                           我的中国心开源团队
                                                           
                                                           联 合 荣 誉 出 品
                                                           
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
//===================================[平板]=====================================
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
//----------------[附加物件]---------------------------//
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
  "傻逼",
  "煞笔",
  "傻比",
  "沙比",
  "操你妈",
  "你麻痹",
  "你妈逼",
  "草泥马",
  "日你妈",
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
new jybdyszt[MAX_PLAYERS];//玩家拿监狱钥匙状态
new jybdlinggunzt[MAX_PLAYERS];//玩家是否已经领枪
new jybdzt[MAX_PLAYERS];																																																																																																																																																																																																																																																														//new	Float:TelePos[MAX_PLAYERS][6];
new	RegistrationStep[MAX_PLAYERS];
//=========================TL原创徽章系统=======================================
new hzxtnqyw[MAX_PLAYERS];//徽章年轻有为
new hzxtjcxqn[MAX_PLAYERS];//徽章杰出小青年
new hzxtwnzy[MAX_PLAYERS];//徽章我乃专业

new hzxtcdqc[MAX_PLAYERS];//徽章财大气粗
new hzxtycwg[MAX_PLAYERS];//徽章腰缠万贯
new hzxtfkdg[MAX_PLAYERS];//徽章富可敌国

new hzxtscjj[MAX_PLAYERS];//徽章赛车季军
new hzxtscyj[MAX_PLAYERS];//徽章赛车亚军
new hzxtscgj[MAX_PLAYERS];//徽章赛车冠军

//new hdcd[100];//记录活动
/*new shu1;//倒计时V1
new shu2;//倒计时V2
new shu3;//倒计时V3
new shu4;//倒计时V4*/
new playeryanhua[100];//记录玩家烟花
new playerlive[100];//记录玩家采访状态
new playerircadmin[100];//记录IRC管理员
new playerircid[100];//记录IRC频道ID
//new DefaultWeather=10;//记录天气
//new to[100],tocar[100],toid[100];//活动记录
new	playeripad[100];//记录玩家IPAD
new playersfz[100];//记录玩家身份证
new	playeradmin[100];//记录玩家管理员等级
new	playerput[100];//记录玩家是否教程过
new	playersex[100];//记录玩家性别
new	playerage[100];//记录玩家年龄
new	playermoney[100];//记录玩家金钱
new	playercar[100];//记录玩家有几辆车
new	playermima[100][100];//记录玩家密码
new	playername[100][100];//记录玩家名字
new	playerzuzhi[100];//记录玩家组织
new	playerskin[100];//记录玩家皮肤
new	playerzuzhilv[100];//记录玩家组织阶级
new zuzhichushenghj[18],Float:zuzhichushengx[18],Float:zuzhichushengy[18],Float:zuzhichushengz[18],Float:zuzhichushenga[18];//组织出生地ID
new	playerlock[100];//记录玩家钥匙
new	playerlock1[100];//记录玩家2号钥匙
new	playerlock2[100];//记录玩家3号钥匙
new	playerspawn[100];//记录玩家出生地
new	playerlv[100];//玩家等级
new	playerlvup[100];//玩家升级点数
new	playerjianyutime[100];//监狱剩余时间
new	playergunzhizhao[100];//记录玩家有没有武器执照 0为无 1为有
new	playercarzhizhao[100];//记录玩家有没有驾驶执照 0为无 1为有
new	playerwuqi[100][7];//记录玩家武器
new	playerinvwuqi[100][7];//记录玩家武器仓库武器
new	playercall[100];//记录玩家电话
new	playerjob[100];//记录玩家工作
new	SNOS[100];//记录玩家NOS打开
new	playersupernos[100];//记录NOS
/*new ms1[100];
new ms2[100];
new ms3[100];
new ms4[100];
new ms5[100];//记录音乐列表*/
new	playerviplv[100];//记录玩家VIP等级
new	playervdou[100];//记录玩家V豆数量
new	playervipczz[100];//记录玩家VIP成长值
//new	playerjiedu[100];//记录玩家饥饿度
//new	playerkouke[100];//记录玩家口渴值
new	food1[100];//记录田园鸡腿堡数量
new	food2[100];//记录雪碧数量
new	food3[100];//记录米饭数量
new	playermats[100];//记录玩家材料
new	playerbank[100];//记录玩家银行存款
new	playercallmoney[100];//记录玩家电话余额
new	SL[100];//玩家登陆状态*0为没登陆 1为登陆*
new	ZFJGID[1000];//保存政府机构的标志ID
new	ZFJGSTR[1000][128],ZFJGSTR1[1000][128],/*ZFJGSTR2[100][64],*/ZFJGMONEY[1000];//保存政府机构的标志ID上面的信息
new	ZFJGTID[1000],ZFJGLV[1000],ZFJGLOCK[1000],ZFJGZJ[1000],ZFJGLOCALHID[1000];//保存政府机构门口标志ID的ID
new	ZFJGZUZHI[1000];//记录房子属于哪个组织
new Float:ZFJGX[1000];//保存政府机构创建点X
new Float:ZFJGY[1000];//保存政府机构创建点Y
new Float:ZFJGZ[1000];//保存政府机构创建点Z
new Float:ZFJGCX[1000],Float:ZFJGCY[1000],ZFJGHU[1000],Float:ZFJGCZ[1000],ZFJGLX[1000];//保存政府机构传送坐标XYZ以及文本是否换行以及PICKUP类型
new	ZFJGHID[1000];//保存政府机构环境ID
new	zuzhiname[18][32];//组织名字
new ircname[18][32];//记录IRC编号
new	zuzhilv[18][32][64];//组织阶级
new	yaoqingjiaru[100];//邀请玩家加入组织
new	zuzhiskin[18][32];//组织皮肤
new	zuzhigonggao[18][64];//组织公告
new	zuzhichushengid[18];//组织出生地ID
new	gongzuoname[8][32];//工作名字
//new playerdm[100]; //DM模式
new	gate;//警察局OBJ
new	gate1;//警察局OBJ
new	gate2;//警察局OBJ
new	gate3;//FBI车库开门
new	gate4;//政府门
new	gate5,gate6,gate7,gate8,gate9,gate10;//GM基地门
new	gate11,gate12,gate13,gate14,gate15,pdmen,pdmen1,pdmen2;//警察局内门	窗帘
new	gate16,gate17,gate18,gate19,gate20,gate21;//记录大门
new	gate22,gate23,gate24,gate25,gate26,gate27,yymen,yymen1;//医院
new ewmen1,ewmen2,xzmen1,xzmen2,xzmen3;
new rqq1;//热气球
//new gate88,gate89;//军队基地OBJ
new	gatetime[25];//警察局OBJ倒计时
new	houseid[100];//记录进入房间的ID
new	carzuyongkey[100];//记录租车钥匙
new	cargzbc[1000];//记录车辆改装
new	savetime;//保存玩家资料间隔
//new carsl=1;//记录当前服务器车有几辆
new	pickupids=0;//记录标志
new	vsellto[100],vselltocar[100],vselltomoney[100],vselltoid[100];//记录卖车玩家ID,被卖车ID,价格
new	carname[1000][64],carmoney[1000],carfill[1000],car[1000],carfuel[1000],Float:carx[1000],Float:cary[1000],Float:carz[1000],Float:carmianxiang[1000],carcolor1[1000],carcolor2[1000],carzuzhi[1000],carmoxing[1000];
new	cargz[1000][10],caryinqing[1000],cardengguang[1000],carlock[1000];//汽车改装、汽车引擎、汽车灯光、汽车锁
new	askqtime[100];//玩家ASKQ间隔
new	carzuyong[1000];//记录车辆租用
new	tg[2][32];//预设执照字符串 0为无1为有
new	adminduty[100];//记录玩家管理员登陆状态
new Text:TextdrawMav;

new	su[100],cu[100],tofind[100],duty[100],swat[100],jcys[100],healid[100],healmoney[100],healtoid[100],Text3D:liaotiantext[100],liaotiantexts[100];//记录通缉状态，记录CU状态，记录找人ID，记录上班状态,记录swat状态,记录机场运送状态,记录玩家3D文字
new	call[100],callbuff[100],calls[100];//记录通话ID	记录通话状态 记录通话时间
new	sellcarsilunchemoney[13],sellcarsilunchemod[13],sellcarlianglunchemoney[8],sellcarlianglunchemod[8],sellfeijimod[3],sellfeijimoney[3],sellvipcarmod[9],sellvipcarmoney[9];//记录卖车信息
new	fills[100],fillmoney[100],fillvid[100],engine[100],enginevid[100];
new	KillSpawn[MAX_PLAYERS];
//text 开始
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

forward	SavePlayer();//函数	保存玩家资料 每10秒保存一次。
forward	AdminXX(zuzhi,string[],color);//向所有ADMIN发送消息
forward	XY(Float:real,playerid,Float:x,Float:y,Float:z);//判断距离的函数 (范围,需要判断的玩家,原点 XYZ)
forward	sjd();//每隔1小时加1点经验点
//forward koujike(playerid);//扣除饥渴值
forward	WeatherAndTime();//换天气时间
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
// 天气时间ID.
/*new	const RandomWorldTime[24][1] =
{
	{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23}
};*/
// 天气ID.
/*new	const RandomWeather[15][1] =
{
	{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}
};*/
new	RandMsg;
new	ANNOUNCEMENTS[11][128] ={
	"[提示]:紧急命令:/110 [喊警察] /120 [喊医生] /888 [喊记者]",
	"[提示]:每次刷车你的车子都不见？快在你的车上输入/vpark停好车吧~",
	"[提示]:有什么问题可以/askq [内容]哦~",
    "[帮助]:有什么疑问，请联系作者QQ947585287或加群:163084182",
	"[帮助]:发现有人作弊?请使用 /askq	报告管理员哦.",
	"[SAMP小贴士]:想要窗口化吗？试试ALT+ENTER吧！",
	"[帮助]:空间BUG了？快使用/kong 修复空间吧!.",
	"[提示]:武器店买不了武器？找武器商人吧~.",
	"[提示]:注意啦，输入命令要小写哦~例：/help.",
	"[提示]:请不要超速!在小镇安装了很多超速摄像头哦~",
	"[公告]:暂无公告！"
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
#define	SCRIPT_VERSION		"我的中国心开源第七版"
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
	print("                                       我的中国心                    ");
	print("                                    My Chinese Heart               ");
	print("________________________________________________________________________________");
	print("                             我的中国心开源第七简体中文版           ");
	print("________________________________________________________________________________");
	print("                              By:TL_GTASA @ hcyxsq.cn            ");
	print("________________________________________________________________________________");
	SendRconCommand("hostname 我的中国心 - 开源第七简体中文版 - SAMP.HCYXSQ.CN");
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
			format(msg,128,"*你由于很长时间没有吃东西，晕倒了！唉，记得以后按时吃饭啊！");
			SetPlayerHealth(playerid, 0);
			return 1;
    }
    if(playerkouke[playerid]<0)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*你由于很长时间没有喝到水，晕倒了！唉，要多喝水，身体才能棒啊！");
			SetPlayerHealth(playerid, 0);
			return 1;
    }
    if(playerjiedu[playerid]<10)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*你感到有点饿了，去吃点东西吧！目前饥饿度：%d",playerjiedu[playerid]);
			playerjiedu[playerid]=100;
			SendClientMessage(playerid,COLOR_YELLOW,"此系统已去除，请不必担心！");
    }
    if(playerkouke[playerid]<10)
    {
			SendClientMessage(playerid,	COLOR_YELLOW,	msg);
			format(msg,128,"*你感到有点渴了，去喝点饮料吧！目前口渴度：%d",playerkouke[playerid]);
			playerkouke[playerid]=100;
			SendClientMessage(playerid,COLOR_YELLOW,"此系统已去除，请不必担心！");
    }
return 1;
}*/
public OnPlayerCommandText(playerid, cmdtext[])//玩家输入指令时的事件
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
		SendClientMessage(playerid,	COLOR_GREY,	"	你现在只可以使用/120请求援助 !");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/120 [救护内容]");
					return 1;
				}
				if(askqtime[playerid]!=0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过120了~请等待10秒后再拨打~！");
					return 1;
				}
				format(msgg,128,"[120急救热线]:市民[ID:%d]%s:%s",playerid,name,tmp);
				AdminXX(6,msgg,0x98FB98FF);
				askqtime[playerid]=10;
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过急救热线了!~请等待120救护车赶到~");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
			return 1;
		}
		return 1;
	}
	}
	
	if (strcmp("/tablet", cmdtext, true, 10) == 0)
	{
	    if (playeripad[playerid]!= 1)
	    {
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板!");
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
		    SendClientMessage(playerid, COLOR_WHITE, "请等待目前烟花发射完成(目前只能全服同时发射一次烟花).");
			return 1;
		}
		if (GetPlayerInterior(playerid) != 0)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "你要炸了这栋楼么...");
		    return 1;
		}
		if (playeryanhua[playerid] <= 0)
		{
		    SendClientMessage(playerid, COLOR_WHITE, "你没有烟花了.");
		    return 1;
		}
		new string[128];
		format(string, sizeof(string), "%s 放下了烟花.", GetPlayerNameEx(playerid));
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
		    SendClientMessage(playerid, COLOR_WHITE, "已经有一个烟花在发射了!(目前只能全服同时发射一次烟花).");
			return 1;
		}
		if(FireworkTotal <= 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "没有烟花已放下.");
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
			format(msg, sizeof(msg), "管理员 {1B8AE4}%s(%d) {FFFFFF}清屏了.", name,playerid);
			SendClientMessageToAll(COLOR_WHITE, msg);
			return 1;
		}
	}
	
	if (strcmp("/fare",	cmdtext, true, 10) == 0)
	{
	    if (playerjob[playerid] != 6) return SendClientMessage(playerid,COLOR_RED,"你不是出租车司机");
		if(OnDuty[playerid] == 0) return SendClientMessage(playerid,COLOR_RED,"你没有值班");
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!IsATaxi(vehicleid)) return SendClientMessage(playerid,COLOR_RED,"你需要在出租车上！");
		if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid,COLOR_RED,"需要驾驶员驾驶!");
		if(CheckPassengers(vehicleid) != 1) return SendClientMessage(playerid,COLOR_RED,"请等待有人进你的出租车!");
		if(IsOnFare[playerid] == 0)
		{

		if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"您已经给出票价");
		GetPlayerPos(playerid,Float:OldX[playerid],Float:OldY[playerid],Float:OldZ[playerid]);
		faretimer[playerid] = SetTimerEx("FareUpdate", 1000, true, "i", playerid);
		IsOnFare[playerid] = 1;
		TotalFare[playerid] = STARTAMOUNT;
		new formatted[128];
		format(formatted,128,"All money: %.2f $",STARTAMOUNT);
		TextDrawSetString(taxithisfare[playerid],formatted);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"你现在的票价，把你的客户送到他/她想要去的地方");
		return 1;
		}
		if(IsOnFare[playerid] == 1)
		{
		TotalFare[playerid] = 0.00;
		TextDrawSetString(taxithisfare[playerid],"All money: N/A");
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"票价停止");
		IsOnFare[playerid] = 0;
		KillTimer(faretimer[playerid]);
	 	return 1;
		}
	    return 1;
	}
	
	
	if (strcmp("/taxiduty",	cmdtext, true, 10) == 0)
	{
        if (playerjob[playerid] != 6) return SendClientMessage(playerid,COLOR_RED,"你不是出租车司机");
		if(IsOnFare[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"您目前给出了票价，现在你不能去下班!");
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_LIGHTBLUE,"你必须下车后才能更改下班/上班!");
		if(OnDuty[playerid] == 0)
		{
		OnDuty[playerid] = 1;

		SendClientMessage(playerid,COLOR_LIGHTBLUE,"你上班了!");
		new name[256],msg[256];
		GetPlayerName(playerid,name,256);
		format(msg,sizeof(msg),"出租车司机:%s上班了! 电召: %d",name,playercall[playerid]);
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

		TextDrawSetString(taxistatus[playerid],"This Taxi：Free");
		Clock();

		return 1;
		}

		if(OnDuty[playerid] == 1)
		{
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"你下班了");
		OnDuty[playerid] = 0;
		new name[256],msg[256];
		GetPlayerName(playerid,name,256);
		format(msg,sizeof(msg),"出租车司机:%s下班了!",name);
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
//===============================================[TL原创暴动功能]====================================
	if (strcmp(cmd, "/jybd", true) == 0) {
		cmd = strtok(cmdtext, idx);
		if (!strlen(cmd)) {
		    ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"监狱暴动功能帮助 (TL原创)","/jybd start [开始暴动]\n/jybd stop [停止暴动(退出暴动)]\n/jybd door [破门]\n/jybd ys [拿钥匙]\n /jybd gun [拿枪]","确定","");
		    return 1;
		}

	    if (strcmp(cmd, "start", true) == 0) {//开始暴动
			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 265.6101,76.1229,1001.0391)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在监狱!");
	        return 1;
   		 	}
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在蹲监狱!");
	        return 1;
   		 	}
			jybdzt[playerid] = 1;
			SendClientMessage(playerid,0x00FF00AA,"暴动系统:你开始暴动了，冲啊!!!(暴动结束点在小镇出口转右的丛林里)");
			SetPlayerCheckpoint(playerid,-2831.4377,2306.6553,98.3154,3);
			SetPlayerPos(playerid,267.2517,76.3074,1001.0391);
			new	msg[128];
			new	name[128];
			GetPlayerName(playerid,name,128);
			su[playerid]=su[playerid]+1;
			format(msg,128,"[总部]:	%s的通缉令已经发布了！通缉等级:%d,通缉理由:暴动",name,su[playerid]);
			AdminXX(3,msg,0x00FF00AA);
			ABroadCast(0x00FF00AA,msg,1);
	        return 1;
	    }

	    if (strcmp(cmd, "stop", true) == 0) {//停止暴动
			jybdzt[playerid] = 0;
			SendClientMessage(playerid,0x00FF00AA,"暴动系统:停止暴动!!!");
			jybdyszt[playerid] = 0;
			jybdlinggunzt[playerid] = 0;
	        return 1;
	    }
	    if (strcmp(cmd, "ys", true) == 0) {//拿钥匙
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在蹲监狱!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你没有在暴动!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 230.7155,71.3590,1005.0391)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在办公室拿钥匙点!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"暴动系统:你取了钥匙.");
			jybdyszt[playerid] = 1;
	        return 1;
	    }
	    if (strcmp(cmd, "gun", true) == 0) {//拿枪
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在蹲监狱!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你没有在暴动!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 257.5566,77.5511,1003.6406)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在储物柜!");
	        return 1;
   		 	}
			if (jybdlinggunzt[playerid] > 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你已经领过了，请不要刷子弹!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"暴动系统:你打开储物柜拿走了一把手枪和警棍.");
			GivePlayerWeaponEx(playerid,22,500);
			GivePlayerWeaponEx(playerid,3,99999);
			jybdlinggunzt[playerid] = 1;
	        return 1;
	    }
	    
	    if (strcmp(cmd, "door", true) == 0) {//破门
			if (playerjianyutime[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在蹲监狱!");
	        return 1;
   		 	}
			if (jybdzt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你没有在暴动!");
	        return 1;
   		 	}
			if (jybdyszt[playerid] == 0) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你没有钥匙!");
	        return 1;
   		 	}
   			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 246.3270,73.1185,1003.6406)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在门口!");
	        return 1;
   		 	}
			SendClientMessage(playerid,0x00FF00AA,"暴动系统:你用钥匙打开了门.");
			MoveDynamicObject(gate11,242.80754089355, 72.450500488281, 1002.640625,8);
			MoveDynamicObject(gate12,248.2579498291, 72.445793151855, 1002.640625,8);
	        return 1;
	    }
	    SendClientMessage(playerid, 0xFFFF00AA, "{FFFF99}提示：输入错误，请输入 /jybd 查看命令.");
  		return 1;
	}
//===============================================[TL原创徽章系统]====================================
	if (strcmp("/gmqt",	cmdtext, true, 10) == 0)
	{
			if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1232.0562,-810.9739,1084.007)) {
	    	SendClientMessage(playerid, 0xCD0000FF, "{FFFF99}提示：你不在GM基地前台服务办理点!");
	        return 1;
   		 	}
		ShowPlayerDialog(playerid,9754,DIALOG_STYLE_LIST,"{00A5FF}GM基地前台服务办理点","{37FF00}徽章系统","确定","取消");
		return 1;
	}
//===============================================[测速摄像头]========================================
	if (strcmp("/szsxt",	cmdtext, true, 10) == 0)
	{
		if(playeradmin[playerid]<1338)
		{
			SendClientMessage(playerid,0xffffffff,"错误: 你无权限使用该命令!");
			return 1;
		}
		ShowPlayerDialog(playerid,DIALOG_MAIN,DIALOG_STYLE_LIST,"{00A5FF}测速摄像头	{FFFFFF}- {FFDC00}主菜单","{37FF00}创建摄像头\n\n得到最近的摄像头ID\n编辑最近的摄像头\n{FF1400}删除最近的摄像头\n{FF1400}删除所有摄像头","确定","取消");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/acu	[玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有上线!");
						return 1;
					}
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"神技术啊你？拷自己？");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(5,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离的太远了。。");
						return 1;
					}
					new	name[128];
					new	msg[128];
					if(cu[id]==0)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"你被管理员%s拷起来了!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"玩家%s被你拷起来了!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,0);
						cu[id]=1;
						return 1;
					}
					if(cu[id]==1)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"你手上的拷子被管理员或警察%s弄掉了!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"你把玩家%s手上的拷子弄掉了!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,1);
						cu[id]=0;
						return 1;
					}
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
	
	/*if(strcmp("/gotobluebus", cmdtext, true) ==	0)
	{
		if(playeradmin[playerid]<1337)
		{
			SendClientMessage(playerid,	COLOR_RED, "您没有权限使用该命令.");
			return 1;
		}
		if(BusID[playerid] > 0)
		{
			SetPlayerVirtualWorld(playerid,	0);
		}
		PutPlayerInVehicle(playerid, NPCBlueBus, 2);
		SendClientMessage(playerid,	COLOR_DARKAQUA,	"您传送到了公交车上");
		return 1;
	}
	if(strcmp("/gotoblackbus", cmdtext,	true) == 0)
	{
		if(playeradmin[playerid]<1337)
		{
			SendClientMessage(playerid,	COLOR_RED, "您没有权限使用该命令.");
			return 1;
		}
		if(BusID[playerid] > 0)
		{
			SetPlayerVirtualWorld(playerid,	0);
		}
		PutPlayerInVehicle(playerid, NPCBlackBus, 2);
		SendClientMessage(playerid,	COLOR_DARKAQUA,	"您传送到了公交车上");
		return 1;
	}
	if(strcmp("/lookout", cmdtext, true) ==	0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 10, 2021.9390,2241.9487,2103.9536))
		{
			SendClientMessage(playerid,	COLOR_RED, "您不在公交车上");
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
			SendClientMessage(playerid,	COLOR_TEAL,	"公交一号线交通线路: 东海滩	- 大球场 - 健身房 -	小医院 - LS飞机场 -	的士站");
			return 1;
		}
		else if(IsAtBlackBusStop(playerid))
		{
			SendClientMessage(playerid,	COLOR_TEAL,	"公交二号线交通线路: 的士站	- 警察署 - 银行	- 大医院 - 市场站 -	圣玛丽亚海滩");
			return 1;
		}
		else
		{
			SendClientMessage(playerid,	COLOR_RED, "您不在公交车站");
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
				SendClientMessage(playerid,	COLOR_RED, "您不在公交车站");
			}
			return 1;
	}*/
//-------------------------------------------测试命令不进行游戏---
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
				SendClientMessage(playerid,	COLOR_GREY,	"	您还没有登陆 !");
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	/w [信息]");
				return 1;
			}
			format(str,	sizeof str,	" %s [小声说]: %s",	str, result);
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
				SendClientMessage(playerid,	COLOR_GREY,	"	您还没有登陆 !");
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	/b [信息]");
				return 1;
			}
			format(str,	sizeof(str), "%s 说: (( %s ))",	str, result);
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
				SendClientMessage(playerid,	COLOR_GREY,	"	你还未登陆 !");
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	(/s)hout [信息]");
				return 1;
			}
			format(str,	sizeof str,	"%s	大喊: %s！！", str,	result);
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
				SendClientMessage(playerid,	COLOR_GREY,	"	您还没有登陆 !");
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	/me	[动作]");
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
				SendClientMessage(playerid,	COLOR_GREY,	"	您还没有登陆 !");
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	/do	[动作]");
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
//=====================================彩灯
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
			SendClientMessage(playerid,	COLOR_YELLOW,"用法 /neon安装你喜欢的彩灯配件!");}
		return 1;
	}
//----------------------------------------------------
	if (strcmp(cmdtext,	"/neon", true)==0)
	{
		if(IsPlayerInRangeOfPoint(playerid,	7.0, 529.618591,-1288.602050,17.334606))
		{
			ShowPlayerDialog(playerid, 8899, DIALOG_STYLE_LIST,	"选择你喜欢的彩灯安装",	"蓝\n红\n绿色\n白\n粉红\n黄色\n警方频闪灯\n车室内灯\n后部虹灯\n前部霓虹灯\n底盘灯\n删除全部霓虹灯",	"确定",	"返回");
			PlayerPlaySound(playerid, 1133,	0.0, 0.0, 10.0);
		}
		
		return 1;
	}
//=====================================彩灯
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
				SendClientMessage(playerid,0x00FF00AA,"用法:/vlock 车ID	//车ID可以通过/vstats或/dl查看");
				return 1;
			}
			new	vid=strval(tmp);
			if(car[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"无效的车辆ID");
				return 1;
			}
			new	name[128];
			GetPlayerName(playerid,name,128);
			if(strcmp(carname[vid],name)!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"这不是你的汽车!");
				return 1;
			}
			if(carlock[vid]==0)
			{
				carlock[vid]=1;
				SendClientMessage(playerid,0x00FF00AA,"你将你的汽车锁上了~~");
				SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
				return 1;
			}
			carlock[vid]=0;
			SendClientMessage(playerid,0x00FF00AA,"你将你的汽车解锁了~~");
			SetVehicleParamsEx(vid,caryinqing[vid],cardengguang[vid],0,carlock[vid],0,0,0);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					format(msg,128,"你挂断了电话,本次通话时间:{FF00FF}%d秒{FFC0CB},本次通话话费:{FF00FF}%d元{FFC0CB},手机剩余话费:{FF00FF}%d元{FFC0CB}",calls[playerid],calls[playerid],playercallmoney[playerid]);
					SendClientMessage(playerid,0xFFC0CBFF,msg);
					SendClientMessage(call[playerid],0xFFC0CBFF,"对方挂断了电话");
					call[call[playerid]]=0;
					callbuff[call[playerid]]=0;
					call[playerid]=0;
					callbuff[playerid]=0;
					return 1;
				}
				new	id=call[call[playerid]];
				playercallmoney[id]=playercallmoney[id]-calls[id];
				format(msg,128,"你挂断了电话,本次通话时间:{FF00FF}%d秒{FFC0CB},本次通话话费:{FF00FF}%d元{FFC0CB},手机剩余话费:{FF00FF}%d元{FFC0CB}",calls[id],calls[id],playercallmoney[id]);
				SendClientMessage(playerid,0xFFC0CBFF,msg);
				SendClientMessage(call[playerid],0xFFC0CBFF,"对方挂断了电话");
				call[call[playerid]]=0;
				callbuff[call[playerid]]=0;
				call[playerid]=0;
				callbuff[playerid]=0;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有打电话!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/p")==0 || strcmp(cmd,"/pickup")==0)
	{
		if(SL[playerid]==1)
		{
			if(call[playerid]!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你接通了电话,可以输入/h来挂断电话!");
				SendClientMessage(call[playerid],0x00FF00AA,"对方接通了电话,你可以输入/h来挂断电话!");
				calls[call[playerid]]=1;
				callbuff[playerid]=1;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"没有人拨打你的电话!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/call [电话号码]");
					return 1;
				}
				if(playercallmoney[playerid]<=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的电话已欠费，请尽快充值!");
					return 1;
				}
				id=strval(tmp);
				if(id==0)
				{
					return 1;
				}
				if(id==playercall[playerid])
				{
					SendClientMessage(playerid,0x00FF00AA,"电话录音:虽然我很高兴你给我们送钱,但这样会浪费服务器资源,请不要这样做了.谢谢!");
					return 1;
				}
				if(id==110)
				{
					SendClientMessage(playerid,0x00FF00AA,"电话录音:虽然我很高兴你给我们送钱,但这样会浪费服务器资源,请不要这样做了.谢谢!");
					return 1;
				}
				if(id==10086)
				{
				    new msg[256];
				    format(msg,sizeof(msg),"余额查询：你的帐户余额是:%d元.",playercallmoney[playerid]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"[短信]{FF00FF}[号码:10086]{FFC0CB}内容:{FF00FF}你的帐户余额是:%d元{FFC0CB}",playercallmoney[playerid]);
					SendClientMessage(playerid,0xFFC0CBFF,msg);
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"叮铃铃~~叮铃铃~~你的电话响了!来电显示:{FF00FF}%d{FFC0CB},输入/(p)ickup 接听!",playercall[playerid]);
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(playercall[i]==id)
							{
								SendClientMessage(playerid,0xFFC0CBFF,"你拨打了一个电话,请等待接通,或者输入/h挂断电话!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拨打的电话暂时没有人接听.请考虑拨打110报失踪案或拨打120报急救!");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有电话");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"用法:/id	[名字]");
				return 1;
			}
			format(msg,128,"---名字中包含'%s'的玩家ID如下---",tmp);
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
							format(msg,128,"ID:%d 名字:%s",i,name);
							SendClientMessage(playerid,0xBA55D3AA,msg);
						}
					}
				}
			}
			SendClientMessage(playerid,0xBA55D3AA,"--------------------------------");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
//=======================================================================================
	if(strcmp(cmd,"/zhiliao")==0)
	{
		if(SL[playerid]==1)
		{
			if(healid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"没有人想为你治疗!");
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
				SendClientMessage(playerid,0x00FF00AA,"你们两个离得太远了!");
				return 1;
			}
			if(playermoney[playerid]<healmoney[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"你付不起治疗费用!");
				return 1;
			}
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"%s接受了你的治疗,你收取了%d~",name,healmoney[playerid]);
			SendClientMessage(healid[playerid],0x00FF00AA,msg);
			GetPlayerName(healid[playerid],name,128);
			format(msg,128,"%你接受了%s的治疗,你花费了%d~",name,healmoney[playerid]);
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
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/heal")==0)
	{
		if(SL[playerid]==1)
		{
			if(ZFJGHU[houseid[playerid]]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的血已经成为100了 你的护甲已经成为100了~");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/heal [玩家id] [价格]");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在车上!");
						return 1;
					}
					if(mod!=416&&mod!=487)
					{
						SendClientMessage(playerid,0x00FF00AA,"这部汽车/飞机上没有医疗用具!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离得有点远啊.");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"价格不能为空");
						return 1;
					}
					money=strval(tmp);
					if(money<1||money>150)
					{
						SendClientMessage(playerid,0x00FF00AA,"价格范围错误!(1-150)");
						return 1;
					}
					if(KillSpawn[id])
					{
						new	msg[128],name[128];
						GetPlayerName(playerid,name,128);
						format(msg,128,"%s把你治疗过来了!治疗费:%d",name,money);
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
						SendClientMessage(playerid,0x00FF00AA,"治疗成功!");
						return 1;
					}
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"%s想为你治疗,治疗费:%d,输入/zhiliao来接受治疗!",name,money);
					SendClientMessage(id,0x00FF00AA,msg);
					GetPlayerName(id,name,128);
					format(msg,128,"你想为%s治疗,治疗费:%d",name,money);
					SendClientMessage(playerid,0x00FF00AA,msg);
					healid[id]=playerid;
					healmoney[id]=money;
					healtoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是医生或不懂医术!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
//-----------------------------------------------------------------------------------
	if(strcmp(cmd,"/zhiliao")==0)
	{
		if(SL[playerid]==1)
		{
			if(healid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"没有人想为你治疗!");
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
				SendClientMessage(playerid,0x00FF00AA,"你们两个离得太远了!");
				return 1;
			}
			if(playermoney[playerid]<healmoney[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"你付不起治疗费用!");
				return 1;
			}
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"%s接受了你的治疗,你收取了%d~",name,healmoney[playerid]);
			SendClientMessage(healid[playerid],0x00FF00AA,msg);
			GetPlayerName(healid[playerid],name,128);
			format(msg,128,"%你接受了%s的治疗,你花费了%d~",name,healmoney[playerid]);
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
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/heal")==0)
	{
		if(SL[playerid]==1)
		{
			if(ZFJGHU[houseid[playerid]]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的血已经成为100了 你的护甲已经成为100了~");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/heal [玩家id] [价格]");
						return 1;
					}
					if(vid==0&&houseid[playerid]!=6)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在车上/医院内!");
						return 1;
					}
					if(mod!=416&&vid!=110&&vid!=109&&houseid[playerid]!=6)
					{
						SendClientMessage(playerid,0x00FF00AA,"这部汽车/飞机上没有医疗用具!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离得有点远啊.");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp, " ")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"价格不能为空");
						return 1;
					}
					money=strval(tmp);
					if(money<1||money>150)
					{
						SendClientMessage(playerid,0x00FF00AA,"价格范围错误!(1-150)");
						return 1;
					}
					if(KillSpawn[id])
					{
						new	msg[128],name[128];
						GetPlayerName(playerid,name,128);
						format(msg,128,"%s把你治疗过来了!治疗费:%d",name,money);
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
						SendClientMessage(playerid,0x00FF00AA,"治疗成功!");
						return 1;
					}
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"%s想为你治疗,治疗费:%d,输入/zhiliao来接受治疗!",name,money);
					SendClientMessage(id,0x00FF00AA,msg);
					GetPlayerName(id,name,128);
					format(msg,128,"你想为%s治疗,治疗费:%d",name,money);
					SendClientMessage(playerid,0x00FF00AA,msg);
					healid[id]=playerid;
					healmoney[id]=money;
					healtoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是医生!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/hu")==0)
	{
		if(SL[playerid]==1)
		{
			if(houseid[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在房子里!");
				return 1;
			}
			if(ZFJGLX[houseid[playerid]]==1||ZFJGLX[houseid[playerid]]==2)
			{
				SendClientMessage(playerid,0x00FF00AA,"这个房子无法进行装修!");
				return 1;
			}
			if(houseid[playerid]!=playerlock[playerid]&&houseid[playerid]!=playerlock1[playerid]&&houseid[playerid]!=playerlock2[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"这不是你的房子!");
				return 1;
			}
			if(ZFJGHU[houseid[playerid]]!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"该房已经装修过了!");
				return 1;
			}
			if(playermoney[playerid]<100000)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的金钱不足!(100000)");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你花了100000元装修了一间房子~");
			ZFJGHU[houseid[playerid]]=1;
			playermoney[playerid]=playermoney[playerid]-100000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"你不在车上!");
					return 1;
				}
				if(zid!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你不是司机......");
					return 1;
				}
				if(carfill[vid]==300)
				{
					SendClientMessage(playerid,0x00FF00AA,"你汽车油箱已经装不下油了...");
					return 1;
				}
				fuel=100-carfill[vid];
				money=fuel*3;
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的金钱不足~");
					return 1;
				}
				TogglePlayerControllable(playerid,0);
				fills[playerid]=3;
				fillmoney[playerid]=money;
				fillvid[playerid]=vid;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在加油站!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/jcys [可用代号]");
					SendClientMessage(playerid,0x00FF00AA,"	|可用代号:A(300-2500) B(500-4000)");
					SendClientMessage(playerid,0x00FF00AA,"	|例如:/jcys	A");
					SendClientMessage(playerid,0x00FF00AA,"	|作用方式:接受后地图上会有红点,到红点处交任务就可以了");
					SendClientMessage(playerid,0x00FF00AA,"	|奖励:接受A运送需要成本300元,交了任务后获得2500元,接受B运送需要成本500元,交了任务后获得4000元");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可能已经处于红点模式(任务或tofind),请先结束红点!");
					return 1;
				}
				new	h,m,s;
				if(strcmp(tmp,"A")==0)
				{
					if(playermoney[playerid]<300)
					{
						SendClientMessage(playerid,0x00FF00AA,"你没有足够的押金!");
						return 1;
					}
					if(askqtime[playerid]!=0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"请休息一下再来(240s)!");
						return 1;
					}
					gettime(h,m,s);
					format(msg,128,"[管理员注意]:<[%d:%d:%d]A点运送>%s领货了!",h,m,s,name);
					ABroadCast(0x00FF00AA,msg,1);
					jcys[playerid]=1;
					SendClientMessage(playerid,0x00FF00AA,"你接受了A类运送任务!");
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
						SendClientMessage(playerid,0x00FF00AA,"你没有足够的押金!");
						return 1;
					}
					if(askqtime[playerid]!=0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"请休息一下再来(240s)!");
						return 1;
					}
					gettime(h,m,s);
					format(msg,128,"[管理员注意]:<[%d:%d:%d]B点运送>%s领货了",h,m,s,name);
					ABroadCast(0x00FF00AA,msg,1);
					jcys[playerid]=2;
					SendClientMessage(playerid,0x00FF00AA,"你接受了B类运送任务!");
					playermoney[playerid]=playermoney[playerid]-500;
					ResetPlayerMoney(playerid);
					GivePlayerMoney(playerid,playermoney[playerid]);
					SetPlayerCheckpoint(playerid, -1055.977661,	-637.489562	,32.007812,3);
					askqtime[playerid]=240;
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"错误的可用名代码.");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在运输任务接受点!(利用红点BUG实现刷材料的玩家注意了，请打消这个念头吧，此BUG已修复)");
		//SetPlayerCheckpoint(playerid,-2547.148925,2300.347900,4.984375,3);
   return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
//------------------------------------走私材料------
//--------------------------------------------------
	if(strcmp(cmd,"/zscl")==0)
	{
		if(playerjob[playerid]==1)
		{
			if(XY(3,playerid, -1623.986083,-2693.479736,48.742660)==1)
			{
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可能已经处于红点模式,请先结束红点或/stofind!");
					return 1;
				}
				if(askqtime[playerid]!=0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"请休息一下再来(240s)!");
					return 1;
				}
				new	name[128],msg[128];
				new	h,m,s;
				gettime(h,m,s);
				format(msg,128,"<[%d:%d:%d]走私材料>%s领取了材料",h,m,s,name);
				ABroadCast(0x00FF00AA,msg,1);
				jcys[playerid]=4;
				SendClientMessage(playerid,0x00FF00AA,"你接受了走私材料任务!");
				playermoney[playerid]=playermoney[playerid]-500;
				ResetPlayerMoney(playerid);
				askqtime[playerid]=240;
				GivePlayerMoney(playerid,playermoney[playerid]);
				SetPlayerCheckpoint(playerid,2230.216796,-2286.343505,14.375131,3);
				return 1;
			}
   			SendClientMessage(playerid,0x00FF00AA,"你不在材料走私领货点(已在地图红点显示)!");
			SetPlayerCheckpoint(playerid,-1623.986083,-2693.479736,48.742660,3);
   			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你不是材料走私犯");
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
SendClientMessage(playerid,0x00FF00AA,"你可能已经处于红点模式,请先结束红点或/stofind!");
return 1;
}
if(askqtime[playerid]!=0)
{
SendClientMessage(playerid,	0xDC143CAA,"请休息一下再来(500s)!");
return 1;
}
new	name[128],msg[128];
new	h,m,s;
gettime(h,m,s);
format(msg,128,"<[%d:%d:%d]武器走私>%s领取了武器材料",h,m,s,name);
ABroadCast(0x00FF00AA,msg,1);
jcys[playerid]=6;
SendClientMessage(playerid,0x00FF00AA,"你接受了武器走私任务(一次需要花费3500购买武器材料的费用)!");
playermoney[playerid]=playermoney[playerid]-3500;
ResetPlayerMoney(playerid);
askqtime[playerid]=500;
GivePlayerMoney(playerid,playermoney[playerid]);
SetPlayerCheckpoint(playerid,2152.208984,-2270.487792,13.308847,3);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"你不在武器材料领货点!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"你不是武器走私贩");
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
				SendClientMessage(playerid,0x00FF00AA,"用法:/t [电话号码] [内容]");
				return 1;
			}
			if(playercall[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你没有手机!");
				return 1;
			}
			id=strval(tmp);
			if(id==playercall[playerid])
			{
				SendClientMessage(playerid,0x00FF00AA,"无法拨打自己的号码!");
				return 1;
			}
			if(callbuff[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"你正在通话中!");
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
							format(msg,128,"发送短信到号码{FF00FF}[%d]{FFC0CB}内容:{FF00FF}%s{FFC0CB},花费了一块钱",id,tmp);
							SendClientMessage(playerid,0xFFC0CBFF,msg);
							format(msg,128,"[短信]{FF00FF}[号码:%d]{FFC0CB}内容:{FF00FF}%s{FFC0CB}",playercall[playerid],tmp);
							SendClientMessage(i,0xFFC0CBFF,msg);
							playercallmoney[playerid]=playercallmoney[playerid]-1;
							return 1;
						}
					}
				}
			}
			SendClientMessage(playerid,0x00FF00AA,"你拨打的电话可能是空号!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/pay [玩家id] [钱数]");
					return 1;
				}
				id=strval(tmp);
				if(id==playerid)
				{
					SendClientMessage(playerid,0x00FF00AA,"无法给自己钱!");
					return 1;
				}
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(3,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你们离得太远了");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"钱数不能为空");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你想给负钱?~~");
					return 1;
				}
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有那么多钱吧?");
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
				format(msg,128,"%s给了你$%d!",name,money);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"你给了%s$%d!",name1,money);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s给了[ID:%d]%s$%d",playerid,name,id,name1,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
//=======================================================银行系统存钱====================
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/cunkuan [任意数字] [钱数]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"钱数不能为空");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你想存负钱?~~");
					return 1;
				}
				if(playermoney[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有那么多钱吧?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]-money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]+money;
				new	msg[128],name[128];
				format(msg,128,"你存了钱$%d!",money);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s存了钱$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在银行!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//------------------------------------------------------银行系统取钱
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/qukuan	[任意数字] [钱数]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"钱数不能为空");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你想存负钱?~~");
					return 1;
				}
				if(playerbank[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有那么多钱吧?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]+money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]-money;
				new	msg[128],name[128];
				format(msg,128,"你取了钱$%d!",money);
				format(msg,128,"[ID:%d]%s取了钱$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在银行!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//------------------------------------------------------ATM系统取钱
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/atmqk	[任意数字] [钱数]");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"钱数不能为空");
					return 1;
				}
				money=strval(tmp);
				if(money<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你想存负钱?~~");
					return 1;
				}
				if(playerbank[playerid]<money)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有那么多钱吧?");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]+money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playerbank[playerid]=playerbank[playerid]-money;
				new	msg[128],name[128];
				format(msg,128,"[ATM提款机]:你取了钱$%d!",money);
				format(msg,128,"[ID:%d]%s使用ATM提款机取了钱$%d",playerid,name,money);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在ATM提款机旁!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//======================================================[给武器]--------------------------------
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/pinvgun [玩家id] [数量]");
						return 1;
					}
					id=strval(tmp);
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"无法给自己武器!");
						return 1;
					}
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(3,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们离得太远了");
						return 1;
					}
					if(playerinvwuqi[playerid][id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该武器栏没有任何武器!");
						return 1;
					}
					if(id<0||id>6)
					{
						SendClientMessage(playerid,0x00FF00AA,"错误的武器栏编号(0-6)");
						return 1;
					}
					new	PlayerWeapons[128];
					PlayerWeapons[playerid]=PlayerWeapons[playerid]-wuqi;
					PlayerWeapons[id]=PlayerWeapons[id]+wuqi;
					new	msg[128],name[128],name1[128];
					GetPlayerName(playerid,name,128);
					GetPlayerName(id,name1,128);
					format(msg,128,"%s给了你一把武器!",name);
					SendClientMessage(id,0x00FF00AA,msg);
					format(msg,128,"你给了%s一把武器!",name1);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"[ID:%d]%s给了[ID:%d]%s一把武器",playerid,name,id,name1);
					ABroadCast(0x00FF00AA,msg,1);
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是武器商人!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}*/
//======================================================[给材料]----------------------------------
	if(strcmp(cmd,"/paycl")==0)
	{
		if(SL[playerid]==1)
		{
				new	tmp[128],id,mats;
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"用法:/paycl [玩家id]	[数量]");
					return 1;
				}
				id=strval(tmp);
				if(id==playerid)
				{
					SendClientMessage(playerid,0x00FF00AA,"无法给自己材料!请不要作弊!");
					return 1;
				}
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(3,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你们离得太远了");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"数量不能为空");
					return 1;
				}
				mats=strval(tmp);
				if(mats<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你想给负材料?~~");
					return 1;
				}
				if(playermats[playerid]<mats)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有那么多材料吧?");
					return 1;
				}
				playermats[playerid]=playermats[playerid]-mats;
				playermats[id]=playermats[id]+mats;
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"%s给了你材料,数量:%d!",name,mats);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"你给了%s材料,数量:%d!",name1,mats);
				SendClientMessage(playerid,0x00FF00AA,msg);
				format(msg,128,"[ID:%d]%s给了[ID:%d]%s材料,数量:%d",playerid,name,id,name1,mats);
				ABroadCast(0x00FF00AA,msg,1);
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/fuel")==0)
	{
		if(SL[playerid]==1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在车上");
				return 1;
			}
			new	msg[128];
			format(msg,128,"当前汽车油量:%d",carfill[vid]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"你的金钱不够执照工本费!(2500)");
					return 1;
				}
				if(playercarzhizhao[playerid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"你已经有驾驶执照了!");
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"请拿好你的驾驶执照!");
				playermoney[playerid]=playermoney[playerid]-2500;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playercarzhizhao[playerid]=1;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在执照中心");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/showzhizhao [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[128],name[128];
				if(id==playerid)
				{
					SendClientMessage(playerid,0x008040FF,"______|你拥有的执照|______");
					format(msg,128,"武器执照:%s",tg[playergunzhizhao[playerid]]);
					SendClientMessage(playerid,0x708090AA,msg);
					format(msg,128,"驾驶执照:%s",tg[playercarzhizhao[playerid]]);
					SendClientMessage(playerid,0x708090AA,msg);
					SendClientMessage(playerid,0x008040FF,"----------------------------------------");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(5,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x708090AA,"你们离得太远了..");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s向你展示了他拥有的执照",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"______|%s拥有的执照|______",name);
				SendClientMessage(id,0x008040FF,msg);
				format(msg,128,"武器执照:%s",tg[playergunzhizhao[playerid]]);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"驾驶执照:%s",tg[playercarzhizhao[playerid]]);
				SendClientMessage(id,0x708090AA,msg);
				SendClientMessage(id,0x008040FF,"----------------------------------------");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/showsfz [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[128],name[128];
				if(id==playerid)
				{
					SendClientMessage(playerid,0x008040FF,"______|市民身份证|______");
					format(msg,128,"身份证编号:%d",playersfz[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					format(msg,128,"年龄:%d",playerage[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					format(msg,128,"性别:%d",playersex[playerid]);
					SendClientMessage(playerid,0xFFFFFFFF,msg);
					SendClientMessage(playerid,0x008040FF,"----------------------------------------");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(XY(5,id,x,y,z)==0)
				{
					SendClientMessage(playerid,0x708090AA,"你们离得太远了..");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s 向你展示了他的市民身份证.",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"______|%s的市民身份证|______",name);
				SendClientMessage(id,0x708090AA,msg);
				format(msg,128,"身份证编号:%d",playersfz[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				format(msg,128,"年龄:%d",playerage[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				format(msg,128,"性别:%d",playersex[playerid]);
				SendClientMessage(playerid,0xFFFFFFFF,msg);
				SendClientMessage(id,0x008040FF,"----------------------------------------");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/delswat [玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
						return 1;
					}
					if(playerzuzhi[id]!=3)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家不是警察");
						return 1;
					}
					if(swat[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家不是swat");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[swat]%s被%s撤消了swat!",name,name1);
					AdminXX(3,msg,0xFAF0E6FF);
					format(msg,128,"你撤消了%s的swat",name);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"你被%s撤消了swat",name1);
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
				SendClientMessage(playerid,0x00FF00AA,"你没有权限");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/setswat [玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
						return 1;
					}
					if(playerzuzhi[id]!=3)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家不是警察");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[swat]%s被%s授权了swat!",name,name1);
					AdminXX(3,msg,0xFAF0E6FF);
					format(msg,128,"你授权了%s为swat",name);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"你被%s授权了swat",name1);
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
				SendClientMessage(playerid,0x00FF00AA,"你没有权限");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
							SendClientMessage(playerid,0x00FF00AA,"用法:/m [内容]");
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
				SendClientMessage(playerid,0x00FF00AA,"你没有上班");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有扩音器");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/admins")==0)
	{
		if(SL[playerid]==1)
		{
			new	str[2][32];
			format(str[0],128,"休闲");
			format(str[1],128,"上班");
			SendClientMessage(playerid,	0x008040FF,"|__________|我的中国心目前在线管理员|__________|");
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
							format(msg,128,"[目前ID]:%d [名字]:%s [等级]:%d [状态]:%s",i,name,playeradmin[i],str[adminduty[i]]);
							SendClientMessage(playerid,	0xB0C4DEAA,msg);
						}
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"*** 你打开了乡村居民装备箱，拿出了防弹衣和防身装备 ***");
					SetPlayerHealth(playerid,100);
					SetPlayerArmour(playerid,100);
					GivePlayerWeaponEx(playerid,10,1111111111111111111);
					GivePlayerWeaponEx(playerid,1,1111111111111111111);
					return 1;
			}
	    	SendClientMessage(playerid,0x00FF00AA,"对不起，您不是乡村居委会成员或不是高级居民，无法享受这项特权哦！");
  	    	SendClientMessage(playerid,0x00FF00AA,"注：普通乡村居委会成员请找居委会会长升级哦！努力干吧！");
		}
		SendClientMessage(playerid,0x00FF00AA,"你不在装备领取点！");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"*** 你上班了 ***");
					SetPlayerColor(playerid,0xFF66FF00);
					SetPlayerHealth(playerid,100);
					SetPlayerArmour(playerid,100);
					adminduty[playerid]=1;
					format(string, sizeof(string),"[服务器]: 管理员 %s 进入了值班管理状态", sendername);
					ABroadCast(COLOR_LIGHTRED, string, 1);
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"*** 你下班了 ***");
				format(string, sizeof(string),"[服务器]: 管理员 %s 进入了下班管理状态", sendername);
				ABroadCast(COLOR_LIGHTRED, string, 1);
				SetPlayerColor(playerid,COLOR_WHITE);
				adminduty[playerid]=0;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
						SendClientMessage(playerid,0x00FF00AA,"** 你上班了 **");
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
					SendClientMessage(playerid,0x00FF00AA,"** 你下班了 **");
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
				SendClientMessage(playerid,0x00FF00AA,"你不在储物柜旁!");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你的组织或工作不需要上班!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"用法:/takegun	[武器栏编号(0-6)]");
				return 1;
			}
			id=strval(tmp);
			if(playerzuzhi[playerid]==5||playerzuzhi[playerid]==4||playerzuzhi[playerid]==3|| playerzuzhi[playerid]==14&&duty[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"警察上班期间不允许使用武器仓库!");
				return 1;
			}
			if(id<0||id>6)
			{
				SendClientMessage(playerid,0x00FF00AA,"错误的武器栏编号(0-6)");
				return 1;
			}
			if(playerinvwuqi[playerid][id]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"该武器栏没有任何武器!");
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
			SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	if(strcmp(cmd,"/putgun")==0)
	{
		if(SL[playerid]==1)
		{
			new	wid;
			if(playerzuzhi[playerid]==3&&duty[playerid]==1)
			{
				SendClientMessage(playerid,0x00FF00AA,"警察禁用武器仓库!");
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
			SendClientMessage(playerid,0x00FF00AA,"你的武器仓库已经满了!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	if(strcmp(cmd,"/inv")==0)
	{
		if(SL[playerid]==1)
		{
			new	msg[128],name[128];
			GetPlayerName(playerid,name,128);
			format(msg,128,"|_____________|%s的武器仓库|_____________|",name);
			SendClientMessage(playerid,0x008040FF,msg);
			for(new	i=0;i<7;i++)
			{
			new wqname[32];
		 	GetWeaponName(playerinvwuqi[playerid][i],wqname[i],sizeof(wqname));
				format(msg,128,"[%d号武器栏]:武器ID:%d武器名称:%s",i,playerinvwuqi[playerid][i],wqname[i]);
				SendClientMessage(playerid,0xCECECEFF,msg);
			}
			SendClientMessage(playerid,0xCECECEFF,"输入/putgun 存入,输入/takegun 武器栏ID取出");
			SendClientMessage(playerid,0x008040FF,"======================================================");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
		            SendClientMessage(playerid,0xDC143CAA,"对不起啊~你的V豆余额不够买VIP啊!");
		        	return 1;
	        	}
		        if(playerviplv[playerid]!=0)
	        	{
		            SendClientMessage(playerid,0xDC143CAA,"对不起啊~你已经是VIP了，不能再购买了哦！");
		        	return 1;
	        	}
					new ak[128],name[128];
				    playervdou[playerid]=playervdou[playerid]-10;
				    playerviplv[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW,"* 你成功购买了VIP，成为了VIP1用户！欢呼~~");
			        GetPlayerName(playerid,name,128);
				    format(ak,128,"[VIP信息]%s使用了10V豆，成为了至尊无比的VIP1！！",name);
				    SendClientMessageToAll(0xFFFACDAA,ak);
				    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在VIP会员购买点!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
			    SendClientMessage(playerid,COLOR_YELLOW,"* 车辆霓虹灯（白色）已经安装完毕！");
  			    return 1;
			}
	     	SendClientMessage(playerid,0x00FF00AA,"你没有足够的VIP等级！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
			    SendClientMessage(playerid,COLOR_YELLOW,"* 车辆霓虹灯已经成功撤出！");
			    return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//--------------------------------------------------
//--------------------------------------接工作
	if(strcmp(cmd,"/jgz")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 362.214172,173.700363,1008.382812)==1)
			{
				ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"工作列表","1.辞去工作\n2.材料走私(BUG)\n3.侦探\n4.武器商人\n5.汽车销售商\n6.加油站服务员\n7.出租车司机","就职","取消");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"你不在领工作点!");
			return 1;

		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	//--------------------------------------办理身份证
	if(strcmp(cmd,"/bsfz")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, 358.342102,164.751647,1008.382812)==1)
			{
				ShowPlayerDialog(playerid,8912,DIALOG_STYLE_LIST,"我的中国心市政管理局 - 身份证办理系统","办理身份证(需要缴纳500手续费)","确认办理","取消办理");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"你不在身份办理点!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//--------------------------------------------------
	if(strcmp(cmd,"/zuogun")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerjob[playerid]==3)
			{
				ShowPlayerDialog(playerid,100,DIALOG_STYLE_LIST,"武器清单","小刀(125)\n沙鹰(180)\n散弹(220)\nMP5(350)\nM4A1(560)\nAK47(560)","购买","取消");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你的材料不够!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你不是武器商人!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ao	[内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[AOOC]管理员{90FFAA}[%s]说:{1493FF}%s{1493FF}",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//--------------------------------记者指令
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/news	[新闻内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[新闻]记者%s 报道:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在电台！");
			return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"你不是记者，无法发布消息!");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ndt	[电台内容]");
					return 1;
				}
					new	vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在新闻播报车/飞机上!");
						return 1;
					}
					if(mod!=582&&mod!=488&&mod!=609&&mod!=560)
					{
						SendClientMessage(playerid,0x00FF00AA,"这部汽车/飞机上没有无线电台!");
						return 1;
					}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[中国心无线电台]记者%s 报道:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/nad	[新闻内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[广告]%s 发布消息:{FF00FF}%s",name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在电台！");
			return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"你不是记者，无法发布消息!");
		return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/admin [内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"*前台管理员:%s",tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/nx	[内容]");
					return 1;
				}
				if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"请等待10秒后再发送新手问题~！");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[新手频道]:	%s说:%s",name,tmp);
				SendClientMessageToAll(0x008040FF,msg);
				askqtime[playerid]=10;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是新手!(1~2级)");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/nf	[内容]");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"请等待5秒后再发送频道消息~！");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[FBI频道]: %s说:%s",name,tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/nn	[内容]");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"请等待5秒后再发送频道消息~！");
return 1;
}
    new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[警用频道]:	%s说:%s",name,tmp);
				SendClientMessageToAll(0x1E90FFAA,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/aad	[内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin广告]:%s",tmp);
				SendClientMessageToAll(0xFFFF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	if(strcmp(cmd,"/reloadbans")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeradmin[playerid]>=3333)
			{
				SendClientMessage(playerid,0xFFFACDAA,"已经刷新封禁列表.");
			    SendRconCommand("reloadbans");
		    return 1;
		    }
	    SendClientMessage(playerid,	 0xDC143CAA, "对不起，您不是管理员，无法使用此功能！");
		}
        SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/agov	[内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin公告]:%s",tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ahd	[内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[Admin活动通知]:%s",tmp);
				SendClientMessageToAll(0xFF00EE00,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//===========================热气球================================
	if(strcmp(cmd,"/rqq1go1")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 200.3100, 1);
			SendClientMessage(playerid,COLOR_YELLOW,"1号热气球起飞啦！");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go2")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 200.3100, 1.5);
			SendClientMessage(playerid,COLOR_YELLOW,"1号热气球出发啦，目标：新手机场！");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go2speed")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 200.3100, 99);
			SendClientMessage(playerid,COLOR_YELLOW,"1号热气球出发啦，目标：新手机场！");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1go3")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,1451.639892, -2360.305419, 13.546875, 1);
			SendClientMessage(playerid,COLOR_YELLOW,"1号热气球停下啦，目标：新手机场！");
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1back")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 11.3100, 1);
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
	if(strcmp(cmd,"/rqq1backspeed")==0)
	{
      if(playeradmin[playerid]>= 3333)
	  {
	    MoveDynamicObject(rqq1,-134.0300, -4591.5801, 11.3100, 99);
	    return 1;
	  }
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
	  return 1;
	}
//=================================自创MSG发送===========================
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
	SendClientMessage(playerid,0x00FF00AA,"你没有发送MSG消息的权限哦~");
	return 1;
	}
	if(strcmp(cmd,"/payday")==0)
	{
      if(playeradmin[playerid]>= 1338)
	  {
        sjd();
	    return 1;
	  }
	SendClientMessage(playerid,0x00FF00AA,"你没有权限哦~");
	return 1;
	}
//==================================飞行脚本=================================
/*if(strcmp(cmd,"/fx")==0)
{
	if(playeradmin[playerid]>= 3333)

	{
	    StartFly(playerid);
        SendClientMessage(playerid,COLOR_YELLOW2,"==================================================================");
	    SendClientMessage(playerid,COLOR_YELLOW2,"使用说明:");
	    SendClientMessage(playerid,COLOR_YELLOW2,"使用W前进(没有后退)，鼠标左键上升，右键下降，空格加速！！");
	    SendClientMessage(playerid,COLOR_YELLOW2,"如果飞累了，可以输入/exitfx停止飞行哦！");
	    return 1;
	}
	    SendClientMessage(playerid,COLOR_YELLOW2,"对不起，您没有权限哦！");

}
if(strcmp(cmd,"/exitfx")==0)
	{
	    StopFly(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW2,"你成功停了下来！还想飞的话就输入/fx吧！");

	    return 1;
	}*/
//===========================MP3控制=======================
if(strcmp(cmd,"/music")==0)
	{
	if(SL[playerid]==1)
	{
	ShowPlayerDialog(playerid,6700,DIALOG_STYLE_LIST,"音乐系统操作","停止播放\nURL音乐","确定","取消");
	    return 1;
		}
 SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
 return 1;
	}
if(strcmp(cmd,"/stopmusic")==0)
	{
	if(SL[playerid]==1)
	{
        StopAudioStreamForPlayer(playerid);
	    SendClientMessage(playerid,COLOR_YELLOW,"【服务器信息】音乐成功停了下来~");

	    return 1;
		}
 SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
 return 1;
	}
//================================刷图==================
if(strcmp(cmd,"/gmx")==0)
	{
	if(SL[playerid]==1)
	{
		if(playeradmin[playerid]>=3333)
		{
		new ak[128],name[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"【服务器信息】管理员%s将服务器重启了！",name);
		SendClientMessageToAll(0xFFFACDAA,ak);
		format(ak,128,"现在，请稍等几秒钟哦！马上就能重新进入游戏的！",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    SendRconCommand("gmx");
	    return 1;
	    }
    SendClientMessage(playerid,	 0xDC143CAA, "对不起，您不是管理员，无法使用此功能！");
	}
 SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
 return 1;
	}
//================================查看饥渴信息===========================
	/*if(strcmp(cmd,"/jike")==0)
	{
		if(SL[playerid]==1)
		{
        new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"==============================我的饥渴度===========================");
			format(msg,256,"尊敬的:%s 您现在的饥饿度是:%d 口渴度是:%d",playername[playerid],playerjiedu[playerid],playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
    	}
  SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
		return 1;
	}
*/
//==================================买食品===============================
	/*if(strcmp(cmd,"/buyfood")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2540.971923,2267.912597,5.026381)==1)
			{
				ShowPlayerDialog(playerid,6667,DIALOG_STYLE_LIST,"食品列表","1.VFC全家桶+40($100)\n2.田园鸡腿堡+2($20)\n3.超大雪碧+30($100)","购买","取消");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"你不在饭店!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	if(strcmp(cmd,"/eatfood")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid, -2540.971923,2267.912597,5.026381)==1)
			{
				ShowPlayerDialog(playerid,6668,DIALOG_STYLE_LIST,"食品列表","1.蛋炒饭+1($10)\n2.田园鸡腿堡+2($20)\n3.雪碧+1($5)\n4.缤纷全家桶+30($100)\n5.超大装雪碧+30($100)","购买","取消");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"你不在饭店!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
	if(strcmp(cmd,"/eats")==0)
	{
		if(SL[playerid]==1)
		{
                new list[256];
		    	format(list,256,"1.VFC全家桶(%d)\n2.田园鸡腿堡(%d)\n3.超大雪碧(%d)",food3[playerid],food1[playerid],food2[playerid]);
				ShowPlayerDialog(playerid,6669,DIALOG_STYLE_LIST,"食品仓库",list,"使用","取消");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}*/
//===============================EW大门==================================
if(strcmp(cmd,"/xzon")==0)
	{
		if(SL[playerid]==1)
		{
		if(playeradmin[playerid]<3333)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~您不是管理员，没办法开门哦！");
			return 1;
		}
		new name[128],ak[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"【服务器信息】管理员%s将小镇的外界通道打开了！",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    	SendClientMessage(playerid,COLOR_BLUE,"* 尊敬的管理员:您打开了小镇的外界通道");
            DestroyDynamicObject(ewmen1);
            DestroyDynamicObject(ewmen2);
            DestroyDynamicObject(xzmen1);
            DestroyDynamicObject(xzmen2);
            DestroyDynamicObject(xzmen3);
		    return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
if(strcmp(cmd,"/xzoff")==0)
	{
		if(SL[playerid]==1)
		{
		if(playeradmin[playerid]<3333)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~您不是管理员，没办法开门哦！");
			return 1;
		}
		new name[128],ak[128];
		GetPlayerName(playerid,name,128);
		format(ak,128,"【服务器信息】管理员%s将小镇的外界通道关闭了！",name);
		SendClientMessageToAll(0xFFFACDAA,ak);

	    	SendClientMessage(playerid,COLOR_BLUE,"* 尊敬的管理员:您关闭了小镇的外界通道");
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
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//==================================激光系统==============================
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
	        ShowPlayerDialog(playerid,6670,DIALOG_STYLE_LIST,"激光系统 选择颜色","红色\n蓝色\n粉红色\n橘色\n绿色\n黄色\n卸载激光","使用","取消");
    	    return 1;
    	}
    SendClientMessage(playerid,COLOR_YELLOW,"对不起，您不是VIP，不能使用本功能哦！");
	return 1;
	}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
return 1;
}
//==============================NOS=======================================
if(strcmp(cmd,"/noshelp")==0)
	{
		if(SL[playerid]==1)
		{
	SendClientMessage(playerid,	0x008040FF," ==================================加速器使用帮助=======================");
    SendClientMessage(playerid,	0xCECECEFF," 注：使用加速器必须要在车上哦！而且加速器不能安装在摩托和一些特殊车子上哦！");
    SendClientMessage(playerid,	0xCECECEFF," /nos2x[安装2倍加速] /nos5x[安装5倍加速] /nos10x[安装10倍加速]");
    SendClientMessage(playerid,	0xCECECEFF," /supernos[安装超级加速器] 购买后后，上车自动安装10XN2O,20秒自动补充氮气(可无限喷)");
    SendClientMessage(playerid,	0xCECECEFF," 注意:如果车辆被刷新，N2O也会消失哦~所以请好好保管~");
    SendClientMessage(playerid,	0xCECECEFF," 收费标准:2倍:500 5倍:1000 10倍:2000");
    SendClientMessage(playerid,	0x008040FF,"========================================================================");
				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}

   if(strcmp(cmd, "/nos10x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
		if(playermoney[playerid]<2000)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~你的钱不够装N2O啊!攒够了再来吧(2000)");
		    SendClientMessage(playerid,0xDC143CAA,"[提示]你可以试试/jcys做机场运输来赚钱哦！");
			return 1;
		}
		 	if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
   			playermoney[playerid]=playermoney[playerid]-2000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[车辆信息]%s成功为TA的爱车安装了10倍N2O！大家也试试吧~(/noshelp查看加速器帮助)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS安装完成!");
			return 1;
	}
   if(strcmp(cmd, "/nos5x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
		if(playermoney[playerid]<1000)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~你的钱不够装N2O啊!攒够了再来吧(1000)");
		    SendClientMessage(playerid,0xDC143CAA,"提示]你可以试试/jcys做机场运输来赚钱哦！");
			return 1;
		}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1008);
   			playermoney[playerid]=playermoney[playerid]-1000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[车辆信息]%s成功为TA的爱车安装了5倍N2O！大家也试试吧~(/noshelp查看加速器帮助)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS安装完成!");
			return 1;
	}
   if(strcmp(cmd, "/nos2x", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
		if(playermoney[playerid]<500)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~你的钱不够装N2O啊!攒够了再来吧(500)");
		    SendClientMessage(playerid,0xDC143CAA,"[提示]你可以试试/jcys做机场运输来赚钱哦！");
			return 1;
		}
			GetPlayerName(playerid,name,128);
		    AddVehicleComponent(GetPlayerVehicleID(playerid),1009);
   			playermoney[playerid]=playermoney[playerid]-500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
				format(ak,128,"[车辆信息]%s成功为TA的爱车安装了2倍N2O！大家也试试吧~(/noshelp查看加速器帮助)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS安装完成!");
			return 1;
	}
   if(strcmp(cmd, "/supernos", true) == 0)
    {
		new name[128],ak[128];
		new	vid=GetPlayerVehicleID(playerid);
 			if(vid==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
		if(playermoney[playerid]<500)
		{
		    SendClientMessage(playerid,0xDC143CAA,"对不起啊~你的钱不够装超级N2O啊!攒够了再来吧(50000)");
		    SendClientMessage(playerid,0xDC143CAA,"[提示]你可以试试/jcys做机场运输来赚钱哦！");
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
				format(ak,128,"[车辆信息]%s成功为TA的爱车安装了超级N2O！大家也试试吧~(/noshelp查看加速器帮助)",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			SendClientMessage(playerid,COLOR_YELLOW," NOS安装完成!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ad	[广告内容]");
					return 1;
				}
				if(playermoney[playerid]<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的金钱不足1500元!可以用/888找记者播广告，也许收费更低！");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"请等待60秒后再发送广告~！");
return 1;
}
				GetPlayerName(playerid,name,128);
				playermoney[playerid]=playermoney[playerid]-1500;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				new	msg[128];
				format(msg,128,"[广告]%s,电话:{FF00FF}%d{FFC0CB}",tmp,playercall[playerid]);
				SendClientMessageToAll(0xFFFF00AA,msg);
				askqtime[playerid]=60;
    return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"你不在传媒台广告发布点!");

			return 1;
		}
			SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/net [消息内容]");
					return 1;
				}
				if(playermoney[playerid]<10)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的金钱不足500元!");
					return 1;
				}
					if(askqtime[playerid]!=0)
{
SendClientMessage(playerid, 0xDC143CAA,"请等待5秒后再发送网吧消息~！");
return 1;
}
    GetPlayerName(playerid,name,128);
				playermoney[playerid]=playermoney[playerid]-150;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				new	msg[128];
				format(msg,128,"[网吧] %s说:%s",name,tmp);
				SendClientMessageToAll(0x6495EDFF,msg);
				askqtime[playerid]=5;
    return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你不在网吧上机处!");
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
					SendClientMessage(playerid,0x00FF00AA,"警员:你已经有执照了!请不要耍我!!");
					return 1;
				}
				if(playermoney[playerid]<10000)
				{
					SendClientMessage(playerid,0x00FF00AA,"警员:你的钱不够武器执照的工本费!穷人就不要玩枪嘛！(10000)");
					return 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"警员:请拿好你的武器执照^_^!");
				playergunzhizhao[playerid]=1;
				playermoney[playerid]=playermoney[playerid]-10000;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在武器执照销售处!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"你目前没有追踪任何一个玩家!");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				jcys[playerid]=0;
				tofind[playerid]=0;
				DisablePlayerCheckpoint(playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
	    SendClientMessage(playerid,	COLOR_LIGHTBLUE, "火箭飞行器已经传送到你身边啦~走动一下就能看到了哦~（已收取费用10000）");
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
				SendClientMessage(playerid,	COLOR_WHITE, "用法:	/rb [路障编号]");
				SendClientMessage(playerid,	COLOR_LIGHTBLUE, "可用路障:");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	1: 小路障 |	2: 中型路障	|");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	3: 大型路障	| 4: 交通锥	| 5: 绕行标志 |");
				SendClientMessage(playerid,	COLOR_GRAD1, "|	6: 禁止通行的标志 |	7: 关闭标志线 |");
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了路障(1), 完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了路障(2), 完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了路障(3), 完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了交通锥体(1), 完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了绕行路障(4), 完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了禁止通行的标志(5),	完毕.",sendername);
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
					format(string,sizeof(string),"[总部]: 人员%s 在他的位置放置了关闭标志线(6),	完毕.",sendername);
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
			format(string,sizeof(string),"[总部]: 人员%s 消除了一个路障, 完毕.",sendername);
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
				format(string,sizeof(string),"[总部]: 人员%s 消除了所有路障, 完毕.",sendername);
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/tofind	[玩家id]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可能已经处于红点模式(运送任务),请先使用/stofind结束任务!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆!");
					return 1;
				}
				jcys[playerid]=3;
				tofind[playerid]=id;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/find [目标id]");
					return 1;
				}
				if(jcys[playerid]!=0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可能已经处于红点模式(运送任务),请先使用/stofind结束任务!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆!");
					return 1;
				}
				jcys[playerid]=3;
				tofind[playerid]=id;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是侦探!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"你目前没有追踪任何一个玩家!");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				jcys[playerid]=0;
				tofind[playerid]=0;
				DisablePlayerCheckpoint(playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是侦探!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/guanya	[玩家id] [时间(秒)]	[罚金]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有上线!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"时间不能为空!");
						return 1;
					}
					s=strval(tmp);
					if(s<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"时间不能小于1!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"罚金不能为空!");
						return 1;
					}
					fj=strval(tmp);
					if(fj<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"罚金不能小于1!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离的太远了。。");
						return 1;
					}
					if(su[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有被通缉!!");
						return 1;
					}
					if(XY(10,playerid,-2485.5210 ,2271.7466, 4.9844)==0&&XY(10,playerid,267.1739 ,77.6191	,1001.0391)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在关押处/警察局门口!");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[总部]:	嫌疑人%s被警员%s关押了,时间:%d秒,罚金:%d.",name,name1,s,fj);
					ABroadCast(0x00FF00AA,msg,1);
					AdminXX(3,msg,0x00FF00AA);
					format(msg,128,"[总部]:	嫌疑人%s被警员%s逮捕了.",name,name1);
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
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//-----------------------------------------------fbi关人
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/guanren [玩家id] [时间(秒)] [罚金]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有上线!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"时间不能为空!");
						return 1;
					}
					s=strval(tmp);
					if(s<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"时间不能小于1!");
						return 1;
					}
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"罚金不能为空!");
						return 1;
					}
					fj=strval(tmp);
					if(fj<1)
					{
						SendClientMessage(playerid,	0xDC143CAA,"罚金不能小于1!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离的太远了。。");
						return 1;
					}
					if(su[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有被通缉!!");
						return 1;
					}
					if(XY(10,playerid,1524.820922 ,-1677.945678, 5.890625)==0&&XY(10,playerid,1557.278686 ,-1675.701538	,28.395452)==0&&XY(15,playerid,1539.951660 ,-1675.954101 ,13.549644)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在车库入口/警察局门口/楼顶入口!");
						return 1;
					}
					new	msg[128],name[128],name1[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128,"[总部]:	嫌疑人%s被警员%s关押了,时间:%d秒,罚金:%d.",name,name1,s,fj);
					ABroadCast(0x00FF00AA,msg,1);
					AdminXX(3,msg,0x00FF00AA);
					format(msg,128,"[总部]:	嫌疑人%s被警员%s逮捕了.",name,name1);
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
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//-----------------------------------------------fbi关人
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/cu	[玩家id]");
						return 1;
					}
					if(duty[playerid]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有上线!");
						return 1;
					}
					if(id==playerid)
					{
						SendClientMessage(playerid,0x00FF00AA,"神技术啊你？拷自己？");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(playerid,x,y,z);
					if(XY(5,id,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们2个离的太远了。。");
						return 1;
					}
					new	name[128];
					new	msg[128];
					if(cu[id]==0)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"你被%s拷起来了!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"%s被你拷起来了!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,0);
						cu[id]=1;
						return 1;
					}
					if(cu[id]==1)
					{
						GetPlayerName(playerid,name,128);
						format(msg,128,"你手上的拷子被%s弄掉了!",name);
						SendClientMessage(id,0x00FF00AA,msg);
						GetPlayerName(id,name,128);
						format(msg,128,"你把%s手上的拷子弄掉了!",name);
						SendClientMessage(playerid,0x00FF00AA,msg);
						TogglePlayerControllable(id,1);
						cu[id]=0;
						return 1;
					}
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				SendClientMessage(playerid,	0x008040FF,"________|我的中国心通缉名单|________");
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(su[i]>=1)
							{
								GetPlayerName(i,name,128);
								format(msg,256,"ID:%d 名字:%s 通缉等级:%d ",i,name,su[i]);
								SendClientMessage(playerid,0x7FFD4AA,msg);
							}
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/su	[玩家id] [通缉理由]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空!");
					return 1;
				}
				if(su[id]>=30)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家已经达到最高通缉(30)…!!");
					return 1;
				}
				new	msg[128];
				new	name[128];
				new	name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				su[id]=su[id]+1;
				format(msg,128,"[总部]:	%s的通缉令已经发布了！通缉等级:%d,通缉理由:%s",name,su[id],tmp);
				AdminXX(3,msg,0x00FF00AA);
				ABroadCast(0x00FF00AA,msg,1);
				format(msg,128,"%s发布了对你的通缉！理由:%s,通缉等级:%d",name1,tmp,su[id]);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"如果%s恶意通缉您，您可以到论坛举报该人，谢谢！",name1);
				SendClientMessage(id,0x00FF00AA,msg);

				format(msg,128,"你发布了对%s的通缉！理由:%s,通缉等级:%d",name,tmp,su[id]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/unsu	[玩家id] [撤销理由]");
					return 1;
				}
				if(duty[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有上班!");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"撤销理由不能为空!");
					return 1;
				}
				if(su[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有被通缉!!");
					return 1;
				}
				new	msg[128];
				new	name[128];
				new	name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				su[id]=0;
				format(msg,128,"[总部]:	%s的通缉令被撤销了,理由:%s",name,tmp);
				AdminXX(3,msg,0x00FF00AA);
				AdminXX(4,msg,0x00FF00AA);
				format(msg,128,"%s撤消了对你发布的通缉令！理由:%s",name1,tmp);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"你撤消了对%s发布的通缉令！理由:%s",name,tmp);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"组织成员不允许购买衣服~~");
					return 1;
				}
				if(playermoney[playerid]<2000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的金钱不足以让你购买新的衣服…(2000)");
					return 1;
				}
				CallRemoteFunction("ChangeSkinCommand","i",playerid);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在衣服店柜台!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,0x00FF00AA,"用法:/drag [玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆!");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在车上!");
						return 1;
					}
					if(playerzuzhi[playerid]==3&&GetVehicleModel(vid)!=599&&GetVehicleModel(vid)!=598&&GetVehicleModel(vid)!=490&&GetVehicleModel(vid)!=528&&GetVehicleModel(vid)!=497&&GetVehicleModel(vid)!=427&&GetVehicleModel(vid)!=428&&GetVehicleModel(vid)!=596&&GetVehicleModel(vid)!=523)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在警车上!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(5,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你们离的太远了..");
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
						SendClientMessage(playerid,0x00FF00AA,"你的汽车已经满人了!");
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
			SendClientMessage(playerid,0x00FF00AA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/jiechuzuche")==0)
	{
		if(SL[playerid]==1)
		{
				new	i=carzuyongkey[playerid];
				if(i==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有租车呀!?");
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
				SendClientMessage(playerid,0x00FF00AA,"你已经退还了你的车子~");
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,0x00FF00AA,"你不是VIP！");

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
			    format(msgd,128,"恭喜VIP用户：%s升级至了VIP%d！大家祝贺他吧！",name,playerviplv[playerid]);
			    SendClientMessage(playerid,COLOR_YELLOW,msgd);
			    format(msgg,128,"你的VIP等级提升啦！现在你的VIP等级是：%d",playerviplv[playerid]);
			    SendClientMessage(playerid,0xFFFF00AA,msgg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你的VIP成长值不够！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"你升级了~");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你的升级点数不够！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			format(msg,128,"当前服务器日期:%d-%d-%d	当前服务器时间:%d:%d:%d",y,r,d,h,m,s);
			SendClientMessage(playerid,0xFFFF00AA,msg);
			if(playerjianyutime[playerid]>0)
			{
				format(msg,128,"监狱剩余时间:%d秒",playerjianyutime[playerid]);
				SendClientMessage(playerid,0xFFFF00AA,msg);
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"用法/spawnchange	0/1/2/3/4 (0为组织出生地或新手机场,1-3为1-3号房出生,4为租房出生(租房暂时不开放)");
				return 1;
			}
			i=strval(tmp);
			if(i<0||i>3)
			{
				SendClientMessage(playerid,0x00FF00AA,"错误的房屋编号(0-3)!");
				return 1;
			}
			if(i==0)
			{
				playerspawn[playerid]=0;
				SendClientMessage(playerid,0x00FF00AA,"你会在新手基地或组织基地出生!");
				return 1;
			}
			if(i==1)
			{
				if(playerlock[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有一号房!");
					return 1;
				}
				playerspawn[playerid]=1;
				SendClientMessage(playerid,0x00FF00AA,"你会在你的1号房出生!");
				return 1;
			}
			if(i==2)
			{
				if(playerlock1[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有二号房!");
					return 1;
				}
				playerspawn[playerid]=2;
				SendClientMessage(playerid,0x00FF00AA,"你会在你的2号房出生!");
				return 1;
			}
			if(i==3)
			{
				if(playerlock2[playerid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有三号房!");
					return 1;
				}
				playerspawn[playerid]=3;
				SendClientMessage(playerid,0x00FF00AA,"你会在你的3号房出生!");
				return 1;
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"你不在改装车解除保存点!");
				return 1;
			}
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"这辆汽车不是你的！");
				return 1;
			}
			if(playermoney[playerid]<50000)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的金钱不足以支付解除保存费用!");
				return 1;
			}
			if(cargzbc[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的汽车还没有保存改装呢..");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-50000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,"你解除了汽车的改装!");
			cargzbc[vid]=0;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"你不在改装车保存点!");
				return 1;
			}
			if(vid==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"这辆汽车不是你的！");
				return 1;
			}
			if(playermoney[playerid]<50000)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的金钱不足以支付保存费用!");
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-50000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,0x00FF00AA,"你保存了汽车的改装!");
			cargzbc[vid]=1;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,	0x00BFFFF,"用法:/vcall	[车辆ID]");
				return 1;
			}
			id=strval(tmp);
			GetPlayerName(playerid,name,128);
			if(GetVehicleModel(id)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"错误的车辆ID!");
				return 1;
			}
			if(strcmp(carname[id],name)!=0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不能召回不属于你的汽车！");
				return 1;
			}
			if(playermoney[playerid]<2500)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的金钱不足以支付拖车费用！");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"拖车中心将你的车拖回了PARK点!收取了2500元");
			SetVehiclePos(id,carx[id],cary[id],carz[id]);
			playermoney[playerid]=playermoney[playerid]-2500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
								SendClientMessage(playerid,0x00FF00AA,"你将你的房子解锁了！");
								return 1;
							}
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"你将你的房子锁上了！");
							return 1;
						}
						SendClientMessage(playerid,0x00FF00AA,"你没有这间房的钥匙！");
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
								SendClientMessage(playerid,0x00FF00AA,"你将组织房子解锁了！");
								return 1;
							}
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"你将组织房子锁上了！");
							return 1;
						}
						SendClientMessage(playerid,0x00FF00AA,"你没有这间房的钥匙！");
						return 1;
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						if(strcmp(ZFJGSTR[u],"未出售")==0)
						{
							SendClientMessage(playerid,0xDC143CAA,"这间房子还没有被购买呢...");
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
							format(ZFJGSTR[u],128,"未出售");
							ZFJGLOCK[u]=0;
							SendClientMessage(playerid,0x00FF00AA,"你出售了一间房子！");
							u=pickupids+1;
							return 1;
						}
						if(playerlock[playerid]!=u||playerlock1[playerid]!=u||playerlock2[playerid]!=u)
						{
							SendClientMessage(playerid,0xDC143CAA,"你不能出售不是你的房子!");
							return 1;
						}
					}
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						if(strcmp(ZFJGSTR[u],"未出售")!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"这间房子已经被购买了…");
							return 1;
						}
						if(playerlock[playerid]!=0&&playerlock1[playerid]!=0&&playerlock2[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"你已经拥有3间房子了!如果想买房请卖掉一间！卖房子输入/sellhouse");
							return 1;
						}
						if(strcmp(ZFJGSTR[u],"未出售")==0)
						{
							id=u;
							u=pickupids+1;
						}
					}
				}
			}
			if(id==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"这个房子买不了啊");

				return 1;
			}
			if(playermoney[playerid]<ZFJGMONEY[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"你买不起这间房子…");
				return 1;
			}
			if(playerlv[playerid]<ZFJGLV[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"你的等级不够…");
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
			SendClientMessage(playerid,0x00FF00AA,"你买了一间新房子！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
				return 1;
			}
			if(carzuzhi[vid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你的汽车不属于任何组织!");
				return 1;
			}
			if(playermoney[playerid]<carmoney[vid]/3)
			{
				format(msg,128,"你的金钱不足以回收%s成员手上的钥匙！",zuzhiname[carzuzhi[vid]]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				return 1;
			}
			playermoney[playerid]=playermoney[playerid]-carmoney[vid]/3;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			format(msg,128,"你花费了%d从%s成员手上回收了你汽车的全部钥匙!",carmoney[vid]/3,zuzhiname[carzuzhi[vid]]);
			SendClientMessage(playerid,0x00FF00AA,msg);
			carzuzhi[vid]=0;
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/tuichuzz")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有组织");
				return 1;
			}
			if(playermoney[playerid]<10000)
			{
				SendClientMessage(playerid,0xFFFACDAA,"你身上的金钱不足以让你安全退出组织!");
				return 1;
			}
			new	msg[128];
			format(msg,128,"你退出了组织%s",zuzhiname[playerzuzhi[playerid]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			playermoney[playerid]=playermoney[playerid]-10000;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			playerzuzhi[playerid]=0;
			playerzuzhilv[playerid]=0;
			SetPlayerSkin(playerid,playerskin[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0xDC143CAA,"没有人想出售汽车给你!");
					return 1;
				}
				if(vselltomoney[playerid]>playermoney[playerid])
				{
					SendClientMessage(playerid,0xDC143CAA,"你买不起这辆汽车…");
					return 1;
				}
				new	Float:x,Float:y,Float:z;
				GetPlayerPos(vsellto[playerid],x,y,z);
				if(XY(10,playerid,x,y,z)==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"你们两个距离太远了…");
					return 1;
				}
				playermoney[playerid]=playermoney[playerid]-vselltomoney[playerid];
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid,playermoney[playerid]);
				playermoney[vsellto[playerid]]=playermoney[vsellto[playerid]]+vselltomoney[playerid];
				ResetPlayerMoney(vsellto[playerid]);
				GivePlayerMoney(vsellto[playerid],playermoney[vsellto[playerid]]);
				format(msg,128,"%s购买了你的汽车,你获得了%d!",name,vselltomoney[playerid]);
				SendClientMessage(vsellto[playerid],0xFFFACDAA,msg);
				format(carname[vselltocar[playerid]],128,"%s",name);
				GetPlayerName(vsellto[playerid],name,128);
				format(msg,128,"你购买了%s的汽车,花费了%d!",name,vselltomoney[playerid]);
				playercar[vsellto[playerid]]=playercar[vsellto[playerid]]-1;
				playercar[playerid]=playercar[playerid]+1;
				SendClientMessage(playerid,0xFFFACDAA,msg);
				vsellto[playerid]=0;
				vselltocar[playerid]=0;
				vselltomoney[playerid]=0;
				return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/sellcar [玩家ID] [价格]");
						return 1;
					}
					id=strval(tmp);
					if(id==playerid)
					{
						SendClientMessage(playerid,0xDC143CAA,"你不能把车卖给自己....");
						return 1;
					}
					if(SL[id]==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"该玩家没有登陆!");
						return 1;
					}
					GetPlayerName(id,name1,128);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"用法:/sellcar [玩家ID] [价格]");
						return 1;
					}
					money=strval(tmp);
					if(money<=100)
					{
						SendClientMessage(playerid,0xDC143CAA,"价格必须在100元以上");
						return 1;
					}
					if(vid==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
						return 1;
					}
					if(strcmp(name,carname[vid])!=0)
					{
						SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					if(XY(10,playerid,x,y,z)==0)
					{
						SendClientMessage(playerid,0xDC143CAA,"你们两个距离太远了…");
						return 1;
					}
					format(msg,128,"%s想出售一辆汽车给你,价格为%d,如果你想购买请输入/maiche",name,money);
					SendClientMessage(id,0xFFFACDAA,msg);
					format(msg,128,"你想出售一辆汽车给%s,价格为%d的请求已经发送给%s了,请等待回应",name1,money,name1);
					SendClientMessage(playerid,0xFFFACDAA,msg);
					vsellto[id]=playerid;
					vselltocar[id]=vid;
					vselltomoney[id]=money;
					vselltoid[playerid]=id;
					return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"你不是汽车销售商!");
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
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
				return 1;
			}
			if(XY(8,playerid,-2445.007568,2485.488525,15.320312)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在卖车点!");
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
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
				return 1;
			}
			if(carzuzhi[vid]!=0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"这辆汽车已经属于某组织了!");
				return 1;
			}
			if(playerzuzhi[playerid]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有组织");
				return 1;
			}
			if(playermoney[playerid]<money)
			{
				SendClientMessage(playerid,0xFFFACDAA,"你身上的金钱不足以注册这辆汽车!");
				return 1;
			}
			carzuzhi[vid]=playerzuzhi[playerid];
			new	msg[128];
			format(msg,128,"你将汽车注册给了组织:%s,花费了%d",zuzhiname[carzuzhi[vid]],money);
			SendClientMessage(playerid,0xF8F8FFFF,msg);
			playermoney[playerid]=playermoney[playerid]-money;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid,playermoney[playerid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/buycar")==0)
	{
		if(SL[playerid]==1)
		{
			if(XY(3,playerid,-2445.007568,2485.488525,15.320312)==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"你不在买车点!");
				return 1;
			}
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"我的中国心	- 车辆购买系统","{00F0F0}1.四轮车类\n{00F0F0}2.两轮车类\n{00F0F0}3.飞机/直升机类\n{00F0F0}4.VIP车辆类\n{00F0F0}5.特殊车辆类","选择","取消");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			if(strcmp(name,carname[vid])!=0 && playeradmin[playerid]<9999)
			{
				SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
				return 1;
			}
			SendClientMessage(playerid,0xDC143CAA,"你修改了汽车的刷新点!");
			GetVehiclePos(vid,carx[vid],cary[vid],carz[vid]);
			GetVehicleZAngle(vid,carmianxiang[vid]);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
				return 1;
			}
			if(strcmp(name,carname[vid])!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"这不是你的汽车!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0x00BFFFF,"用法:/vcolor	[颜色1] [颜色2]");
				return 1;
			}
			c1=strval(tmp);
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,	0x00BFFFF,"用法:/vcolor	[颜色1] [颜色2]");
				return 1;
			}
			if(playermoney[playerid]<1000)
			{
				SendClientMessage(playerid,0xDC143CAA,"你的金钱不足(1000)!");
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
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
SendClientMessage(playerid,	0x0D7792AA,	"5秒后关闭车库");
gatetime[1]=5;
return 1;
}
if(XY(8,playerid,1564.3739,-1611.4268,13.3828))
{
MoveDynamicObject(gate89, 1563.911255, -1617.380615, 4.307865, 0.8);
SendClientMessage(playerid,	0x0D7792AA,	"5秒后关闭库门");
gatetime[2]=5;
return 1;
}
SendClientMessage(playerid,0x0D7792AA, "你附近没有可以打开的门");
return 1;
}
SendClientMessage(playerid,0x0D7792AA, "你没有钥匙");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x0D7792AA, "5秒后关闭铁栏");
					gatetime[0]=5;
					return 1;
				}
				if(XY(8,playerid,1588.2493,-1637.5610,13.4196))
				{
					MoveDynamicObject(gate1, 1591.738037, -1638.271606,	-2.911936, 0.8);
					SendClientMessage(playerid,	0x0D7792AA,	"10秒后关闭车库");
					gatetime[1]=10;
					return 1;
				}
				if(XY(8,playerid,1564.3739,-1611.4268,13.3828))
				{
					MoveDynamicObject(gate2, 1563.911255, -1617.380615,	4.307865, 0.8);
					SendClientMessage(playerid,	0x0D7792AA,	"10秒后关闭库门");
					gatetime[2]=10;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "你附近没有可以打开的门");
				return 1;
			}
			if(playerzuzhi[playerid]==4)
			{
				if(XY(8,playerid,1535.0043,-1451.6725,13.3887))
				{
					MoveDynamicObject(gate3, 1535.4482421875,-1451.5390625,9.160917282104, 1.0);
					SendClientMessage(playerid,	0x0D7792AA,	"10秒后关闭车库");
					gatetime[3]=10;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "你附近没有可以打开的门");
				return 1;
			}
			if(playerzuzhi[playerid]==5)
			{
				if(XY(2,playerid,372.0354,166.7028,1008.3828)==1)
				{
					MoveDynamicObject(gate4, 369.2467956543, 166.54695129395, 1007.3828125,	5);
					SendClientMessage(playerid,	0x0D7792AA,	"2秒后关门");
					gatetime[4]=2;
					return 1;
				}
				SendClientMessage(playerid,0x0D7792AA, "你附近没有可以打开的门");
				return 1;
			}
			SendClientMessage(playerid,0x0D7792AA, "你没有钥匙");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}


if(strcmp(cmd,"/gengxin")==0)
	{
		if(SL[playerid]==1)
		{

				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}

 if(strcmp(cmd,"/help")==0)
	{
		if(SL[playerid]==1)
		{
				new	listitems[]	= "1\t饥渴系统帮助\n2\t常用指令帮助\n3\t音乐系统帮助\n4\t手机帮助\n5\t房屋帮助\n6\t组织领导帮助\n7\t医生/市政/记者帮助\n8\t警察/FBI/军队帮助\n9\t工作帮助\n10\t管理员帮助\n11\tVIP帮助";
				ShowPlayerDialog(playerid,8536,DIALOG_STYLE_LIST,"请选择你需要查看的帮助:",listitems,"确定","取消");
				return 1;
			}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/gov [内容]");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"|____________政府新闻公告____________|");
				SendClientMessageToAll(0xCECECEFF,msg);
				format(msg,128,"%s%s:%s",zuzhigonggao[playerzuzhi[playerid]],name,tmp);
				SendClientMessageToAll(0x00BFFFF,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//==================================================================================
	if(strcmp(cmd,"/kong")==0)
	{
		if(SL[playerid]==1)
		{
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SendClientMessage(playerid,	0x00BFFFF,"空间已经修复完毕！如还有BUG请反馈管理员或在群里留言哦~");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//--------------------------------admin---------------------------------------------
//==================================DM===================================、
/*	if(strcmp(cmd,"/dm")==0)
	{
		if(playerdm[playerid]==0)
		{
			SetPlayerVirtualWorld(playerid,555);
			playerdm[playerid]=1;
			new name[128],ak[128];
			GetPlayerName(playerid,name,128);
				format(ak,128,"[DM信息]%s进入了DM模式，大家一起来战斗吧！'/dm'",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
   					SetPlayerPos(playerid, -783.2614,503.1347,1381.6);
					SetPlayerInterior(playerid,1);
			SendClientMessage(playerid,	0x00BFFFF,"DM模式已经启动！您还可以输入/dm退出DM模式哦");
			return 1;
		}
		if(playerdm[playerid]==1)
		{
			SetPlayerVirtualWorld(playerid,0);
			playerdm[playerid]=0;
			new name[128],ak[128];
			GetPlayerName(playerid,name,128);
				format(ak,128,"[DM信息]%s退出了DM模式",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
			ResetPlayerWeaponEx(playerid);
			SendClientMessage(playerid,	0x00BFFFF,"DM模式已经退出！我们已经将您的武器放进了军用仓库，祝您玩得愉快！");
			SendClientMessage(playerid,	0x00BFFFF,"您现在的位置：洛杉矶警察局大门口！");
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
				ShowPlayerDialog(playerid, 8900, DIALOG_STYLE_LIST,	"商品菜单",	"IPhoneG3(3800元)\n小灵通S2(800元)\n话费:10元面额\n话费:20元面额\n话费:50元面额\n话费:100元面额\n话费:200元面额\n彩票(50000元)\n驴胶补血颗粒(1500元)\n电话薄(1000元)\n平板电脑(6000元)\n烟花(1000元)", "购买", "返回");
				PlayerPlaySound(playerid, 1135,	0.0, 0.0, 10.0);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不在商店,无法购买");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/setcallmoney [玩家id] [话费]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"话费不能为空");
					return 1;
				}
				callmoney=strval(tmp);
				if(callmoney<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"话费不能小于0");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s将你的电话余额设置为%d",name,callmoney);
				SendClientMessage(id,0x00FF00AA,msg);
				playercallmoney[id]=callmoney;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/setmats [玩家id] [材料]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"材料不能为空");
					return 1;
				}
				mats=strval(tmp);
				if(mats<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"材料不能小于0");
					return 1;
				}
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"管理员%s将你的材料设置为%d",name,mats);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"管理员%s将玩家%s的材料设置为%d.",name,name1,mats);
				ABroadCast(0x00FF00AA,msg,1);
    playermats[id]=mats;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/xgname [玩家id] [新名字]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"新名字不能为空");
					return 1;
				}
				new	msg[128],name[128],name1[128];
				GetPlayerName(playerid,name,128);
				GetPlayerName(id,name1,128);
				format(msg,128,"管理员%s将你的名字更改为%d.",name,pname);
				SendClientMessage(id,0x00FF00AA,msg);
				format(msg,128,"你将玩家%s的名字更改为%d.",name1,pname);
				SendClientMessage(id,0x00FF00AA,msg);
				playername[id]=pname;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
							SendClientMessage(playerid,0x00FF00AA,"用法:/ky	[内容]");
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
				SendClientMessage(playerid,0x00FF00AA,"你没有上班");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有扩音器");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/setcall [玩家id]	[号码]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"号码不能为空");
					return 1;
				}
				callid=strval(tmp);
				if(callid>100&&callid<10087)
				{
					SendClientMessage(playerid,0x00FF00AA,"电话号码必须小于100或大于1000");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"%s将你的电话号码设置为%d",name,callid);
				SendClientMessage(id,0x00FF00AA,msg);
				playercall[id]=callid;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0x00FF00AA,"用法:/chm [玩家id]");
				return 1;
			}
			id=strval(tmp);
			if(SL[id]==0)
			{
				SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
				return 1;
			}
			new	msg[128],name[128];
			new	hm;
			hm=playercall[id];
			GetPlayerName(id,name,128);
			format(msg,128,"[信息台]:%s的电话号为:%d",name,hm);
			SendClientMessage(playerid,0x00FF00AA,msg);
			playercallmoney[id]=playercallmoney[id]-5;
			GameTextForPlayer(playerid,"-5",5000,1);
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0xDC143CAA,"用法:/ckar [玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
						return 1;
					}
					new	Float:ar,msg[128],name[128];
					GetPlayerArmour(id,ar);
					GetPlayerName(id,name,128);
					format(msg,128,"%s的护甲(AR)为%f",name,ar);
					SendClientMessage(playerid,	0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0xDC143CAA,"用法:/ckhp [玩家id]");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
						return 1;
					}
					new	Float:hp,msg[128],name[128];
					GetPlayerHealth(id,hp);
					GetPlayerName(id,name,128);
					format(msg,128,"%s的血量(HP)为%f",name,hp);
					SendClientMessage(playerid,	0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						format(ZFJGSTR[u],128,"未出售");
						ZFJGTID[u]=1273;
						ZFJGLOCK[u]=0;
						format(msg,128,"<批量卖房>房子描述:%s",ZFJGSTR1[u]);
						SendClientMessage(playerid,0x00FF00AA,msg);
					}
				}
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/refill	[车辆ID] [汽油量]");
					return 1;
				}
				id=strval(tmp);
				if(car[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"没有这辆车");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp, " ")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"油量不能为空");
					return 1;
				}
				fill=strval(tmp);
				if(fill<1||fill>100)
				{
					SendClientMessage(playerid,0x00FF00AA,"油量必须大于1小于100!");
					return 1;
				}
				carfill[id]=fill;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是加油站服务员");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/afill	[车辆ID] [汽油量]");
					return 1;
				}
				id=strval(tmp);
				if(car[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"没有这辆车");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp, " ")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"油量不能为空");
					return 1;
				}
				fill=strval(tmp);
				if(fill<1||fill>1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"油量必须大于1小于1000!");
					return 1;
				}
				carfill[id]=fill;
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是加油站服务员");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ckzhizhao [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(id,name,128);
				format(msg,128,"----%s拥有的执照----",name);
				SendClientMessage(playerid,0x708090AA,msg);
				format(msg,128,"武器执照:%s",tg[playergunzhizhao[id]]);
				SendClientMessage(playerid,0x708090AA,msg);
				format(msg,128,"驾驶执照:%s",tg[playercarzhizhao[id]]);
				SendClientMessage(playerid,0x708090AA,msg);
				SendClientMessage(playerid,0x708090AA,"--------------------");
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ckwuqi	[玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆!");
					return 1;
				}
				new	msg[256],name[128];
				GetPlayerName(id,name,128);
				format(msg,128,"|----%s----|",name);
				SendClientMessage(playerid,	0xDC143CAA,msg);
				for(new	i=0;i<7;i++)
				{
					format(msg,256,"武器%dID:%d	/武器仓库%d栏武器ID:%d",i,playerwuqi[id][i],i,playerinvwuqi[id][i]);
					SendClientMessage(playerid,	0xDC143CAA,msg);
				}
				SendClientMessage(playerid,	0xDC143CAA,"|----武器列表----|");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/setlv	[玩家id] [等级]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				up=strval(tmp);
				if(up<1)
				{
					SendClientMessage(playerid,0x00FF00AA,"等级必须大于0");
					return 1;
				}
				playerlv[id]=up;
				SetPlayerScore(playerid,playerlv[id]);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/setlvup [玩家id] [点数]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				up=strval(tmp);
				if(up<0)
				{
					SendClientMessage(playerid,0x00FF00AA,"点数必须大于0");
					return 1;
				}
				playerlvup[id]=up;
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/settime [时间]");
					return 1;
				}
				id=strval(tmp);
				if(id<0||id>24)
				{
					SendClientMessage(playerid,	0xDC143CAA,"错误的时间(0-24)");
					return 1;
				}
				SetWorldTime(id);
				new	msg[128];
				format(msg,128,"时间被设置为%d点",id);
				SendClientMessageToAll(0xDC143CAA,msg);
//SendClientMessage(playerid, 0xDC143CAA,"此功能停止使用");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/jianjin [玩家id] [时间(秒)] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家不在线!");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"秒数不能为空!");
					return 1;
				}
				t=strval(tmp);
				if(t<1)
				{
					SendClientMessage(playerid,	0xDC143CAA,"秒数不能小于1!");
					return 1;
				}
				if(id == playerid && t<60 && playerjianyutime[id] > 0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"不要滥用权限(你自己有监狱时间并且再次监禁自己60秒以内)!");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"理由不能为空!");
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
				format(msg,128,"[监禁]%s被%s监禁%d秒,理由:%s",name,name1,t,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/xsld")==0)
	{
		if(SL[playerid]==1)
		{
			if(playerzuzhi[playerid]==3||playerzuzhi[playerid]==14)
			{
				SetPlayerColor(playerid,0x1229FAFF);
							SendClientMessage(playerid,	0xDC143CAA,"你的昵称颜色已经改变成了蓝色，并且你的位置已在地图上标出哦~");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是警察!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"你不是记者!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"你不是FBI!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"你不是医生!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"你不是管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"对不起，您不是VIP用户，不能享有此项权利！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"对不起，您不是VIP用户，不能享有此项权利！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/tv [玩家id");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				TogglePlayerSpectating(playerid, 1);
				PlayerSpectatePlayer(playerid, id);
				SetPlayerInterior(playerid,GetPlayerInterior(id));
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					format(msg,128,"你当前的环境ID是%d,坐标是%f,%f,%f(x,y,z)",h,x,y,z);
					SendClientMessage(playerid,0x00FF00AA,msg);
					printf("%s当前的环境ID是%d,坐标是%f,%f,%f(x,y,z)",name,h,x,y,z);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/changezzhouse [ID] [图标ID] [所属组织ID]	[描述]  [内室ID] [内室坐标X] [内室坐标Y] [内室坐标Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"没有这间房！");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==3)
					{
						SendClientMessage(playerid,	0x00BFFFF,"修改房子请用/changehouse!");
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
					format(msg,128,"你将ID为%d的组织房信息修改了",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"新的信息:描述:%s 所属组织ID:%d 内室ID:%d 内室x坐标:%f 内室y坐标:%f 内室z坐标:%f",ZFJGSTR[id],ZFJGZUZHI[id],ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/changegzhouse [ID] [图标ID] [描述] [当地环境ID] [内室ID]	[内室坐标X] [内室坐标Y]	[内室坐标Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"没有这间房！");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==3)
					{
						SendClientMessage(playerid,	0x00BFFFF,"修改房子请用/changehouse!");
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
					format(msg,128,"你将ID为%d的政府房信息修改了",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"新的信息:描述:%s 当地环境ID:%d 内室ID:%d 内室x坐标:%f 内室y坐标:%f 内室z坐标:%f",ZFJGSTR[id],ZFJGLOCALHID[id],ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/changehouse [房屋ID]	[描述] [价格] [等级] [内室ID] [内室坐标X]	[内室坐标Y] [内室坐标Z]");
						return 1;
					}
					id=strval(tmp);
					if(ZFJGLX[id]==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"没有这间房！");
						return 1;
					}
					if(ZFJGLX[id]==2||ZFJGLX[id]==1)
					{
						SendClientMessage(playerid,	0x00BFFFF,"修改政府机构请用/changegzhouse!");
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
					format(msg,128,"你将ID为%d的房子信息修改了",id);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"新的信息:描述:%s 价格:%d 购买等级:%d",ZFJGSTR1[id],ZFJGMONEY[id],ZFJGLV[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					format(msg,128,"内室ID:%d 内室x坐标:%f 内室y坐标:%f	内室z坐标:%f",ZFJGHID[id],ZFJGCX[id],ZFJGCY[id],ZFJGCZ[id]);
					SendClientMessage(playerid,0x00FF00AA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CAA,"用法:/gotohouse	[房屋id]");
					return 1;
				}
				id=strval(tmp);
				if(ZFJGLX[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该房不存在");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
							format(msg,128,"ID:%d,图标ID:%d,描述1:%s 描述2:%s",h,ZFJGTID[h],ZFJGSTR[h],ZFJGSTR1[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
							format(msg,128,"ID:%d,描述:%s,当地环境ID:%d,内室ID:%d,内室X:%f,内室Y:%f,内室Z:%f",h,ZFJGSTR[h],ZFJGLOCALHID[h],ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/kick	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[踢人]%s被%s踢出服务器,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				SetTimerEx("KickEx",2000,false,"i",id);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ikick1	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC踢出]%s被IRC管理员%s踢出IRC频道,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是IRC频道1管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ikick2	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC踢出]%s被IRC管理员%s踢出IRC频道,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是IRC频道2管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ikick3	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC踢出]%s被IRC管理员%s踢出IRC频道,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是IRC频道3管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ikick4	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC踢出]%s被IRC管理员%s踢出IRC频道,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是IRC频道4管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ikick5	[玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
			 playerircid[id]=0;
    GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[IRC踢出]%s被IRC管理员%s踢出IRC频道,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是IRC频道5管理员!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/ban [玩家id] [理由]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家不在线");
					return 1;
				}
				tmp=strtokp(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"理由不能为空");
					return 1;
				}
				new	msg[128];
				new	name[128],name1[128];
				GetPlayerName(id,name,128);
				GetPlayerName(playerid,name1,128);
				format(msg,128,"[BAN]%s被管理员%s封锁了帐号,理由:%s",name,name1,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
				BanEx(id,tmp);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
							format(msg,128,"房子ID:%d,房子描述:%s,房子所属组织ID:%d",h,ZFJGSTR[h],ZFJGZUZHI[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
							format(msg,128,"房子内室ID:%d,房子内室X:%f,房子内室Y:%f	,房子内室Z:%f",ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
							format(msg,128,"房子ID:%d,房子描述:%s,房子价格:%d,房子购买等级:%d",h,ZFJGSTR1[h],ZFJGMONEY[h],ZFJGLV[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
							format(msg,128,"房子内室ID:%d,房子内室X:%f,房子内室Y:%f	,房子内室Z:%f",ZFJGHID[h],ZFJGCX[h],ZFJGCY[h],ZFJGCZ[h]);
							SendClientMessage(playerid,0x00FF00AA,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/ckhstats [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"======================房屋信息======================");
				new	msg[128];
				for(new	u=0;u<pickupids;u++)
				{
					if(ZFJGLX[u]==3)
					{
						if(playerlock[id]==u||playerlock1[id]==u||playerlock2[id]==u)
						{
							format(msg,128,"房屋ID:%d 房屋描述:%s 房屋价格:%d 房屋购买等级:%d 门锁状态(0为锁门,1为解锁):%d",u,ZFJGSTR1[u],ZFJGMONEY[u],ZFJGLV[u],ZFJGLOCK[u]);
							SendClientMessage(playerid,	0xD3D3D3FF,msg);
						}
					}
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/ckvstats [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[256];
				SendClientMessage(playerid,	0xD3D3D3FF,"======================汽车信息======================");
				if(playercar[id]!=0)
				{
					for(new	i=1;i<999;i++)
					{
						if(strcmp(carname[i],playername[id])==0)
						{
							if(car[i]!=0)
							{
								format(msg,128,"车辆ID:%d 车辆模型:%d 车辆颜色1:%d 车辆颜色2:%d	车辆所属组织:%s	汽车价值:%d",car[i],carmoxing[i],carcolor1[i],carcolor2[i],zuzhiname[carzuzhi[i]],carmoney[i]);
								SendClientMessage(playerid,	0xD3D3D3FF,msg);
							}
						}
					}
				}
				SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/ckstats [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[256];
SendClientMessage(playerid, 0x008040FF,"===================================================================");
format(msg,256,"|名字:%s| |金钱:%d |组织:%s| |组织等级:%s| |汽车数量:%d| |VIP等级:%d| |VIP成长值:%d/%d|",playername[id],playermoney[id],zuzhiname[playerzuzhi[id]],zuzhilv[playerzuzhi[id]][playerzuzhilv[id]],playercar[id],playerviplv[id],playervipczz[id],playerviplv[id]*8);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|房屋钥匙1:%d| |房屋钥匙2:%d| |房屋钥匙3:%d| |存款:%d| |电话余额:%d| |V豆余额:%d|",playerlock[id],playerlock1[id],playerlock2[id],playerbank[id],playercallmoney[id],playervdou[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|等级:%d| |升级点:%d/%d| |电话号码:%d| |工作:%s| |材料:%d| |平板:%d|",playerlv[id],playerlvup[id],playerlv[id]*8,playercall[id],gongzuoname[playerjob[id]],playermats[id],playeripad[playerid]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|当前皮肤:%d| |监狱剩余时间:%d| |通缉等级:%d| |当前出生地:%d|",playerskin[id],playerjianyutime[id],su[id],playerspawn[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
format(msg,256,"|是否教程过:%d| |性别:%d|	|身份证编号:%d| |年龄:%d|",playerput[id],playersex[id],playersfz[id],playerage[id]);
SendClientMessage(playerid,	0xD3D3D3FF,msg);
SendClientMessage(playerid, 0x008040FF,"===================================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/ckjike [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[256];
format(msg,256,"名字:%s 饥饿值:%d 口渴值:%d",playername[id],playerjiedu[id],playerkouke[id]);
SendClientMessage(playerid, 0xD3D3D3FF,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}*/
//-------------------------------------------------[MDC犯罪资料库系统]------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/mdc [目标ID]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
					return 1;
				}
				new	msg[256];
				SendClientMessage(playerid,	0x008040FF,"======================MDC犯罪资料库======================");
				format(msg,256,"嫌疑人:[%s]	",playername[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"通缉等级:[%d] ",su[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"坐牢时间:[%d] ",playerjianyutime[id]);
				SendClientMessage(playerid,	0xCECECEFF,msg);
				format(msg,256,"LSPD警察局MDC犯罪资料库移动数据系统");
				SendClientMessage(playerid,	0xFFFFFFFF,msg);
				SendClientMessage(playerid,	0x008040FF,"==============================================================");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"你不是警察/FBI/军人");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//-----------------------------------------------------------------[设置AR]-----------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/ar	[玩家id] [ar量]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"ar不能为空");
					return 1;
				}
				ar=strval(tmp);
				SetPlayerArmour(id,ar);
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"你的AR被%s设置为了%d!",name,ar);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//-----------------------------------------------------------------[设置HP]-----------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/hp	[玩家id] [hp量]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"hp不能为空");
					return 1;
				}
				hp=strval(tmp);
				SetPlayerHealth(id,hp);
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"你的HP被%s设置为了%d!",name,hp);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//----------------------------[制作护甲]----------------------------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/zuoar [玩家id]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				if(playermats[playerid]<100)
				{
					SendClientMessage(playerid,0x00FF00AA,"你没有足够的武器材料(100)制作防弹衣!");
					return 1;
				}
				//playerid=strval(tmp);
				SetPlayerArmour(id,100);
				playermats[playerid]=playermats[playerid]-100;
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"玩家%s将部分材料制作成防弹衣,并戴在了你身上!",name);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你不是武器商人!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//===========================================================================================
if(strcmp(cmd,"/givegun") == 0)
{
	if(!SL[playerid])
	{
	    SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
	    return 1;
	}
	if(playerjob[playerid] != 3)
	{
	    SendClientMessage(playerid, 0xDC143CAA,"错误,错误原因:你不是武器商人");
		return 1;
	}
	if(playermats[playerid] < 300)
	{
		SendClientMessage(playerid,0x00FF00AA,"你材料不够");
		return 1;
	}
	new tmp[256];
	new weapid,giveplayid;
	tmp=strtok(cmdtext,idx);
	if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_WHITE, "用法: /givegun [武器ID] [玩家ID]");
		return 1;
	}
    weapid=strval(tmp);

    tmp=strtok(cmdtext,idx);
	if(!strlen(tmp)) {
		SendClientMessage(playerid, COLOR_WHITE, "用法: /givegun [武器ID] [玩家ID]");
		return 1;
	}
    giveplayid = strval(tmp);

    if(weapid == 34 || weapid == 28 || weapid == 27 || weapid == 26 || weapid == 17 || weapid == 1 || weapid == 3 || weapid == 9 || weapid == 16 || weapid == 35 || weapid == 36 || weapid == 37 || weapid == 38 || weapid == 39 || weapid == 40 || weapid == 44 || weapid == 23 || weapid == 15 || weapid == 45 || weapid == 34)
    {
  		SendClientMessage(playerid, COLOR_WHITE, "你不能做这个武器!");
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

			format(msg,128,"%s给了你一把武器[武器id %d].!",name,weapid);
			SendClientMessage(giveplayid,COLOR_PURPLE,msg);

			format(msg,128,"你给了%s一把武器[武器id %d].!",name1,weapid);
			SendClientMessage(playerid,COLOR_PURPLE,msg);

			format(msg,128,"[武器商人][ID:%d]%s给了[ID:%d]%s一把武器[武器id %d]",playerid,name,giveplayid,name1,weapid);
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
SendClientMessage(playerid,0xFFFACDAA,"成功拉人");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
SendClientMessage(playerid,0xDC143CAA,"你报名参加了活动");
to[id]=sc;
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"服务器没有打开活动报名");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"你没有登录");
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
format(msg,128,"管理员撤消了所有人活动状态");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"你没有登录");
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
format(msg,128,"管理员关闭了活动报名");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"你没有登录");
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
format(msg,128,"[活动系统]:服务器开启了活动报名,想参加活动请输入/cjhd参加.");
SendClientMessageToAll(0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"你没有登录");
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
SendClientMessage(playerid, 0x00BFFFF,"用法:/szhd [玩家id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"该玩家没有登陆");
return 1;
}
playerid=strval(tmp);
SetPlayerHealth(id,100);
SetPlayerArmour(id,100);
hdcd[id]=1;
new msg[128],name[128];
GetPlayerName(playerid,name,128);
format(msg,128,"你被设置为了活动状态!");
SendClientMessage(id, 0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
SendClientMessage(playerid, 0x00BFFFF,"用法:/live [玩家id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"该玩家没有登陆");
return 1;
}
					new	vid=GetPlayerVehicleID(playerid),mod=GetVehicleModel(vid);
					if(vid==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"你不在新闻播报车/飞机上!");
						return 1;
					}
					if(mod!=582&&mod!=488)
					{
						SendClientMessage(playerid,0x00FF00AA,"这部汽车/飞机上没有无线电台!");
						return 1;
					}
if(playerlive[id]==1)
{
SendClientMessage(playerid,0x00FF00AA,"该玩家已经被接入News直播台了!");
return 1;
}
playerid=strval(tmp);
playerlive[id]=1;
new msg[128];
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"记者%s将你接入了News直播台,现在你能使用/e开始访谈了.",name);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"你将玩家%s接入了News直播台,使用/ulive可以取消连线.",name1);
SendClientMessage(playerid,0xE5C43EAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
SendClientMessage(playerid, 0x00BFFFF,"用法:/live [玩家id]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid, 0xDC143CAA,"该玩家没有登陆");
return 1;
}
if(playerlive[id]==0)
{
SendClientMessage(playerid,0x00FF00AA,"该玩家并没有被接入News直播台!");
return 1;
}
playerid=strval(tmp);
playerlive[id]=0;
new msg[128];
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"记者%s取消了对你的连线,采访结束.",name);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"你取消了对%s的连线,采访结束.",name1);
SendClientMessage(playerid,0xE5C43EAA,msg);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,0x00FF00AA,"用法:/e	[内容]");
					return 1;
				}
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"[我的中国心无线电台采访]:{90FFAA}%s_%s说:{1493FF}%s{1493FF}",zuzhilv[playerzuzhi[playerid]],name,tmp);
				SendClientMessageToAll(0xFFFACDAA,msg);
				return 1;
			}
			SendClientMessage(playerid,0x00FF00AA,"你没有被记者邀请连线!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
		return 1;
	}
//--------------------------------[倒计时]--------------------------------
/*if (strcmp("/count", cmdtext, true) == 0)//这个按/count可以倒计时。
{
if(playeradmin[playerid]>= 2)
			{
shu1 = SetTimer("cj",200,1);
shu2 = SetTimer("cj2",1200,1);
shu3 = SetTimer("cj3",2200,1);
shu4 = SetTimer("cj4",3200,1);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"你不是管理员!");
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
SendClientMessage(playerid,0x00FF00AA,"用法:/text [内容(仅限英文)]");
return 1;
}
new msg[128],name[128];
GetPlayerName(playerid,name,128);
format(msg,128,"%s",tmp);
GameTextForAll(msg,5000,3);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"你没有权限!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
				SendClientMessage(playerid, 0x00FF00AA, "用法:/gtq [天气ID]");
			return 1;
			}
			new weather;
			weather = strval(tmp);
			if(weather < 0||weather > 45)
			{
				SendClientMessage(playerid,0x00FF00AA, "天气id错误 0~45");
			return 1;
			}
			SetWeather(weather);
			//SendClientMessage(playerid, COLOR_GREY, " 我操,是E文,懒得翻译,在后面 %s KangYee留." , weather);//You have set the weather to
			tmp = strtok(cmdtext,idx);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 256, "[公告]管理员%s将天气设置编号为 %d 的天气.", sendername,weather);
			SendClientMessageToAll(0xDC143CAA,string);
//			DefaultWeather=weather;
		}
	return 1;
	}
SendClientMessage(playerid, 0x00FF00AA, "   你不是管理员!");
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
SendClientMessage(playerid,0x00FF00AA,"用法:/apm [玩家id] [内容]");
return 1;
}
id=strval(tmp);
if(SL[id]==0)
{
SendClientMessage(playerid,0x00FF00AA,"该玩家没有登陆");
return 1;
}
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:内容不能为空");
return 1;
}
GetPlayerName(id,name1,128);
GetPlayerName(playerid,name,128);
format(msg,128,"[APM]管理员[ID:%d]%s对你说:%s",playerid,name,tmp);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"[APM]你对玩家%s说:%s",name1,tmp);
SendClientMessage(playerid,0xE5C43EAA,msg);
format(msg,128,"[APM]管理员%s对玩家%s说:%s.",name,name1,tmp);
ABroadCast(0x00FF00AA,msg,1);
return 1;
}
SendClientMessage(playerid, 0xDC143CAA,"你不是管理员!");
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
return 1;
}
//-----------------------------------------------[自杀]----------------------------------
/*if(strcmp(cmd,"/kill")==0)
{
if(SL[playerid]==1)
{
new	msg[128];
new	id[128];
new	tmp[128];
SetPlayerHealth(playerid, 0.0);
format(msg,128,"你成功自杀了,你将会在医院出生,请珍惜生命!",id,tmp);
SendClientMessage(playerid,0xDC143CAA,msg);
return 1;
}
SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/pai [玩家id] 理由");
						return 1;
					}
					id=strval(tmp);
					if(SL[id]==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
						return 1;
					}
					tmp=strtokp(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"理由不能为空");
						return 1;
					}
					new	Float:x,Float:y,Float:z;
					GetPlayerPos(id,x,y,z);
					SetPlayerPos(id,x,y,z+10);
					new	name[128],name1[128];
					new	msg[128];
					GetPlayerName(id,name,128);
					GetPlayerName(playerid,name1,128);
					format(msg,128," %s被%s轻轻拍了一下,理由:%s",name,name1,tmp);
					SendClientMessageToAll(0xDC143CAA,msg);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/gotocar [车id]");
						return 1;
					}
					id=strval(tmp);
					if(GetVehicleModel(id)==0)
					{
						SendClientMessage(playerid,0x00FF00AA,"该车辆不存在！");
						return 1;
					}
					GetVehiclePos(id,x,y,z);
					SetPlayerPos(playerid,x+1,y+1,z+1);
					return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
			        SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:请等待当前正在进行的倒计时结束.");
			        return 1;
			    }
	            allscactive = 1;
				allscdjstime = SetTimer("daojishi",1000,1);
				new name1[128],ak[128];
				GetPlayerName(playerid,name1,128);
				format(ak,128,"[服务器信息]管理员%s开启倒计时准备刷新所有未使用的车辆~记得用/vpark修改你的车的出生点哦!",name1);
				SendClientMessageToAll(0xFFFACDAA,ak);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/changetbhouse [ID]	[图标ID] [描述1] [描述2] (为空则按原设置) ");
					return 1;
				}
				id=strval(tmp);
				if(ZFJGLX[id]!=2)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该指令只允许修改图标类房子!");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/addtbhouse	[图标ID] [描述1] [描述2] ");
					return 1;
				}
				tid=strval(tmp);
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"描述1不能为空");
					return 1;
				}
				format(miaoshu,128,"%s",tmp);
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0x00BFFFF,"描述2不能为空");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/addzzhouse	[门口物体ID] [所属组织ID] [描述] [内室环境ID] [内室坐标X]	[内室坐标Y] [内室坐标Z]");
						return 1;
					}
					tid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"所属组织不能为空");
						return 1;
					}
					zuzhiid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"描述不能为空");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室环境ID不能为空");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标X不能为空");
						return 1;
					}
					x=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标Y不能为空");
						return 1;
					}
					y=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标Z不能为空");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/addgzhouse	[门口物体ID] [描述]	[当地环境ID] [内室环境ID] [内室坐标X]	[内室坐标Y] [内室坐标Z]");
						return 1;
					}
					tid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"描述不能为空");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(cmd,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"当地环境ID不能为空");
						return 1;
					}
					localhid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室环境ID不能为空");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标X不能为空");
						return 1;
					}
					x=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标Y不能为空");
						return 1;
					}
					y=floatstr(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标Z不能为空");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/addhouse [描述] [价格]	[购买等级] [内室环境ID]	[内室坐标X] [内室坐标Y]	[内室坐标Z]");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"价格不能为空");
						return 1;
					}
					money=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00BFFFF,"购买等级不能为空");
						return 1;
					}
					lv=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室环境ID不能为空");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标x不能为空");
						return 1;
					}
					format(x,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标y不能为空");
						return 1;
					}
					format(y,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标z不能为空");
						return 1;
					}
					format(z,128,"%s",tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=3;
					ZFJGTID[pickupids]=1273;
					format(ZFJGSTR[pickupids],128,"未出售");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/addhouse 描述 价格	购买等级 内室环境ID	内室坐标X 内室坐标Y	内室坐标Z");
						return 1;
					}
					format(miaoshu,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"价格不能为空");
						return 1;
					}
					money=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,0x00BFFFF,"购买等级不能为空");
						return 1;
					}
					lv=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室环境ID不能为空");
						return 1;
					}
					hid=strval(tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标x不能为空");
						return 1;
					}
					format(x,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标y不能为空");
						return 1;
					}
					format(y,128,"%s",tmp);
					tmp=strtok(cmdtext,idx);
					if(strcmp(tmp,"	")==0)
					{
						SendClientMessage(playerid,	0x00BFFFF,"内室坐标z不能为空");
						return 1;
					}
					format(z,128,"%s",tmp);
					GetPlayerPos(playerid,px,py,pz);
					ZFJGLX[pickupids]=3;
					ZFJGTID[pickupids]=1273;
					format(ZFJGSTR[pickupids],128,"产业-未出售");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
						if(strcmp(ZFJGSTR[u],"未出售")!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"这间房子已经被购买了…");
							return 1;
						}
						if(playerlock[playerid]!=0&&playerlock1[playerid]!=0&&playerlock2[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"你已经拥有3间房子了!如果想买房请卖掉一间！卖房子输入/sellhouse");
							return 1;
						}
						if(strcmp(ZFJGSTR[u],"未出售")==0)
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
				SendClientMessage(playerid,0xDC143CAA,"你买不起这间房子…");
				return 1;
			}
			if(playerlv[playerid]<ZFJGLV[id])
			{
				SendClientMessage(playerid,0xDC143CAA,"你的等级不够…");
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
			SendClientMessage(playerid,0x00FF00AA,"你买了一间新房子！");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/skin [玩家id] [皮肤id]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"用法:/skin 玩家id 皮肤id");
				return 1;
			}
			sid=strval(tmp);
			if(sid>299)
			{
				SendClientMessage(playerid,0xDC143CAA,"皮肤ID错误！(0-299)");
				return 1;
			}
			SetPlayerSkin(id,sid);
			playerskin[id]=sid;
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
	if(strcmp(cmd,"/ckcar")==0)
	{
		if(playeradmin[playerid]>= 1)
		{
			new	vid=GetPlayerVehicleID(playerid);
			if(vid==0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"你不在车上");
				return 1;
			}
			new	msg[128];
			format(msg,128,"[汽车主人]:%s	[车辆ID]:%d [车辆模型]:%d [车辆颜色1]:%d [车辆颜色2]:%d	[车辆所属组织]:%s	[汽车价值]:%d",carname[vid],car[vid],carmoxing[vid],carcolor1[vid],carcolor2[vid],zuzhiname[carzuzhi[vid]],carmoney[vid]);
			SendClientMessage(playerid,	0x00BFFFF,msg);
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
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
			SendClientMessage(playerid,0x0D7792AA, "你附近没有可以打开的门");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
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
					SendClientMessage(playerid,0xDC143CAA,"你不在汽车上!");
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
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
	/*if(strcmp(cmd,"/skcs")==0)
	{
	    if(playerzuzhilv[playerid]>=2)
		{
          if(playermoney[playerid]<10000)
		  {
 			SendClientMessage(playerid,	COLOR_GRAD1, "哎呀，没钱就别传送嘛。。");
 			return 1;
		  }
			if(SL[playerid]==1)
			{
				ShowPlayerDialog(playerid, GOTOMENU, DIALOG_STYLE_LIST,	"传送菜单(如没有提示则是8000费用)","洛杉矶警察局(LSPD)\n旧金山\n拉斯维加斯\n飞往LS飞机机舱\n银行\n室内场地\n千年山顶\nSAST小镇\n室内场地2\n光碟酒吧\n体育场	2\n医院\n白宫\n飞机场\n健身房\n小镇\n自由城\nGM基地大门(20000)\n驾照中心\n银行内部\n工作地点 ", "传送", "取消");
				return 1;
			}
			SendClientMessage(playerid,	COLOR_GRAD1, "	 你未登陆.");
			return 1;
		}
		SendClientMessage(playerid,	COLOR_GRAD1, "	 你没有权限.");
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
					SendClientMessage(playerid,0xFFFACDAA,"用法:/la [玩家id]");
					return 1;
				}
				if(SL[strval(tmp)]==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetPlayerPos(strval(tmp),x+1,y+1,z+1);
				SetPlayerInterior(strval(tmp),GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(strval(tmp),GetPlayerVirtualWorld(playerid));
				houseid[strval(tmp)]=houseid[playerid];
				SendClientMessage(playerid,0xFFFACDAA,"成功拉人");
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
SendClientMessage(playerid,0xFFFACDAA,"用法:/goto [玩家id]");
return 1;
}
new hid=GetPlayerInterior(strval(tmp));
if(SL[strval(tmp)]==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
return 1;
}
GetPlayerPos(strval(tmp),x,y,z);
SetPlayerPos(playerid,x+1,y+1,z+1);
houseid[playerid]=houseid[strval(tmp)];
SetPlayerInterior(playerid,hid);
SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(strval(tmp)));
SendClientMessage(playerid,0xFFFACDAA,"成功传送");
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/gq	[玩家id] [武器id]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			wid=strval(tmp);
			if(wid>=47)
			{
				SendClientMessage(playerid,0xFFFACDAA,"错误,错误原因:武器ID错误(0-46)");
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
					format(msg,128,"[ID:%d]%s给予[ID:%d]%s了一把ID为%d的武器.",playerid,name1,id,name,wid);
					ABroadCast(0x00FF00AA,msg,1);
					/*if(playergunzhizhao[id]==0&&wid!=0&&wid!=46&&wid!=41&&wid!=43&&wid!=42&&wid!=1&&wid!=2&&wid!=3&&wid!=4&&wid!=5&&wid!=6&&wid!=7&&wid!=8&&wid!=9&&wid!=14&&wid!=10&&wid!=11&&wid!=12&&wid!=13&&wid!=15)
					{
						if(su[id]<10)
						{
							su[id]=su[id]+1;
						}
						format(msg,128,"|+通缉+|%s被通缉了,通缉等级:%d,理由:非法携带枪支",name,su[id]);
						AdminXX(3,msg,0x00FF00AA);
						format(msg,128,"你由于非法携带枪支所以被通缉了！目前通缉等级:%d",su[id]);
						SendClientMessage(id,0x00FF00AA,msg);
					}*/
					return 1;
				}
			}
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/gms [玩家id] [钱数] [理由]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			id=strval(tmp);
   if(playeradmin[playerid]<3333)
   {
   if(id==playerid)
   {
   SendClientMessage(playerid,0x00FF00AA,"无法给自己奖励(请不要刷钱)!");
   return 1;
   }
   }
   tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			GetPlayerName(id,name1,128);
			if(money<0)
			{
				format(msg,128,"[罚款]%s被%s罚了%d,理由:%s",name1,name,money,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
			}
			if(money>0)
			{
				format(msg,128,"[奖励]%s被%s奖励了%d,理由:%s",name1,name,money,tmp);
				SendClientMessageToAll(0x6495EDAA,msg);
			}
			playermoney[id]=playermoney[id]+money;
			ResetPlayerMoney(id);
			GivePlayerMoney(id,playermoney[id]);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/gmvdou [玩家id] [V豆数量] [理由]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			id=strval(tmp);
   if(id==playerid)
   {
   SendClientMessage(playerid,0x00FF00AA,"无法给自己奖励(请不要刷V豆。。)!");
   return 1;
   }
   tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
			GetPlayerName(playerid,name,128);
			GetPlayerName(id,name1,128);
			if(money<0)
			{
				format(msg,128,"[V豆信息]%s被%s罚了%d V豆,理由:%s",name1,name,money,tmp);
				SendClientMessageToAll(0xDC143CAA,msg);
			}
			if(money>0)
			{
				format(msg,128,"[V豆信息]%s被%s奖励了%d V豆,理由:%s",name1,name,money,tmp);
				SendClientMessageToAll(0x6495EDAA,msg);
			}
			playervdou[id]=playervdou[id]+money;
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
	//=====================================================[设置车辆数量]===================
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
SendClientMessage(playerid,0xFFFACDAA,"用法:/szcar [玩家id] [汽车数量] [理由]");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money<0)
{
format(msg,128,"[服务器]:玩家%s被管理员%s将汽车数量设置为了%d辆,执行理由:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
if(money>0)
{
format(msg,128,"[服务器]:玩家%s被管理员%s将汽车数量设置为了%d辆,执行理由:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
playercar[id]=playercar[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}
//=====================================================[设置金钱数量]===================
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
SendClientMessage(playerid,0xFFFACDAA,"用法:/money [玩家id] [金钱数量] [理由]");
return 1;
}
tmp=strtok(cmdtext,idx);
			money=strval(tmp);
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
format(msg,128,"[信息]:管理员 %s 设置你的金钱数量为: %d ,理由:%s.",name,money,tmp);
SendClientMessage(id,0xE5C43EAA,msg);
format(msg,128,"[信息]:你设置玩家 %s 的金钱数量为: %d ,理由%s.",name1,money,tmp);
SendClientMessage(playerid,0xE5C43EAA,msg);
playermoney[id]=playermoney[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
return 1;
}*/
//============================================================[工资]=======================
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
SendClientMessage(playerid,0xFFFACDAA,"用法:/tax [玩家id] [工资数量] [理由]");
return 1;
}
id=strval(tmp);
if(id==playerid)
{
SendClientMessage(playerid,0x00FF00AA,"无法给自己工资(总统没工资滴)!");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
return 1;
}
if(playerzuzhi[id]==1||playerzuzhi[id]==7||playerzuzhi[id]==8||playerzuzhi[id]==9||playerzuzhi[id]==10||playerzuzhi[id]==11||playerzuzhi[id]==12||playerzuzhi[id]==15)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:目标玩家不是政府组织人员(警察/FBI/军队/政府/医院)");
return 1;
}
money=strval(tmp);
if(money<1||money>80000)
{
SendClientMessage(playerid,	0xDC143CAA,"罚金不能小于1或不能大于80000!");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money>0)
{
format(msg,128,"[政府工资]:政府组织人员 %s 被总统 %s 奖励了 %d 元工资,理由:%s .",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}

playermoney[id]=playermoney[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"你不是总统!");
return 1;
}
//=====================================================[奖励/罚材料]===================
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
SendClientMessage(playerid,0xFFFACDAA,"用法:/gmats[玩家id] [数量] [理由]");
return 1;
}
id=strval(tmp);
if(IsPlayerConnected(id)==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
return 1;
}
tmp=strtok(cmdtext,idx);
money=strval(tmp);
tmp=strtokp(cmdtext,idx);
if(strcmp(tmp," ")==0)
{
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
return 1;
}
GetPlayerName(playerid,name,128);
GetPlayerName(id,name1,128);
if(money<0)
{
format(msg,128,"[服务器]:玩家%s被管理员%s罚了%d个材料,执行理由:%s",name1,name,money,tmp);
SendClientMessageToAll(0xDC143CAA,msg);
}
if(money>0)
{
format(msg,128,"[服务器]:玩家%s被管理员%s奖励了%d个材料,执行理由:%s",name1,name,money,tmp);
SendClientMessageToAll(0x6495EDAA,msg);
}
playermats[id]=playermats[id]+money;
ResetPlayerMoney(id);
GivePlayerMoney(id,playermoney[id]);
return 1;
}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
					SendClientMessage(playerid,0xFFFACDAA,"用法:/lache [车辆ID]");
					return 1;
				}
				if(GetVehicleModel(strval(tmp))==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"该车不存在!");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetVehiclePos(strval(tmp),x+1,y+1,z+1);
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
	if(strcmp(cmd,"/shuache")==0)
	{
		if(SL[playerid]==1)
		{
  if(playeradmin[playerid]>= 1337)
		{
		        CallRemoteFunction("ShuacheCommand","i",playerid);
				SendClientMessage(playerid,COLOR_BLUE,"刷车成功，记得要/shanche删掉他哦~");
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/shanche [车辆ID]");
				return 1;
			}
			if(GetVehicleModel(strval(tmp))==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"该车不存在!");
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
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/scld 玩家id 理由");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			if(playerzuzhilv[id]!=5)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:目标玩家不是组织LD");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
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
			format(msg,128,"[组织]%s被管理员撤消了%s的LD权限,理由:%s",name,zuzhiname[playerzuzhi[id]],tmp);
			SendClientMessageToAll(0xDC143CAA,msg);
			format(msg,128,"你将%s撤消了%s组织的LD",name,zuzhiname[playerzuzhi[id]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			format(msg,128,"你被管理员撤消了%s组织的LD",zuzhiname[playerzuzhi[id]]);
			SendClientMessage(id,0xFFFACDAA,msg);
			playerzuzhi[id]=0;
			playerzuzhilv[id]=0;
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
/*----------------------------------[设定GM]------------------------------*/
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
				SendClientMessage(playerid,	COLOR_GRAD2, "使用:	/makeadmin [玩家id/玩家名字] [等级(1-5)]");
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
						printf("[管理员信息]: %s 将	%s 提升到 %d 管理员.", sendername, giveplayer, level);
						format(string, sizeof(string), "   你被	%s提升到 %d	管理员 ",  sendername,level);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   你提升 %s 到	%d 管理员.", giveplayer,level);
					 SendClientMessage(playerid,	COLOR_LIGHTBLUE, string);
					 SetPlayerSkin(id,26);
//AdminLog(string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid,	COLOR_GRAD1, "	 你没有权限(1338)!");
			}
		}
		return 1;
	}
	SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
//==================================设置VIP===============================
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/szvip	[玩家id] [VIP等级]");
					return 1;
				}
				id=strval(tmp);
				if(SL[id]==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"该玩家没有登陆");
					return 1;
				}
				tmp=strtok(cmdtext,idx);
				if(strcmp(tmp,"	")==0)
				{
					SendClientMessage(playerid,	0xDC143CAA,"VIP等级不能为空");
					return 1;
				}
				ar=strval(tmp);
				playerviplv[id]=ar;
				new	msg[128],name[128];
				GetPlayerName(playerid,name,128);
				format(msg,128,"你的VIP等级被%s设置为了%d!",name,ar);
				SendClientMessage(id, 0xDC143CAA,msg);
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"错误,错误原因:你没有登陆");
		return 1;
	}
//=================================================[设置Leader]==============================
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
				SendClientMessage(playerid,0xFFFACDAA,"用法:/szld [玩家id] [组织id]	[理由]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			if(playerzuzhi[id]!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"该玩家已经有组织了!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			zzid=strval(tmp);
			if(zzid<0||zzid>16)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误的组织ID~~(1-16)管理员组织已经无");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
			playerzuzhi[id]=zzid;
			playerzuzhilv[id]=5;
			GetPlayerName(id,name,128);
			format(msg,128,"[组织]%s被管理员设置为%s组织的LD,理由:%s",name,zuzhiname[playerzuzhi[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"你将玩家 %s 设置为了 %s 组织的领导!",name,zuzhiname[playerzuzhi[id]]);
			SendClientMessage(playerid,0x00C2ECFF,msg);
			format(msg,128,"管理员将你设置为了 %s 组织的领导!",zuzhiname[playerzuzhi[id]]);
			SendClientMessage(id,0x00C2ECFF,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}

//=================================================[设置IRC管理员]==============================
 if(strcmp(cmd,"/szircadmin")==0)
	{
		if(SL[playerid]==1)
		{
  new	name1[128];
		GetPlayerName(playerid,name1,128);
		if(playeradmin[playerid]>= 1337)//判断是不是组织2的成员,组织2是GM
		{
			new	tmp[128];
			new	id;
			new	ircid;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"用法:/szircadmin [玩家id] [IRC频道ID]	[理由]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			if(playerircadmin[id]!=0)
			{
				SendClientMessage(playerid,0xDC143CAA,"该玩家已经是IRC频道管理员了!");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			ircid=strval(tmp);
			if(ircid<0||ircid>6)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误的IRC频道ID~~(1-5)");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
			playerircadmin[id]=ircid;
			playerircid[id]=ircid;
			GetPlayerName(id,name,128);
			format(msg,128,"[公告]: %s 被管理员设置为IRC频道ID为 %d 的管理员,理由:%s .",name,ircname[playerircid[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"你将玩家 %s 设置为了IRC频道ID为 %d 的管理员!",name,ircname[playerircid[id]]);
			SendClientMessage(playerid,0x00C2ECFF,msg);
			format(msg,128,"管理员将你设置为了IRC频道ID为 %d 的管理员!",ircname[playerircid[id]]);
			SendClientMessage(id,0x00C2ECFF,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
//---------------------------------------------------------------------------------
	if(strcmp(cmd,"/szgz")==0)
	{
			if(SL[playerid]==1)
		{
  new	name1[128];
		GetPlayerName(playerid,name1,128);
		if(playeradmin[playerid]>= 1337)//判断是不是组织2的成员,组织2是GM
		{
			new	tmp[128];
			new	id;
			new	jobid;
			new	msg[128];
			new	name[128];
			tmp=strtok(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xFFFACDAA,"用法:/szgz [玩家id] [工作id]	[理由]");
				return 1;
			}
			id=strval(tmp);
			if(IsPlayerConnected(id)==0&&SL[id]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			tmp=strtok(cmdtext,idx);
			jobid=strval(tmp);
			if(jobid<0||jobid>6)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误的组织ID(0~6)~~");
				return 1;
			}
			tmp=strtokp(cmdtext,idx);
			if(strcmp(tmp,"	")==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:理由不能为空");
				return 1;
			}
			playerjob[id]=jobid;
			GetPlayerName(id,name,128);
			format(msg,128,"[工作]%s被管理员设置工作为: %s,理由:%s",name,gongzuoname[playerjob[id]],tmp);
			SendClientMessageToAll(0x6495EDAA,msg);
			format(msg,128,"你将%s的工作设置为了%s",name,gongzuoname[playerjob[id]]);
			SendClientMessage(playerid,0xFFFACDAA,msg);
			format(msg,128,"管理员将你的工作设置为了%s",gongzuoname[playerjob[id]]);
			SendClientMessage(id,0xFFFACDAA,msg);
			return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
		return 1;
	}
//---------------------------------------------------------------------------------

//-----------------------------------------拉车------------------------------------
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
					SendClientMessage(playerid,0xFFFACDAA,"用法:/lache [车辆ID]");
					return 1;
				}
				if(GetVehicleModel(strval(tmp))==0)
				{
					SendClientMessage(playerid,0xDC143CAA,"该车不存在!");
					return 1;
				}
				GetPlayerPos(playerid,x,y,z);
				SetVehiclePos(strval(tmp),x+1,y+1,z+1);
				return 1;
		}
		SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
  SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/110 [报警内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过110了~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"[报警通知][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(3,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您已经成功报警!~请等待警察支援");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/999 [求助内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过报警热线~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"[报警通知][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(1,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过报警热线了!~请等待FBI赶到~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/888 [爆料内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过爆料热线~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"[爆料][ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(1,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过爆料热线了!~请等待记者采用~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/16800	[热线内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过16800了~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"【通知】[ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(15,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您已经成功求助!~请等待一下！");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未出生！");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/10086	[热线内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经拨打过10086了~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"【通知】[ID:%d]%s:%s",playerid,name,tmp);
			AdminXX(14,msgg,0x98FB98FF);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您已经成功求助!~请等待一下！");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未出生！");
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
				SendClientMessage(playerid,	0xDC143CAA,"用法:/askq [内容]");
				return 1;
			}
			if(askqtime[playerid]!=0)
			{
				SendClientMessage(playerid,	0xDC143CAA,"您已经提交过问题了~请等待4秒后再提交~！");
				return 1;
			}
			format(msgg,128,"[ID:%d]%s:%s",playerid,name,tmp);
			ABroadCast(0x98FB98FF,msgg,1);
			askqtime[playerid]=4;
			SendClientMessage(playerid,	0xDC143CAA,"您的内容已经提交给在线管理员!~");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:目标玩家不在线");
						return 1;
					}
					if(playerzuzhi[id]!=playerzuzhi[playerid])
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:目标玩家不属于你的组织");
						return 1;
					}
					if(playerzuzhilv[id]==5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不能踢出LD");
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
					format(msg,128,"你将%s踢出了组织%s",name1,zuzhiname[playerzuzhi[playerid]]);
					SendClientMessage(playerid,	0xFFFACDAA,msg);
					format(msg,128,"你被%s踢出了组织%s",name,zuzhiname[playerzuzhi[playerid]]);
					SendClientMessage(id, 0xFFFACDAA,msg);
					playerzuzhi[id]=0;
					playerzuzhilv[id]=0;
					SetPlayerSkin(id,playerskin[id]);
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
						SendClientMessage(playerid,	0x00BFFFF,"用法:/setzzlv [玩家id]	[组织阶级(1~5)]");
						return 1;
					}
					id=strval(tmp);
					if(IsPlayerConnected(id)==0)
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:目标玩家不在线");
						return 1;
					}
					if(playerzuzhi[id]!=playerzuzhi[playerid])
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:目标ID不属于你的组织");
						return 1;
					}
					if(id!=playerid)
					{
					if(playerzuzhilv[id]==5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不能修改LD的阶级");
						return 1;
					}
					}
					tmp=strtok(cmdtext,idx);
					lv=strval(tmp);
					if(lv<1||lv>5)
					{
						SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:阶级错误(1-5)");
						return 1;
					}
					new	msg[128];
					new	name[128];
					new	name1[128];
					GetPlayerName(playerid,name,128);
					GetPlayerName(id,name1,128);
					format(msg,128,"组织成员 %s 被你提升到了 %d 阶.",name1,lv);
					SendClientMessage(playerid,	0x00BFFFF,msg);
					format(msg,128,"你被组织领导 %s 提升到了 %d 阶.",name,lv);
					SendClientMessage(id, 0x00BFFFF,msg);
					playerzuzhilv[id]=lv-1;
					SetPlayerSkin(id,zuzhiskin[playerzuzhi[id]][playerzuzhilv[id]]);
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
				SendClientMessage(playerid,	0x008040FF,"________|在线组织成员|________");
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(SL[i]==1)
						{
							if(playerzuzhi[i]==playerzuzhi[playerid])
							{
								GetPlayerName(i,name,128);
								format(msg,128,"昵称:%s	 阶级:%s",name,zuzhilv[playerzuzhi[i]][playerzuzhilv[i]]);
								SendClientMessage(playerid,0xFFFACDAA,msg);
							}
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					format(msg,128,"你成功加入了%s的组织！",name);
					SendClientMessage(playerid,0xFFFACDAA,msg);
					format(msg,128,"%s加入了你的组织!",name1);
					SendClientMessage(yaoqingjiaru[playerid],0xFFFACDAA,msg);
					playerzuzhi[playerid]=playerzuzhi[yaoqingjiaru[playerid]];
					playerzuzhilv[playerid]=0;
					SetPlayerSkin(playerid,zuzhiskin[playerzuzhi[playerid]][playerzuzhilv[playerid]]);
					yaoqingjiaru[playerid]=-1;
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:邀请者不是组织的LD");
				yaoqingjiaru[playerid]=-1;
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:没有人邀请你加入组织!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0xDC143CFF,"错误,错误原因:目标玩家已经有组织了!");
					return 1;
				}
				if(strval(tmp)==0)
				{
					SendClientMessage(playerid,	0xDC143CFF,"错误,错误原因:目标ID不能为0");
					return 1;
				}
				if(strval(tmp)!=playerid)
				{
					if(IsPlayerConnected(strval(tmp))==1)
					{
						GetPlayerName(playerid,name,128);
						GetPlayerName(strval(tmp),name1,128);
						format(msg,128,"你邀请%s加入%s的请求已经发送给%s了,请等待回应.",name1,zuzhiname[playerzuzhi[playerid]],name1);
						SendClientMessage(playerid,	0xFFFACDAA,msg);
						format(msg,128,"%s邀请你加入%s,如果想加入请输入/jiaru!",name,zuzhiname[playerzuzhi[playerid]]);
						SendClientMessage(strval(tmp),0xFFFACDAA,msg);
						yaoqingjiaru[strval(tmp)]=playerid;
						return 1;
					}
					SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:目标玩家不在线");
					return 1;
				}
				SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你无法邀请自己");
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有权限");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/d [内容]");
					return 1;
				}
				GetPlayerName(playerid,name,128);
				format(msg,128,"**%s %s	%s[对讲机]:%s 通话完毕**",zuzhiname[playerzuzhi[playerid]],zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
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
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
//---------------------------------------------[IRC频道]---------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------
	if(strcmp(cmd,"/ircjoin")==0)
	{
		if(SL[playerid]==1)
		{
			if(playeripad[playerid]==1)
			{
				ShowPlayerDialog(playerid,3576,DIALOG_STYLE_LIST,"[IRC频道 - 选项]","进入IRC频道1\n进入IRC频道2\n进入IRC频道3\n进入IRC频道4\n进入IRC频道5\n退出IRC频道","确定","取消");
				return 1;
			}
				SendClientMessage(playerid,0x00FF00AA,"你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,0x00FF00AA,"你没有登陆!");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/i1 [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRC频道1]说:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未加入IRC频道1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/i2 [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRC频道2]说:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未加入IRC频道1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/i3 [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRC频道3]说:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未加入IRC频道1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/i4 [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRC频道4]说:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未加入IRC频道1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/i5 [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerircid[i]==playerircid[playerid])
						{
							format(msg,256,"**[ID:%d]%s[IRC频道5]说:%s.**",playerid,name,tmp);
							SendClientMessage(i, 0xFFD699FF,msg);
						}
					}
				}
				return 1;
			}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有平板电脑!");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你还未加入IRC频道1");
		return 1;
	}
  SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
//------------------------------------------[组织对讲机频道]--------------------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/r [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerzuzhi[i]==playerzuzhi[playerid])
						{
							format(msg,256,"**%s %s[对讲机]:%s .over**",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
							SendClientMessage(i, 0xFFFF00FF,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
//------------------------------------------------------[组织频道]-----------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/f [内容]");
					return 1;
				}
				for(new	i=0;i<101;i++)
				{
					if(IsPlayerConnected(i)==1)
					{
						if(playerzuzhi[i]==playerzuzhi[playerid])
						{
							format(msg,256,"**%s %s[组织频道]:%s .over**",zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],name,tmp);
							SendClientMessage(i, 0x00C2ECFF,msg);
						}
					}
				}
				return 1;
			}
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是组织成员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
		return 1;
	}
//-------------------------------------------[管理员频道]---------------------------
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
					SendClientMessage(playerid,	0x00BFFFF,"用法:/a [内容]");
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
			SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你不是管理员");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,"错误,错误原因:你没有登陆");
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
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"注册","请输入你要设置的密码!","确定","取消");
				return 1;
			}
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"登录","请输入密码!","确定","取消");
			return 1;
		}
		SendClientMessage(playerid,	0xDC143CAA,	"错误,错误原因:你已经登陆");
		return 1;
	}
//==================================查看我的食品==========================
	if(strcmp(cmd,"/myfood")==0)
	{
		if(SL[playerid]==1)
		{
            new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"===============================食品仓库==========================");
			format(msg,256," |田园鸡腿堡:%d| |雪碧:%d| |蛋炒饭:%d|",food1[playerid],food2[playerid],food3[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
		}
  SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
		return 1;
	}
//==========================================================================
	if(strcmp(cmd,"/stats")==0)
	{
		if(SL[playerid]==1)
		{
   new	msg[256];
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			format(msg,256,"|名字:%s| |金钱:%d |组织:%s| |组织等级:%s| |VIP等级:%d| |VIP成长值:%d/%d| |汽车数量:%d|",playername[playerid],playermoney[playerid],zuzhiname[playerzuzhi[playerid]],zuzhilv[playerzuzhi[playerid]][playerzuzhilv[playerid]],playerviplv[playerid],playervipczz[playerid],playerviplv[playerid]*8,playercar[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|房屋钥匙1:%d| |房屋钥匙2:%d| |房屋钥匙3:%d| |存款:%d| |V豆余额:%d| |电话余额:%d|",playerlock[playerid],playerlock1[playerid],playerlock2[playerid],playerbank[playerid],playervdou[playerid],playercallmoney[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|等级:%d| |升级点:%d/%d| |电话号码:%d| |工作:%s| |材料:%d| |IPAD:%d| |烟花:%d|",playerlv[playerid],playerlvup[playerid],playerlv[playerid]*8,playercall[playerid],gongzuoname[playerjob[playerid]],playermats[playerid],playeripad[playerid],playeryanhua[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|当前皮肤:%d| |监狱剩余时间:%d|	|通缉等级:%d| |当前出生地:%d|",playerskin[playerid],playerjianyutime[playerid],su[playerid],playerspawn[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			format(msg,256,"|是否教程过:%d| |性别:%d|	|身份证编号:%d| |年龄:%d|",playerput[playerid],playersex[playerid],playersfz[playerid],playerage[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			SendClientMessage(playerid,	0x008040FF,"==============================================================");
			return 1;
	}
  SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/vstats")==0)
	{
		if(SL[playerid]==1)
		{
			new	msg[256];
			SendClientMessage(playerid,	0xD3D3D3FF,"======================个人汽车信息======================");
			if(playercar[playerid]!=0)
			{
				for(new	i=1;i<999;i++)
				{
					if(strcmp(carname[i],playername[playerid])==0)
					{
						if(car[i]!=0)
						{
							format(msg,128,"车辆ID:%d 车辆模型:%d 车辆颜色1:%d 车辆颜色2:%d	车辆所属组织:%s	汽车价值:%d",car[i],carmoxing[i],carcolor1[i],carcolor2[i],zuzhiname[carzuzhi[i]],carmoney[i]);
							SendClientMessage(playerid,	0xD3D3D3FF,msg);
						}
					}
				}
			}
			SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
			return 1;
		}
		SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
		return 1;
	}
	if(strcmp(cmd,"/hstats")==0)
	{
		if(SL[playerid]==1)
		{
			SendClientMessage(playerid,	0xD3D3D3FF,"======================个人房屋信息======================");
			new	msg[128];
			for(new	u=0;u<pickupids;u++)
			{
				if(ZFJGLX[u]==3)
				{
					if(playerlock[playerid]==u||playerlock1[playerid]==u||playerlock2[playerid]==u)
					{
						format(msg,128,"房屋ID:%d 房屋描述:%s 房屋价格:%d 房屋购买等级:%d 门锁状态(0为锁门,1为解锁):%d",u,ZFJGSTR1[u],ZFJGMONEY[u],ZFJGLV[u],ZFJGLOCK[u]);
						SendClientMessage(playerid,	0xD3D3D3FF,msg);
					}
				}
			}
			SendClientMessage(playerid,	0xD3D3D3FF,"====================================================");
			return 1;
		}
		SendClientMessage(playerid,	 0xDC143CAA, "错误,错误原因:你没有登陆");
		return 1;
	}
	SendClientMessage(playerid,	 0xF8F8FFFF,"提示：哎呀，你的指令输入错啦，是不是忘记小写啦？详细的命令可以输入/help查看哦~");
	return 1;
}
public OnPlayerDisconnect(playerid,	reason)//下线函数，ID下线保存这个ID的数据。
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
	format(msgg,128,"[ID:%d]%s离开了服务器",playerid,name);
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
public OnDialogResponse(playerid, dialogid,	response, listitem,	inputtext[])//玩家点击对话框的事件
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
					case 0:	ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"设置一个角度","请输入一个角度 (范围:	20-30)","确定","取消");
					case 1:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"没有找到附近的相机!");
							SendClientMessageEx(playerid,COLOR_GREEN,"sis","最近的摄像头ID是:	",cam,".");
						}
					case 2:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"没有找到附近的相机!");
							SetPVarInt(playerid,"selected",cam);
							ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,"{00A5FF}测速摄像头	{FFFFFF}- {FFDC00}Editor","改变角度\n改变范围\n更改车速限制\n变更罚款\n切换英里模式\n添加/移除/编辑文本标签\n{FF1400}删除摄像机","确定","取消");
						}
					case 3:
						{
							new	cam	= GetClosestCamera(playerid);
							if(cam == -1) return SendClientMessage(playerid,COLOR_RED,"没有找到附近的相机!");
							DestroySpeedCam(cam);
							SendClientMessage(playerid,COLOR_GREEN,"测速摄像头被移除！！.");
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
							SendClientMessage(playerid,COLOR_GREEN,"所有测速摄像头被移除！！.");
						}
				}
			}
//======================================================
//					Making a speedcam
//======================================================
		case DIALOG_RANGE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_RANGE,DIALOG_STYLE_INPUT,"设置一个角度","请输入一个角度	(范围: 20-30)","确定","取消");
				SetPVarInt(playerid,"range",strval(inputtext));
				ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"设置一个速度范围","请输入一个速度范围","确定","取消");
			}
		case DIALOG_LIMIT:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_LIMIT,DIALOG_STYLE_INPUT,"设置一个速度范围","请输入一个速度范围","确定","取消");
				SetPVarInt(playerid,"limit",strval(inputtext));
				ShowPlayerDialog(playerid,DIALOG_FINE,DIALOG_STYLE_INPUT,"设置罚款","请输入一个罚款数额","确定","取消");
			}
		case DIALOG_FINE:
			{
					if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_FINE,DIALOG_STYLE_INPUT,"设置罚款","请输入一个罚款数额","确定","取消");
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
					ShowPlayerDialog(playerid,DIALOG_EDIT,DIALOG_STYLE_LIST,"{00A5FF}测速摄像头	{FFFFFF}- {FFDC00}Editor","改变角度\n改变范围\n更改车速限制\n变更罚款\n切换英里模式\n添加/移除/编辑文本标签\n{FF1400}删除摄像机","确定","取消");
			}
//======================================================
//						Edit menu
//======================================================
		case DIALOG_EDIT:
			{
				switch(listitem)
				{
					case 0:	ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者	- Angle","请输入一个新的角度","确定","取消");
					case 1:	ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者	- Range","请输入一个新的范围","确定","取消");
					case 2:	ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者	- Speedlimit","请进入一个新的的车速限制","确定","取消");
					case 3:	ShowPlayerDialog(playerid,DIALOG_EFINE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}-	{FFDC00}创建者 - Fine","请进入一个新的的罚款","确定","取消");
					case 4:	ShowPlayerDialog(playerid,DIALOG_ETYPE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}-	{FFDC00}创建者 - Mph/Kmh","输入1使用英里和0为每小时公里","确定","取消");
					case 5:	ShowPlayerDialog(playerid,DIALOG_LABEL,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}-	{FFDC00}创建者 - Textlabel","请填写您要附加的文字，或让它空删除现有的标签!","确定","取消");
					case 6:
						{
							DestroySpeedCam(GetPVarInt(playerid,"selected"));
							SendClientMessage(playerid,COLOR_GREEN,"测速摄像头被移除！！.");
							DeletePVar(playerid,"selected");
						}
				}
			}
//======================================================
//				   Editing a speedcam
//======================================================
		case DIALOG_EANGLE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_EANGLE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者 -	Angle","请输入一个新的角度","确定","取消");
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
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The angle	of cameraID	",id," 成功设置为 ",strval(inputtext),".");
			}
		case DIALOG_ERANGE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ERANGE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者 -	Range","请输入一个新的范围","确定","取消");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_range] = strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The range	of cameraID	",id," 成功设置为 ",strval(inputtext),".");
			}
		case DIALOG_ELIMIT:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_ELIMIT,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头 {FFFFFF}- {FFDC00}创建者 -	Speedlimit","请进入一个新的的车速限制","确定","取消");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_limit] = strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The speedlimit of	cameraID ",id,"	成功设置为 ",strval(inputtext),".");
			}
		case DIALOG_EFINE:
			{
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_EFINE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头	{FFFFFF}- {FFDC00}创建者 - Fine","请进入一个新的的罚款","确定","取消");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_fine]	= strval(inputtext);
				SaveCamera(id);
				SendClientMessageEx(playerid,COLOR_GREEN,"sisis","The fine of cameraID ",GetPVarInt(playerid,"selected")," 成功设置为 ",strval(inputtext),".");
			}
		case DIALOG_ETYPE:
			{
				if(!strlen(inputtext) || strval(inputtext) != 0	&& strval(inputtext) !=	1) return ShowPlayerDialog(playerid,DIALOG_ETYPE,DIALOG_STYLE_INPUT,"{00A5FF}测速摄像头	{FFFFFF}- {FFDC00}创建者 - Mph/Kmh","输入1使用英里和0为每小时公里","确定","取消");
				new	id = GetPVarInt(playerid,"selected");
				SpeedCameras[id][_usemph] =	strval(inputtext);
				if(strval(inputtext) ==	1)
				{
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","CameraID ",GetPVarInt(playerid,"selected")," 但现在衡量英里的速度.");
				} else {
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","CameraID ",GetPVarInt(playerid,"selected")," 但现在衡量公里每小时的速度.");
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
					SendClientMessageEx(playerid,COLOR_GREEN,"sis","摄像头的文字 ",GetPVarInt(playerid,"selected")," 测速摄像头成功被移除！！.");
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
					SendClientMessageEx(playerid,COLOR_GREEN,"sisss","摄像头的文字	",GetPVarInt(playerid,"selected"),"	成功设置为 ",inputtext,".");
				}
				SaveCamera(id);
			}
	}
	
 	if(dialogid == DIALOG_TABLETCHAT)
    {
        if(response)
        {
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}玩家ID:", "输入玩家ID", "查找", "退出");
            if(IsNumeric(inputtext))
            {
				new id = strval(inputtext);
				if(id == playerid)
				{
					ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}不能和你自己说话.", "输入玩家ID", "查找", "退出");
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
			            ShowPlayerDialog(id, DIALOG_TABLETCHAT+1, DIALOG_STYLE_MSGBOX, "{FF0000}聊天邀请", str, "接受", "拒绝");
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
                		ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}错误: ID错误", "输入玩家ID", "查找", "退出");
					}
				}
			}
			else
			{
			    ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}玩家ID:", "输入玩家ID", "查找", "退出");
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
	        format(str,sizeof(str),"{FF0000}聊天 - %s",asd);
	        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, "输入信息:", "发送", "退出");
	        }
        }
        else
        {
			new name[24];
			GetPlayerName(playerid,name,24);
			new str[64];
			chatid[playerid] = 0;
			chatid[GetPVarInt(playerid,"therplayeronid")] = 0;
			format(str,sizeof(str),"%s 接受了你的聊天邀请.\n\n",name);
			ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}聊天", str,"退出", "");
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
		        format(str,sizeof(str),"{FF0000}聊天 - %s",asd);
		        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, chattext[playerid], "发送", "退出");
		        new str2[64];
				format(str2,sizeof(str2),"{FF0000}聊天 - %s",name);
		        ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str2, chattext[GetPVarInt(playerid,"playeronid")], "发送", "退出");
			}
			else
			{
		        new str[64];
		        format(string,sizeof(string),"{FF0000}%s: %s\n",name,inputtext);
		        strcat(chattext[playerid],string);
		        strcat(chattext[GetPVarInt(playerid,"therplayeronid")],string);
		        new asd[24];
		        GetPVarString(playerid, "sendername2",asd,24);
		        format(str,sizeof(str),"{FF0000}聊天 - %s",asd);
		        ShowPlayerDialog(playerid, DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str, chattext[playerid], "发送", "退出");
		        new str2[64];
				format(str2,sizeof(str2),"{FF0000}聊天 - %s",name);
		        ShowPlayerDialog(GetPVarInt(playerid,"therplayeronid"), DIALOG_TABLETCHAT+2, DIALOG_STYLE_INPUT, str2, chattext[GetPVarInt(playerid,"therplayeronid")], "发送", "退出");
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
				format(str,sizeof(str),"%s 退出聊天.",name);
				ShowPlayerDialog(GetPVarInt(playerid,"playeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}聊天", str,"退出", "");
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
				format(str,sizeof(str),"%s 退出聊天.",name);
				ShowPlayerDialog(GetPVarInt(playerid,"therplayeronid"), DIALOG_TABLETCHAT+3, DIALOG_STYLE_MSGBOX, "{FF0000}聊天", str,"退出", "");
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
					SendClientMessage(playerid,	0x0D7792AA,	"你旋转了汽车钥匙，打开了汽车发动机！");
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
				SendClientMessage(playerid,0x0D7792AA,	"你旋转了汽车钥匙，关闭了汽车发动机！");
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
					SendClientMessage(playerid,	0x0D7792AA,	"你把车灯打开咯~");
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
				SendClientMessage(playerid,0x0D7792AA,	"你关掉了车灯~");
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
						SendClientMessage(playerid,	COLOR_GRAD6,"::饥渴系统::");
						SendClientMessage(playerid,	COLOR_GREEN,"::{FFFFF0}/jike[查看饥渴度] /eatfood [在饭店吃饭] /buyfood [购买打包食品] /eats[使用背包食品]");
					}
				case 1:
					{
						SendClientMessage(playerid,0x99FFFFAA,"账户:/lg [登陆] /lvup [升级] /vstats [查看车辆]");
						SendClientMessage(playerid,0x99FFFFAA,"聊天:/r [组织IC聊天] /f [组织OOC聊天]	/d [频道聊天] ");
						SendClientMessage(playerid,0x99FFFFAA,"聊天:/i [IRC频道聊天] /ircjoin [加入IRC频道] /ad [广告] ");
      SendClientMessage(playerid,0x99FFFFAA,"车辆:/buycar	[买车] /vcolor [汽车颜色] /vpark [泊车]	/vsell [卖车] /vreg	[注册给组织] /vunreg[解除注册]");
						SendClientMessage(playerid,0x99FFFFAA,"车辆:/vcall [拉车] /savecar [保存改装] /unsavecar[解除保存改装] /jiechuzuche	[解除租车] /fuel [查看汽油]");
						SendClientMessage(playerid,0x99FFFFAA,"车辆:右ctrl键 [开启/关闭引擎] 左ctrl键[开启/关闭灯光] /vlock	[锁/解锁汽车] /neon[汽车安装彩灯]/noshelp[N2O帮助]");
      SendClientMessage(playerid,0x99FFFFAA,"特殊:/kong [修复空间] /duty [上班] /pay [给钱] /buyskin [买衣服]  /showsfz [展示身份证]");
						SendClientMessage(playerid,0x99FFFFAA,"特殊:/paycl [给材料] /anims	[动作列表] /jcys [接受机场运送任务] /id [根据名字查询ID] /askq [提交问题]");
						SendClientMessage(playerid,0x99FFFFAA,"执照:/showzhizhao [秀执照] /buygunzhizhao [买武器执照] /buycarzhizhao [买驾驶执照]");
						SendClientMessage(playerid,0x99FFFFAA,"/stats [查看账户状态资料] /vstats [查看账户车辆状态] /hstats [查看账户房屋状态]]");
						SendClientMessage(playerid,0x99FFFFAA,"武器:/inv [武器仓库]	/putgun [放进武器仓库] /takegun [取出仓库中的武器]");
						SendClientMessage(playerid,0x99FFFFAA,"银行:/cunkuan [存款]	/qukuan	[取款]");
						SendClientMessage(playerid,0x99FFFFAA,"ATM提款机:/atmqk	[取款]");
						SendClientMessage(playerid,0x99FFFFAA,"烟花:/placefw [放下烟花] /launch [发射烟花]");
						SendClientMessage(playerid,0x99FFFFAA,"平板:/tablet [开/关平板]");
      SendClientMessage(playerid,0xE100E1FF,"提示:指令过多,可能有些看不到,请按 'Page Up' 或 'Page	Down' 可以上下翻页来查看指令. ");
					}
				case 2:
					{
						SendClientMessage(playerid,	COLOR_GRAD6,"::音乐系统::");
						SendClientMessage(playerid,0x99FFFFAA,"/music [音乐系统] /stopmusic [停止音乐]");
					}
				case 3:
					{
						if (playercall[playerid] > 0)
						{
							SendClientMessage(playerid,	COLOR_WHITE,"***手机帮助***");
							SendClientMessage(playerid,0x99FFFFAA,"电话:/call [拨打电话] /p	[接听电话] /h [挂断电话] /t	[发送短信] /chm	[电子查号码]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_WHITE,"你没有手机你可以去27/7购买");
						}
					}
				case 4:
					{
						SendClientMessage(playerid,	COLOR_WHITE,"***房屋帮助***");
						SendClientMessage(playerid,0x99FFFFAA,"房屋:/buyhouse [买房] /sellhouse	[卖房] /lockhouse [锁房] /spawnchange [切换出生地]");
						SendClientMessage(playerid,0x99FFFFAA,"房屋:/hu [装修] /heal [恢复]");
      }
				case 5:
					{
						if (playerzuzhi[playerid] >= 1 )
						{
							SendClientMessage(playerid,0x99FFFFAA,"组织:/members [查询在线成员]	/gov [组织公告] /jr [邀请加入]");
							SendClientMessage(playerid,0x99FFFFAA,"组织:/unjr [踢人] /setzzlv [设置组织阶级] /tuichuzz [退出组织]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_GREY,	"	你不是一名组织成员!");
						}
					}
				case 6:
					{
						if(playerzuzhi[playerid]==1)
						{
							SendClientMessage(playerid,0x6495EDFF,"记者:/news	[发布新闻] /live [采访] /nad [广告]	/ndt	[电台] /xsdl [显示淡蓝点] /ycd [隐藏淡蓝点]");
						}
						else if(playerzuzhi[playerid]==5)
						{
							SendClientMessage(playerid,0x6495EDFF,"市政府:/tax [工资] /tofind [找人]	/stofind [停止找人]");
						}
						else if(playerzuzhi[playerid]==6)
						{
							SendClientMessage(playerid,0x6495EDFF,"医生: /heal [加血] /xsfd[显示粉点] /ycd [隐藏粉点]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "你目前不在记者/市政府/医生组织中!");
						}
					}
    case 7:
					{
						if(playerzuzhi[playerid]==3)
						{
							SendClientMessage(playerid,0x6495EDFF,"警察:/nn	[警力频道]/su [通缉] /drag	[押人上车] /rb [路障] /urb [撤销路障]");
							SendClientMessage(playerid,0x6495EDFF,"警察:/cu	[拷人] /go [开车库门] /guanya [关人] /m	[扩音器] /cktongji [查看通缉名单]");
							SendClientMessage(playerid,0x6495EDFF,"警察:/setswat [授权SWAT]	/delswat [撤消SWAT]	/tofind	[找人] /stofind	[停止找人]");
							SendClientMessage(playerid,0x6495EDFF,"警察:/xsld [显示蓝点]	/ycd [隐藏蓝点]	/unsu [撤销通缉令] /rrb [撤销所有路障]");
						}
						else if(playerzuzhi[playerid]==14)
						{
							SendClientMessage(playerid,0x6495EDFF,"军队:/nn	[警力频道]/su [通缉] /drag	[押人上车] /rb [路障] /urb [撤销路障]");
							SendClientMessage(playerid,0x6495EDFF,"军队:/cu	[拷人] /go [开车库门] /guanya [关人] /m	[扩音器] /cktongji [查看通缉名单]");
							SendClientMessage(playerid,0x6495EDFF,"军队:/setswat [授权SWAT]	/delswat [撤消SWAT]	/tofind	[找人] /stofind	[停止找人]");
							SendClientMessage(playerid,0x6495EDFF,"军队:/xsld[显示蓝点]	/ycd [隐藏蓝点]	/unsu [撤销通缉令] /rrb [撤销所有路障]");
						}
						else if(playerzuzhi[playerid]==4)
						{
							SendClientMessage(playerid,0x6495EDFF,"FBI:/nn	[警力频道]/su [通缉] /drag	[押人上车] /rb [路障] /urb [撤销路障]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/cu	[拷人] /go [开车库门] /guanya [关人] /m	[扩音器] /cktongji [查看通缉名单]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/setswat [授权SWAT]	/delswat [撤消SWAT]	/tofind	[找人] /stofind	[停止找人]");
							SendClientMessage(playerid,0x6495EDFF,"FBI:/xsld[显示蓝点]	/ycd [隐藏蓝点]	/unsu [撤销通缉令] /rrb [撤销所有路障]");
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "你目前不在警察/FBI/军队的组织");
						}
					}
				case 8:
					{
						if(playerjob[playerid]==1)
						{
							SendClientMessage(playerid,0xFFFF00AA,"材料走私犯: /zscl [走私材料] /sellmats [出售材料]");
							return 1;
						}
						if(playerjob[playerid]==2)
						{
							SendClientMessage(playerid,0xFFFF00AA,"侦探: /find [找人] /tzfind [停止找人] ");
							return 1;
						}
						if(playerjob[playerid]==3)
						{
							SendClientMessage(playerid,0xFFFF00AA,"武器商人: /zuogun [制作武器] /zuoar [制护甲] /givegun [给武器]");
							return 1;
						}
						if(playerjob[playerid]==4)
						{
							SendClientMessage(playerid,0xFFFF00AA,"汽车销售商: /sellcar	[出售车辆]");
							return 1;
						}
						if(playerjob[playerid]==5)
						{
							SendClientMessage(playerid,0xFFFF00AA,"加油站服务员: /refill [加油]");
							return 1;
						}
						if(playerjob[playerid]==6)
						{
							SendClientMessage(playerid,0xFFFF00AA,"出租车司机: /fare [出票价] /taxiduty [上/下班]");
							return 1;
						}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "你没有工作");
      					}
					}
				case 9:
					{
						if(playeradmin[playerid]>=1)
						{
							SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1级管理员指令]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"1级:/tv [观看] /stv [停止观看] /jianjin [监禁] /ckstats [查看玩家信息] /ao [AOOC]");
							SendClientMessage(playerid,0x6495EDFF,"1级:/ckvstats	[查看车辆状态] /ckhstats [查看房屋状态]	/ckcar [查看车辆信息]");
							SendClientMessage(playerid,0x6495EDFF,"1级:/gotohouse [传送到房子] /ckhouse [查看房子信息] /km [打开GM基地大门]");
							SendClientMessage(playerid,0x6495EDFF,"1级:/kick [踢人] /la [拉人] /goto	[传送到玩家]	/ckwuqi	[查看武器] /apm [回答]");
				   }
        if(playeradmin[playerid]>=2)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[2级管理员指令]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"2级:/sc [重生车辆] /ckhp[查看生命] /ckar [查看护甲] /ban [BAN出] /ckzhizhao [查看执照]");
							SendClientMessage(playerid,0x6495EDFF,"2级:/setcall [设置号码] /afill [设置车油量] /count [倒计时]	/ky [扩音器] /pai [拍]	");
							}
        if(playeradmin[playerid]>=3)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[3级管理员指令]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"3级:/hp [设置生命] /ar [设置护甲]	/skin [设置皮肤] /setcallmoney [设置话费]");
							SendClientMessage(playerid,0x6495EDFF,"3级:/kick	[踢人] /sc [重生此车]	/ckwuqi	[查武器] /gtq [换天气] /settime [设置时间]");
							}
       	if(playeradmin[playerid]>=4)
						{
       SendClientMessage(playerid,0xDC143CAA,"--------------------------------[4级管理员指令]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"4级:/setmats [设置材料] /settime [设置时间] /aad [广告] /agov[公告] /ahd [活动消息]");
							SendClientMessage(playerid,0x6495EDFF,"4级:/setcallmoney [设置话费] /allsc [刷新全部汽车] /lache [拉车] /text [大字]");
								}
        if(playeradmin[playerid]>=5)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[5级管理员指令]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"5级: /mypos [查看当前坐标]");
							}
						if(playeradmin[playerid]>=1337)
						{
							SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1337级管理员指令]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"1337级:/gms [奖励] /gmats [奖励材料] /gotobluebus [前往蓝色巴士] /gotoblackbus [前往白色巴士]");
							SendClientMessage(playerid,0x6495EDFF,"1337级:/szircadmin [设置IRC管理员] /szgz [设置工作] /szsxt [设置测速摄像头]");
							SendClientMessage(playerid,0x6495EDFF,"1337级:	/szld [设置组织领导]	/scld [撤销组织领导] ");
									}
        if(playeradmin[playerid]>=1338)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[1338级管理员指令]------------------------------------------");
       SendClientMessage(playerid,0x6495EDFF,"1338级:/ckzzhouse [查看组织房屋信息] /ckgzhouse [查看政府房屋信息]	/addhouse [增加房子]");
							SendClientMessage(playerid,0x6495EDFF,"1338级:/addtbhouse [增加房子TB]	/addgzhouse [增加政府房子] /addzzhouse [增加组织房子]");
							SendClientMessage(playerid,0x6495EDFF,"1338级:/allsellhouse [批量卖房]	/ckhouse [查看房屋信息] /cktbhouse [查看房子TB]");
							SendClientMessage(playerid,0x6495EDFF,"1338级:/changetbhouse [修改房屋TB信息]/changezzhouse [修改组织房屋信息]");
							SendClientMessage(playerid,0x6495EDFF,"1338级:/changegzhouse [修改政府房屋信息] /changehouse [修改房屋信息]/szircadmin[设置IRC管理员]");
							SendClientMessage(playerid,0x6495EDFF,"1338级:/shuache[刷车]/shanche[删车]/makeadmin[设置管理员]");
       SendClientMessage(playerid,0xDC143CAA,"-----------------------------------------------------------------------------------------");
							}
        if(playeradmin[playerid]>=3333)
						{
						 SendClientMessage(playerid,0xDC143CAA,"--------------------------------[后台管理员指令]------------------------------------------");
							SendClientMessage(playerid,0x6495EDFF,"3333级:/makeadmin[设置管理员] /gmvdou[奖励/惩罚V豆] /ckjike[查看玩家饥渴] /reloadbans [重载封禁列表]");
							SendClientMessage(playerid,0x6495EDFF,"3333级:/admin [系统消息] /msgy[黄] /szvip[设置VIP] /gmx[重启服务器] /xzon[打开小镇] /xzoff[封锁小镇]");
       SendClientMessage(playerid,0xDC143CAA,"------------------------------------------------------------------------------------------------------------");
							}
						else
						{
							SendClientMessage(playerid,	COLOR_YELLOW2, "你不是管理员!");
      }
					}
				case 10:
					{
						if(playerviplv[playerid]!=0)
						{
							SendClientMessage(playerid,0xDC143CAA,"=================================VIP功能==========================================================");
							SendClientMessage(playerid,0xDC143CAA,"VIP1:/vipcd [白色车灯(部分车辆)] /vipycd [隐藏名称颜色] /viplvup [VIP升级]");
							SendClientMessage(playerid,0xDC143CAA,"VIP1:/vipshow[显示VIP红点] /delcd[删除车灯] /jg[激光系统]");
							SendClientMessage(playerid,0xDC143CAA,"==================================================================================================");
							return 1;
						}
							SendClientMessage(playerid,0xDC143CAA,"您没有VIP权限哦，请购买！");

					}
			}
		}
		else
		{
			SendClientMessage(playerid,COLOR_YELLOW2,"你关闭了帮助菜单");
		}
		return 1;
	}
//=====================[GM服务台]====================================
	if(dialogid	== 9754)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
					{
						ShowPlayerDialog(playerid,9755,DIALOG_STYLE_LIST,"{00A5FF}徽章系统 (TL原创、Xx_DD策划荣誉出品)","{FFFF00}查看我的徽章\n领取{FF0000}年轻有为{FFFFF}徽章\n领取{FF0000}杰出小青年{FFFFFF}徽章\n领取{FF0000}我乃专业{FFFFFF}徽章\n领取{FF0000}财大气粗{FFFFFF}徽章\n领取{FF0000}腰缠万贯{FFFFFF}徽章\n领取{FF0000}富可敌国{FFFFFF}徽章\n领取{FF0000}赛车季军{FFFFFF}徽章\n领取{FF0000}赛车亚军{FFFFFF}徽章\n领取{FF0000}赛车冠军{FFFFFF}徽章","确定","取消");
					}
			}
		}
		return 1;
	}
//======================[徽章系统]===================================
	if(dialogid	== 9755)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
					{
						SendClientMessage(playerid,COLOR_GREEN,"=====我拥有的徽章=====");
						if (hzxtnqyw[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"年轻有为徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"年轻有为徽章:未拥有");
						}
						if (hzxtjcxqn[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"杰出小青年徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"杰出小青年徽章:未拥有");
						}
						if (hzxtwnzy[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"我乃专业徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"我乃专业徽章:未拥有");
						}
						if (hzxtcdqc[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"财大气粗徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"财大气粗徽章:未拥有");
						}
						if (hzxtycwg[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"腰缠万贯徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"腰缠万贯徽章:未拥有");
						}
						if (hzxtfkdg[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"富可敌国徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"富可敌国徽章:未拥有");
						}
						if (hzxtscjj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"赛车季军徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"赛车季军徽章:未拥有");
						}
						if (hzxtscyj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"赛车亚军徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"赛车亚军徽章:未拥有");
						}
						if (hzxtscgj[playerid] == 1)
						{
							SendClientMessage(playerid,COLOR_GREEN,"赛车冠军徽章:已拥有");
						}
						else
						{
						    SendClientMessage(playerid,COLOR_GREEN,"赛车冠军徽章:未拥有");
						}
					}
			case 1:
				{
				    if(hzxtnqyw[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：这个徽章你已经领取过了......");
				        return 1;
				    }
				    if(playerlv[playerid]<5)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：你的等级还不满足领取此徽章的条件（游戏等级超过5）包括5级.");
				        return 1;
				    }
				    hzxtnqyw[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：成功领取此徽章......");
				    return 1;
				}
			case 2:
				{
				    if(hzxtjcxqn[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：这个徽章你已经领取过了......");
				        return 1;
				    }
				    if(playerlv[playerid]<10)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：你的等级还不满足领取此徽章的条件（游戏等级超过10）包括10级.");
				        return 1;
				    }
				    hzxtjcxqn[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：成功领取此徽章......");
				    return 1;
				}
			case 3:
				{
				    if(hzxtwnzy[playerid]==1)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：这个徽章你已经领取过了......");
				        return 1;
				    }
				    if(playerlv[playerid]<20)
				    {
				        SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：你的等级还不满足领取此徽章的条件（游戏等级超过20）包括20级.");
				        return 1;
				    }
				    hzxtwnzy[playerid]=1;
				    SendClientMessage(playerid,COLOR_YELLOW2,"徽章系统：成功领取此徽章......");
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
//======================================购买食物菜单======================================

	/*if(dialogid	== 6667)
	{
		if(response)
		{
		    if(listitem	== 0)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"你购买了一桶VFC全家桶($100)！");
				playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food3[playerid]=food3[playerid]+1;
			}
			if(listitem	== 1)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"你购买了一个田园鸡腿堡$20！");
				playermoney[playerid]=playermoney[playerid]-20;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food1[playerid]=food1[playerid]+1;
			}
			if(listitem	== 2)
			{
			SendClientMessage(playerid,COLOR_YELLOW2,"你购买了一瓶超大装雪碧$100！");
				playermoney[playerid]=playermoney[playerid]-100;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            food2[playerid]=food2[playerid]+1;
			}
			ShowPlayerDialog(playerid,6667,DIALOG_STYLE_LIST,"食品列表","1.VFC全家桶+30($100)\n2.田园鸡腿堡+2($20)\n3.超大雪碧+30($100)","购买","取消");
			return 1;
		}
	}
//======================================吃食物菜单======================================
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
			format(msg,256,"[饭店]对不起，你已经吃的够多了，请过几分钟再来吧！记得不要暴饮暴食哦！目前饥饿度：%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[饭店]你购买了一碗米饭，吃下它后，心里舒服多了！目前饥饿度：%d",playerjiedu[playerid]);
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
			format(msg,256,"[饭店]对不起，你已经吃的够多了，请过几分钟再来吧！记得不要暴饮暴食哦！目前饥饿度：%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[饭店]你购买了一个田园鸡腿堡，吃下它后，心里舒服多了！目前饥饿度：%d",playerjiedu[playerid]);
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
			format(msg,256,"[饭店]对不起，你已经喝的够多了，请过几分钟再来吧！记得不要把自己当成水桶！目前口渴度：%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[饭店]你购买了一瓶雪碧，喝下后，简直爽爆了！目前口渴度：%d",playerkouke[playerid]);
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
			format(msg,256,"[饭店]对不起，你已经吃的够多了，请过几分钟再来吧！记得不要暴饮暴食哦！目前饥饿度：%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[饭店]你购买了一桶VFC缤纷全家桶，吃下它后，心里舒服多了！目前饥饿度：%d",playerjiedu[playerid]);
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
			format(msg,256,"[饭店]对不起，你已经喝的够多了，请过几分钟再来吧！难不成您想尿床？目前口渴值：%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			return 1;
			}
			format(msg,256,"[饭店]你购买了一桶超大装雪碧，由于太渴，您一口气喝完了。。。目前口渴值：%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);
			}
       	ShowPlayerDialog(playerid,6668,DIALOG_STYLE_LIST,"食品列表","1.蛋炒饭+1($10)\n2.田园鸡腿堡+2($20)\n3.雪碧+1($5)\n4.缤纷全家桶+30($100)\n5.超大装雪碧+30($100)","购买","取消");
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

					SendClientMessage(playerid,COLOR_YELLOW,"对不起，您的背包里没有这种食品了！");
					return 1;
			}
			new msg[128];
	            food3[playerid]=food3[playerid]-1;
	            playerjiedu[playerid]=playerjiedu[playerid]+30;
			format(msg,256,"你吃了一桶VFC全家桶！饥饿值+30！目前饥饿值：%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		if(listitem	== 1)
			{
			if(food1[playerid]==0)
			{
					SendClientMessage(playerid,COLOR_YELLOW2,"对不起，您的背包里没有这种食品了！");
					return 1;
			}
			new msg[128];
	            food1[playerid]=food1[playerid]-1;
	            playerjiedu[playerid]=playerjiedu[playerid]+2;
			format(msg,256,"你吃了一个田园鸡腿堡！饥饿值+2！目前饥饿值：%d",playerjiedu[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		if(listitem	== 2)
			{
			if(food2[playerid]==0)
			{
					SendClientMessage(playerid,COLOR_YELLOW2,"对不起，您的背包里没有这种食品了！");
					return 1;
			}
			new msg[128];
	            food2[playerid]=food2[playerid]-1;
	            playerkouke[playerid]=playerkouke[playerid]+30;
			format(msg,256,"你喝了一瓶超大雪碧！口渴值+30！目前口渴值：%d",playerkouke[playerid]);
			SendClientMessage(playerid,	0xD3D3D3FF,msg);

				return 1;
			}
		}
	}*/
//==============================激光列表===============================
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
//================================MP3系统==========================
	if(dialogid	== 6700)
	{
		if(response)
		{
			if(listitem	== 0)
			{
                StopAudioStreamForPlayer(playerid);
	            SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】音乐成功停了下来~");
				return 1;
			}
			if(listitem	== 1)
			{
                ShowPlayerDialog(playerid,555,DIALOG_STYLE_INPUT,"{00A5FF}自定义URL播放","请输入您想播放的URL(可以先复制再CTRL+V)!\n当然,需要游戏等级2级以上!","点播","取消");
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
				ShowPlayerDialog(playerid,555,DIALOG_STYLE_INPUT,"自定义URL播放","对不起,您没有输入URL!\n请重新输入或粘贴吧!","点播","取消");
				return 1;
			}
		    	if(playerlv[playerid]<1)
		    	{
                SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】您的等级还不够2级，请努力升级了再来吧!不过您可以点播推荐歌曲哦!");
		    	return 1;
		    	}
                new af[256];
		    	format(af,256,"您成功的点了歌曲,网址如下:\n{FF0000}%s\n{0033CC}如果不能播放或播放缓慢,请看看是不是URL输入错误了!",inputtext);
			ShowPlayerDialog(playerid,266,DIALOG_STYLE_MSGBOX,"音乐台",af,"确定","");
			PlayAudioStreamForPlayer(playerid,	inputtext);
//Duquplayer(playerid);
			return 1;
		}
        SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】这次您没有点歌，记得下次来点播哦~");
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
				format(ak,128,"[音乐台]%s点播了一首:I don't think I love you 演唱:Hoobastank 大家都去听听吧~/music",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
                PlayAudioStreamForPlayer(playerid, "http://gtasa.8866.org/music/1.mp3");
	            SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】现在播放：I don't think I love you 演唱:Hoobastank");
	            SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】正在加载音乐中，请稍候……马上就为您奉上好听的音乐！");
			}
		if(listitem	== 1)
			{
			    GetPlayerName(playerid,name,128);
				format(ak,128,"[音乐台]%s点播了一首:逆战 演唱:张杰 大家都去听听吧~/music",name);
				SendClientMessageToAll(0xFFFACDAA,ak);
                PlayAudioStreamForPlayer(playerid, "http://gtasa.8866.org/music/2.mp3");
	            SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】现在播放：逆战(逆战主题曲) 演唱:张杰");
	            SendClientMessage(playerid,COLOR_YELLOW,"【音乐台】正在加载音乐中，请稍候……马上就为您奉上好听的音乐！");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}洛杉矶警察局（LSPD）{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}旧金山（SF）{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
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
				SendClientMessage(playerid,	COLOR_GRAD1, "	 你被传送了!");
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
							SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}飞往LS机场机舱内{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
			}
			if(listitem	== 4) // Bank
			{
				new	vehicleid;
				vehicleid =	GetPlayerVehicleID(playerid);
				SetVehiclePos(vehicleid, 593.0324,-1241.1177,17.9662);
				SetPlayerPos(playerid, 593.0324,-1241.1177,17.9662);
				SendClientMessage(playerid,	COLOR_ALLDEPT, "你被传送到了LS银行.");
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
				SendClientMessage(playerid,	COLOR_GRAD1, "	 你被传送了!");
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
				SendClientMessage(playerid,	COLOR_GRAD1, "	 你被传送了!");
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
				SendClientMessage(playerid,	COLOR_GRAD1, "	 你被传送了!");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}LS机场{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}运动馆{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}自由城{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
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
				SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}GM基地前门{FFC0CB} 方式：{FF00FF}连车传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
			SendClientMessage(playerid, COLOR_BLUE, "注：本次传送目标为特殊地点，将多收费1.2W的费用！");
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
			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}银行内部{FFC0CB} 方式：{FF00FF}单人传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
				SetPlayerInterior(playerid,0);
			}
			if(listitem	== 20)
			{
				SetPlayerPos(playerid,2124.29882812,-1791.83972168,13.22490692);
   			SendClientMessage(playerid, COLOR_BLUE, "=====================时空机器=========================");
			SendClientMessage(playerid, COLOR_BLUE, "您启动了时空机器，目标：{FF00FF}工作点{FFC0CB} 方式：{FF00FF}单人传送{FFC0CB}");
			SendClientMessage(playerid, COLOR_BLUE, "时空机器启动中……  启动完毕！！");
  			SendClientMessage(playerid, COLOR_BLUE, "到达指定目标！本次传送结束！谢谢您的使用！");
			SendClientMessage(playerid, COLOR_BLUE, "=====================================================");
            SetPlayerInterior(playerid, 6);
			}
            playermoney[playerid]=playermoney[playerid]-8000;
            		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,playermoney[playerid]);
			SendClientMessage(playerid,	COLOR_RED, "你收到了一封来自VS Bank的账单，内容如下：");
			SendClientMessage(playerid,	COLOR_YELLOW2, "VS银行:感谢您的使用，我们已经收取了您的时空机使用费！祝您玩得开心！");
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
				SendClientMessage(playerid,	COLOR_YELLOW2, "你的性别为男.");
				new	listitems[]	= "{FFFFFF}请在下方填写你的出生日期{55EE55}\n格式(日/月/年 如:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"你的出生日期:",listitems,"确定","取消");
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
				SendClientMessage(playerid,	COLOR_YELLOW2, "你的性别为女.");
				new	listitems[]	= "{FFFFFF}请在下方填写你的出生日期{55EE55}\n格式(日/月/年 如:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"你的出生日期:",listitems,"确定","取消");
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
			new	listitems[]	= "{FFFFFF}男\n{FFFFFF}女";
			ShowPlayerDialog(playerid,8525,DIALOG_STYLE_LIST,"你的性别:",listitems,"确定","取消");
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
				new	listitems[]	= "{FFFFFF}填写格式错误,请重新填写{55EE55}\n格式(日/月/年 如:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"你的出生日期:",listitems,"确定","取消");
				return 1;
			}
			new	check =	year - strvalEx(DateInfo[2]);
			if(check ==	year)
			{
				new	listitems[]	= "{FFFFFF}填写格式错误,请重新填写{55EE55}\n格式(日/月/年 如:7/7/1993)";
				ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"你的出生日期:",listitems,"确定","取消");
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
			format(string, sizeof(string), "好的,你今年是 %d 岁.",playerage[playerid]);
			SendClientMessage(playerid,	COLOR_YELLOW2, string);
			new	packthings[] = "礼包 1	\n 礼包	2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"请选择一个礼包打开！",packthings,"选择","");
			RegistrationStep[playerid] = 3;
		}
		else
		{
			new	listitems[]	= "{FFFFFF}请在下方填写你的出生日期{55EE55}\n格式(日/月/年 如:7/7/1993)";
			ShowPlayerDialog(playerid,8526,DIALOG_STYLE_INPUT,"你的出生日期:",listitems,"确定","取消");
		}
	}
//================================================彩灯
	if(dialogid	== 158)
	{
		if(response)
		{
			if (listitem ==	0)
			{
				new	DialogString[1024];
				format(DialogString, sizeof	DialogString, "4 点升级点数	\n 1000$元");
				ShowPlayerDialog(playerid,159,DIALOG_STYLE_MSGBOX,"新手礼包	1",	DialogString,"选择","返回");
			}
			else if	(listitem == 1)
			{
				new	DialogString[1024];
				format(DialogString, sizeof	DialogString, "等级	1 \n 4000$元");
				ShowPlayerDialog(playerid,160,DIALOG_STYLE_MSGBOX,"新手礼包	2",	DialogString,"选择","返回");
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
			SendClientMessage(playerid , COLOR_YELLOW,"[我的中国心]:您成功办理了身份证,手续费已由政府补贴,祝您愉快!");
			//SetPlayerPos(playerid, 1613.401000,	-2330.213134, 13.546875);//1.71875,	30.4062, 1200.34
			TogglePlayerControllable(playerid, 1);
		}
		else
		{
			new	packthings[] = "新手礼包 1 \n 新手礼包 2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"请选择一个您喜欢的礼包开始游戏！",packthings,"确定","");
		}
	}
	if(dialogid	== 160)
	{
		if(response)
		{
			GivePlayerMoney(playerid, 4000);
			playerput[playerid]	= 1;
			RegistrationStep[playerid] = 0;
			SendClientMessage(playerid , COLOR_YELLOW,"[我的中国心]:您成功办理了身份证,手续费已由政府补贴,祝您愉快!");
			//SetPlayerPos(playerid, 1613.401000,	-2330.213134, 13.546875);//1.71875,	30.4062, 1200.34
			TogglePlayerControllable(playerid, 1);
		}
		else
		{
			new	packthings[] = "新手礼包 1 \n 新手礼包 2";
			ShowPlayerDialog(playerid,158,DIALOG_STYLE_LIST,"请选择一个您喜欢的礼包开始游戏！",packthings,"确定","");
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
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 2)
			{
			//green
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon4", CreateDynamicObject(18649,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon5", CreateDynamicObject(18649,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon4"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon5"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 3)
			{
			//white
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon6", CreateDynamicObject(18652,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon7", CreateDynamicObject(18652,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon6"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon7"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 4)
			{
			//pink
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon8", CreateDynamicObject(18651,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon9", CreateDynamicObject(18651,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon8"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon9"), GetPlayerVehicleID(playerid), 0.8,	0.0, -0.70,	0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 5)
			{
			//yellow
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon10", CreateDynamicObject(18650,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon11", CreateDynamicObject(18650,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon10"), GetPlayerVehicleID(playerid),	-0.8, 0.0, -0.70, 0.0, 0.0,	0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon11"), GetPlayerVehicleID(playerid),	0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 6)
			{
			//police
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "neon12", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "neon13", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "neon12"), GetPlayerVehicleID(playerid),	-0.8, 0.0, -0.70, 0.0, 0.0,	0.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "neon13"), GetPlayerVehicleID(playerid),	0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 7)
			{
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "interior", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "interior1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "interior"),	GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0,	3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "interior1"), GetPlayerVehicleID(playerid), 0, -0.0,	0, 2.0,	2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 8)
			{
			//back
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "back", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "back1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "back"),	GetPlayerVehicleID(playerid), -0.0,	-1.5, -1, 2.0, 2.0,	3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "back1"), GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0,	2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
			}
			if(listitem	== 9)
			{
				//front
				SetPVarInt(playerid, "Status", 1);
				SetPVarInt(playerid, "front", CreateDynamicObject(18646,0,0,0,0,0,0));
				SetPVarInt(playerid, "front1", CreateDynamicObject(18646,0,0,0,0,0,0));
				AttachObjectToVehicle(GetPVarInt(playerid, "front"), GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6,	2.0, 2.0, 3.0);
				AttachObjectToVehicle(GetPVarInt(playerid, "front1"), GetPlayerVehicleID(playerid),	-0.0, 1.5, -0.6, 2.0, 2.0, 3.0);
				SendClientMessage(playerid,	0xFFFFFFAA,	"安装完毕");
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
//--------------------------------------------做枪---------------------------------
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你身上的材料不够制作这把武器!");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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

//===========================================接工作============================================
	if(dialogid	== 200)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				playerjob[playerid]=0;
				SendClientMessage(playerid,0xDC143CAA,"你成功的辞去了工作!");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem	== 1)
			{
				playerjob[playerid]=1;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 材料走私犯");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem== 2)
			{
				playerjob[playerid]=2;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 侦探");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem	== 3)
			{
				playerjob[playerid]=3;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 武器商人");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem	== 4)
			{
				playerjob[playerid]=4;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 汽车销售商");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem	== 5)
			{
				playerjob[playerid]=5;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 加油站服务员");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
			if(listitem	== 6)
			{
				playerjob[playerid]=6;
				SendClientMessage(playerid,0xDC143CAA,"你成功就职了工作: 出租车司机");
				SendClientMessage(playerid,0xDC143CAA,"你现在可以输入/help 来查看工作帮助!");
				return 1;
			}
		}
	}

	//===========================================办理身份证============================================
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
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够办理手续费 (500) !");
					GivePlayerMoney(playerid,-500);
 				GameTextForPlayer(playerid,"shouxufei 500$ okey!",5000,1);
     return 1;
				}
    sdi = GetPlayerPing(playerid);//身份证
	   sfzid = playercall[playerid]+SFZIDB+sdi;//身份证
	   playersfz[playerid] = sfzid+1;//身份证
				SendClientMessage(playerid,0xDC143CAA,"你办好了身份证咯，请/stats察看身份证号码吧,希望你能够做个好市民!");
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
	SendClientMessage(playerid,0xDC143CAA,"你成功进入了IRC频道1,输入/i来在IRC频道中说话!");
	return 1;
	}
	if(listitem	== 1)
	{
	playerircid[playerid]=2;
	SendClientMessage(playerid,0xDC143CAA,"你成功进入了IRC频道2,输入/i来在IRC频道中说话!");
	return 1;
	}
	if(listitem	== 2)
	{
	playerircid[playerid]=3;
	SendClientMessage(playerid,0xDC143CAA,"你成功进入了IRC频道3,输入/i来在IRC频道中说话!");
	return 1;
	}
	if(listitem	== 3)
	{
	playerircid[playerid]=4;
	SendClientMessage(playerid,0xDC143CAA,"你成功进入了IRC频道4,输入/i来在IRC频道中说话!");
	return 1;
	}
	if(listitem	== 4)
	{
	playerircid[playerid]=5;
	SendClientMessage(playerid,0xDC143CAA,"你成功进入了IRC频道5,输入/i来在IRC频道中说话!");
	return 1;
	}
	if(listitem	== 5)
	{
	playerircid[playerid]=0;
	SendClientMessage(playerid,0xDC143CAA,"你成功的退出了IRC频道,你将不能使用/i在IRC频道中说话!");
	return 1;
			}
		}
	}
//===========================================24/7商店===============================
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
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				callid=playerid+CSH+pi;
				playercall[playerid]=callid+pi+callid;
				format(msg,128,"你买了一部IphoneG3	[电话号码为:%d]*Iphone优点:号码短小,好记",playercall[playerid]);
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
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				callid=playercall[playerid]+CSH+pi;
				playercall[playerid]=callid+1;
				format(msg,128,"你买了一部小灵通 [电话号码为:%d]",playercall[playerid]);
				SendClientMessage(playerid,0x00FF00AA,msg);
				GivePlayerMoney(playerid,-800);
				GameTextForPlayer(playerid,"-800",5000,1);
			}
			if(listitem	== 2)
			{
				if (GetPlayerMoney(playerid)<10)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+10;
				SendClientMessage(playerid,0x00FF00AA,"你为你的手机卡充值了10元");
				GivePlayerMoney(playerid,-10);
				GameTextForPlayer(playerid,"-10",5000,1);
			}
			if(listitem	== 3)
			{
				if (GetPlayerMoney(playerid)<20)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+20;
				SendClientMessage(playerid,0x00FF00AA,"你为你的手机卡充值了20元");
				GivePlayerMoney(playerid,-20);
				GameTextForPlayer(playerid,"-20",5000,1);
			}
			if(listitem	== 4)
			{
				if (GetPlayerMoney(playerid)<50)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+50;
				SendClientMessage(playerid,0x00FF00AA,"你为你的手机卡充值了50元");
				GivePlayerMoney(playerid,-50);
				GameTextForPlayer(playerid,"-50",5000,1);
			}
			if(listitem	== 5)
			{
				if (GetPlayerMoney(playerid)<100)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+100;
				SendClientMessage(playerid,0x00FF00AA,"你为你的手机卡充值了100元");
				GivePlayerMoney(playerid,-100);
				GameTextForPlayer(playerid,"-100",5000,1);
			}
			if(listitem	== 6)
			{
				if (GetPlayerMoney(playerid)<200)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				playercallmoney[playerid]=playercallmoney[playerid]+200;
				SendClientMessage(playerid,0x00FF00AA,"你为你的手机卡充值了200元");
				GivePlayerMoney(playerid,-200);
				GameTextForPlayer(playerid,"-200",5000,1);
			}
			if(listitem	== 7)
			{
				new	pi;
				if (GetPlayerMoney(playerid)<50000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				pi = GetPlayerPing(playerid);
				if(pi==50 && pi==55	&& pi==60 && pi==65	&& pi==70 && pi==75	&& pi==80 && pi==85)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"彩票:恭喜玩家%s中了2等奖3万元",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"恭喜你!你中了3万元");
					GivePlayerMoney(playerid,30000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"遗憾~你没中奖~");}
				if(pi==85 && pi==90	&& pi==91 && pi==96	&& pi==92 && pi==98	&& pi==100 && pi==150)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"彩票:恭喜玩家%s中了1等奖500万元",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"恭喜你!你中了500万元");
					GivePlayerMoney(playerid,5000000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"遗憾~你没中奖~");}
				if(pi>130)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"彩票:恭喜玩家%s中了特等奖1000元",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"恭喜你!你中了1000元");
					GivePlayerMoney(playerid,1000);
					return 1;
				}
				if(pi>100)
				{
					new	msg[128],name[128];
					GetPlayerName(playerid,name,128);
					format(msg,128,"彩票:恭喜玩家%s中了安慰奖5元",name);
					SendClientMessageToAll(0x00FF00AA,msg);
					SendClientMessage(playerid,0x00FF00AA,"恭喜你!你中了1000元");
					GivePlayerMoney(playerid,1000);
					return 1;
				}
				else{SendClientMessage(playerid,0x00FF00AA,"遗憾~你没中奖~");}
				GivePlayerMoney(playerid,-50000);
				GameTextForPlayer(playerid,"-50000",5000,1);
			}
			if(listitem	== 8)
			{
				if (GetPlayerMoney(playerid)<1500)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				SetPlayerHealth(playerid,100);
				GivePlayerMoney(playerid,-1500);
				GameTextForPlayer(playerid,"-1500",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"你买了一包驴胶补血颗粒，冲在碗里，喝在嘴里，貌似能加血~");
			}
			if(listitem	== 9)
			{
				if (GetPlayerMoney(playerid)<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				GivePlayerMoney(playerid,-1000);
				GameTextForPlayer(playerid,"-1000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"你购买了电子电话薄 用法[/chm+玩家ID查号]	每次耗费5元话费");
			}
			if(listitem	== 10)
			{
				if (GetPlayerMoney(playerid)<6000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				GivePlayerMoney(playerid,-6000);
				GameTextForPlayer(playerid,"-6000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"你购买了IPAD	请使用/help查看命令");
				playeripad[playerid]=1;
			}
			if(listitem	== 11)
			{
				if (GetPlayerMoney(playerid)<1000)
				{
					SendClientMessage(playerid,0x00FF00AA,"你的钱不够");
					return 1;
				}
				GivePlayerMoney(playerid,-1000);
				GameTextForPlayer(playerid,"-1000",5000,1);
				SendClientMessage(playerid,0x00FF00AA,"你购买了烟花	请使用/help查看命令");
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
						SendClientMessage(playerid,0x00FF00AA,"你不在车库入口/警察局门口/楼顶入口!");
						return 1;
					}
            if(Account[playerid][_fine]==0)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, " 错误: 你不需要缴纳罚金");
            	return 1;
            }
            if(GetPlayerMoney(playerid)<Account[playerid][_fine])
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, " 错误: 缴纳不起罚金/stats查看超速罚单");
            	return 1;
            }
            if(PlayerToPoint(5.0, playerid, 252.3794,117.5285,1003.2187))
            {
                GiveMoney(playerid, -Account[playerid][_fine]);
                fastdrive[playerid]=0;
	       		format(string, sizeof(string), "   你缴纳了 $ %d 的超速罚金.", Account[playerid][_fine]);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				Govassets+=Account[playerid][_fine];
     			SaveStuff();
     			new tmpstr[255];
				format(tmpstr, sizeof(tmpstr), " 政府基金增加 $%d[余额: $%d] 来自 %s[ID %d] 的超速罚金", Account[playerid][_fine],Govassets,Account[playerid][pName],playerid);
				ABroadCast(COLOR_GREEN,tmpstr,1);
				//fastdrive[playerid]=0;
	           	Account[playerid][pCarLicS]=0;
				Account[playerid][_fine]=0;
				SendClientMessage(playerid, COLOR_YELLOW2, string);
				SendClientMessage(playerid, COLOR_YELLOW2, " 提示: 以后请小心驾驶");
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
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"错误","","确定","取消");
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
				ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"错误","密码错误!请重新输入!","登录","退出");
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
			    ShowPlayerDialog(playerid,66,DIALOG_STYLE_LIST,"买车系统 - 四轮车类",carliststring,"购买","取消");
			}
			if(listitem==1)
			{
			 #define carliststring1 "[ID:509]Bike($8000)\n[ID:481]BMX($12000)\n[ID:510]Mountain Bike($18000)\n[ID:462]Faggio($24000)\n[ID:463]Freeway($35000)\n[ID:461]PCJ-600($45000)\n[ID:581]BF-400($50000)"
				ShowPlayerDialog(playerid,67,DIALOG_STYLE_LIST,"买车系统 - 两轮车类",carliststring1,"购买","取消");
			}
			if(listitem==2)
			{
			 #define carliststring2 "[ID:487]Maverick($3200000)\n[ID:469]Sparrow($3000000)"
				ShowPlayerDialog(playerid,68,DIALOG_STYLE_LIST,"买车系统 - 飞机/直升机类",carliststring2,"购买","取消");
			}
			if(listitem==3)
			{
			 #define carliststring3 "[ID:409]Stretch($300000)\n[ID:411]Infernus($400000)\n[ID:415]Cheetah($400000)\n[ID:429]Banshee($400000)\n[ID:451]Turismo($450000)\n[ID:477]ZR-350($500000)\n[ID:506]Super GT($500000)\n[ID:541]Bullet($500000)"
				ShowPlayerDialog(playerid,69,DIALOG_STYLE_LIST,"买车系统 - VIP车辆类",carliststring3,"购买","取消");
			}
			if(listitem==4)
			{
				ShowPlayerDialog(playerid,70,DIALOG_STYLE_LIST,"买车系统 - 特殊车辆类","本功能暂未添加,请等待下版","反悔","");
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
						SendClientMessage(playerid,0xFFFACDAA,"* 你的钱不够购买这辆车!");
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
						SendClientMessage(playerid,0xFFFACDAA,"* 你的钱不够购买这辆车!");
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
						SendClientMessage(playerid,0xFFFACDAA,"* 你的钱不够购买这架飞机/直升机!");
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
			SendClientMessage(playerid,0x00FF00AA,"你不是VIP!");
			return 1;
			}
   for(new	s=0;s<8;s++)
			{
				if(listitem==s)
				{
					if(playermoney[playerid]<sellvipcarmoney[s])
					{
						SendClientMessage(playerid,0xFFFACDAA,"* 你的钱不够购买这辆车!");
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
			SendClientMessage(playerid,0x00FF00AA,"不使用时请输入/jiechuzuche解租!");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
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
							SendClientMessage(playerid,0x00FF00AA,"你买不起这把武器");
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
				SendClientMessage(playerid,0x00FF00AA,"你拿不了更多的武器了");
				return 1;
			}
			if(listitem==6)
			{
				SendClientMessage(playerid,0x00FF00AA,"该武器长期缺货中.");
				return 1;
			}
		}
		SendClientMessage(playerid,0x00FF00AA,"下次再买吧! ");
		return 1;
	}
	if(dialogid	== 8520)
	{
		if(response)
		{
			if(listitem	== 0)
			{
				SendClientMessage(playerid,	COLOR_GREY,	"你现在非常虚弱,你可以输入/120,拨打急救电话,若得不到救援,则在50秒后将被送往医院");
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
public OnPlayerConnect(playerid)//玩家连接服务器
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
SetPlayerMapIcon(playerid,0,-2494.097167,2272.395263,4.954111 ,56, 0);//为该玩家在地图上创建政府小图标
SetPlayerMapIcon(playerid,1,-2485.685302,2272.334228,4.984375  ,30, 0);//为该玩家在地图上创建警察局小图标
SetPlayerMapIcon(playerid,2,1173.634155, -2035.625976 ,68.704116  , 38, 0);//为该玩家在地图上创建三合会组织图标
SetPlayerMapIcon(playerid,3,-693.689147,  949.383056,12.239253  , 4, 0);//为该玩家在地图上创建管理员家图标
SetPlayerMapIcon(playerid,4,316.571990, -1784.195800 ,4.674662  , 61, 0);//为该玩家在地图上创建蓝帮组织图标
SetPlayerMapIcon(playerid,5,2340.050537, -1234.563110 ,27.976562  , 62, 0);//为该玩家在地图上创建绿帮组织图标
SetPlayerMapIcon(playerid,6,1997.449951, -1285.688842 ,28.488073  , 59, 0);//为该玩家在地图上创建紫帮组织图标
SetPlayerMapIcon(playerid,7,1276.380371, -790.172912 ,92.031250  , 24, 0);//为该玩家在地图上创建黑手党组织图标
SetPlayerMapIcon(playerid,8,725.648437, -1451.579467 ,22.210937  , 60, 0);//为该玩家在地图上创建3K党组织图标
SetPlayerMapIcon(playerid,9,-2386.710449,2446.947021,10.169355  , 22, 0);//为该玩家在地图上创建医院图标
SetPlayerMapIcon(playerid,10,-2445.007568,2485.488525,15.320312  , 55, 0);//为该玩家在地图上创建买车点图标
SetPlayerMapIcon(playerid,11,2244.497070, -1665.593139 ,15.476562  , 45, 0);//为该玩家在地图上创建买衣服点图标
SetPlayerMapIcon(playerid,12,2495.557617, -1691.032226 ,14.765625  , 15, 0);//为该玩家在地图上创建cj老家点图标
SetPlayerMapIcon(playerid,13,1837.023925, -1682.109375 ,13.323469  , 48, 0);//为该玩家在地图上创建光碟酒吧图标
SetPlayerMapIcon(playerid,14,1498.498046, -1581.214355 ,13.549827  , 49, 0);//为该玩家在地图上创建爵士酒吧图标
SetPlayerMapIcon(playerid,15,-2501.096679,2319.394287,4.984375  , 52, 0);//为该玩家在地图上创建银行图标
SetPlayerMapIcon(playerid,16,2045.566650, -1913.380737 ,13.546875  , 36, 0);//为该玩家在地图上创建驾校图标
SetPlayerMapIcon(playerid,17,-2187.459228,2416.550292,5.165121  , 44, 0);//为该玩家在地图上创建传媒台图标
SetPlayerMapIcon(playerid,18,-2547.148925,2300.347900,4.984375  , 5, 0);//为该玩家在地图上创建运输工作图标
SetPlayerMapIcon(playerid,19,1518.841064, -1452.584960 ,14.203125  ,30, 0);//为该玩家在地图上创建FBI小图标
SetPlayerMapIcon(playerid,20,1457.002929, -1023.099548 ,23.828125  , 17, 0);//为该玩家在地图上创建银行图标
SetPlayerMapIcon(playerid,21,-2540.971923,2267.912597,5.026381  , 12, 0);//为该玩家在地图上创建便民餐馆图标
SetPlayerMapIcon(playerid,22,-2479.197753,2317.906250,4.984375  , 52, 0);//为该玩家在地图上创建24/7 2图标
SetPlayerMapIcon(playerid,23,1310.208374, -1367.452392 ,13.534426  , 52, 0);//为该玩家在地图上创建24/7 总图标
SetPlayerMapIcon(playerid,24,1352.428955, -1759.248413 ,13.507812  , 52, 0);//为该玩家在地图上创建24/7 3图标
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
	format(msg,128,"[服务器]: [ID:%d]%s	连接了服务器(IP:%s)",playerid,name,ip);
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
 	SendClientMessage(playerid, 0xFFFF00AA, "欢迎来到 {FF0000}汇诚游戏社区 {FFFF00}旗下 {FF00FF}我的中国心{FFC0CB} 开源第七版服务器.");
 	SendClientMessage(playerid, 0xFFFF00AA, "如果你觉得这个服务器脚本好玩，请赞助我们。联系QQ: 947585287 汇诚游戏社区: www.hcyxsq.cn");
 	SendClientMessage(playerid, COLOR_YELLOW, "===================================================================================");
 	SendClientMessage(playerid, 0x99FFFFAA, "正在读取此帐户资料中，请稍候......");
 	for(new i; i<44; i++)
	{
	    PlayerWeapons[playerid][i] = 0;
	}
	return 0;
}
//---------------------------------------------------------------------[电话中]----------------------
public OnPlayerText(playerid,text[])//玩家输入不带"/"的内容的事件
{
	if(KillSpawn[playerid])
	{
		SendClientMessage(playerid,	COLOR_GREY,	"	你现在只可以使用/120请求援助 !");
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
				format(str,	sizeof(str), "%s 说: **********", pname);
				ProxDetector(30.0, playerid, str, COLOR_FADE1, COLOR_FADE2,	COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				return 0;
		  }
		}
		if(playerviplv[playerid]!=0)
		{
		format(str,	sizeof(str), "{FF00FF}[VIP%d]{FFC0CB}%s 说: %s",playerviplv[playerid], pname, text);
		}
		else
		{
		format(str,	sizeof(str), "%s 说: %s", pname, text);
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
			format(msg,128,"%s(电话中):%s",name,text);
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
public SavePlayer()//保存玩家资料,每一秒运行一次
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
									SendClientMessage(i, 0x0D7792AA, "你的汽车引擎启动了!");
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
							format(msg,128,"<加油站>你将汽车的油加满了!花费了%d!",fillmoney[i]);
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
						SendClientMessage(i,0xFFC0CBFF,"``叮铃铃·``叮铃铃·``你的电话响了!输入/p接听!");
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
								SendClientMessage(i, 0xDC143CAA,"<警告>你的汽车油量不多了!");
							}
						}
						if(carfill[vid]==0&&zid==0)
						{
         					SendClientMessage(i, 0xDC143CAA,"你的汽车已经没有油了!如果您是VIP，可以将车继续开走，不过别忘了加油哦！30秒后就会死火的！");
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
						format(msg,128,"[ID:%d]%s武器异常,请管理员注意.",i,name);
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
									SendClientMessage(i, 0xDC143CAA,"你的监禁时间未满！自动分配到1号监狱");
									SetPlayerSkin(i,252);
									SetPlayerPos(i,264.752624,77.582786,1001.039062);
									SetPlayerInterior(i,6);
								}
							}
						}
						if(playerjianyutime[i]==0)
						{
							SendClientMessage(i, 0xDC143CAA,"监狱长：你坐牢时间到了~出去吧!");
							SendClientMessage(i, 0xDC143CAA,"监狱长：好好反省你之前犯下的错误，努力做个好市民吧！加油！");
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
							SendClientMessage(i, 0xDC143CAA,"目标玩家下线,追踪强制解除!");
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
								if(strcmp(ZFJGSTR[u],"未出售")==0)
								{
									//SendClientMessage(i, 0xFFFFF0FF,"如果你想购买这间房请输入/buyhouse");
								}
							}
						}
					}
					if(savetime==0)
					{
  /*new	msgg[128];
  new sendername[MAX_PLAYER_NAME];
  GetPlayerName(i, sendername, sizeof(sendername));
  format(msgg,128,"%s数据秒存保存完成",sendername[i]);
  print(msgg);*/
//===================================KINI保存=========================
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
/*public huanming()//计时器事件
{
SendRconCommand(Randomx[random(sizeof(Randomx))]);
}*/
public OnGameModeExit()//服务器关闭时的事件~
{
		BAOCUNACCOUNT();
		RemoveCameras();
		TextDrawDestroy(flash);
		        new p = GetMaxPlayers();
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "laser", 0);
                RemovePlayerAttachedObject(i, 0);
        }
				print("服务器已经关闭啦！");
		return 1;
}
public OnGameModeInit()//服务器运行时的事件~
{
		InitTablet();
        ManualVehicleEngineAndLights();
        CreatePickup(1314, 0, 1232.0562,-810.9739,1084.0078);
        Create3DTextLabel("===GM基地服务台===\n/gmqt查看操作",0xFFFF00AA,1232.0562,-810.9739,1084.0078,10,0,0);
    	CreatePickup(1239, 0, 265.6101,76.1229,1001.0391);
    	CreatePickup(1239, 0, 230.7155,71.3590,1005.0391);
    	CreatePickup(1239, 0, -2831.4377,2306.6553,98.3154);
    	CreatePickup(1239, 0, 257.5566,77.5511,1003.6406);
    	Create3DTextLabel("===暴动功能===\n/jybd start开始暴动",0xFFFF00AA,265.6101,76.1229,1001.0391,10,0,0);
		Create3DTextLabel("===暴动功能===\n/jybd ys取钥匙",0xFFFF00AA,230.7155,71.3590,1005.0391,50,0,0);
		Create3DTextLabel("===暴动功能===\n暴动结束点",0xFFFF00AA,-2831.4377,2306.6553,98.3154,100,0,0);
		Create3DTextLabel("===暴动功能===\n/jybd gun领枪",0xFFFF00AA,257.5566,77.5511,1003.6406,50,0,0);
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
        SetTimer("huanming",3000,1);//计时器
		SetTimer("sjd",1200000,1);
		SetTimer("SavePlayer",1000,1);
		SetTimer("WeatherAndTime", 300000, true);
		SetTimer("GlobalAnnouncement" ,120000,true); //	2分钟一次广告- -
		SetTimer("OtherTimer", 500,	1);
//=======================================工作================================//-

	//========
		SetGameModeText(SCRIPT_VERSION);
	//========

//===========================加载物件=========================

//===========================加载完毕=========================
	//////////////////四轮车类
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
	//////////////////两轮车类
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
	//////////////////飞机类
	 sellfeijimoney[0]=3200000;
		sellfeijimoney[1]=3000000;
		sellfeijimod[0]=487;
		sellfeijimod[1]=469;
//////////////////VIP车辆类
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
	//--------------------------------------买车系统初始化
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
	//--------------------------------------------各组织出生地
		zuzhiskin[0][0]=26;
		zuzhiskin[0][1]=26;
		zuzhiskin[0][2]=26;
		zuzhiskin[0][3]=26;
		zuzhiskin[0][4]=26;
		zuzhiskin[0][5]=26;
	//--------------------------------平民皮肤ID
		zuzhiskin[1][0]=188;
		zuzhiskin[1][1]=26;
		zuzhiskin[1][2]=37;
		zuzhiskin[1][3]=91;
		zuzhiskin[1][4]=120;
		zuzhiskin[1][5]=166;
	//--------------------------------记者ID
		zuzhiskin[2][0]=16;
		zuzhiskin[2][1]=16;
		zuzhiskin[2][2]=16;
		zuzhiskin[2][3]=16;
		zuzhiskin[2][4]=16;
		zuzhiskin[2][5]=16;
	//--------------------------------管理组
		zuzhiskin[3][0]=280;
		zuzhiskin[3][1]=267;
		zuzhiskin[3][2]=265;
		zuzhiskin[3][3]=282;
		zuzhiskin[3][4]=283;
		zuzhiskin[3][5]=288;
	//--------------------------------警察皮肤ID
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
	//--------------------------------政府
		zuzhiskin[6][0]=276;
		zuzhiskin[6][1]=275;
		zuzhiskin[6][2]=274;
		zuzhiskin[6][3]=91;
		zuzhiskin[6][4]=70;
		zuzhiskin[6][5]=228;
	//--------------------------------医院
		zuzhiskin[7][0]=121;
		zuzhiskin[7][1]=117;
		zuzhiskin[7][2]=118;
		zuzhiskin[7][3]=120;
		zuzhiskin[7][4]=123;
		zuzhiskin[7][5]=294;
	//--------------------------------三合会
		zuzhiskin[8][0]=173;
		zuzhiskin[8][1]=175;
		zuzhiskin[8][2]=174;
		zuzhiskin[8][3]=114;
		zuzhiskin[8][4]=115;
		zuzhiskin[8][5]=116;
	//--------------------------------蓝帮
		zuzhiskin[9][0]=28;
		zuzhiskin[9][1]=29;
		zuzhiskin[9][2]=101;
		zuzhiskin[9][3]=102;
		zuzhiskin[9][4]=103;
		zuzhiskin[9][5]=104;
	//--------------------------------紫帮
		zuzhiskin[10][0]=106;
		zuzhiskin[10][1]=105;
		zuzhiskin[10][2]=107;
		zuzhiskin[10][3]=269;
		zuzhiskin[10][4]=271;
		zuzhiskin[10][5]=270;
	//--------------------------------绿帮
		zuzhiskin[11][0]=184;
		zuzhiskin[11][1]=185;
		zuzhiskin[11][2]=240;
		zuzhiskin[11][3]=126;
		zuzhiskin[11][4]=127;
		zuzhiskin[11][5]=125;
	//--------------------------------黑手党
		zuzhiskin[12][0]=108;
		zuzhiskin[12][1]=109;
		zuzhiskin[12][2]=110;
		zuzhiskin[12][3]=142;
		zuzhiskin[12][4]=222;
		zuzhiskin[12][5]=113;
	//--------------------------------3K党
		zuzhiskin[14][0]=287;
		zuzhiskin[14][1]=287;
		zuzhiskin[14][2]=287;
		zuzhiskin[14][3]=287;
		zuzhiskin[14][4]=287;
		zuzhiskin[14][5]=287;
	//--------------------------------军队
		zuzhiskin[15][0]=68;
		zuzhiskin[15][1]=163;
		zuzhiskin[15][2]=164;
		zuzhiskin[15][3]=166;
		zuzhiskin[15][4]=165;
		zuzhiskin[15][5]=154;
	//--------------------------------装修公司
		zuzhiskin[16][0]=26;
		zuzhiskin[16][1]=26;
		zuzhiskin[16][2]=26;
		zuzhiskin[16][3]=26;
		zuzhiskin[16][4]=26;
		zuzhiskin[16][5]=26;
	//--------------------------------城里人
		format(zuzhilv[0][0],8,"小小住户");
		format(zuzhilv[0][1],8,"正式住户");
		format(zuzhilv[0][2],8,"牛逼住户");
		format(zuzhilv[0][3],8,"高级住户");
		format(zuzhilv[0][4],8,"居民先锋");
		format(zuzhilv[0][5],32,"居委会会长");
	//--------------------------------乡村
		format(zuzhilv[1][0],8,"记者");
		format(zuzhilv[1][1],8,"娱乐");
		format(zuzhilv[1][2],8,"新闻");
		format(zuzhilv[1][3],8,"副总编");
		format(zuzhilv[1][4],8,"总编");
		format(zuzhilv[1][5],32,"台长");
	//--------------------------------记者
		format(zuzhilv[2][0],8,"新手协助员");
		format(zuzhilv[2][1],8,"正式GM");
		format(zuzhilv[2][2],8,"中级GM");
		format(zuzhilv[2][3],8,"高级GM");
		format(zuzhilv[2][4],8,"前台总管");
		format(zuzhilv[2][5],32,"后台总管");
	//--------------------------------管理组
		format(zuzhilv[3][0],8,"学警");
		format(zuzhilv[3][1],8,"巡警");
		format(zuzhilv[3][2],8,"刑警");
		format(zuzhilv[3][3],8,"督查");
		format(zuzhilv[3][4],32,"副局长");
		format(zuzhilv[3][5],8,"局长");
	//--------------------------------警署
		format(zuzhilv[4][0],32,"实习探员");
		format(zuzhilv[4][1],32,"正式探员");
		format(zuzhilv[4][2],32,"高级探员");
		format(zuzhilv[4][3],8,"探长");
		format(zuzhilv[4][4],32,"副署长");
		format(zuzhilv[4][5],32,"署长");
	//--------------------------------FBI
		format(zuzhilv[5][0],32,"实习职员");
		format(zuzhilv[5][1],8,"司机");
		format(zuzhilv[5][2],32,"文员");
		format(zuzhilv[5][3],32,"市长");
		format(zuzhilv[5][4],32,"省长");
		format(zuzhilv[5][5],8,"总统");
	//--------------------------------政府
		format(zuzhilv[6][0],32,"实习医生");
		format(zuzhilv[6][1],8,"医生");
		format(zuzhilv[6][2],32,"高级医生");
		format(zuzhilv[6][3],32,"专家");
		format(zuzhilv[6][4],32,"副院长");
		format(zuzhilv[6][5],8,"院长");
	//--------------------------------医院
		format(zuzhilv[7][0],8,"小弟");
		format(zuzhilv[7][1],8,"暴徒");
		format(zuzhilv[7][2],8,"打手");
		format(zuzhilv[7][3],8,"助理");
		format(zuzhilv[7][4],32,"副会长");
		format(zuzhilv[7][5],8,"会长");
	//--------------------------------三合会
		format(zuzhilv[8][0],8,"小弟");
		format(zuzhilv[8][1],8,"打手");
		format(zuzhilv[8][2],8,"军事");
		format(zuzhilv[8][3],8,"小队长");
		format(zuzhilv[8][4],32,"领队");
		format(zuzhilv[8][5],8,"统领");
	//--------------------------------蓝帮
		format(zuzhilv[9][0],8,"小弟");
		format(zuzhilv[9][1],8,"暴徒");
		format(zuzhilv[9][2],8,"打手");
		format(zuzhilv[9][3],8,"助理");
		format(zuzhilv[9][4],32,"副帮主");
		format(zuzhilv[9][5],8,"帮主");
	//--------------------------------紫帮
		format(zuzhilv[10][0],8,"小弟");
		format(zuzhilv[10][1],8,"暴徒");
		format(zuzhilv[10][2],8,"打手");
		format(zuzhilv[10][3],8,"助理");
		format(zuzhilv[10][4],32,"副族长");
		format(zuzhilv[10][5],8,"族长");
	//--------------------------------绿帮
		format(zuzhilv[11][0],8,"小弟");
		format(zuzhilv[11][1],8,"打手");
		format(zuzhilv[11][2],8,"杀手");
		format(zuzhilv[11][3],32,"高级杀手");
		format(zuzhilv[11][4],8,"领队");
		format(zuzhilv[11][5],8,"教父");
	//--------------------------------黑手党
		format(zuzhilv[12][0],8,"小弟");
		format(zuzhilv[12][1],8,"水手");
		format(zuzhilv[12][2],32,"航海士");
		format(zuzhilv[12][3],8,"队长");
		format(zuzhilv[12][4],32,"副船长");
		format(zuzhilv[12][5],8,"船长");
	//--------------------------------3K党
		format(zuzhilv[14][0],8,"列兵");
		format(zuzhilv[14][1],8,"中尉");
		format(zuzhilv[14][2],32,"少校");
		format(zuzhilv[14][3],8,"大校");
		format(zuzhilv[14][4],32,"指挥官");
		format(zuzhilv[14][5],8,"总司令");
	//--------------------------------军人
		format(zuzhilv[15][0],8,"新人");
		format(zuzhilv[15][1],8,"小弟");
		format(zuzhilv[15][2],32,"打手");
		format(zuzhilv[15][3],8,"枪手");
		format(zuzhilv[15][4],32,"领队");
		format(zuzhilv[15][5],8,"族长");
	//--------------------------------装修公司
		format(zuzhilv[16][0],8,"普通公民");
		format(zuzhilv[16][1],8,"高级公民");
		format(zuzhilv[16][2],32,"公务员");
		format(zuzhilv[16][3],8,"公民督察");
		format(zuzhilv[16][4],32,"副会长");
		format(zuzhilv[16][5],8,"会长");
	//--------------------------------城市
		format(zuzhiname[0],32,"乡村居委会");
		format(zuzhiname[1],32,"记者");
		format(zuzhiname[2],32,"管理员");
		format(zuzhiname[3],32,"警察");
		format(zuzhiname[4],32,"FBI");
		format(zuzhiname[5],32,"政府");
		format(zuzhiname[6],32,"医院");
		format(zuzhiname[7],32,"三合会");
		format(zuzhiname[8],32,"蓝帮");
		format(zuzhiname[9],32,"紫帮");
		format(zuzhiname[10],32,"绿帮");
		format(zuzhiname[11],32,"黑手党");
		format(zuzhiname[12],32,"3K党");
		format(zuzhiname[13],32,"出租车公司");
		format(zuzhiname[14],32,"军队");
		format(zuzhiname[15],32,"Assassintor家族");
		format(zuzhiname[16],32,"城市居委会");
		format(zuzhigonggao[3],32,"局长");
		format(zuzhigonggao[4],32,"署长");
		format(zuzhigonggao[5],32,"总统");
		format(zuzhigonggao[6],32,"院长");
		format(zuzhigonggao[14],32,"总司令");
		format(tg[0],128,"无");
		format(tg[1],128,"有");
	//----------------------------------------
		format(gongzuoname[0],32,"无");
		format(gongzuoname[1],32,"材料走私");
		format(gongzuoname[2],32,"侦探");
		format(gongzuoname[3],32,"武器商人");
		format(gongzuoname[4],32,"汽车销售商");
		format(gongzuoname[5],32,"加油站服务员");
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
	//-------------------------------------俺家
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
	//====================皮卡开始
		CreateDynamicPickup(1318, 1, 2.6288,33.2132,1199.5938);	// /飞机离开- -
		Create3DTextLabel("[飞机场]	\n {F0FF00}请按{F0FFFF}	[{F0000F}上车键{F0FFFF}	]{F0FF00}进入这里",0xFFFF00AA, 2.6288,33.2132,1199.5938, 20,0,1);
	//NPCs
		ConnectNPC("VGBUS_1","Bus");
		ConnectNPC("BlackBus_Driver","Bus2");
		SetPlayerSkin(0,93);
        SetPlayerSkin(1,11);
        SetPlayerSkin(2,287);
        SetPlayerSkin(3,287);  //设置一下NPC的皮肤
	//3DTextLabels
		/*NPCTextBlue	= Create3DTextLabel("[免费车 按G上车]", 0x6495EDFF, 0.0,	0.0, 0.0, 30.0,0, 0);
		NPCTextBlack = Create3DTextLabel("[公交2号线]",	0x6495EDFF,	0.0, 0.0, 0.0, 30.0,0, 0);
		Create3DTextLabel("[输入F离开]", 0x6495EDFF, 2021.9740,2235.6626,2103.9536,	15.0,2);
		Create3DTextLabel("[输入F离开]", 0x6495EDFF, 2021.9740,2235.6626,2103.9536,	15.0,3);
	//Vehicles
		NPCBlueBus = CreateVehicle(437,	0.0, 0.0, 0.0, 0.0,	125, 125, 1);
		NPCBlackBus	= CreateVehicle(437, 0.0, 0.0, 0.0,	0.0, 0,	0, 1);*/
//=====================皮卡结束
//=============================================
		new	File:player=fopen("ZFJG.cfg",io_read);
		new	nr[128];
		new	idx;
		new	msg[128];
//new tmp[128];
		while(fread(player,nr))//创建全部牌子
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
				if(strcmp(ZFJGSTR[pickupids],"未出售")==0)
				{
					pd=1;
					format(msg,128,"{FFFF00}状态:{1E90FF}%s{FFFF00}\n购买等级:{1E90FF}%d{FFFF00}\n价格:{1E90FF}%d{FFFF00}\n描述:{1E90FF}%s{FFFF00}\n",ZFJGSTR[pickupids],ZFJGLV[pickupids],ZFJGMONEY[pickupids],ZFJGSTR1[pickupids]);
				}
				if(pd==0)
				{
					format(msg,128,"{FFFF00}房主:{FF1493}%s{FFFF00}\n租金:{FF1493}%d{FFFF00}\n描述:{FF1493}%s{FFFF00}\n",ZFJGSTR[pickupids],ZFJGZJ[pickupids],ZFJGSTR1[pickupids]);
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
		while(fread(player,nr))//创建全部车子
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
	            print("* 默认RCON密码还没改, 请打开server.cfg并修改rcon_password后数值后再重启服务端.");
	        }
	    }
		print("服务器运行信息: ");
		SendRconCommand("varlist");
		return 1;
}
public AdminXX(zuzhi,string[],color)//向所有ADMIN发消息
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
public XY(Float:real,playerid,Float:x,Float:y,Float:z)//判断距离的函数
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
strtokp(const string[],	&index)//截取函数，适用于/指令聊天的特殊截取函数
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
//==========================点击玩家后===========================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(playeradmin[playerid]>= 1)
	{
			new	Float:x,Float:y,Float:z;
			new	hid=GetPlayerInterior(clickedplayerid);
			if(SL[clickedplayerid]==0)
			{
				SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:该玩家不在线");
				return 1;
			}
			GetPlayerPos(clickedplayerid,x,y,z);
			SetPlayerPos(playerid,x+1,y+1,z+1);
			houseid[playerid]=houseid[clickedplayerid];
			SetPlayerInterior(playerid,hid);
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(clickedplayerid));
			SendClientMessage(playerid,0xFFFACDAA,"成功传送");
			return 1;
	}
	SendClientMessage(playerid,0xDC143CAA,"错误,错误原因:你没有权限");
	return 1;
}
//==================================工作=======================

//===========================================================
public OnPlayerDeath(playerid, killerid, reason) //玩家死亡的事件
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
		format(msg,128,"[ID:%d]%s死亡,原因:意外",playerid,name);
		ABroadCast(0xFF1493FF,msg,1);
	}
	if(killerid!=65535)
	{
/*	if(playerdm[playerid]==1)
	{
				new msgdm[128];
			    format(msgdm,128,"[DM信息]{FF00FF}%s{FFC0CB}在DM模式中战胜了{FF00FF}%s{FFC0CB},获得了奖励资金1000，大家也来战斗吧~(/dm)",name1,name);
				SendClientMessageToAll(0xFFFF00AA,msgdm);
				playermoney[playerid]=playermoney[playerid]+1000;
                ResetPlayerMoney(playerid);
	            GivePlayerMoney(playerid,playermoney[playerid]);
	            return 1;
	}*/
		if(su[playerid]==0||su[playerid]>=1&&playerzuzhi[killerid]!=3)
		{

   //=======================DMKILL
			format(msg,128,"[ID:%d]%s死亡,凶手:[ID:%d]%s",playerid,name,killerid,name1);
			ABroadCast(0xFF1493FF,msg,1);
			if(playerzuzhi[playerid]<7||playerzuzhi[killerid]<7)
			{
				if(su[killerid]<10)
				{
					su[killerid]=su[killerid]+1;
				}
				format(msg,128,"[通缉]%s被通缉了！通缉等级:%d,理由:谋杀",name1,su[killerid]);
				AdminXX(3,msg,0x00FF00AA);
				format(msg,128,"你由于杀了%s所以被通缉了！目前通缉等级:%d",name,su[killerid]);
				SendClientMessage(killerid,0x00FF00AA,msg);
			}
		}
		if(su[playerid]>=1&&playerzuzhi[killerid]==3)
		{
			format(msg,128,"[ID:%d]%s死亡,击毙:[ID:%d]%s",playerid,name,killerid,name1);
			ABroadCast(0xFF1493FF,msg,1);
			format(msg,128,"[总部]:罪犯%s被警员%s击毙了!",name,name1);
			AdminXX(3,msg,0x00FF00AA);
		}
	}
	if(playerzuzhi[playerid]==0)
	{
		SetSpawnInfo(playerid,0,playerskin[playerid],zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],0,0,0,0,0,0,0);
	}
	if(jybdzt[playerid]==1)
	{
	    SendClientMessage(playerid,0x00FF00AA,"你死亡了，暴动失败.");
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
		SendClientMessage(playerid,0x00FF00AA,"你因为被通缉后死亡而被送进了监狱!");
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

	GetPlayerPos(playerid,x,y,z);//暂存死亡地址
	SpawnPlayer(playerid);
	SetPlayerPos(playerid,x,y,z);//恢复死亡地址
	SetPlayerHealth(playerid,5);
/*	if(playerdm[playerid]==1)
	{
	SendClientMessage(playerid,COLOR_BLUE,"[医院消息]:您在DM模式中受伤了，我们将您救了回来，并且将您送回了原地！");
	SendClientMessage(playerid,COLOR_BLUE,"[医院消息]:DM治疗费：1000");
	playermoney[playerid]=playermoney[playerid]-1000;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
		SetPlayerHealth(playerid,100);
	return 1;
	}*/
	KillSpawn[playerid]	= true;
	TogglePlayerControllable(playerid, false);
	ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0,	1, 0, 0, 0,	0);
	ShowPlayerDialog(playerid,8520,DIALOG_STYLE_LIST,"请选择:","{FFFFFF}1\t{55EE55}等待援助（不推荐）\n{FFFFFF}2\t{55EE55}放弃援助.\n\n\n若都不选视为放弃援助","确定","取消");
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
	SendClientMessage(playerid,0x00FF00AA,"[医院消息]:你被送往医院救治了,收取了您3500医疗费!");
	//SendClientMessage(playerid,0x00FF00AA,"[医院消息]:我们已经给您吃饱喝足了，目前饥饿值和口渴值均为20！记得多多补充哦！");
	//playerjiedu[playerid]=20;
	//playerkouke[playerid]=20;
	}
	if(playerviplv[playerid]!=0)
	{
	playermoney[playerid]=playermoney[playerid]-500;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,playermoney[playerid]);
	SendClientMessage(playerid,0x00FF00AA,"[医院消息]:你被送往医院救治了,由于您是VIP,我们只收取了您500医疗费!");
	//SendClientMessage(playerid,0x00FF00AA,"[医院消息]:我们已经给您吃饱喝足了，目前饥饿值和口渴值均为25！记得多多补充哦！");
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
		format(msg,128,"[汇诚游戏反作弊系统]:玩家%s被服务器踢出.（原因：刷飞行器）执行日期:%d年%d月%d日",name,y,r,d);
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
			format(msg,128,"[汇诚游戏反作弊系统]:玩家%s被服务器踢出.（原因：车辆速度超过最大限度500KM/H）执行日期:%d年%d月%d日",name,y,r,d);
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
			format(msg,128,"[汇诚游戏反作弊系统]:玩家%s被服务器踢出.（原因：车辆健康值大于1000.0）执行日期:%d年%d月%d日",name,y,r,d);
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
	    if(PlayerWeapons[playerid][weaponid] == 0 && weaponid != 0 && wammo != 0 && weaponid != 1  && Kicking[playerid] == 0) //刷武器
	    {
  			new msg[128];
			new name[128];
			new	y,r,d;
			GetPlayerName(playerid,name,128);
			getdate(y,r,d);
			format(msg,128,"[汇诚游戏反作弊系统]:玩家%s被服务器踢出.（原因：刷武器）执行日期:%d年%d月%d日",name,y,r,d);
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

public OnPlayerStateChange(playerid, newstate, oldstate)//改变状态
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


	SendClientMessage(playerid,COLOR_LIGHTBLUE,"出租车值班结束 - 您离开了车辆！");
	OnDuty[playerid] = 0;
	TotalFare[playerid] = 0.00;
 	TextDrawSetString(taxithisfare[playerid],"N/A");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"票价停止");
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
			format(msg,128,"这辆车是%s的爱车哦！",carname[vid]);
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
				SendClientMessage(playerid,0x00FF00AA,"由于您购买了超级N2O，现在已经自动安装N2O！");
				SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
				return 1;
				}
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"由于您购买了超级N2O，现在已经自动安装N2O！");
		   NOSTimer[playerid] = SetTimerEx("NOS",20000,1,"d",playerid);
				SNOS[playerid] = 1;
				}
				SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
			}
			if(caryinqing[vid]==1)
			{
                if(playersupernos[playerid]== 1)
                {
                if(SNOS[playerid]== 1)
                {
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"由于您购买了超级N2O，现在已经自动安装N2O！");
				SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
					 return 1;
				}
                AddVehicleComponent(GetPlayerVehicleID(playerid),1010);
				SendClientMessage(playerid,0x00FF00AA,"由于您购买了超级N2O，现在已经自动安装N2O");
		   NOSTimer[playerid] = SetTimerEx("NOS",20000,1,"d",playerid);
		   				SNOS[playerid] = 1;
				}

				SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
			}
			return 1;
		}
		if(carzuzhi[vid]>=1)
		{
			if(carzuzhi[vid]==playerzuzhi[playerid]||playeradmin[playerid]>= 1)
			{
				format(msg,128,"该车注册给组织:%s,因此你可以开走这辆车",zuzhiname[carzuzhi[vid]]);
				SendClientMessage(playerid,0xD3D3D3FF,msg);
				if(caryinqing[vid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
				}
				if(caryinqing[vid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
				}
				return 1;
			}
			if(carzuyongkey[playerid]==vid)
			{
				if(caryinqing[vid]==0)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
				}
				if(caryinqing[vid]==1)
				{
					SendClientMessage(playerid,0x00FF00AA,"你可以按下{FF0000}N{00FF00}来查看车辆菜单!");
				}
				return 1;
			}
			if(carzuzhi[vid]==13&&carzuyong[vid]==0)
			{
				ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"租车","此车为免费车辆, 请小心驾驶!","确定","");
				return 1;
			}
			RemovePlayerFromVehicle(playerid);
			SendClientMessage(playerid,0xD3D3D3FF,"你没有租用钥匙/钥匙");
			return 1;
		}
		RemovePlayerFromVehicle(playerid);
		SendClientMessage(playerid,0xD3D3D3FF,"你没有租用钥匙/钥匙");
		return 1;
	}
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)//次事件是改装车时候的
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
	SendClientMessage(playerid,0xFF0000FF,"警告!你的汽车改装保存没有解除!现在进行的改装将会无效化!");
	SendClientMessage(playerid,0xFF0000FF,"警告!你的汽车改装保存没有解除!现在进行的改装将会无效化!");
	SendClientMessage(playerid,0xFF0000FF,"警告!你的汽车改装保存没有解除!现在进行的改装将会无效化!");
	SendClientMessage(playerid,0xFF0000FF,"警告!你的汽车改装保存没有解除!现在进行的改装将会无效化!");
	return 1;
}
public OnVehicleSpawn(vehicleid)//汽车出生的事件
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
					format(string, sizeof(string), "[公交车司机] 公交车到了	东海滩站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 2636.3242,-1693.125,10.9544))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	大球场站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 2243.8457,-1725.9121,13.5960))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	健身房站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1948.3310,-1454.3525,13.5960))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	小医院站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1571.0644,-2188.0107,13.6260))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	LS飞机场站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1712.9423,-1818.7148,13.6260))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	的士站.");
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
					format(string, sizeof(string), "[公交车司机] 公交车到了	警察署站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1503.9716,-1027.7617,23.7701))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	银行站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1188.8359,-1354.6279,13.6483))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	大医院站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 861.7125,-1313.3009,13.6260))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	市场站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 393.6944,-1766.2702,5.6197))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	圣玛丽亚海滩站.");
				}
				else if(IsPlayerInRangeOfPoint(playerid, 100, 1705.5898,-1805.8476,13.5300))
				{
					format(string, sizeof(string), "[公交车司机] 公交车到了	的士站.");
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
  		ShowPlayerDialog(playerid,8889, DIALOG_STYLE_LIST, "车辆菜单", "打开引擎\n关闭引擎\n打开车灯\n关闭车灯", "完成", "返回");
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
		{//飞机出口
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
					SendClientMessage(playerid,	0x0D7792AA,	"你把门打开了~请记得关门");
					MoveDynamicObject(gate22, 239.55921936035, 115.10925292969,	1002.2504272461,8);
					MoveDynamicObject(gate23,  239.50939941406,	118.59090423584, 1002.21875,8);
					yymen=1;
					return 1;
				}
				SendClientMessage(playerid,	0x0D7792AA,	"你把门关上了~谢谢");
				MoveDynamicObject(gate22, 239.55921936035, 116.10925292969,	1002.2504272461,8);
				MoveDynamicObject(gate23, 239.50939941406, 117.59090423584,	1002.21875,8);
				yymen=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
					SendClientMessage(playerid,	0x0D7792AA,	"你把门打开了~请记得关门");
					MoveDynamicObject(gate24,  239.56811523438,	122.58466339111, 1002.21875,8);
					MoveDynamicObject(gate25,  239.62255859375,	126.07441711426, 1002.21875,8);
					yymen1=1;
					return 1;
				}
				SendClientMessage(playerid,	0x0D7792AA,	"你把门关上了~谢谢");
				MoveDynamicObject(gate24,239.56811523438, 123.58466339111, 1002.21875,8);
				MoveDynamicObject(gate25, 239.62255859375, 125.07441711426,	1002.21875,8);
				yymen1=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
					SendClientMessage(playerid,	0x0D7792AA,	"你把门打开了~请记得关门");
					pdmen=1;
					return 1;
				}
				MoveDynamicObject(gate11,244.80754089355, 72.450500488281, 1002.640625,8);
				MoveDynamicObject(gate12, 246.2579498291, 72.445793151855, 1002.640625,8);
				SendClientMessage(playerid,	0x0D7792AA,	"你把门关上了~谢谢");
				pdmen=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
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
					SendClientMessage(playerid,	0x0D7792AA,	"你把门打开了~请记得关门");
					pdmen1=1;
					return 1;
				}
				DestroyDynamicObject(gate13);
				DestroyDynamicObject(gate14);
		        gate13=CreateDynamicObject(1500, 250.66600036621, 63.249282836914, 1002.640625,	0, 0, 270);
		        gate14=CreateDynamicObject(1500, 250.60919189453, 64.719268798828, 1002.640625,	0, 0, 270);
				SendClientMessage(playerid,	0x0D7792AA,	"你把门关上了~谢谢");
				pdmen1=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
			return 1;
		}
		if(XY(2,playerid,250.65625,	67.820426940918, 1005.1415405273)==1)
		{
			if(playerzuzhi[playerid]==3)
			{
				if(pdmen2==0)
				{
					MoveDynamicObject(gate15,250.65625,	67.820426940918, 996.1415405273,24);
					SendClientMessage(playerid,	0x0D7792AA,	"你把窗帘拉开了~请记得关上");
					pdmen2=1;
					return 1;
				}
				MoveDynamicObject(gate15,250.65625,	67.820426940918, 1005.1415405273,24);
				SendClientMessage(playerid,	0x0D7792AA,	"你把窗帘拉上了~谢谢 ");
				pdmen2=0;
				return 1;
			}
			SendClientMessage(playerid,0xFF0000FF,"你没有钥匙");
			return 1;
		}
/*if(playerzuzhi[playerid]==3)
{
If(PlayerToPoint(x,y,z,));//入口坐标
{
SetPlayerPos(playerid,x,y,z);//出口坐标
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
						SendClientMessage(playerid,	0xFFFFF0FF,"这间房子被锁住了!");
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
					if(strcmp(ZFJGSTR[u],"未出售")!=0)
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
							SendClientMessage(playerid,	0xFFFFF0FF,"这间房子被锁上了！");
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
		SendClientMessage(playerid,0x00FF00AA,"暴动系统:结束暴动，暴动成功!!!");
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
		format(msg,128,"[管理员注意]:<[%d:%d:%d]A点运送>%s交货了",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"你成功的将货运到了指定点,获得了2500元!");
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
		format(msg,128,"[管理员注意]:<[%d:%d:%d]B点运送>%s交货了",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"你成功的将货运到了指定点,获得了4000元!");
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
		format(msg,128,"[管理员注意]:<[%d:%d:%d]50材料点>%s交货了",h,m,s,name);
		ABroadCast(0x00FF00AA,msg,1);
		SendClientMessage(playerid,0x00FF00AA,"你成功的将货运到了指定点,获得了50材料!");
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
public sjd()//经验增长函数 BY GTAYY
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
SendClientMessage(sc,0xCECECEFF,"┏━━━┳━━━━━┳━━┓");
SendClientMessage(sc,0xCECECEFF,"┣━━━┛SC银行账单┗━━┫");
SendClientMessage(sc,0xCECECEFF,"┃　你的固定工资：５００　┃");
SendClientMessage(sc,0xCECECEFF,"┃　政府补贴了你：３００　┃");
if(playerzuzhi[sc]!=0)
{
SendClientMessage(sc,0xCECECEFF,"┃　　组织资金：１０００　┃");
}
SendClientMessage(sc,0xCECECEFF,"┣━━━━━━━━━━━━┫");
    if(playerzuzhi[sc]!=0)
    {
    SendClientMessage(sc,0xCECECEFF,"┃　共得工资：１８００　　┃");
    }
else
    {
    SendClientMessage(sc,0xCECECEFF,"┃　　共得工资：８００　　┃");
    }
if(playerviplv[sc]!=0)
{
SendClientMessage(sc,0xCECECEFF,"┃　ＶＩＰ奖金：３０００　┃");
playermoney[sc]=playermoney[sc]+3000;
ResetPlayerMoney(sc);
GivePlayerMoney(sc,playermoney[sc]);
}
SendClientMessage(sc,0xCECECEFF,"┗━━━━━━━━━━━━┛");
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
public SpawonDJ(playerid)//冻结锁定
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
public Aftersave(playerid)//服务器退出保存BY Kiva_Ws
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
public Duquplayer(playerid)//读取玩家资料- -
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
public Onplayerregister(playerid, inputtext[])//当玩家注册后- -
{
	new	msg[128];
	new	SFZIDB=330000000000000000;
	new	sfzid;
 new	sdi;
 SL[playerid]=1;
	format(playermima[playerid],128,"%s",inputtext);
	playerzuzhi[playerid]=0;
	playerzuzhilv[playerid]=0;
	format(msg,128,"你成功的办理了身份证,编号为:%d,姓名为:%s .希望你能够遵守我的中国心的法律法规",playersfz[playerid],playername[playerid]);
 format(msg,128,"你获得了政府资助你的8500元资金,并将5000元打入了你的银行账户中.请注意查收.");
 liaotiantext[playerid]=Create3DTextLabel("R	C R	P Y M T",0xF8F8FFFF,30.0,40.0,50.0,15.0,0);
	SendClientMessage(playerid,	0xFFFF00AA,	msg);
	SetSpawnInfo(playerid,0,0,zuzhichushengx[playerzuzhi[playerid]],zuzhichushengy[playerzuzhi[playerid]],zuzhichushengz[playerzuzhi[playerid]],zuzhichushenga[playerzuzhi[playerid]],0,0,0,0,0,0);
	SetPlayerInterior(playerid,zuzhichushenghj[playerzuzhi[playerid]]);
	SpawnPlayer(playerid);
	sdi = GetPlayerPing(playerid);//身份证
	sfzid = playercall[playerid]+SFZIDB+sdi;//身份证
	playersfz[playerid] = sfzid+1;//身份证
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
	format(msgg,128,"[ID:%d]%s办理了入境手续",playerid,name);
	ABroadCast(0x98FB98FF,msgg,1);
 if(playerskin[playerid]==0)
 {
 SendClientMessage(playerid, COLOR_LIGHTRED, "[系统提示]:欢迎来到我的中国心，你被送到移民局进行户籍登记.");
 SendClientMessage(playerid, COLOR_GREY, "你好!欢迎来到移民中心，我现在问你几个问题.");
 SendClientMessage(playerid, COLOR_LIGHTRED, "提示: 请你认真填写!我们不会泄露你的资料的!");
 new listitems[] = "{FF0000}男\n{FF00FF}女";
 ShowPlayerDialog(playerid,8525,DIALOG_STYLE_LIST,"你的性别:",listitems,"确定","取消");
 return 1;
 }
 playerskin[playerid]=zuzhiskin[playerzuzhi[playerid]][random(5)];
	SetPlayerSkin(playerid,playerskin[playerid]);
	return 1;
}
forward	Onplayerlogin(playerid,	inputtext[]);
public Onplayerlogin(playerid, inputtext[])//当玩家登陆后- -
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
			format(msg,128,"欢迎回到我的中国心~{FF0000} %s (%d)",playername[playerid],playerid,SCRIPT_VERSION);
			SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			format(msg,128,"[金钱]:%d [等级]:%d	[组织]:%s [材料]:%d [工作]:%s [存款]:%d [VIP等级]:%d [V豆余额]:%d",playermoney[playerid],playerlv[playerid],zuzhiname[playerzuzhi[playerid]],playermats[playerid],gongzuoname[playerjob[playerid]],playerbank[playerid],playerviplv[playerid],playervdou[playerid]);
			SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			//format(msg,128,"[饥饿]:%d [口渴]:%d",playerjiedu[playerid],playerkouke[playerid]);
			//SendClientMessage(playerid,	0xFFFFFFFF,	msg);
			SendClientMessage(playerid,	0xFFFFFFFF,	"详细资料请使用'/stats'查看，谢谢！");
			if(playeradmin[playerid]>=1)
			{
				format(msg,128,"您登陆了 %d 级别管理员账户.",playeradmin[playerid]);
				SendClientMessage(playerid,	0x008040FF,	msg);
			}
			if(playerviplv[playerid]>=1)
			{
				format(msg,128,"您登陆了 %d 级VIP账户.",playerviplv[playerid]);
				SendClientMessage(playerid,	0x008040FF,	msg);

			}
			format(msg,128,"===================================================================");
			SendClientMessage(playerid,	0x008040FF,	msg);
		    //kouchujike[playerid] = SetTimerEx("koujike",240000,1,"d",playerid);
			ShowPlayerDialog(playerid,265,DIALOG_STYLE_MSGBOX,"此次更新:","{FF0000}我的中国心，强势归来。能有今日，一路有你！","继续","");
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
//format(msg,128,"|+通缉+|%s被通缉了,通缉等级:%d,理由:非法携带枪支",name1,su[playerid]);
//AdminXX(3,msg,COLOR_RED);
//format(msg,128,"你由于非法携带枪支所以被通缉了！目前通缉等级:%d",su[playerid]);
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
				format(ak,128,"尊贵的VIP:%s 进入了中国心小镇.",name);
				SendClientMessageToAll(0xFFFF00AA,ak);
				SetPlayerColor(playerid,COLOR_RED);
			}
			else
			{
                GetPlayerName(playerid,name,128);
			    format(msgg,128,"[ID:%d]%s 进入了中国心小镇.",playerid,name);
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
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"错误","密码错误，请重新输入!","登录","退出");
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
				ShowPlayerDialog(playerid,0,DIALOG_STYLE_INPUT,"欢迎来到我的中国心","请输入密码注册您的帐号!","注册","退出");
				return 1;
			}

		SendClientMessage(playerid, 0x99FFFFAA, "加载完毕！赶快输入密码进入游戏吧！");
			ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"欢迎来到我的中国心","请输入您的密码,进入游戏吧!","登录","退出");
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
	printf("成功读取 %i 个测速表.",loaded_cameras);
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
								SendClientMessageEx(a,0xFF1E00FF,"sisis","你驾驶速度达到 ",speed,"km/h	你超速了,被监控拍下,这里限速为	",limit, "km/h.");
								SendClientMessageEx(a,0xFF1E00FF,"sis","本次超速罚单 $",SpeedCameras[b][_fine],".");
							 //SendClientMessageEx(a,0xFF1E00FF,"sis"," 你已经累计罚单 $",Account[a][_fine],",请尽快去警局窗口缴纳罚款以避免驾照被吊销/payfine.");
       } else {
								SendClientMessageEx(a,0xFF1E00FF,"sisis","你驾驶速度达到 ",speed,"mp/h	你超速了,被监控拍下,这里限速为	",limit, "mp/h.");
								SendClientMessageEx(a,0xFF1E00FF,"sis","本次超速罚单 $",SpeedCameras[b][_fine],".");
							 //SendClientMessageEx(a,0xFF1E00FF,"sis"," 你已经累计罚单 $",Account[a][_fine],",请尽快去警局窗口缴纳罚款以避免驾照被吊销/payfine.");
       }
							//GivePlayerMoney(a, - SpeedCameras[b][_fine]);
							if (playerbank[a] <= SpeedCameras[b][_fine])
							{
							new tjmsg[256];
							new name1[256];
							SendClientMessage(a,0x00FF00AA,"你的银行存款已经不足以缴纳罚款，你被通缉了!");
							GetPlayerName(a,name1,256);
							su[a]=su[a]+1;
							format(tjmsg,128,"[通缉]%s被通缉了！通缉等级:%d,理由:银行存款不足以交纳交通罚款!",name1,su[a]);
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
	SendClientMessage(playerid,0x00FF00AA,"你花了2000元买了一件新衣服!");
}

public OnPlayerExitVehicle(playerid, vehicleid)
{

    new driver = GetVehicleDriver(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && TotalFare[driver] > 0)
	{
	new money = floatround(TotalFare[driver]);
	new message[128];
    format(message,sizeof(message),"您已支付 %d 元给出租车司机",money);
	GivePlayerMoney(playerid,-money);
	playermoney[playerid] -= money;
	TotalFare[driver] = 0;
	TextDrawSetString(taxithisfare[driver],"All money: N/A");
	GivePlayerMoney(driver,money);
	playermoney[playerid] += money;
	SendClientMessage(playerid,COLOR_LIGHTBLUE,message);
	format(message,sizeof(message),"%s 已经支付你 %d 元乘坐你的出租车.",GetPlayerNameEx(playerid),money);
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
	else if(page == 2)return PlayerTextDrawSetString(playerid,TabletWin8Pag2,"MESSAGES"), ShowPlayerDialog(playerid, DIALOG_TABLETCHAT, DIALOG_STYLE_INPUT, "{FF0000}玩家ID", "输入玩家ID", "查找", "取消"),ShowPagForItems(playerid),TextDrawHideForPlayer(playerid,TabletWin8Pag[1]);
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
