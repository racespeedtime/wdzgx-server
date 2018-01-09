//======================================================
// kiva's ini
//
// (c) Copyright 2010-2011, KIVA_WS
// = =µ°ÌÛÀ´µÄ.
//======================================================


#pragma dynamic 45000 // Change accordingly!!

#if defined MAX_STRING
	#define KINI_MAX_VALUE MAX_STRING
#else
	#define KINI_MAX_VALUE 128
#endif
#define KINI_MAX_KEY 24
#define KINI_MAX_LINE (KINI_MAX_KEY + KINI_MAX_VALUE + 3)
#define KINI_MAX_FILENAME 256
#define KINI_MAX_LINES 256


enum E_CACHE
{
	E_KEY[KINI_MAX_KEY],
	E_VALUE[KINI_MAX_VALUE]
}

enum E_FILE
{
	E_FILENAME[KINI_MAX_FILENAME],
	bool: E_OPEN
}

static gCache[KINI_MAX_LINES][E_CACHE];
static gEmptyCache[E_CACHE];
static gFile[E_FILE];
static gNoFile[E_FILE];


#define KINI_Exist fexist


stock KINI_Open(const filename[])
{
	if (!filename[0]) return false;
	if (gFile[E_OPEN])
	{
		if (!strcmp(gFile[E_FILENAME], filename, true)) return true;
		//return false;
		KINI_Close();
	}
	new File: h;
	h = fopen(filename, io_readwrite);
	if (h)
	{
		KINI_strcpy(gFile[E_FILENAME], filename, KINI_MAX_FILENAME, KINI_MAX_FILENAME);
		new line[KINI_MAX_LINE];
		new ln = -1;
		new separator;
		while (((ln + 1) < KINI_MAX_LINES) && (fread(h, line)))
		{
			ln ++;
			KINI_StripLine(line);
			separator = strfind(line, "=", false);
			if ((line[0] == ';') || (line[0] == '=') || (separator == -1) || (separator > KINI_MAX_KEY))
			{
				if (line[0] == ';')
				{
					KINI_strcpy(gCache[ln][E_VALUE], line, KINI_MAX_VALUE, KINI_MAX_VALUE);
				}
				else
				{
					KINI_strcpy(gCache[ln][E_VALUE][1], line, KINI_MAX_VALUE - 1, KINI_MAX_VALUE - 1);
					gCache[ln][E_VALUE][0] = ';';
				}
				continue;
			}
			KINI_strcpy(gCache[ln][E_KEY], line, separator, KINI_MAX_KEY);
			KINI_strcpy(gCache[ln][E_VALUE], line[separator + 1], KINI_MAX_VALUE, KINI_MAX_VALUE);
			if (!gCache[ln][E_VALUE][0]) gCache[ln][E_VALUE][0] = ' ';
		}
		fclose(h);
		gFile[E_OPEN] = true;
		return 1;
	}
	return 0;
}


stock KINI_Save()
{
	if (!gFile[E_OPEN]) return false;
	new File: h;
	h = fopen(gFile[E_FILENAME], io_write);
	if (h)
	{
		new line[KINI_MAX_LINE];
		new ln = -1;
		while (((ln + 1) < KINI_MAX_LINES) && (gCache[ln + 1][E_VALUE][0]))
		{
			ln ++;
			if (gCache[ln][E_VALUE][0] == ';')
			{
				if (gCache[ln][E_VALUE][1])
				{
					format(line, sizeof(line), "%s\r\n", gCache[ln][E_VALUE]);
					fwrite(h, line);
					continue;
				}
				fwrite(h, "\r\n");
				continue;
			}
			format(line, sizeof(line), "%s=%s\r\n", gCache[ln][E_KEY], gCache[ln][E_VALUE]);
			fwrite(h, line);
		}
		fclose(h);
		return true;
	}
	return false;
}


stock KINI_Close()
{
	if (!gFile[E_OPEN]) return false;
	for (new ln; ln < KINI_MAX_LINES; ln++) gCache[ln] = gEmptyCache;
	gFile = gNoFile;
	return true;
}


stock KINI_ReadString(dest[], const key[], maxlength = sizeof(dest))
{
	if ((!gFile[E_OPEN]) || (!key[0])) return false;
	new ln = -1;
	while (((ln + 1) < KINI_MAX_LINES) && (gCache[ln + 1][E_VALUE][0]))
	{
		ln ++;
		if (gCache[ln][E_VALUE][0] == ';') continue;
		if (!strcmp(gCache[ln][E_KEY], key, false))
		{
			KINI_strcpy(dest, gCache[ln][E_VALUE], KINI_MAX_VALUE, maxlength);
			return true;
		}
	}
	return false;
}


stock KINI_ReadInt(const key[])
{
	new dest[12];
	if (KINI_ReadString(dest, key)) return strval(dest);
	return false;
}


stock Float: KINI_ReadFloat(const key[])
{
	new dest[12];
	if (KINI_ReadString(dest, key)) return floatstr(dest);
	return 0.0;
}


stock KINI_WriteString(const key[], const value[])
{
	if ((!gFile[E_OPEN]) || (!key[0]) || (key[0] == ';') || (strfind(key, "=", false) != -1)) return false;
	new ln = -1;
	while (((ln + 1) < KINI_MAX_LINES) && (gCache[ln + 1][E_VALUE][0]))
	{
		ln ++;
		if (gCache[ln][E_VALUE][0] == ';') continue;
		if (!strcmp(gCache[ln][E_KEY], key, false))
		{
			KINI_strcpy(gCache[ln][E_VALUE], value, KINI_MAX_VALUE, KINI_MAX_VALUE);
			return true;
		}
	}
	ln ++;
	if (ln < KINI_MAX_LINES)
	{
		KINI_strcpy(gCache[ln][E_KEY], key, KINI_MAX_KEY, KINI_MAX_KEY);
		KINI_strcpy(gCache[ln][E_VALUE], value, KINI_MAX_VALUE, KINI_MAX_VALUE);
		return true;
	}
	return false;
}


stock KINI_WriteInt(const key[], value)
{
	new dest[12];
	format(dest, sizeof(dest), "%i", value);
	return KINI_WriteString(key, dest);
}


stock KINI_WriteFloat(const key[], Float: value)
{
	new dest[12];
	format(dest, sizeof(dest), "%0.4f", value);
	return KINI_WriteString(key, dest);
}


stock KINI_RemoveEntry(const key[])
{
	if ((!gFile[E_OPEN]) || (!key[0]) || (strfind(key, "=", false) != -1)) return false;
	new ln = -1;
	while (((ln + 1) < KINI_MAX_LINES) && (gCache[ln + 1][E_VALUE][0]))
	{
		ln ++;
		if (gCache[ln][E_VALUE][0] == ';') continue;
		if (!strcmp(gCache[ln][E_KEY], key, false))
		{
			for (; ln < (KINI_MAX_LINES - 1); ln ++)
			{
				KINI_strcpy(gCache[ln][E_KEY], gCache[ln + 1][E_KEY], KINI_MAX_KEY, KINI_MAX_KEY);
				KINI_strcpy(gCache[ln][E_VALUE], gCache[ln + 1][E_VALUE], KINI_MAX_VALUE, KINI_MAX_VALUE);
			}
			return true;
		}
	}
	return false;
}


stock KINI_Remove(const filename[])
{
	if (!filename[0]) return false;
	if ((gFile[E_OPEN]) && (!strcmp(gFile[E_FILENAME], filename, true))) gFile = gNoFile;
	return fremove(filename);
}


stock KINI_strcpy(dest[], const source[], numcells = sizeof(source), maxlength = sizeof(dest))
{
	new i;
	while ((source[i]) && (i < numcells) && (i < maxlength))
	{
		dest[i] = source[i];
		i ++;
	}
	dest[(i == maxlength) ? (i - 1) : (i)] = '\0';
}


stock KINI_StripLine(string[])
{
	new l;
	l = strlen(string);
	if (string[l - 2] == '\r') string[l - 2] = '\0';
	if (string[l - 1] == '\n') string[l - 1] = '\0';
}




