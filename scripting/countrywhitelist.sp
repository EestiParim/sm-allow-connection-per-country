/*
 * MIT License
 * 
 * Copyright (c) 2022 nofxD
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <geoip>

public Plugin myinfo =
{
    name = "[SM] Country Whitelist",
    author = "nof + seep",
    description = "Blocks all connections all countries except one.",
    version = "1.0",
    url = "https://github.com/EestiParim/"
};

public void OnPluginStart()
{
    LoadTranslations("whitelist_kick_messages.phrases");
}

public bool OnClientConnect(int client, char[] rejectmsg, int maxlen)
{
    char ip[15];
    char country[45];
    char buffer[200];

    GetClientIP(client, ip, sizeof(ip));
    GeoipCountry(ip, country, sizeof(country));
    Format(buffer, sizeof(buffer), "%t", "Kick message");
    
    if (!StrEqual("Estonia", country))
    {
        strcopy(rejectmsg, maxlen, buffer);
        return false;
    }
    return true;
}
