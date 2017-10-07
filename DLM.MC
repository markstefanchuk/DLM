/*----------------------------------------------------------------------+
|																		|
| name		dlm.mc	 													|
|																		|
| Revision:	01.00.00.01													|
| Date:		1994														|
|																		|
|																		|
| Copyright (c) 1994-2017, Mark Stefanchuk, The Phocaz Group, LLC   	|
| All rights reserved.													|
|																		|
| Redistribution and use in source and binary forms, with or without 	|
| modification, are permitted provided that the following conditions 	|
| are met:																|
|         																|
|   Redistribution of source code must retain the above copyright 		|
|   notice, this list of conditions and the following disclaimer. 		|
|              															|
|   Redistribution in binary form must reproduce the above copyright 	|
|   notice, this list of conditions and the following disclaimer in 	|
|   the documentation and/or other materials provided with the 			|
|   distribution.														|
|           															|
|   Neither name of Mark Stefanchuk, The Phocaz Group, LLC nor the	| 
|   names of its contributors may be used to endorse or promote			|
|   products derived from this software without specific prior          |
|   written permission.													|
|            															|
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 	|
| "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT 		|
| NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS |
| FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS| 
| OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 		|
| SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 		|
| LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF 		|
| USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 		|
| AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,| 
| OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 	|
| OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 		|
| OF SUCH DAMAGE.														|
|																		|
+----------------------------------------------------------------------*/
/*----------------------------------------------------------------------+
|                                   									|
|   Include Files                               						|
|                                  										|
+----------------------------------------------------------------------*/
#include <mdl.h>
#include <ctype.h>
#include <msinputq.h>
#include <mdlio.h>
#include <userfnc.h>
#include <cmdlist.h>
#include <cmdclass.h>
#include <string.h>

#include "dlm.h"
#include "dlmcmd.h"

#include "fdf.fdf"

/*----------------------------------------------------------------------+
|                                   									|
|   convertOff ()                               						|
|   Dummy funtion, used so that dlm can remain loaded.                  |
+----------------------------------------------------------------------*/
Private int convertOff
(
char *stringP
)
    {
    mdlOutput_prompt ("Metric Conversion OFF");
    return(INPUT_ACCEPT);
    }

/*----------------------------------------------------------------------+
|                                   									|
|   convertKeyin ()                               						|
|  This function is designed to read the key-in convert it				|
|  from metric to mm and send it back as a DL keyin						|
+----------------------------------------------------------------------*/
Private int convertKeyin
(
char *stringP
)
    {
    int i, j, k, jay, kay;
    char newString[MAXSTRLENGTH], stringX[MAXSTRLENGTH];
    char stringY[MAXSTRLENGTH], stringZ[MAXSTRLENGTH], teststr[MAXSTRLENGTH];

    mdlOutput_prompt ("Metric Conversion ON");
    
    newString[MAXSTRLENGTH] = NULL;
    stringX[MAXSTRLENGTH] = NULL;
    stringY[MAXSTRLENGTH] = NULL;
    stringZ[MAXSTRLENGTH] = NULL;
    teststr[MAXSTRLENGTH] = NULL;

    // get first 3 characters of string to test for dl=
    for (i=0; i<4 && stringP != '\0'; i++)
        teststr[i] = stringP[i];

    // break apart string into its x,y,z coords
    jay = 0;
    kay = 0;
    for (i=0; i<MAXSTRLENGTH && stringP[i] != ','; i++)
        stringX[i] = stringP[i];
    for (j=i+1; j<MAXSTRLENGTH && stringP[j] != ','; j++)
        {
        stringY[jay] = stringP[j];
        jay = jay + 1;
        }
    for (k=j+1; k<MAXSTRLENGTH && stringP[k] != '\0'; k++)
        {
        stringZ[kay] = stringP[k];
        kay = kay + 1;
        }
    // added 7/25/94: If di= then convert, else check for dl=
    if (strstr(teststr,"di=") != NULL || strstr(teststr, "DI=") != NULL)
        {
        // reassemble the string with x divided by mm/ft and dir (y) same
        if (stringX != NULL) 
           {
           strcat (newString, stringX);
           strcat (newString, "/304.8,");
           }
        else
           strcat (newString, "dl=,");

        if (stringY != NULL) 
           {
           strcat (newString, stringY);
           }
        
        strcpy (stringP, newString);

        }
        
    // if dl= is the keyin, go ahead and make conversion. else skip
    if (strstr(teststr,"dl=") != NULL || strstr(teststr, "DL=") != NULL)
        {
        // reassemble the string with x,y,z divided by mm/ft
        if (stringX != NULL) 
           {
           strcat (newString, stringX);
           strcat (newString, "/304.8,");
           }
        else
           strcat (newString, "dl=,");

        if (stringY != NULL) 
           {
           strcat (newString, stringY);
           strcat (newString, "/304.8,");
           }

        if (stringZ != NULL) 
           {
           strcat (newString, stringZ);  
           strcat (newString, "/304.8");  
           }

        strcpy (stringP, newString);

        }
    //if something goes wrong, show me the new string
    mdlOutput_prompt (stringP);
    
    return(INPUT_ACCEPT);
    }

/*----------------------------------------------------------------------+
|                                   									|
|  dlm_dontConvert                               						|
|  Turns the command interpreter off.									|
+----------------------------------------------------------------------*/
Private void	dlm_dontConvert
(
void
)
cmdNumber CMD_UE
{

    // output message to the command window as a test
    mdlOutput_prompt ("Metric Converter OFF");

    // pass input from command window to conversion function
    mdlInput_setFunction (INPUT_KEYIN_PREPROCESS, convertOff);    
    
}

/*----------------------------------------------------------------------+
|                                   									|
|  dlm_convertMM	                               						|
|																		|
|  This is the command that interprets the metric key in.  It accepts 	|
|  input at the command line like 400,, and converts the 400 to english	|
|  units then it re-inserts it into a dl key in.						|
|																		|
+----------------------------------------------------------------------*/
Private void	dlm_convertMM
(
void
)
cmdNumber CMD_MM
    {

    // output message to the command window as a test
    mdlOutput_prompt ("Metric Conversion ON");
    
    // pass input from command window to conversion function
    mdlInput_setFunction (INPUT_KEYIN_PREPROCESS, convertKeyin);    
    
    }

/*----------------------------------------------------------------------+
|                                   									|
|  main				                               						|
|																		|
|																		|
+----------------------------------------------------------------------*/
void main ()
{
 
    // load the command table
    if (mdlParse_loadCommandTable(NULL) == NULL)
       mdlOutput_error ("Cannot Load Command Table");

}
