//+------------------------------------------------------------------+
//|                                                              Ash |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Ash"
#property link "Ash Link"
#import "kernel32.dll"
int CopyFileW(string a0,string a1,int a2);
bool CreateDirectoryW(string a0,int a1);
string TransferFileName="";
input string FILESFolderPath="";
string FILESFolderPath2;
input string TransitPath="";
string TransitPath2="";
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
int OnInit()
  {
   if(IsDllsAllowed()==false)
      Alert("Please allow calls to dynamic link libraries");
   OnTick();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Comment("");
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
void OnTick()
  {
  
  
   if(IsDllsAllowed()==false)
      return;

   if(TransitPath=="")
     {
      CreateDirectoryW("E:\\CopyTrade",0);
      TransitPath2="E:\\CopyTrade2";
     }
   else
      TransitPath2=TransitPath;

   while(true)
     {
      Comment("Loop");
      TransferFileName=DoubleToStr(AccountNumber(),0);

      RefreshRates();
      int handle;
      handle=FileOpen(TransferFileName+".csv",FILE_CSV|FILE_WRITE|FILE_SHARE_WRITE|FILE_SHARE_READ,';');
      if(handle>0)
        {
        

         for(int i=0;i<OrdersTotal();i++)
            if(OrderSelect(i,SELECT_BY_POS))
              {
               string name=OrderSymbol();
        
               name=StringSubstr(OrderSymbol(),0,6);
               if(StringFind(name,"GOLD",0)==0)
                  name="GOLD";
    
               FileWrite(handle,OrderTicket(),name,OrderType(),OrderLots(),OrderStopLoss(),
                         OrderTakeProfit(),OrderComment(),OrderMagicNumber(),
                         OrderOpenTime()-TimeCurrent()+TimeLocal(),OrderOpenPrice(),MarketInfo(OrderSymbol(),MODE_TICKVALUE));

              }
         FileClose(handle);
        }

      handle=FileOpen(TransferFileName+"2.csv",FILE_CSV|FILE_WRITE|FILE_SHARE_WRITE|FILE_SHARE_READ,';');
      if(handle>0)
        {
         for(i=OrdersHistoryTotal();i>=0;i--)
            if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
               if(OrderType()<6)
                 {
                  FileWrite(handle,OrderTicket(),OrderSymbol(),OrderType(),OrderLots(),OrderStopLoss(),OrderTakeProfit(),OrderComment(),OrderMagicNumber(),OrderOpenTime()-TimeCurrent()+TimeLocal(),OrderOpenPrice());
                 }
         FileClose(handle);
        }

      if(FILESFolderPath!="")
         FILESFolderPath2=FILESFolderPath;
      else
         FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files";

      int t=CopyFileW(FILESFolderPath2+"\\"+TransferFileName+".csv",TransitPath2+"\\"+TransferFileName+".csv",0);

      t=CopyFileW(FILESFolderPath2+"\\"+TransferFileName+"2.csv",TransitPath2+"\\"+TransferFileName+"2.csv",0);

      if(!(!IsStopped() && IsExpertEnabled() && IsTesting()==false && IsOptimization()==false))
         return;
      Sleep(300);
     }
   return;
  }

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
  OnTick(); 
  }