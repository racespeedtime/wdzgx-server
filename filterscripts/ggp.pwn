#include <a_samp>
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" 我的中国心 广告牌(ggp.pwn) By TL_GTASA");
	print("--------------------------------------\n");
	new wqd1 = CreateObject(19353, -2513.3699,2321.6001,4.9544, 0.0, 0.0, 90.0); //create the object
	SetObjectMaterialText(wqd1, "{FF0000}===武器店===\n沙鹰: 5000\nMP5: 25000\nM4A1: 30000\nAK47: 30000\n如果关门则店主不在\n联系电话:160622", 0, OBJECT_MATERIAL_SIZE_256x128,\"微软雅黑", 15, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	new ggp1 = CreateObject(19353, -2192.805419, 2400.965087, 5.694453, 0.000000, -0.100000, -42.799949);
	SetObjectMaterialText(ggp1, "{FF0000}我的中国心\n开源第{FFFF00}六{FF0000}版", 0, OBJECT_MATERIAL_SIZE_256x128,\"楷体", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}
