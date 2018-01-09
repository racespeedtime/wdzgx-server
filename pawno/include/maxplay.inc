#if defined Y_MAX_P
  #endinput
#endif
#define Y_MAX_P

#include <a_samp>

#define PP_NUMBER_FILE "mxp.txt"

/*
native WritePustPlayerNumber()
*/
stock WritePustPlayerNumber() {
	new pustNumber = 0, number = 0, File:fileP;
	if (!fexist(PP_NUMBER_FILE)) {
		fileP = fopen(PP_NUMBER_FILE, io_write);
		if (!fileP) {print("IO 异常+++"); fclose(fileP); return 0;}
		fwrite(fileP,"PustPlayerNumber:\r\n");
		fwrite(fileP,"0\r\n");
		fclose(fileP);
	}
	
 	fileP = fopen(PP_NUMBER_FILE, io_read);
  	if (!fileP) {print("IO 异常+++"); fclose(fileP); return 0;}
	new tmp[64];
	if (!fread(fileP, tmp, sizeof(tmp))) {print("IO 异常+++"); fclose(fileP); return 0;}
	if (fread(fileP, tmp, sizeof(tmp))) {pustNumber = strval(tmp);}
	fclose(fileP);
	
	for (new i = 0; i < MAX_PLAYERS; i++) {
		if (IsPlayerConnected(i)) {
		    number++;
		}
	}
	
	if (pustNumber < number) {
	    new string[256];
	    format(string, sizeof(string), "服务器：当前服务器最高在线人数： {FF0000}%d {FFFF00},突破了历史最高人数： {FF0000}%d{FFFF00}.", number, pustNumber);
		print(string);
	    SendClientMessageToAll(0xFFFF00AA, string);
	    pustNumber = number;
		fremove(PP_NUMBER_FILE);
		
		fileP = fopen(PP_NUMBER_FILE, io_write);
		if (!fileP) {print("IO 异常+++"); fclose(fileP); return 0;}
		fwrite(fileP,"PustPlayerNumber:\r\n");
		format(string, sizeof(string), "%d\r\n", pustNumber);
		fwrite(fileP, string);
		fclose(fileP);
	}
	return number;
}





























