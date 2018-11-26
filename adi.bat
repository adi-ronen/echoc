@if (@X)==(@Y) @end /* JScript comment
@echo off
setlocal

for /f "tokens=* delims=" %%v in ('dir /b /s /a:-d  /o:-n "%SystemRoot%\Microsoft.NET\Framework\*jsc.exe"') do (
   set "jsc=%%v"
)

if not exist "%~n0.exe" (
   "%jsc%" /nologo /out:"%~n0.exe" "%~dpsfnx0"
)

%~n0.exe %*

endlocal & exit /b %errorlevel%
*/
//this code is from
//http://stackoverflow.com/questions/28174386/how-can-a-bat-file-be-converted-to-exe-without-third-party-tools
import System;
var words = Environment.CommandLine.Replace(Environment.CurrentDirectory,"");
var arguments:String[] = words.Split(' ');
var output = "";
var foregroundColor = Console.ForegroundColor;
var backgroundColor = Console.BackgroundColor;
var currentBackground=Console.BackgroundColor;
var currentForeground=Console.ForegroundColor;
var colors = ["Bk = Black       ",
			  "B = Blue         ",
			  "G = Green        ",
			  "A = Aqua         ",
			  "R = Red          ",
			  "P = Purple       ",
			  "Y = Yellow       ",
			  "W = White        ",
			  "Gr = Gray        ",
			  "LB = Light Blue  ",
			  "LG = Light Green ",
			  "LA = Light Aqua  ",
			  "LR = Light Red   ",
			  "LP = Light Purple",
			  "LY = Light Yellow",
			  "BW = Bright White"];
var TextColors = {
   "Bk" : '0',
   "B": '1',
   "G": '2',
   "A": '3',
   "R": '4',
   "P": '5',
   "Y" : '6',
   "W" : '7',
   "Gr": '8',
   "LB" : '9',
   "LG" : '10',
   "LA" : '11',
   "LR" : '12',
   "LP" :'13',
   "LY" : '14',
   "BW" : '15'
 };
 
function printHelp( ) {
   print( " " );
   print( arguments[0] + " foreground [-b background] text " );
   print( " " );
   print( "   foreground 		 Text color" );
   print( "   text      		 Text to display" );
   print( "   background (optional) Background color" );
   print( "" );
   print( "Colors :" );
   for (var i = 0; i < colors.length; i= i+2)
   {
		Console.BackgroundColor = i;
		Console.Write( "    " );
		Console.BackgroundColor=currentBackground;
		Console.Write( "  -  "+colors[i]);
		Console.Write("                 ");
		Console.BackgroundColor = i+1;
		Console.Write( "    " );
		Console.BackgroundColor=currentBackground;
		Console.WriteLine( "  -  "+colors[i+1]);
		Console.WriteLine();
   }
}

function errorChecker( e:Error ) 
{
	 print ( "Error Message: " + e.message );
	 Environment.Exit(0);
}

if ( arguments.length < 4 || arguments[1].toLowerCase() == "-help" || arguments[1].toLowerCase() == "/?" )
{
   printHelp();
   Environment.Exit(0);
}

try
{
     foregroundColor=Int32.Parse( TextColors[arguments[2]] );
} 
catch(e)
{
     errorChecker(e);
}

if (arguments[3]=="-b")
{
	try 
	{
		 backgroundColor=Int32.Parse( TextColors[arguments[4]] );
	}
	catch(e)
	{
		 errorChecker(e);
	}
	output = arguments[5];
	for (var arg = 6; arg <= arguments.length-1; arg++ ) 
	{
	output = output + " " + arguments[arg];
	}	
}
else
{
	output = arguments[3];
	for (var arg = 4; arg <= arguments.length-1; arg++ )
	{
		output = output + " " + arguments[arg];
	}
}

Console.BackgroundColor = backgroundColor ;
Console.ForegroundColor = foregroundColor ;
Console.WriteLine(output);
Console.BackgroundColor = currentBackground;
Console.ForegroundColor = currentForeground;