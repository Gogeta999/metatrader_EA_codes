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
bool needToLoad = false;

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
   
   Print("File Start to Create " + fileName);
   //File Name is On Above
   if(FileIsExist(fileName, 0))
   {
      FileDelete(fileName, 0);
   }
  
    int file_handle;
    file_handle = FileOpen(fileName, FILE_READ|FILE_WRITE|FILE_CSV);
    Print("File Name is " + fileName);
    Print("File Handle is " + file_handle);
    Print("File Done");

   // Get File Path
   if(FILESFolderPath!="")
        FILESFolderPath2=FILESFolderPath;
  else
      FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files"; 

   Print("FILESFolderPath2 is " + FILESFolderPath2 + "\\" + fileName);
   Print("TransitFilePath is " + TransitFilePath + "\\" + fileName);
   //Loop All Symbols
   Print("---Loop All Symbols---");
   for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
   //Print("Why Not Write")
  // int file_handle = FileOpen(FILESFolderPath2+"\\"+fileName, FILE_READ|FILE_WRITE|FILE_CSV);
   Print("File Path is " + FILESFolderPath2+"\\"+fileName);
   Print("File_Handle Before New Write Status is " + file_handle);
   if(file_handle!=INVALID_HANDLE)
    {
      Print("Start To Write" + SymbolArray[intSymbolCounter]);
      FileSeek(file_handle, 0, SEEK_SET);
      FileWrite(file_handle, "Symbol", "Bid", "Ask", "Spread", "Time");
      FileSeek(file_handle, 0, SEEK_END);
      FileWrite(file_handle, SymbolArray[intSymbolCounter], SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_BID), SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_ASK), SymbolInfoInteger(SymbolArray[intSymbolCounter], SYMBOL_SPREAD), TimeToString(TimeCurrent(), TIME_MINUTES));
      //FileClose(file_handle);
    }

   Print(intSymbolCounter + " symbol name " + SymbolArray[intSymbolCounter]);
   
   }
   FileClose(file_handle);
   needToLoad = false;
   
   intSymbolCounter = intSymbolCounter;
   Print("Total Symbols = " + intSymbolCounter);
   
   

    
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
   //Print("49 Symbol Should be " + SymbolArray[48]);
   Print("--Init--Done--");
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
   
  datetime time= TimeCurrent();
  string hoursandMinutes= TimeToString(time,TIME_MINUTES);   
                  
  if(hoursandMinutes == "12:00" && needToLoad == true)
  if(TimeCurrent()> 1658923170 && TimeCurrent()< 1658880030){
          Print ("It's Now" + hoursandMinutes);
        getALLSymbols();
        
         } else {
          needToLoad = true;
         }
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {

  }
