# DLM
Displace Metric - MDL Command for MicroStation V8i

<p>
An early CADGURUS free downloads. DBK draws a duct break (or continuation) between two points. 
The command does not use dynamic display and it uses the active symbology.
</p>

<p>
LOAD: MDL LOAD DBK<br>
COMMAND: DBK<br>
</p>
<p>
There are no prompts – just ID the first point and then the second point. The command will draw the line with the break.
</p>

## Files:
<ul>
<li>DLM.MA – the compiled command for V8i</li>
<li>DLM.H – header file</li>
<li>DLM.MC – main source file</li>
<li>DLMCMD.R – command definition</li>
<li>DLM.MKE – make file used with the MicroStation development shell</li>
<li>Fdf.fdf – listing of include files (lazy way to incorporate include statements). This is NOT and Adobe file.</li>
</ul>

## Compiling The MDL
Use bmake to compile via the MicroStation command window (delivered with the SDK).

Before you do the following, open dlm.mke and change the path for baseDir to point to your MDL programs folder.

Open the command window and cd to MircoStation\mdl\bin\

For a standard MicroStation install, that is C:\Program Files (x86)\Bentley\MicroStation V8i (Selectseries)\MicroStation\mdl\bin\

From this location you can run, bmake -a (path to app)\dlm.mke

For me, bmake -a Z:\Documents\Github\CADGURUS\dlm\dlm.mke
