/*----------------------------------------------------------------------------*\
                              =====================
                               YSI - Version Check
                              =====================
Description:
	Checks online to see if there is a newer version of YSI available.
Legal:
	Version: MPL 1.1
	
	The contents of this file are subject to the Mozilla Public License Version 
	1.1 (the "License"); you may not use this file except in compliance with 
	the License. You may obtain a copy of the License at 
	http://www.mozilla.org/MPL/
	
	Software distributed under the License is distributed on an "AS IS" basis,
	WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
	for the specific language governing rights and limitations under the
	License.
	
	The Original Code is the YSI version check include.
	
	The Initial Developer of the Original Code is Alex "Y_Less" Cole.
	Portions created by the Initial Developer are Copyright (C) 2011
	the Initial Developer. All Rights Reserved.
	
	Contributors:
		ZeeX, koolk, JoeBullet/Google63, g_aSlice/Slice
	
	Thanks:
		JoeBullet/Google63 - Handy arbitrary ASM jump code using SCTRL.
		ZeeX - Very productive conversations.
		koolk - IsPlayerinAreaEx code.
		TheAlpha - Danish translation.
		breadfish - German translation.
		Fireburn - Dutch translation.
		yom - French translation.
		50p - Polish translation.
		Zamaroht - Spanish translation.
		Dracoblue, sintax, mabako, Xtreme, other coders - Producing other modes
			for me to strive to better.
		Pixels^ - Running XScripters where the idea was born.
		Matite - Pestering me to release it and using it.
	
	Very special thanks to:
		Thiadmer - PAWN, whose limits continue to amaze me!
		Kye/Kalcor - SA:MP.
		SA:MP Team past, present and future - SA:MP.
	
Version:
	0.2
Changelog:
	26/10/10:
		Added changelog capabilities.
	22/10/10:
		First version.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		-
	Static:
		-
	Inline:
		-
	API:
		-
	Hooks:
		OnGameModeInit
Callbacks:
	-
Definitions:
	-
Enums:
	-
Macros:
	-
Tags:
	-
Variables:
	Global:
		-
	Static:
		-
Commands:
	-
Compile options:
	-
Operators:
	-
Natives:
	-
\*----------------------------------------------------------------------------*/

#if defined _YSI_NO_VERSION_CHECK
	#endinput
#endif

#include <a_samp>
#tryinclude <a_http>

#if MAX_PLAYER_NAME != (24)
	#error Unknown MAX_PLAYER_NAME size.
#else
	// Strip the brackets off.
	#undef MAX_PLAYER_NAME
	#define MAX_PLAYER_NAME 24
#endif

#include <YSI\y_scriptinit>

#define YSI_VERSION_RESPO               2

#define YSI_VERSION_MAJOR               1
#define YSI_VERSION_MINOR               04
#define YSI_VERSION_BUILD               0000

#define YSI_VERSION                     #YSI_VERSION_MAJOR "." #YSI_VERSION_MINOR "." #YSI_VERSION_BUILD

/*----------------------------------------------------------------------------*\
Hook:
	OnScriptInit
Notes:
	Constructor.  Checks to see if there is a new version available.  This code
	can not use ANY of the rest of YSI as it needs to be included by everything
	first.
\*----------------------------------------------------------------------------*/

#if !defined _inc_a_http

	public OnScriptInit()
	{
		CallLocalFunction("YVers_OnScriptInit", "");
		return 1;
	}
	
	#undef OnScriptInit
	#define OnScriptInit YVers_OnScriptInit
	forward OnScriptInit();
	
	#endinput
#endif

forward YVers_Callback(index, code, data[]);

public OnScriptInit()
{

	// Call my server to check the current public YSI version.  v is the current
	// version and c is the version of data response which this code can parse.
	// Note that the response data SHOULD be backward compatible, but may not
	// always be - hence the accept parameter.  This will never send any data
	// except the current version for targeted replies (e.g. to ignore minor
	// updates which aren't critical).  It MAY in the future send what libraries
	// are in use so that it only tells you to upgrade if the libraries you are
	// using have changed, but that will take more work and I'm not going to do
	// that for now (I'm not entirely sure exactly how to do it (though I have
	// an idea - note to self: chain callbacks from repeated inclusions of this
	// file in the same way as ALS then call them BEFORE sending the HTTP)).
	// Note that due to the way the internet works the server will know the IP
	// of the server which sent the request, but the ENTIRE current contents of
	// the remote page are (note: I won't update this comment every time the
	// version updates, but that's the gist of it):
	//  
	//  1
	//  1.01.0000
	//  
	// This remote script has now been updated to include changelog information.
	HTTP(0, HTTP_GET, "ysi-version.y-less.com/index.php?c=" #YSI_VERSION_RESPO "&v=" YSI_VERSION, "", "YVers_Callback");
	CallLocalFunction("YVers_OnScriptInit", "");
	return 1;
}

#undef OnScriptInit
#define OnScriptInit YVers_OnScriptInit
forward OnScriptInit();

/*----------------------------------------------------------------------------*\
Function:
	YVers_Callback
Params:
	index - Not used.
	code - Response code from the server.
	data[] - HTTP data sent from the server.
Return:
	-
Notes:
	This is called when my server responds to the HTTP request sent above (or
	when it doesn't).  This prints information on the current and any future
	versions of YSI.  Note that it only does a strcmp to determine if the
	version is newer - people can't have versions newer than the latest, only
	older or equal (unless they play with the version numbers, but then that's
	their own fault).
\*----------------------------------------------------------------------------*/

public YVers_Callback(index, code, data[])
{
	print(" ");
	if (code == 200)
	{
		// Got the remote page.
		// The first line is the version data version.  This should be forward
		// compatible, so new data is always added to the end of the file.
		// Skip the first line - contains the response version.
		new
			pos = strfind(data, "\n") + 1;
		if (strcmp(data[pos], YSI_VERSION, false, 9))
		{
			//data[pos + 9] = '\0';
			print(" ========================================== ");
			print(" |                                        | ");
			printf(" |  A new version (v%.9s) of YSI is  | ", data[pos]);
			print(" |            available from:             | ");
			print(" |                                        | ");
			print(" |     www.y-less.com/YSI/YSI_1.0.zip     | ");
			//printf("data[0]: %c", data[0]);
			if (data[0] == '2')
			{
				print(" |                                        | ");
				print(" | Changelog:                             | ");
				// Print the changelog.
				new
					last = pos + 13;
				for ( ; ; )
				{
					pos = strfind(data[last], "\n", false);
					//printf("%d %d %s", last, pos, data[last]);
					if (pos == -1)
					{
						// To break out in the middle of a loop.
						break;
					}
					pos += last;
					data[pos - 1] = '\0';
					printf(" | %38s | ", data[last]);
					last = pos + 1;
				}
			}
			print(" |                                        | ");
			print(" ========================================== ");
		}
		else
		{

		}
	}
	else
	{

	}
	print(" ");
}
