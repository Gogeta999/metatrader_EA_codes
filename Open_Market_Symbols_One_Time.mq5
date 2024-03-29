#property copyright "Just Ash"
#property link      "Ash Link"
#define  EXPERT_MAGIC 999 
//#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
string SymbolArray[];
int SuccessOrderCount;

// If 1 means Buy Order
// If 0 means Sell Order
// Default is 1
input int buy_or_sell = 1; // 1 = Buy Order, 0 = Sell Order
void buyAllSymbols() {
    int totalNumberOfSymbols;
    int intSymbolCounter;
      
    //CaptureAllSymbol will only capture those symbols shown in MarketWatch windows
    //CaptureAllSymbol will show all symbols offer by broker.
    bool captureAllSymbol;
    captureAllSymbol=false;
   
    totalNumberOfSymbols = SymbolsTotal(captureAllSymbol);
    Print("Total Number Of Symbols = ", totalNumberOfSymbols);
  
    //Loop All Symbols
    Print("---Loop All Symbols---");
    for(intSymbolCounter=0; intSymbolCounter<totalNumberOfSymbols; intSymbolCounter++)
    {
    //Resize Array
    ArrayResize(SymbolArray,intSymbolCounter+1);
    SymbolArray[intSymbolCounter] = SymbolName(intSymbolCounter, captureAllSymbol);
    Print(intSymbolCounter, " symbol name ", SymbolArray[intSymbolCounter]);
   
    MqlTradeRequest request = {};
    MqlTradeResult result = {};
    
    //Parameters Of Request
    request.symbol = SymbolArray[intSymbolCounter];
    request.volume = 1;
    
    request.action = TRADE_ACTION_DEAL;
    if(buy_or_sell==1)
      {
       request.price = SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_ASK);
       request.type = ORDER_TYPE_BUY;
      }
    else
      {
       request.price = SymbolInfoDouble(SymbolArray[intSymbolCounter], SYMBOL_BID);
       request.type = ORDER_TYPE_SELL;
      }
    
    request.deviation = 5;
    
    request.comment = "Order that Created By Ash999";
    request.magic = EXPERT_MAGIC;
    if(OrderSend(request, result))
     {
      PrintFormat("retcode=%u deal=%I64u order=%I64u ", result.retcode, result.deal, result.order);
     }
     else
       {
        PrintFormat("OrderSend Error %d", GetLastError());
        Print("See RetCode ", result.retcode);
       }
   }

   intSymbolCounter = intSymbolCounter;      
   Print("Total Number Of intSymbolsCounter = ",intSymbolCounter);


}

int OnInit()
  {
//--- create timer
   Print("---Started-To-Open-Order---");
   buyAllSymbols();
   Print("--OpenOrderDone--");
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
    //---
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {

  }
