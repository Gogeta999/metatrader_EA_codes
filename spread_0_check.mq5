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
   //Print("Total Number Of Symbols = " ,totalNumberOfSymbols);
   
   //Loop All Symbols
   //Print("---Loop All Symbols---");
   // Just Using Admin Orders to Check Specific Symbol
   for(intSymbolCounter=38; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
 
   //Print("Symbol","  ", "Spread");
   //Print( SymbolArray[intSymbolCounter],"  ",SymbolInfoInteger(SymbolArray[intSymbolCounter], SYMBOL_SPREAD));
   
   if(SymbolInfoInteger(SymbolArray[intSymbolCounter],SYMBOL_SPREAD) <= 10)
   {
      Alert(SymbolArray[intSymbolCounter], " is lower than  10 now");
      SendMail("CFD Spread is Lower Than 10 now", "This Symbol is lower than 10 = " + SymbolArray[intSymbolCounter]);
   }
   
   if(SymbolInfoInteger(SymbolArray[intSymbolCounter],SYMBOL_SPREAD) == 0)
   {
      Alert(SymbolArray[intSymbolCounter], " is match 0 now");
      SendMail("CFD Spread is match 0 now!!!", "This Symbol is equal to 0 = " + SymbolArray[intSymbolCounter]);
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
 //checkALLSymbols();
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

