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

//==============Add function (limit account By xDragon)==============
string mOnlyUserNum="Nothing"; //Fill in the authorized digital account number, separated by spaces, such as: 8888 9999 6666 Note: If you cancel the account authorization limit, please fill in Nothing
string mOnlyPermissionDate="unlimited"; //Fill in the authorization deadline, such as: 2017.1.1 Note: If you cancel the deadline, please fill in 'unlimited'

//========================================================================
input string TrackMasterAccount="";
input string FILESFolderPath="";
input string TransitPath="";
string FILESFolderPath2;
input string CurrencyPairNameAppended="";
input string comm0="---------------------";
input int DocumentaryAllowableSecondError=100;
input double DocumentaryAllowablePointError=100;
input bool TrailingStopLossAndTakeProfit=true;
input bool ReverseCopy=false;
input bool MultiOrderAndAultiPendingOrders=true;
input bool FollowShortOrdersAndEmptyPendingOrders=true;
input bool TrackPendingOrders=true;
input string comm1="---------------------";
input double SingleVolumeRatio=1;
input bool ConvertOrderQuantityAccordingToOrderValue=false;
input bool UsingFixedQuantity=false;
input double FixedQuantity=0.1;
bool MinimumOrderQuantityBelowMinimumOrderQuantity=false;
input string comm2="---------------------";
input int MaximumNumberOfOrders=10000;
input double NumberOfOrdersWithMasterAccountGreaterThanOrEqualNOrders=0;
input double NumberOfOrdersWithMasterAccountGreaterThanOrEqualMOrders=100;
input string comm3="---------------------";
input string CustomSectionNotes="";
input string RemarkMustBeIncludedWhenReceivingTheOrder="";
string TransitPath2="";
input string comm4="--------------------";
input string comm5="---------------------";
input string comm6="---------------------";
input string comm7="---------Used when individual currency pairs cannot be copied normally------------";
input bool CurrencPairNameForcedCorrectionSwitch=false;
input string TheNameOfTheCurrencyPairToFollow1 ="";
input string OrderCurrencyPairName1 ="";
input string TheNameOfTheCurrencyPairToFollow2 ="";
input string OrderCurrencyPairName2 ="";
input string TheNameOfTheCurrencyPairToFollow3 ="";
input string OrderCurrencyPairName3 ="";
input string comm8="---------------------";
input bool LimitedAvailableCurrencyPairs=false;
input string LimitAvailableCurrencyPair1 ="";
input string LimitAvailableCurrencyPair2 ="";
input string LimitAvailableCurrencyPair3 ="";
input string LimitAvailableCurrencyPair4 ="";
input string LimitAvailableCurrencyPair5 ="";
input string LimitAvailableCurrencyPair6 ="";
input string LimitAvailableCurrencyPair7 ="";
input string LimitAvailableCurrencyPair8 ="";
input string LimitAvailableCurrencyPair9 ="";
input string LimitAvailableCurrencyPair10="";
string LimitAvailableCurrencyPairs[100];
input string comm9="---------------------";
input bool LimitedCurrencyPairsThatCannotBeDone=false;
input string RestrictionsNotToBeUsedAsCurrencyPairs1="";
input string RestrictionsNotToBeUsedAsCurrencyPairs2="";
input string RestrictionsNotToBeUsedAsCurrencyPairs3="";
input string RestrictionsNotToBeUsedAsCurrencyPairs4="";
input string RestrictionsNotToBeUsedAsCurrencyPairs5="";
input string RestrictionsNotToBeUsedAsCurrencyPairs6="";
input string RestrictionsNotToBeUsedAsCurrencyPairs7="";
input string RestrictionsNotToBeUsedAsCurrencyPairs8="";
input string RestrictionsNotToBeUsedAsCurrencyPairs9="";
input string RestrictionsNotToBeUsedAsCurrencyPairs10="";
string RestrictionsNotToBeUsedAsCurrencyPairs[100];
input string comm10="---------------------";
input bool WhetherToShowTextLabels=true;
input int magic=0;
input string comm11="---------------------";
//======== Development and Backup Features ===============
bool PriceDisadvantageTurnsToPendingOrder=false;
double MinutesOfBadTransferTendingOrder=10;
bool MandatoryReplenishmentOfSettledAndUndocumentedDocuments=false;
bool TrackPartialClosingDocuments=true;

bool HideNotes=false;
bool OpenPartialClosing=false;
bool DoSinglePCVerification=false;
double  ToMakeAnOrderNeedPriceSwitch=false;
double  OrdersNeedToBeBetterThanPoints=0;

int OrderTicketX[200];
string OrderSymbolX[200];
int OrderTypeX[200];
double OrderLotsX[200];
double OrderStopLossX[200];
double OrderTakeProfitX[200];
string OrderCommentX[200];
int OrderMagicNumberX[200];
datetime OrderOpenTimeX[200];
double OrderOpenPriceX[200];

int OrderTicketXH[200];
string OrderSymbolXH[200];
int OrderTypeXH[200];
double OrderLotsXH[200];
double OrderStopLossXH[200];
double OrderTakeProfitXH[200];
string OrderCommentXH[200];
int OrderMagicNumberXH[200];
datetime OrderOpenTimeXH[200];
double OrderOpenPriceXH[200];

double valuePerPoint[200];
double slippage=100;
//=========================================================================== 
int OnInit()
  {
   LimitAvailableCurrencyPairs [1]=LimitAvailableCurrencyPair1;
   LimitAvailableCurrencyPairs [2]=LimitAvailableCurrencyPair2;
   LimitAvailableCurrencyPairs [3]=LimitAvailableCurrencyPair3;
   LimitAvailableCurrencyPairs [4]=LimitAvailableCurrencyPair4;
   LimitAvailableCurrencyPairs [5]=LimitAvailableCurrencyPair5;
   LimitAvailableCurrencyPairs [6]=LimitAvailableCurrencyPair6;
   LimitAvailableCurrencyPairs [7]=LimitAvailableCurrencyPair7;
   LimitAvailableCurrencyPairs [8]=LimitAvailableCurrencyPair8;
   LimitAvailableCurrencyPairs [9]=LimitAvailableCurrencyPair9;
   LimitAvailableCurrencyPairs[10]=LimitAvailableCurrencyPair10;

   RestrictionsNotToBeUsedAsCurrencyPairs[1]=RestrictionsNotToBeUsedAsCurrencyPairs1;
   RestrictionsNotToBeUsedAsCurrencyPairs[2]=RestrictionsNotToBeUsedAsCurrencyPairs2;
   RestrictionsNotToBeUsedAsCurrencyPairs[3]=RestrictionsNotToBeUsedAsCurrencyPairs3;
   RestrictionsNotToBeUsedAsCurrencyPairs[4]=RestrictionsNotToBeUsedAsCurrencyPairs4;
   RestrictionsNotToBeUsedAsCurrencyPairs[5]=RestrictionsNotToBeUsedAsCurrencyPairs5;
   RestrictionsNotToBeUsedAsCurrencyPairs[6]=RestrictionsNotToBeUsedAsCurrencyPairs6;
   RestrictionsNotToBeUsedAsCurrencyPairs[7]=RestrictionsNotToBeUsedAsCurrencyPairs7;
   RestrictionsNotToBeUsedAsCurrencyPairs[8]=RestrictionsNotToBeUsedAsCurrencyPairs8;
   RestrictionsNotToBeUsedAsCurrencyPairs[9]=RestrictionsNotToBeUsedAsCurrencyPairs9;
   RestrictionsNotToBeUsedAsCurrencyPairs[10]=RestrictionsNotToBeUsedAsCurrencyPairs10;

   for(int ix=0;ix<200;ix++)
     {
      OrderSymbolX[ix]="";
      OrderCommentX[ix]="";
      OrderSymbolXH[ix]="";
      OrderCommentXH[ix]="";
     }
   if(IsDllsAllowed()==false)
      Alert("Please allow calls to dynamic link libraries");
      
   //----------Determine whether to authorize the account----------
   if(isPermission_Account(mOnlyUserNum)==false){
      Alert("This account "+AccountNumber()+" is unauthorized!");
      return(INIT_FAILED);
   }
   //----------Determine whether the authorization expires----------
  if(isPermission_Date(mOnlyPermissionDate)==false){
       Alert("Authorization expired!");
       iSetLabel("PermissionDate","Authorization time: expired",140,19,8,"Verdana",Red);
       return(INIT_FAILED);
    }else{
       iSetLabel("PermissionDate","Authorization time:"+mOnlyPermissionDate,140,19,8,"Verdana",Red);
    }
   
    //------------Start copying------------
   OnTick();
   return(INIT_SUCCEEDED);
  }
//===========================================================================
void OnDeinit(const int reason)
  {
   ObjectsDeleteAll();
   Comment("");
  }
//===========================================================================
void OnTick()
  {
Comment(IsTradeAllowed());
   if(IsTradeAllowed()==false)
     {
      Comment("No Expert Advisor allowed");
      return;
     }

   if(IsDllsAllowed()==false)
      return;

   if(TransitPath=="")
     {
      CreateDirectoryW("D:\\AshCopyTrade",0);
      TransitPath2="D:\\AshCopyTrade";
     }
   else
      TransitPath2=TransitPath;

   while(true)
     {
      RefreshRates();
      ChartRedraw();

      Button("MandatoryReplenishmentOfSettledAndUndocumentedDocuments",500,30,160,20,CORNER_LEFT_UPPER,clrOrangeRed,clrBlack);

      if(ObjectGetInteger(0,"MandatoryReplenishmentOfSettledAndUndocumentedDocuments",OBJPROP_STATE)==1)
         MandatoryReplenishmentOfSettledAndUndocumentedDocuments=true;
      else
         MandatoryReplenishmentOfSettledAndUndocumentedDocuments=false;

       ExtractSignal ();
       ExtractHistoricalSignals();

      ObjectSetInteger(0,"MandatoryReplenishmentOfSettledAndUndocumentedDocuments",OBJPROP_STATE,0);

      Button("Profit is full even greater than",180,90,100,20,CORNER_RIGHT_LOWER,clrSpringGreen,clrBlack);
      EDITLabel("Profits reach full even greater than -2","100000",80,90,60,20,CORNER_RIGHT_LOWER,clrWhite,clrBlack);

      if(ObjectGetInteger(0,"Profit is full even greater than",OBJPROP_STATE)==1)
         if(AccountProfit()>StrToDouble(ObjectGetString(0,"Profits reach full even greater than -2",OBJPROP_TEXT)))
           {
            deleteorder(-100,-1,"");
            ObjectSetInteger(0,"Profit is full even greater than",OBJPROP_STATE,0);
           }

      Button("Loss reaches full even less than",750,30,200,20,CORNER_LEFT_UPPER,clrRed,clrBlack);
      EDITLabel("Loss reaches full even less than -2","-100000",80,60,60,20,CORNER_RIGHT_LOWER,clrWhite,clrBlack);

      if(ObjectGetInteger(0,"Loss reaches full even less than",OBJPROP_STATE)==1)
         if(AccountProfit()<StrToDouble(ObjectGetString(0,"Loss reaches full even less than -2",OBJPROP_TEXT)))
           {
            deleteorder(-100,-1,"");
            ObjectSetInteger(0,"Loss reaches full even less than",OBJPROP_STATE,0);
           }

      for(int ix=GlobalVariablesTotal();ix>=0;ix--)
        {
         int OrderNumberMonitoring=GlobalVariableGet(GlobalVariableName(ix));
         if(OrderSelect(OrderNumberMonitoring,SELECT_BY_TICKET,MODE_HISTORY))
            if(OrderCloseTime()!=0)
               GlobalVariableDel(GlobalVariableName(ix));
        }

      Comment(
             "----------Documentary software receiver------------"+
              "\n----------The copy receiving terminal has been opened---------"+
              "\nHistory0:"+OrderTicketXH[0]+" "+OrderSymbolXH[0]+" "+OrderTypeXH[0]+" "+OrderLotsXH[0]+
              "\nHistory1:"+OrderTicketXH[1]+" "+OrderSymbolXH[1]+" "+OrderTypeXH[1]+" "+OrderLotsXH[1]+
              "\nHistory2:"+OrderTicketXH[2]+" "+OrderSymbolXH[2]+" "+OrderTypeXH[2]+" "+OrderLotsXH[2]+
              "\nHistory3:"+OrderTicketXH[3]+" "+OrderSymbolXH[3]+" "+OrderTypeXH[3]+" "+OrderLotsXH[3]+
              "\nHistory4:"+OrderTicketXH[4]+" "+OrderSymbolXH[4]+" "+OrderTypeXH[4]+" "+OrderLotsXH[4]+
              "\nHistory5:"+OrderTicketXH[5]+" "+OrderSymbolXH[5]+" "+OrderTypeXH[5]+" "+OrderLotsXH[5]+
              "\nHistory6:"+OrderTicketXH[6]+" "+OrderSymbolXH[6]+" "+OrderTypeXH[6]+" "+OrderLotsXH[6]+
              "\n"+
              "\nHold0:"+OrderTicketX[0]+" "+OrderSymbolX[0]+" "+OrderTypeX[0]+" "+OrderLotsX[0]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[0])+" 时间"+TimeToStr(OrderOpenTimeX[0])+
              "\nHold1:"+OrderTicketX[1]+" "+OrderSymbolX[1]+" "+OrderTypeX[1]+" "+OrderLotsX[1]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[1])+" 时间"+TimeToStr(OrderOpenTimeX[1])+
              "\nHold2:"+OrderTicketX[2]+" "+OrderSymbolX[2]+" "+OrderTypeX[2]+" "+OrderLotsX[2]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[2])+" 时间"+TimeToStr(OrderOpenTimeX[2])+
              "\nHold3:"+OrderTicketX[3]+" "+OrderSymbolX[3]+" "+OrderTypeX[3]+" "+OrderLotsX[3]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[3])+" 时间"+TimeToStr(OrderOpenTimeX[3])+
              "\nHold4:"+OrderTicketX[4]+" "+OrderSymbolX[4]+" "+OrderTypeX[4]+" "+OrderLotsX[4]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[4])+" 时间"+TimeToStr(OrderOpenTimeX[4])+
              "\nHold5:"+OrderTicketX[5]+" "+OrderSymbolX[5]+" "+OrderTypeX[5]+" "+OrderLotsX[5]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[5])+" 时间"+TimeToStr(OrderOpenTimeX[5])+
              "\nHold6:"+OrderTicketX[6]+" "+OrderSymbolX[6]+" "+OrderTypeX[6]+" "+OrderLotsX[6]+" Correspond"+CorrespondingRecordHasBeenCopied(OrderTicketX[6])+" 时间"+TimeToStr(OrderOpenTimeX[6])
              );

      ChartRedraw();
      if(!(!IsStopped() && IsExpertEnabled() && IsTesting()==false && IsOptimization()==false))
         return;
      Sleep(300);
     }
   return;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   OnTick();
  }
//+------------------------------------------------------------------+
void EDITLabel(string name,string Content,int XX,int YX,int XL,int YL,int WZ,color A,color B)
  {
   if(ObjectFind(0,name)==-1)
     {
      ObjectCreate(0,name,OBJ_EDIT,0,0,0);
      ObjectSetString(0,name,OBJPROP_TEXT,Content);
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XX);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YX);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,XL);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,YL);
      ObjectSetString(0,name,OBJPROP_FONT,"Microsoft YaHei");
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
      ObjectSetInteger(0,name,OBJPROP_CORNER,WZ);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,A);
      ObjectSetInteger(0,name,OBJPROP_COLOR,B);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Button(string name,int XX,int YX,int XL,int YL,int WZ,color A,color B)
  {
   if(ObjectFind(0,name)==-1)
     {
      ObjectCreate(0,name,OBJ_BUTTON,0,0,0);
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,XX-XL);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,YX-YL);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,XL);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,YL);
      ObjectSetString(0,name,OBJPROP_TEXT,name);
      ObjectSetString(0,name,OBJPROP_FONT,"Microsoft YaHei");
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
      ObjectSetInteger(0,name,OBJPROP_CORNER,WZ);
     }

   if(ObjectGetInteger(0,name,OBJPROP_STATE)==1)
     {
      ObjectSetInteger(0,name,OBJPROP_COLOR,A);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,B);
     }
   else
     {
      ObjectSetInteger(0,name,OBJPROP_COLOR,B);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,A);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LoweOrder (int i2)
  {
   if(OrderTicketXH[i2]!=0)
      if(StringFind(OrderCommentXH[i2],"to #",0)==-1 || OpenPartialClosing==false)
         if(OrderSelect(CorrespondingRecordHasBeenCopied(OrderTicketXH[i2]),SELECT_BY_TICKET))
            if(OrderCloseTime()==0)
               if(OrderComment()==CustomSectionNotes+"{"+DoubleToStr(OrderTicketXH[i2],0)+"}"
                  || (StringFind(OrderComment(),"from #",0)!=-1)
                  || OrderComment()==CustomSectionNotes+"{"+DoubleToStr(OrderTicketXH[i2],0)+"}(Bad Transfer)"
                  || HideNotes
                  )
                  if(OrderCloseTime()==0)
                    {
                     if(OrderType()>1)
                        OrderDelete(OrderTicket());
                     else
                        OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slippage);
                     GetError ("1");
                     if(GlobalVariableCheck(OrderTicketXH[i2]))
                        GlobalVariableDel(OrderTicketXH[i2]);
                    }
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
int CorrespondingRecordHasBeenCopied(int ti)
   {
    if(ti==0)
       return(-1);

    if(HideNotes==false)
       if(findlassorder(-100,-1,"after","now",ti)!=-1)
          return(findlassorder(-100,-1,"after","now",ti));

    if(HideNotes==false)
       if(findlassorder(-100,-1,"after","History",ti)!=-1)
          return(findlassorder(-100,-1,"after","History",ti));

    if(GlobalVariableCheck(ti))
      {
       return(GlobalVariableGet(ti));
      }
    return(-1);
   }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HoldCorrespondingRecord(int ti)
  {
   if(ti==0)
      return(-1);

   if(GlobalVariableCheck(ti))
      if(OrderSelect(GlobalVariableGet(ti),SELECT_BY_TICKET))
         if(OrderCloseTime()==0)
           {
            return(GlobalVariableGet(ti));
           }

  if(findlassorder(-100,-1,"after","now",ti)!=-1)
       return(findlassorder(-100,-1,"after","now",ti));

   return(-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TrackMarketOrder(int i)
  {
   if(ListedOrder(-100,-1,"")<MaximumNumberOfOrders)
      if(OrderSymbolX[i]!="" && OrderTicketX[i]!=0)
         if(OrderTypeX[i]<2 || TrackPendingOrders)
            if(TimeLocal()-OrderOpenTimeX[i]<=DocumentaryAllowableSecondError || StringFind(OrderCommentX[i],"from",0)!=-1 || MandatoryReplenishmentOfSettledAndUndocumentedDocuments)
               if(StringFind(OrderCommentX[i],RemarkMustBeIncludedWhenReceivingTheOrder,0)!=-1 || RemarkMustBeIncludedWhenReceivingTheOrder=="")
                  if((OrderTypeX[i]==0 && MathAbs(MarketInfo(OrderSymbolX[i],MODE_ASK)-OrderOpenPriceX[i])<=DocumentaryAllowablePointError *MarketInfo(OrderSymbolX[i],MODE_POINT)*SymbolName(OrderSymbolX[i]))
                     || (OrderTypeX[i]==1 && MathAbs(MarketInfo(OrderSymbolX[i],MODE_BID)-OrderOpenPriceX[i])<=DocumentaryAllowablePointError *MarketInfo(OrderSymbolX[i],MODE_POINT)*SymbolName(OrderSymbolX[i]))
                     || TrackPendingOrders
                     || StringFind(OrderCommentX[i],"from",0)!=-1
                     || MandatoryReplenishmentOfSettledAndUndocumentedDocuments)
                     if(TrackPartialClosingDocuments || StringFind(OrderCommentX[i],"from",0)==-1)
                        if((CorrespondingRecordHasBeenCopied(OrderTicketX[i])==-1 && MandatoryReplenishmentOfSettledAndUndocumentedDocuments==false) || (HoldCorrespondingRecord(OrderTicketX[i])==-1 && MandatoryReplenishmentOfSettledAndUndocumentedDocuments))
                           if(OrderLotsX[i]>=NumberOfOrdersWithMasterAccountGreaterThanOrEqualNOrders)
                              if(OrderLotsX[i]<=NumberOfOrdersWithMasterAccountGreaterThanOrEqualMOrders)
                                 if(MarketInfo(OrderSymbolX[i],MODE_ASK)!=0)
                                   {
                                    if(ConvertOrderQuantityAccordingToOrderValue)
                                       double SingleVolumeRatioAdjustment=valuePerPoint[i]/MarketInfo(OrderSymbolX[i],MODE_TICKVALUE);
                                    else
                                       SingleVolumeRatioAdjustment=1;

                                    //==================================================================================================
                                    //==================================================================================================
                                    //==================================================================================================
                                    //================================================================================================== 
                                    //==================================================================================================
                                    //==================================================================================================  

                                    if(OrderTypeX[i]<2)
                                      {
                                       if(ReverseCopy==false)
                                         {
                                          int t=CreateDocument(OrderSymbolX[i],OrderTypeX[i],OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,0,0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                       else
                                         {
                                          t=CreateDocument(OrderSymbolX[i],MathAbs(OrderTypeX[i]-1),OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,0,0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                      }

                                    if(TrackPendingOrders)
                                      {
                                       if(OrderTypeX[i]==OP_BUYLIMIT)
                                         {
                                          if(ReverseCopy==false)
                                             t=CreateDocument(OrderSymbolX[i],OP_BUYLIMIT,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                          else
                                             t=CreateDocument(OrderSymbolX[i],OP_SELLSTOP,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                       if(OrderTypeX[i]==OP_BUYSTOP)
                                         {
                                          if(ReverseCopy==false)
                                             t=CreateDocument(OrderSymbolX[i],OP_BUYSTOP,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                          else
                                             t=CreateDocument(OrderSymbolX[i],OP_SELLLIMIT,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                       if(OrderTypeX[i]==OP_SELLLIMIT)
                                         {
                                          if(ReverseCopy==false)
                                             t=CreateDocument(OrderSymbolX[i],OP_SELLLIMIT,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                          else
                                             t=CreateDocument(OrderSymbolX[i],OP_BUYSTOP,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                       if(OrderTypeX[i]==OP_SELLSTOP)
                                         {
                                          if(ReverseCopy==false)
                                             t=CreateDocument(OrderSymbolX[i],OP_SELLSTOP,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                          else
                                             t=CreateDocument(OrderSymbolX[i],OP_BUYLIMIT,OrderLotsX[i]*SingleVolumeRatio*SingleVolumeRatioAdjustment,OrderOpenPriceX[i],0,0,0,CustomSectionNotes+"{"+OrderTicketX[i]+"}",magic,OrderTicketX[i]);
                                         }
                                      }
                                   }
  }
//===========================================================================
void  ExtractHistoricalSignals()
  {

   if(FILESFolderPath!="")
      FILESFolderPath2=FILESFolderPath;
   else
      FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files";

   int t=CopyFileW(TransitPath2+"\\"+TrackMasterAccount+"2.csv",FILESFolderPath2+"\\"+TrackMasterAccount+"2.csv",0);

   int handle;
   handle=FileOpen(TrackMasterAccount+"2.csv",FILE_CSV|FILE_READ|FILE_SHARE_WRITE|FILE_SHARE_READ,';');

   if(handle>0)
     {
      for(int i=0;i<200;i++)
        {
         OrderTicketXH[i]=StrToInteger(FileReadString(handle));
         string namexx=FileReadString(handle);
         OrderSymbolXH[i]=namexx+CurrencyPairNameAppended;

         if(CurrencPairNameForcedCorrectionSwitch)
           {
            if(namexx==TheNameOfTheCurrencyPairToFollow1)
               OrderSymbolXH[i]=OrderCurrencyPairName1;
            if(namexx==TheNameOfTheCurrencyPairToFollow2)
               OrderSymbolXH[i]=OrderCurrencyPairName2;
            if(namexx==TheNameOfTheCurrencyPairToFollow3)
               OrderSymbolXH[i]=OrderCurrencyPairName3;
           }

         OrderTypeXH[i]= StrToInteger(FileReadString(handle));
         OrderLotsXH[i]= StrToDouble(FileReadString(handle));
         if(OrderTicketXH[i]!=0)
            if(OrderTypeXH[i]<6)
              {
               OrderStopLossXH[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolXH[i],MODE_DIGITS));
               OrderTakeProfitXH[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolXH[i],MODE_DIGITS));
              }

         OrderCommentXH[i]=FileReadString(handle);
         OrderMagicNumberXH[i]=StrToInteger(FileReadString(handle));
         OrderOpenTimeXH[i]=StrToInteger(FileReadString(handle));
         OrderOpenPriceXH[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolXH[i],MODE_DIGITS));

         LoweOrder (i);

         if(FileIsEnding(handle))
            break;
        }
      FileClose(handle);
     }
  }
//===========================================================================
void ExtractSignal ()
  {

   if(FILESFolderPath!="")
      FILESFolderPath2=FILESFolderPath;
   else
      FILESFolderPath2=TerminalInfoString(TERMINAL_DATA_PATH)+"\\MQL4\\Files";

   int t=CopyFileW(TransitPath2+"\\"+TrackMasterAccount+".csv",FILESFolderPath2+"\\"+TrackMasterAccount+".csv",0);

   int handle;
   handle=FileOpen(TrackMasterAccount+".csv",FILE_CSV|FILE_READ|FILE_SHARE_WRITE|FILE_SHARE_READ,';');

   if(handle>0)
     {
      ArrayInitialize(OrderTicketX,0);
      ArrayInitialize(OrderTypeX,0);
      ArrayInitialize(OrderLotsX,0);
      ArrayInitializeX(OrderSymbolX,"",200);
      ArrayInitialize(valuePerPoint,0);

      for(int i=0;i<200;i++)
        {
         OrderTicketX[i]=StrToInteger(FileReadString(handle));
         string namexx=FileReadString(handle);
         OrderSymbolX[i]=namexx+CurrencyPairNameAppended;

         if(CurrencPairNameForcedCorrectionSwitch)
           {
            if(namexx==TheNameOfTheCurrencyPairToFollow1)
               OrderSymbolX[i]=OrderCurrencyPairName1;
            if(namexx==TheNameOfTheCurrencyPairToFollow2)
               OrderSymbolX[i]=OrderCurrencyPairName2;
            if(namexx==TheNameOfTheCurrencyPairToFollow3)
               OrderSymbolX[i]=OrderCurrencyPairName3;
           }

         OrderTypeX[i]= StrToInteger(FileReadString(handle));
         OrderLotsX[i]= StrToDouble(FileReadString(handle));

         if(OrderTicketX[i]!=0)
            if(OrderTypeX[i]<6)
              {
               OrderStopLossX[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolX[i],MODE_DIGITS));
               OrderTakeProfitX[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolX[i],MODE_DIGITS));
              }

         OrderCommentX[i]=FileReadString(handle);
         OrderMagicNumberX[i]=StrToInteger(FileReadString(handle));
         OrderOpenTimeX[i]=StrToInteger(FileReadString(handle));
         OrderOpenPriceX[i]=NormalizeDouble(StrToDouble(FileReadString(handle)),MarketInfo(OrderSymbolX[i],MODE_DIGITS));
         valuePerPoint[i]=StrToDouble(FileReadString(handle));

         TrackMarketOrder(i);
         ModifyOrderStopLossTakeProfit(i);

         if(FileIsEnding(handle))
            break;
        }
      FileClose(handle);
     }
  }
//=========================================================================== 
void ArrayInitializeX(string &A[],string b,int c)
  {
   for(int i=0;i<c;i++)
      A[i]=b;
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
void deleteorder(int type,int magicX,string comm)
  {
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
         //if(Symbol()==OrderSymbol())
         if(OrderMagicNumber()==magicX || magicX==-1)
            if(OrderType()==type || type==-100)
               if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
                 {
                  if(OrderType()>=2)
                    {
                     if(OrderDelete(OrderTicket())==false)
                        GetError ("");
                     i=OrdersTotal();
                    }
                  else
                    {
                     if(OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),slippage*SymbolName(Symbol()))==false)
                        GetError ("");
                     i=OrdersTotal();
                    }
                 }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SymbolName(string symbol)
  {
   int SymbolEum=1;
   if(
      MarketInfo(symbol,MODE_DIGITS)==3
      || MarketInfo(symbol,MODE_DIGITS)==5
      || (StringFind(symbol,"XAU",0)==0 && MarketInfo(symbol,MODE_DIGITS)==2)
      ||(StringFind(symbol,"GOLD",0)==0&&MarketInfo(symbol,MODE_DIGITS)==2)
      ||(StringFind(symbol,"Gold",0)==0&&MarketInfo(symbol,MODE_DIGITS)==2)
      || (StringFind(symbol,"USD_GLD",0)==0 && MarketInfo(symbol,MODE_DIGITS)==2)
      )SymbolEum=10;

   if(StringFind(symbol,"XAU",0)==0 && MarketInfo(symbol,MODE_DIGITS)==3)SymbolEum=100;

   return(SymbolEum);
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
void laber(string a,color b)
  {
   if(WhetherToShowTextLabels==true)
     {
      ObjectDelete("Arrow"+TimeToStr(Time[0],TIME_DATE|TIME_MINUTES)+a);
      ObjectCreate("Arrow"+TimeToStr(Time[0],TIME_DATE|TIME_MINUTES)+a,OBJ_TEXT,0,Time[0],Low[0]);
      ObjectSetText("Arrow"+TimeToStr(Time[0],TIME_DATE|TIME_MINUTES)+a,a,8,"Times New Roman",b);
     }
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
bool HasCurrency(string symbol,string &symbolX[])
  {
   for(int ix=0;ix<11;ix++)
      if(symbol==symbolX[ix])
         return(true);

   return(false);
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
int findlassorder(int type,int magicX,string fx,string CurrentHistory,string comm)
  {
   if(CurrentHistory=="now")
      if(fx=="after")
         for(int i=OrdersTotal()-1;i>=0;i--)
           {
            if(OrderSelect(i,SELECT_BY_POS))
               //if(Symbol()==OrderSymbol())
               if(OrderMagicNumber()==magicX || magicX==-1)
                  if(OrderType()==type || type==-100)
                     if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
                        return(OrderTicket());
           }

   if(CurrentHistory=="now")
      if(fx=="before")
         for(i=0;i<OrdersTotal();i++)
           {
            if(OrderSelect(i,SELECT_BY_POS))
               //if(Symbol()==OrderSymbol())
               if(OrderMagicNumber()==magicX || magicX==-1)
                  if(OrderType()==type || type==-100)
                     if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
                        return(OrderTicket());
           }

   if(CurrentHistory=="History")
      if(fx=="after")
         for(i=OrdersHistoryTotal()-1;i>=0;i--)
           {
            if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
               //if(Symbol()==OrderSymbol())
               if(OrderMagicNumber()==magicX || magicX==-1)
                  if(OrderType()==type || (type==-100 && OrderType()<=5 && OrderType()>=0))
                     if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
                        if(OrderCloseTime()!=0)
                           return(OrderTicket());
           }

   if(CurrentHistory=="History")
      if(fx=="before")
         for(i=0;i<OrdersHistoryTotal();i++)
           {
            if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
               //if(Symbol()==OrderSymbol())
               if(OrderMagicNumber()==magicX || magicX==-1)
                  if(OrderType()==type || (type==-100 && OrderType()<=5 && OrderType()>=0))
                     if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
                        if(OrderCloseTime()!=0)
                           return(OrderTicket());
           }
   return(-1);
  }
//+------------------------------------------------------------------+
//||
//+------------------------------------------------------------------+
void ModifyOrderStopLossTakeProfit(int i)
  {

   if(OrderSelect(CorrespondingRecordHasBeenCopied(OrderTicketX[i]),SELECT_BY_TICKET))
      if((StringFind(OrderComment(),"(Bad Transfer)",0)!=-1))
         if(OrderType()>=2)
            if(TimeCurrent()-OrderOpenTime()>=MinutesOfBadTransferTendingOrder*60)
               OrderDelete(OrderTicket());

   if(TrackPendingOrders)
      //for(int i=0;i<200;i++)
      if(OrderSelect(CorrespondingRecordHasBeenCopied(OrderTicketX[i]),SELECT_BY_TICKET))
         if(OrderCloseTime()==0)
            if(OrderType()>1)
               if(
                  MathAbs(OrderOpenPrice()-OrderOpenPriceX[i])>=MarketInfo(OrderSymbol(),MODE_POINT)
                  )
                 {
                  OrderModify(OrderTicket(),OrderOpenPriceX[i],OrderStopLoss(),OrderTakeProfit(),0);
                  GetError ("2");
                 }

   if(TrailingStopLossAndTakeProfit)
      //for(i=0;i<200;i++)
      if(OrderSelect(CorrespondingRecordHasBeenCopied(OrderTicketX[i]),SELECT_BY_TICKET))
         if(StringFind(OrderComment(),"(Bad Transfer)",0)==-1)
            if(OrderCloseTime()==0)
              {

               if(ReverseCopy==false)
                  if(
                     MathAbs(OrderStopLoss()-OrderStopLossX[i])>=MarketInfo(OrderSymbol(),MODE_POINT)
                     || 
                     MathAbs(OrderTakeProfit()-OrderTakeProfitX[i])>=MarketInfo(OrderSymbol(),MODE_POINT)
                     )
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLossX[i],OrderTakeProfitX[i],0);
                     GetError ("3");
                    }

               if(ReverseCopy)
                  if(
                     MathAbs(OrderStopLoss()-OrderTakeProfitX[i])>=MarketInfo(OrderSymbol(),MODE_POINT)
                     || 
                     MathAbs(OrderTakeProfit()-OrderStopLossX[i])>=MarketInfo(OrderSymbol(),MODE_POINT)
                     )
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),OrderTakeProfitX[i],OrderStopLossX[i],0);
                     GetError ("4");
                    }

              }
  }
//===========================================================================
int ListedOrder(int type,int magicX,string comm)
  {
   int Quantity=0;
   for(int i=0;i<OrdersTotal();i++)
      if(OrderSelect(i,SELECT_BY_POS))
         //if(OrderSymbol()==Symbol())
         if(OrderMagicNumber()==magicX || magicX==-1)
            if(StringFind(OrderComment(),comm,0)!=-1 || comm=="")
               if(OrderType()==type || type==-100)
                  Quantity++;
   return(Quantity);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CreateDocument(string Symbol,int Type,double SignalQuantity,double Price,double Interval,double StopLoss,double TakeProfit,string Remark,int magicX,int FollowOrderNumber)
  {

   if(UsingFixedQuantity)
      SignalQuantity=FixedQuantity;

   if(LimitedAvailableCurrencyPairs && HasCurrency(Symbol,LimitAvailableCurrencyPairs)==false)
      return(-1);

   if(LimitedCurrencyPairsThatCannotBeDone && HasCurrency(Symbol,RestrictionsNotToBeUsedAsCurrencyPairs))
      return(-1);


   if(MultiOrderAndAultiPendingOrders==false)
      if(Type==OP_BUY || Type==OP_BUYSTOP || Type==OP_BUYLIMIT)
         return(-1);

   if(FollowShortOrdersAndEmptyPendingOrders==false)
      if(Type==OP_SELL || Type==OP_SELLSTOP || Type==OP_SELLLIMIT)
         return(-1);


   if(MarketInfo(Symbol,MODE_LOTSTEP)<10)int SignalDecimalConvertX=0;
   if(MarketInfo(Symbol,MODE_LOTSTEP)<1)SignalDecimalConvertX=1;
   if(MarketInfo(Symbol,MODE_LOTSTEP)<0.1)SignalDecimalConvertX=2;

   SignalQuantity=NormalizeDouble(SignalQuantity,SignalDecimalConvertX);

   if(MinimumOrderQuantityBelowMinimumOrderQuantity)
      if(SignalQuantity<MarketInfo(Symbol,MODE_MINLOT))
         SignalQuantity=MarketInfo(Symbol,MODE_MINLOT);

   if(SignalQuantity<MarketInfo(Symbol,MODE_MINLOT))
     {
      laber("Below the minimum order quantity",Yellow);
      return(-1);
     }

   if(SignalQuantity>MarketInfo(Symbol,MODE_MAXLOT))
      SignalQuantity=MarketInfo(Symbol,MODE_MAXLOT);

   int t;
   double POINT=MarketInfo(Symbol,MODE_POINT)*SymbolName(Symbol);
   int DIGITS=MarketInfo(Symbol,MODE_DIGITS);
   int slippage2=slippage*SymbolName(Symbol);

   if(Type==OP_BUY)
     {
      RefreshRates();
      t=OrderSend(Symbol,OP_BUY,SignalQuantity,MarketInfo(Symbol,MODE_ASK),slippage2,0,0,Remark,magicX,0);
      GetError ("5");
      if(OrderSelect(t,SELECT_BY_TICKET))
        {
         if(StopLoss!=0 && TakeProfit!=0)
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(OrderOpenPrice()-StopLoss*POINT,DIGITS),NormalizeDouble(OrderOpenPrice()+TakeProfit*POINT,DIGITS),0);

         if(StopLoss==0 && TakeProfit!=0)
            OrderModify(OrderTicket(),OrderOpenPrice(),0,NormalizeDouble(OrderOpenPrice()+TakeProfit*POINT,DIGITS),0);

         if(StopLoss!=0 && TakeProfit==0)
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(OrderOpenPrice()-StopLoss*POINT,DIGITS),0,0);

         GetError ("6");
        }
     }

   if(Type==OP_SELL)
     {
      RefreshRates();
      t=OrderSend(Symbol,OP_SELL,SignalQuantity,MarketInfo(Symbol,MODE_BID),slippage2,0,0,Remark,magicX,0);
      GetError ("7");
      if(OrderSelect(t,SELECT_BY_TICKET))
        {
         if(StopLoss!=0 && TakeProfit!=0)
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(OrderOpenPrice()+StopLoss*POINT,DIGITS),NormalizeDouble(OrderOpenPrice()-TakeProfit*POINT,DIGITS),0);

         if(StopLoss==0 && TakeProfit!=0)
            OrderModify(OrderTicket(),OrderOpenPrice(),0,NormalizeDouble(OrderOpenPrice()-TakeProfit*POINT,DIGITS),0);

         if(StopLoss!=0 && TakeProfit==0)
            OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(OrderOpenPrice()+StopLoss*POINT,DIGITS),0,0);
        }
      GetError ("8");
     }

   if(Type==OP_BUYLIMIT || Type==OP_BUYSTOP)
     {
      if(Price==0)
        {
         RefreshRates();
         Price=MarketInfo(Symbol,MODE_ASK);
        }

      if(Type==OP_BUYLIMIT)
        {
         if(StopLoss!=0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_BUYLIMIT,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price-Interval*POINT-StopLoss*POINT,DIGITS),NormalizeDouble(Price-Interval*POINT+TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss==0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_BUYLIMIT,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,0,NormalizeDouble(Price-Interval*POINT+TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss!=0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_BUYLIMIT,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price-Interval*POINT-StopLoss*POINT,DIGITS),0,Remark,magicX,0);
         if(StopLoss==0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_BUYLIMIT,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,0,0,Remark,magicX,0);
        }

      if(Type==OP_BUYSTOP)
        {
         if(StopLoss!=0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_BUYSTOP,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price+Interval*POINT-StopLoss*POINT,DIGITS),NormalizeDouble(Price+Interval*POINT+TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss==0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_BUYSTOP,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,0,NormalizeDouble(Price+Interval*POINT+TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss!=0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_BUYSTOP,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price+Interval*POINT-StopLoss*POINT,DIGITS),0,Remark,magicX,0);
         if(StopLoss==0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_BUYSTOP,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,0,0,Remark,magicX,0);
        }
      GetError ("9");
     }

   if(Type==OP_SELLLIMIT || Type==OP_SELLSTOP)
     {
      if(Price==0)
        {
         RefreshRates();
         Price=MarketInfo(Symbol,MODE_BID);
        }

      if(Type==OP_SELLSTOP)
        {
         if(StopLoss!=0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_SELLSTOP,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price-Interval*POINT+StopLoss*POINT,DIGITS),NormalizeDouble(Price-Interval*POINT-TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss==0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_SELLSTOP,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,0,NormalizeDouble(Price-Interval*POINT-TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss!=0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_SELLSTOP,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price-Interval*POINT+StopLoss*POINT,DIGITS),0,Remark,magicX,0);
         if(StopLoss==0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_SELLSTOP,SignalQuantity,NormalizeDouble(Price-Interval*POINT,DIGITS),slippage2,0,0,Remark,magicX,0);
        }

      if(Type==OP_SELLLIMIT)
        {
         if(StopLoss!=0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_SELLLIMIT,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price+Interval*POINT+StopLoss*POINT,DIGITS),NormalizeDouble(Price+Interval*POINT-TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss==0 && TakeProfit!=0)
            t=OrderSend(Symbol,OP_SELLLIMIT,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,0,NormalizeDouble(Price+Interval*POINT-TakeProfit*POINT,DIGITS),Remark,magicX,0);
         if(StopLoss!=0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_SELLLIMIT,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,NormalizeDouble(Price+Interval*POINT+StopLoss*POINT,DIGITS),0,Remark,magicX,0);
         if(StopLoss==0 && TakeProfit==0)
            t=OrderSend(Symbol,OP_SELLLIMIT,SignalQuantity,NormalizeDouble(Price+Interval*POINT,DIGITS),slippage2,0,0,Remark,magicX,0);
        }
      GetError ("10");
     }

   return(t);
  }
  
//+--------------------------------------------------------- -------------------+
//|Verify whether this account is authorized |
//+--------------------------------------------------------- -------------------+
bool isPermission_Account(string strAccount)
  {
      bool rtnResult=false;
      
      if(strAccount=="Nothing"){    //没有限制
         rtnResult=true;
      }else{ //limited
      
          string result[]; //separated result array
          string sep=" "; // separator is character
          ushort u_sep; // separator character code
         
          //--- get the separator code
          u_sep=StringGetCharacter(sep,0);
          //--- split the string into substrings
          int k=StringSplit(strAccount,u_sep, result);
          // Determine if the account is allowed
         int intAccountCount=ArraySize(result);
         for(int i=0;i<intAccountCount;i++) 
         {  
            Print("Account:"+result[i]);
            string accTemp=AccountNumber();
            if(accTemp==result[i]){
               rtnResult=true;
            }
         }
      }
      return rtnResult; 
   
  }
  
//+--------------------------------------------------------- -------------------+
//|Verification Authorization Deadline |
//+--------------------------------------------------------- -------------------+
bool isPermission_Date(string strDate)
   {
       bool rtnResult=false;
      
       if (strDate=="") return false;
      
       if(strDate=="unlimited"){ //unlimited
          rtnResult=true;
       }else{ //limited
          datetime Date_End=StringToTime(strDate);
          if (TimeCurrent()<Date_End) {
             return true;
          }
          else {
             return false;
          }
       }
       return rtnResult;
   
   }
  
  
//+--------------------------------------------------------- -------------------+
//| Display text on the screen |
//+--------------------------------------------------------- -------------------+
void iSetLabel(string LabelName,string LabelDoc,int LabelX,int LabelY,int DocSize,string DocStyle,color DocColor)
{
   ObjectCreate(LabelName,OBJ_LABEL,0,0,0);
   ObjectSetText(LabelName,LabelDoc,DocSize,DocStyle,DocColor);
   ObjectSet(LabelName,OBJPROP_XDISTANCE,LabelX);
   ObjectSet(LabelName,OBJPROP_YDISTANCE,LabelY);
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void GetError (string a)
  {
   if(IsOptimization())
      return;

   int t=GetLastError();
   string Message;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(t!=0)
      switch(t)
        {
         //case 0:Message="Error code:"+0+"No error returned";break;
         //case 1:Message="Error code:"+1+"No error returned but the result is unknown";break;
         //case 2:Message="Error code:"+2+"General error";break;
         case 3:Message="Error code:"+3+"Invalid transaction parameter";break;
         case 4:Message="Error code:"+4+"Trade server is busy";break;
         case 5:Message="Error code:"+5+"Client terminal old version";break;
         case 6:Message="Error code:"+6+"No connection to server";break;
         case 7:Message="Error code:"+7+"No permission";break;
         //case 8:Message="Error code:"+8+"Request too frequently";break;
         case 9:Message="Error code:"+9+"Transaction failure";break;
         case 64:Message="Error code:"+64+"Account banned";break;
         case 65:Message="Error code:"+65+"Invalid account";break;
         // case 128:Message="Error code:"+128+"Transaction timed out";break;
         case 129:Message="Error code:"+129+"Invalid price";break;
         case 130:Message="Error code:"+130+"Invalid stop";break;
         case 131:Message="Error code:"+131+"Invalid transaction volume";break;
         case 132:Message="Error code:"+132+"Market closed";break;
         case 133:Message="Error code:"+133+"Transaction is forbidden";break;
         case 134:Message="Error code:"+134+"Insufficient funds";break;
         case 135:Message="Error code:"+135+"Price change";break;
         //case 136:Message="Error code:"+136+"Offer";break;
         case 137:Message="Error code:"+137+"Broker is busy";break;
         //case 138:Message="Error code:"+138+"Requote";break;
         case 139:Message="Error code:"+139+"Order is locked";break;
         case 140:Message="Error code:"+140+"Only bullish positions are allowed";break;
         //case 141:Message="Error code:"+141+"Too many requests";break;
         //case 145:Message="Error code:"+145+"Because it is too close to the market, the modification is negated";break;
         //case 146:Message="Error code:"+146+"The transaction text is full";break;
         case 147:Message="Error code:"+147+"Time period negated by broker";break;
         case 148:Message="Error code:"+148+"The total number of open and pending orders has been limited by the broker";break;
         case 149:Message="Error code:"+149+"When the hedge is rejected, open a single position relative to the existing one";break;
         case 150:Message="Error code:"+150+"Close the list specified for anti-FIFO";break;
         case 4000:Message="Error code:"+4000+"No error";break;
         case 4001:Message="Error code:"+4001+"Error function indication";break;
         case 4002:Message="Error code:"+4002+"Array index out of range";break;
         case 4003:Message="Error code:"+4003+"Insufficient memory for call stack storage function";break;
         case 4004:Message="Error code:"+4004+"The loop stack overflow";break;
         case 4005:Message="Error code:"+4005+"No memory for stack storage parameter";break;
         case 4006:Message="Error code:"+4006+"There is not enough memory for the line parameter";break;
         case 4007:Message="Error code:"+4007+"Not enough memory for line";break;
         //case 4008:Message="Error code:"+4008+"No initial line";break;
         case 4009:Message="Error code:"+4009+"No initial string character in array";break;
         case 4010:Message="Error code:"+4010+"No memory for array";break;
         case 4011:Message="Error code:"+4011+"The line is too long";break;
         case 4012:Message="Error code:"+4012+"Remainder divided by zero";break;
         case 4013:Message="Error code:"+4013+"Zero division";break;
         case 4014:Message="Error code:"+4014+"Unknown command";break;
         case 4015:Message="Error code:"+4015+"Error conversion (no general error)";break;
         case 4016:Message="Error code:"+4016+"No initial array";break;
         case 4017:Message="Error code:"+4017+"Calling DLL is forbidden";break;
         case 4018:Message="Error code:"+4018+"Database cannot be downloaded";break;
         case 4019:Message="Error code:"+4019+"Cannot call function";break;
         case 4020:Message="Error code:"+4020+"Calling the Expert Advisor function is forbidden";break;
         case 4021:Message="Error code:"+4021+"Not enough memory for line from function";break;
         case 4022:Message="Error code:"+4022+"System busy (no general errors)";break;
         case 4050:Message="Error code:"+4050+"Invalid count parameter function";break;
         case 4051:Message="Error code:"+4051+"Invalid parameter value function";break;
         case 4052:Message="Error code:"+4052+"Internal error in line function";break;
         case 4053:Message="Error code:"+4053+"Some array errors";break;
         case 4054:Message="Error code:"+4054+"Incorrect array applied";break;
         case 4055:Message="Error code:"+4055+"Custom indicator error";break;
         case 4056:Message="Error code:"+4056+"Uncoordinated array";break;
         case 4057:Message="Error code:"+4057+"Overall variable procedure error";break;
         case 4058:Message="Error code:"+4058+"Integral variable not found";break;
         case 4059:Message="Error code:"+4059+"Test mode function forbidden";break;
         case 4060:Message="Error code:"+4060+"No confirmation function";break;
         case 4061:Message="Error code:"+4061+"Error sending email";break;
         case 4062:Message="Error code:"+4062+"Line expected parameter";break;
         case 4063:Message="Error code:"+4063+"Integer expected parameter";break;
         case 4064:Message="Error code:"+4064+"Double expected parameter";break;
         case 4065:Message="Error code:"+4065+"Array as expected parameter";break;
         case 4066:Message="Error code:"+4066+"Refresh status request History data";break;
         case 4067:Message="Error code:"+4067+"Trade function error";break;
         case 4099:Message="Error code:"+4099+"End of file";break;
         case 4100:Message="Error code:"+4100+"Some file errors";break;
         case 4101:Message="Error code:"+4101+"Error file name";break;
         case 4102:Message="Error code:"+4102+"Too many open files";break;
         case 4103:Message="Error code:"+4103+"Cannot open file";break;
         case 4104:Message="Error code:"+4104+"Inconsistent file";break;
         case 4105:Message="Error code:"+4105+"No order selected";break;
         case 4106:Message="Error code:"+4106+"Unknown currency pair";break;
         case 4107:Message="Error code:"+4107+"Invalid price";break;
         case 4108:Message="Error code:"+4108+"Invalid order code";break;
         case 4109:Message="Error code:"+4109+"Transaction not allowed";break;
         case 4110:Message="Error code:"+4110+"Long term not allowed";break;
         case 4111:Message="Error code:"+4111+"Short term not allowed";break;
         case 4200:Message="Error code:"+4200+"Order already exists";break;
         case 4201:Message="Error code:"+4201+"Unknown order attribute";break;
         //case 4202:Message="Error code:"+4202+"Order does not exist";break;
         case 4203:Message="Error code:"+4203+"Unknown order type";break;
         case 4204:Message="Error code:"+4204+"No order name";break;
         case 4205:Message="Error code:"+4205+"Order coordinate error";break;
         case 4206:Message="Error code:"+4206+"No child window specified";break;
         case 4207:Message="Error code:"+4207+"Order some function error";break;
         case 4250:Message="Error code:"+4250+"Error setting send notification to queue";break;
         case 4251:Message="Error code:"+4251+"Invalid argument - empty string passed to SendNotification() function";break;
         case 4252:Message="Error code:"+4252+"Invalid setting to send notification (no ID specified or notification not enabled)";break;
         case 4253:Message="Error code:"+4253+"Notifications are sent too frequently";break;
        }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(t!=0)
     {
      while(IsTradeContextBusy())
         Sleep(300);
      RefreshRates();
      Print(a+Message);
      laber(a+Message,Yellow);
     }
  }
//+------------------------------------------------------------------+