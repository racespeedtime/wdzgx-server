#include <a_samp>
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" �ҵ��й��� �����(ggp.pwn) By TL_GTASA");
	print("--------------------------------------\n");
	new wqd1 = CreateObject(19353, -2513.3699,2321.6001,4.9544, 0.0, 0.0, 90.0); //create the object
	SetObjectMaterialText(wqd1, "{FF0000}===������===\nɳӥ: 5000\nMP5: 25000\nM4A1: 30000\nAK47: 30000\n����������������\n��ϵ�绰:160622", 0, OBJECT_MATERIAL_SIZE_256x128,\"΢���ź�", 15, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	new ggp1 = CreateObject(19353, -2192.805419, 2400.965087, 5.694453, 0.000000, -0.100000, -42.799949);
	SetObjectMaterialText(ggp1, "{FF0000}�ҵ��й���\n��Դ��{FFFF00}��{FF0000}��", 0, OBJECT_MATERIAL_SIZE_256x128,\"����", 50, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}
