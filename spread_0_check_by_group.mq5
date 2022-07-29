//+------------------------------------------------------------------+
//|                                               spread_0_check.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
string SymbolArray[];

void checkALLSymbols() {
   int totalNumberOfSymbols;
   int intSymbolCounter;
   
   //CaptureAllSymbol will only capture those symbols shown in MarketWatch windows
   //CaptureAllSymbol will show all symbols offer by broker.
   bool captureAllSymbol;
   captureAllSymbol=false;
   
   totalNumberOfSymbols = SymbolsTotal(captureAllSymbol);
   Print("Total Number Of Symbols = " ,totalNumberOfSymbols);
   
   //Loop All Symbols
   Print("---Loop All Symbols---");
   for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
   //Print("Why Not Write")
   // int file_handle = FileOpen(FILESFolderPath2+"\\"+fileName, FILE_READ|FILE_WRITE|FILE_CSV);
 
   Print("Start To Write" + SymbolArray[intSymbolCounter]);
   Print("Symbol","  ", "Spread");
   Print( SymbolArray[intSymbolCounter],"  ",SymbolInfoInteger(SymbolArray[intSymbolCounter], SYMBOL_SPREAD));
   if(SymbolInfoInteger(SymbolArray[intSymbolCounter],SYMBOL_SPREAD) == 0)
   {
      Print("---Go---Go---Go---Go---");
      Alert(SymbolArray[intSymbolCounter], " is match 0 now");
   }
   
   Print(intSymbolCounter, " symbol name ", SymbolArray[intSymbolCounter]);
   
   }

   
   intSymbolCounter = intSymbolCounter;      
  

}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
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
   checkALLSymbols();
  }
//+------------------------------------------------------------------+
