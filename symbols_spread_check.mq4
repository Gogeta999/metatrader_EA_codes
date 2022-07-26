#property copyright "Just Ash"
#property link      "Ash Link"
#import "kernel32.dll"
//#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int CopyFileW(string a0,string a1,int a2);
bool CreateDirectoryW(string a0,int a1);
input string inputDirectoryName="";
string inputDirectoryDrive="D:\\";
string  defaultDirectoryName="D:\\Group_Spread"; // directory name
string directoryName="";
string SymbolArray[];

// Get File Path
input string FILESFolderPath="";
string FILESFolderPath2;
string TransitFilePath="";

string fileName="SpreadByGroup.csv";
string symbol=NULL;





void getALLSymbols() {
   int totalNumberOfSymbols;
   int intSymbolCounter;
   
   //CaptureAllSymbol will only capture those symbols shown in MarketWatch windows
   //CaptureAllSymbol will show all symbols offer by broker.
   bool captureAllSymbol;
   captureAllSymbol=false;
   
   totalNumberOfSymbols = SymbolsTotal(captureAllSymbol);
   Print("Total Number Of Symbols = " +totalNumberOfSymbols);
   
   //Loop All Symbols
   for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
   
   
   Print(intSymbolCounter + " symbol name " + SymbolArray[intSymbolCounter]);
   }
   intSymbolCounter = intSymbolCounter;
   Print("Total Symbols = " + intSymbolCounter);
   
   //File Name is On Above
   if(FileIsExist(fileName, 0))
   {
      FileDelete(fileName, 0);
   }
    
    int file_handle;
    file_handle = FileOpen(fileName, FILE_READ|FILE_WRITE|FILE_CSV);
    Print("File Name is " + fileName);
    Print("File Done");

    if(FILESFolderPath!="")
        FILESFolderPath2=FILESFolderPath;
    else
        FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files";

    Print("FILESFolderPath2 is " + FILESFolderPath2 + "\\" + fileName);
    Print("TransitFilePath is " + TransitFilePath + "\\" + fileName);
    int t=CopyFileW(FILESFolderPath2+"\\"+fileName,TransitFilePath+"\\"+fileName,0);

    t=CopyFileW(FILESFolderPath2+"\\"+fileName,TransitFilePath+"\\"+fileName,0);

}

int OnInit()
  {
//--- create timer
   Print("---On-Init-and-Create-Folder---");
   if(inputDirectoryName=="" )
     {
      CreateDirectoryW( defaultDirectoryName, 0);
      directoryName= defaultDirectoryName;
      Print("Default Directory Name is" + directoryName);
      TransitFilePath=directoryName;
     }
   else
     {
      CreateDirectoryW(inputDirectoryDrive + inputDirectoryName,0);
      directoryName= inputDirectoryDrive + inputDirectoryName;
      Print("Input Directory Name is" + directoryName);
      TransitFilePath=directoryName;
     }
     getALLSymbols();
     Print("49 Symbol Should be " + SymbolArray[48]);
   Print("--Init-and-Folder-Create-Done--");
//---
   return(INIT_SUCCEEDED);
  }
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //if(IsTradeAllowed()==false)
   //  {
   //   Comment("No Expert Advisor allowed");
   //   return;
   //  }

   if(IsDllsAllowed()==false)
      return;
   
   //getALLSymbols();
   
   //Print("Before Something");
   //symbolTest = SymbolName(1,true);
   //Print("Symbols Are" + symbolTest);
   //---
   

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
