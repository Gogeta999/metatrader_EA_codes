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

input string inputFileName="";
string fileName="AverageSpread.csv";
int file_handle;

//TODO: Need to Use Below Three Variables
int currentSpread;
int minSpread;
int maxSpread;
int averageCounter; // counter for average formula

void getAverageSpread() {
   int totalNumberOfSymbols;
   int intSymbolCounter;
   
   //CaptureAllSymbol will only capture those symbols shown in MarketWatch windows
   //CaptureAllSymbol will show all symbols offer by broker.
   bool captureAllSymbol;
   captureAllSymbol=false;
   
   totalNumberOfSymbols = SymbolsTotal(captureAllSymbol);
   Print(averageCounter + 1 + "'s total Number Of Symbols = " +totalNumberOfSymbols);  

    //file_handle = FileOpen(fileName, FILE_READ|FILE_WRITE|FILE_CSV);
    Print("File Name in Tick is " + fileName);
    Print("File Handle in Tick Status is " + file_handle);

   // Get File Path
   if(FILESFolderPath!="")
        FILESFolderPath2=FILESFolderPath;
  else
      FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files"; 

   //Loop All Symbols
   Print("---Loop All Symbols---");
   for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
 
   if(file_handle!=INVALID_HANDLE)
    {
      // Print("Start To Write" + SymbolArray[intSymbolCounter]);
      FileSeek(file_handle, 0, SEEK_SET);
      FileWrite(file_handle, "Symbol", "Bid", "Ask", "Spread", "Time");
      FileSeek(file_handle, 0, SEEK_END);
      FileWrite(file_handle, SymbolArray[intSymbolCounter], SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_BID), SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_ASK), SymbolInfoInteger(SymbolArray[intSymbolCounter], SYMBOL_SPREAD), TimeToString(TimeCurrent(), TIME_MINUTES));
    }

   // Print(intSymbolCounter + " symbol name " + SymbolArray[intSymbolCounter]);
   
   }
   
   intSymbolCounter = intSymbolCounter;
   Print("Total Symbols = " + intSymbolCounter);
   
   

    
    int t=CopyFileW(FILESFolderPath2+"\\"+fileName,TransitFilePath+"\\"+fileName,0);

    t=CopyFileW(FILESFolderPath2+"\\"+fileName,TransitFilePath+"\\"+fileName,0);
    averageCounter = averageCounter + 1;
    Print("Done Loop Again and Count As " + averageCounter + " Times");
}

int OnInit()
  {
    if(IsDllsAllowed()==false)
      Alert("Please allow calls to dynamic link libraries");
//---
   Print("---On-Init-and-Create-Folder---");
   if(inputDirectoryName=="" )
     {
      CreateDirectoryW( defaultDirectoryName, 0);
      directoryName= defaultDirectoryName;
      Print("---Default Directory Name is ---" + directoryName);
      TransitFilePath=directoryName;
     }
   else
     {
      CreateDirectoryW(inputDirectoryDrive + inputDirectoryName,0);
      directoryName= inputDirectoryDrive + inputDirectoryName;
      Print("---Input Directory Name is ---" + directoryName);
      TransitFilePath=directoryName;
     }

     if(inputFileName=="")
       {
        fileName=fileName;
        Print("---Default File Name is ---" + fileName);
       }
     else
       {
        fileName=inputFileName;
        Print("---Input File Name is ---" + fileName);
       }

      if(FileIsExist(fileName, 0))
      {
        FileDelete(fileName, 0);
      }

      file_handle=FileOpen(fileName, FILE_READ|FILE_WRITE|FILE_CSV);
      Print("---File Name is ---" + fileName);
      Print("---File Status In Init Is---"+ file_handle);
      Print("---Create File Name Done---");

   Print("--Init--Done--");
   OnTick();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  Print("---File Handle Status In Tick Is---" + file_handle);
   getAverageSpread();
  }
//+------------------------------------------------------------------+
