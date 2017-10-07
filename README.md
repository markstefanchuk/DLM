# DLM
Displace Metric - MDL Command for MicroStation V8i

<p>
DLM or DL Metric is one of the first MDLs I wrote for production. The program has two commands MM = turn on metric conversion, UE = turn off metric conversion.
</p>
<p>
Use Case: The MM command will allow the user to take metric measurement, say 1000mm and use it in a dl key-in, but in a file with English units. Let’s say you want to draw a line with MicroStation. You start the place line command and then click the first point, then you might (old school) use a dl= command to tell MicroStation where the endpoint. For example, dl=1000 would normally put the end point at 1000 feet (or master units) along the x axis from the start point. But, when MM command is on, the line is placed at 3.2808 feet along the X axis. 
</p>

## Load The MDL

<p>
LOAD: MDL LOAD DLM<br>
</p>

## Commands
<p>
MM – turns on metric conversion to take displacements in mm, but draw them in feet (or automatically convert them) and then enter the displacement. This command is intended to be used in conjunction with DL= command and usually place line command.
<br><br>
UE – turns off the conversion (the MM command) 
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
