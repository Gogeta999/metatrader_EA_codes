#property copyright "Just Ash"
#property link      "Ash Link"
#import "kernel32.dll"
//#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
string SymbolArray[];
int SuccessOrderCount;
int ticket = -1;
// If 1 means Buy Order
// If 0 means Sell Order
// Default is 1
input int buy_or_sell = 1; // 1 = Buy Order, 0 = Sell Order
void openAllSymbolsOrder() {
   int totalNumberOfSymbols;
   int intSymbolCounter;
   
   //CaptureAllSymbol will only capture those symbols shown in MarketWatch windows
   //CaptureAllSymbol will show all symbols offer by broker.
   bool captureAllSymbol;
   captureAllSymbol=false;
   
   totalNumberOfSymbols = SymbolsTotal(captureAllSymbol);
   Print("Total Number Of Symbols = " +totalNumberOfSymbols);
  
   //Loop All Symbols
   Print("---Loop All Symbols---");
   for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
   {
   //Resize Array
   ArrayResize(SymbolArray,intSymbolCounter+1);
   SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
   //Print("Why Not Write")
  // int file_handle = FileOpen(FILESFolderPath2+"\\"+fileName, FILE_READ|FILE_WRITE|FILE_CSV);
   Print(intSymbolCounter + " symbol name " + SymbolArray[intSymbolCounter]);
   //--- get minimum stop level
   double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   //TODO: Need To Switch to Bid Price
   double ask_price=Ask;
   double bid_price = Bid;
 
   //--- place market order to buy 1 lot
   if(buy_or_sell==1)
     {
       ticket=OrderSend(SymbolName(intSymbolCounter, false),OP_BUY,1,ask_price,3, 0, 0,"My order",999,0,clrPurple);
     }
   else
     {
      ticket=OrderSend(SymbolName(intSymbolCounter, false), OP_SELL,1,bid_price,3,0,0," Order's Created By Ash999",999,0,clrPurple);
     }
   if(ticket<0)
     {
      Print("Failed to Buy " + SymbolName(intSymbolCounter, false));
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      {
        Print("OrderSend placed successfully for " + SymbolArray[intSymbolCounter]);
        SuccessOrderCount = SuccessOrderCount + 1;
        Print("SuccessOrderCount = " + SuccessOrderCount);
      }
      

   }

   intSymbolCounter = intSymbolCounter;      
   Print("Total Number Of intSymbolsCounter = " +intSymbolCounter);


}

int OnInit()
  {
//--- create timer
   Print("---Start-To-Open-Orders---");
    openAllSymbolsOrder();
   Print("--Order-Open-Done--");
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
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {

  }
