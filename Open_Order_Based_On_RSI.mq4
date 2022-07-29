//+------------------------------------------------------------------+
//|                                                     RSI_Test.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Input Part                                                       |
//+------------------------------------------------------------------+

input string _="//-- General Setting --//";
input int Magic_Number          = 999;
input string Open_Order_Comment = "RSI Test By Ash999";
input int Spread_Filter         = 20; // Spread_Filter (0= Disable)

input string __="//-- Entry Setting --//";
input int   RSI_Period          = 14;
input int   OverBought          = 70;
input int   OverSold            = 30;
input double  First_Order_Lot_Size = 1;

input string ___="//-- Exit Setting --//";
input int   Take_Profit_in_Points   = 100; // Take_Profit_in_Points(0= Disable)
input int   Stop_Loss_in_Points     = 100; // Stop_Loss_in_Points(0= Disable)

//+------------------------------------------------------------------+
//| Define Variables                                                 |
//+------------------------------------------------------------------+

double Point_Value = 0;
int Number_Of_Buy_Order = 0;
int Number_Of_Sell_Order = 0;
double Open_Price_Of_Buy_Order = 0;
double Open_Price_Of_Sell_Order = 0;
bool Close_Order_Status = TRUE;
int Open_Order_Status = 0;

//+------------------------------------------------------------------+
//| Custom Function for Reducing Code                                |
//+------------------------------------------------------------------+

//Something Wrong in below codes
//double Check_Lot_Size(double Lot_Size_Before) // Check Lot Size and take approximate number, 0.1234 > 0.12, 0.177 > 0.18 
//   {
//   double Lot_Size_After = 0;
//   Lot_Size_After = NormalizeDouble(Lot_Size_Before/MarketInfo(Symbol(), MODE_LOTSTEP), 0);
//   Lot_Size_After *= MarketInfo(Symbol(), MODE_LOTSTEP); //Adjustable Lot Size to broker's acceptable rate
//   Lot_Size_After = MathMax(Lot_Size_After, MarketInfo(Symbol(), MODE_MINLOT)); // If Lot is too small than adjust to Broker's minimal accepate lot
//   Lot_Size_After = MathMax(Lot_Size_After, MarketInfo(Symbol(), MODE_MAXLOT));
//   return(Lot_Size_After);
//   }

void Close_Single_Direction_All_Orders(int Operation_Type) //Close Buy/Sell's Single Direction Order
   {
   for(int i=OrdersTotal()-1; i>=0; i--)
      {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) //Select Order
         {
         if(OrderMagicNumber()==Magic_Number && OrderSymbol()==Symbol() && OrderType()==Operation_Type) // If All Condition is Same
            {
            Close_Order_Status=OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Red);
            }
         }
      }
   }

//+------------------------------------------------------------------+
//| Check_Opened_Orders(Function)                                    |
//+------------------------------------------------------------------+
void Check_Opened_Orders() //Check User's Opened Order
{
   
   Number_Of_Buy_Order = 0;
   Number_Of_Sell_Order = 0;
   Open_Price_Of_Buy_Order = 0;
   Open_Price_Of_Sell_Order = 0;
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(OrderMagicNumber()==Magic_Number && OrderSymbol()==Symbol())
         {
            if(OrderType()==OP_BUY)
            {
             Number_Of_Buy_Order++;
             Open_Price_Of_Buy_Order += OrderOpenPrice();
            } // End For OP_Buy
            
            if(OrderType()==OP_SELL)
            {
            Number_Of_Sell_Order++;
            Open_Price_Of_Sell_Order += OrderOpenPrice();
            } // End For OP_Sell
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Check For Close (Should Close Order or Not)                      |
//+------------------------------------------------------------------+
void Check_For_Close()
   {
   //Check Buy Order Shouled Close or Not
   if(Number_Of_Buy_Order>0)
   {
   printf("Checked Buy Order" + Take_Profit_in_Points);
      if(Take_Profit_in_Points>0 && Bid>=Open_Price_Of_Buy_Order+Take_Profit_in_Points*Point_Value)
         {
           Close_Single_Direction_All_Orders(OP_BUY);
         }
      if(Stop_Loss_in_Points>0 && Bid<=Open_Price_Of_Buy_Order-Stop_Loss_in_Points*Point_Value)
         {
         Close_Single_Direction_All_Orders(OP_BUY);
         }
   }// End For Buy Order
   
   //Check Sell Order Shouled Close or Not
   if(Number_Of_Sell_Order>0)
   {
      if(Take_Profit_in_Points>0 && Ask<=Open_Price_Of_Sell_Order-Take_Profit_in_Points*Point_Value)
         {
         Close_Single_Direction_All_Orders(OP_SELL);
         }
      if(Stop_Loss_in_Points>0 && Ask>=Open_Price_Of_Sell_Order+Stop_Loss_in_Points*Point_Value)
         {
         Close_Single_Direction_All_Orders(OP_SELL);
         }
   }//Check Sell Order Shouled Close or Not
   }

//+------------------------------------------------------------------+
//| Check For Open (Should Open Order or Not)                        |
//+------------------------------------------------------------------+
void Check_For_Open()
   {
   
   double RSI_Value = iRSI(Symbol(),0,RSI_Period,PRICE_CLOSE,1); 
   printf("RSI Gonna Open is " + OverSold + "RSI Gonna Sell is " + OverBought);
   printf("Current RSI is" + RSI_Value);
   if(Spread_Filter>=MarketInfo(Symbol(),MODE_SPREAD) || Spread_Filter==0)
      {
      //Open
         if(Number_Of_Buy_Order==0)
            {
            if(RSI_Value < OverSold)
               {
               printf("Should create Buy Order Now");
               //Open_Order_Status=OrderSend(Symbol(),OP_BUY, Check_Lot_Size(First_Order_Lot_Size),Ask,0,0,0,Open_Order_Comment,Magic_Number,0,Purple);
               Open_Order_Status=OrderSend(Symbol(),OP_BUY, 1,Ask,0,0,0,Open_Order_Comment,Magic_Number,0,Green);
               if(Open_Order_Status<0)
                 {
                  PrintFormat("OrderSend failed with error #",GetLastError());
                 }
               else
                  PrintFormat("OrderSend placed successfully");
               
               }//End Check RSI
            }// End Number of Buy Order = 0
            
      //Sell
         if(Number_Of_Sell_Order==0)
            {
            if(RSI_Value > OverBought)
               {
                   
               printf("Should create Sell Order Now");
               // Open_Order_Status=OrderSend(Symbol(),OP_SELL,Check_Lot_Size(First_Order_Lot_Size),Bid,0,0,0,Open_Order_Comment,Magic_Number,0,Purple);
               Open_Order_Status=OrderSend(Symbol(),OP_SELL,1,Bid,0,0,0,Open_Order_Comment,Magic_Number,0,Purple);
               
               if(Open_Order_Status<0)
                 {
                  PrintFormat("OrderSend failed with error #",GetLastError());
                 }
               else
                  PrintFormat("OrderSend placed successfully");
               
               }//End Check Rsi
            }// EndNumber Of Sell Order = 0
      }//End Spread Filter
 
   }



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   Point_Value = MarketInfo(Symbol(), MODE_POINT);
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
   Check_Opened_Orders(); //Check User's Open Order
   Check_For_Close();
   Check_For_Open();
  //  OrderSend(Symbol(),OP_BUY,1,Bid,3,0,0,"My order",16384,0,Red); 

       
  }
//+------------------------------------------------------------------+
