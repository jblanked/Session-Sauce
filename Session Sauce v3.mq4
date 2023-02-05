//+------------------------------------------------------------------+
//|                                                Session Sauce.mq4 |
//|                                          Copyright 2022,JBlanked |
//|                                         https://www.jblanked.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022,JBlanked"
#property link      "https://www.jblanked.com"
#property strict
#property show_inputs
#property description "Ultimate session price EA."

#include <CustomFunctionsFix.mqh>


input    string         SETTINGSs         = "======= TRADE SESSIONS LOW/HIGH SETTINGS ======";  //---------------
input    bool           sellAsianLow      = false; // Sell asian low?
input    bool           buyAsianLow       = false; // Buy asian low?
input    bool           sellAsianHigh     = true; // sell asian high?
input    bool           buyAsianHigh      = false; // buy asian high?
input    bool           sellLondonLow     = false; // Sell london low?
input    bool           buyLondonLow      = false; // Buy london low?
input    bool           sellLondonHigh    = false; // sell london high?
input    bool           buyLondonHigh     = false; // buy london high?

input    string         SETTINGSss        = "======= TRADE SESSION OPEN SETTINGS ======";  //---------------
input    bool           buyLondonOpen     = false; // Buy london open?
input    bool           sellLondonOpen    = false; // Sell london open?
input    bool           buyAsianOpen      = false; // Buy Asian open?
input    bool           sellAsianOpen     = false; // Sell Asian open?
input    bool           buyNewYorkOpen    = true; // Buy new york open?
input    bool           sellNewYorkOpen   = false; // Sell new york open?


input    string         SETTINGS          = "======= ORDER SETTINGS ======";  //---------------
input    int            takeprofit        = 1000; // Take profit
input    int            stoploss          = 20; // Stop loss 
input    bool           usepercentrisk          = true; // Use risk per trade?
input    double         percentrisk             = 0.25; // Percent risk
input    bool           uselotsize              = false; // Use lot size?
input    double         lotsizee                = 0.10; // Lot size

input    int            martinTimer       = 1; // Limit expiry (hours)


input    string         BreakEvenSettings       = "======= TAKE PARTIAL SETTINGS =======";  //--------------------------->
input    bool           UseBreakEvenStop        = true;  //Use take partials?
input    double         BEclosePercent          = 50.0;   //Close how much percent?
input    double         breakstart              = 50; // Take partials after how many pips in profit (1)
input    double         breakstart2             = 100; // Take partials after how many pips in profit (2)
input    double         breakstart3             = 200; // Take partials after how many pips in profit (3)
input    double         breakstart4             = 300; // Take partials after how many pips in profit (4)
input    double         breakstop               = 20; // Move stop loss in profit X pips  

input    string         MAGICNUMBERS      = "======= OTHER SETTINGS ======";  //---------------
input    int            magicNBs          = 613119; //Magic Number
input    string         orderComments     = "SS v3"; // Order Comment

int magicNBs1 = magicNBs +1;
int magicNBs2 = magicNBs +2;
int magicNBs3 = magicNBs +3;
int magicNBs4 = magicNBs +4;
int magicNBs5 = magicNBs +5;
int magicNBs6 = magicNBs +6;
int magicNBs7 = magicNBs +7;
int magicNBs8 = magicNBs +8;
int magicNBs9 = magicNBs +9;
int magicNBs10 = magicNBs +10;
int magicNBs11 = magicNBs +11;
int magicNBs12 = magicNBs +12;
int magicNBs13 = magicNBs +13;



string         timeSettingsa              = "======= ASIAN OPEN TIME SETTINGS ======";  //---------------
bool           UseTimerAsianOpen          = true;    // Custom trading hours (true/false)
string         StartTimeAsianOpen         = "01:00";  // Trading start time (hh:mm)
string         StopTimeAsianOpen          = "01:01";  // Trading stop time (hh:mm)

string         timeSettingsn              = "======= NEW YORK OPEN TIME SETTINGS ======";  //---------------
bool           UseTimerNewYorkOpen        = true;    // Custom trading hours (true/false)
string         StartTimeNewYorkOpen       = "15:00";  // Trading start time (hh:mm)
string         StopTimeNewYorkOpen        = "15:01";  // Trading stop time (hh:mm)

string         timeSettingsl              = "======= LONDON OPEN TIME SETTINGS ======";  //---------------
bool           UseTimerLondonOpen         = true;    // Custom trading hours (true/false)
string         StartTimeLondonOpen        = "10:00";  // Trading start time (hh:mm)
string         StopTimeLondonOpen         = "10:01";  // Trading stop time (hh:mm)


string         timeSettingsc              = "======= LONDON CLOSE TIME SETTINGS ======";  //---------------
bool           UseTimerLondonClose        = true;    // Custom trading hours (true/false)
string         StartTimeLondonClose       = "15:00";  // Trading start time (hh:mm)
string         StopTimeLondonClose        = "15:01";  // Trading stop time (hh:mm)

string         timeSettingsac             = "======= ASIAN CLOSE TIME SETTINGS ======";  //---------------
bool           UseTimerAsianClose         = true;    // Custom trading hours (true/false)
string         StartTimeAsianClose        = "10:00";  // Trading start time (hh:mm)
string         StopTimeAsianClose         = "10:01";  // Trading stop time (hh:mm)




int orderID;
    

string   masterComment = "JBlanked - ";
string   orderComment  = masterComment + orderComments;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   JBlankedInitVIP(magicNBs,613119,"SS v3");
JBlankedBranding("SS v3",magicNBs,string(expiryDateVIP));
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  
  JBlankedDeinit();
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
  
  //////////////////// Start Take Partials Tempalte

if(UseBreakEvenStop)DoBreak2(magicNBs,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);
if(UseBreakEvenStop)DoBreak2(magicNBs1,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs2,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs3,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs4,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs5,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs6,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs7,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs8,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs9,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs10,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs11,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);
if(UseBreakEvenStop)DoBreak2(magicNBs12,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);

if(UseBreakEvenStop)DoBreak2(magicNBs13,breakstart,BEclosePercent,breakstop,breakstart2,breakstart3,breakstart4);




   
   double sessionhighAsian = High[iHighest(NULL, 0, MODE_HIGH, 9, 1)];
   double sessionlowAsian = Low[iLowest(NULL, 0, MODE_LOW, 9, 1)];
   
   double sessionhighLondon = High[iHighest(NULL, 0, MODE_HIGH, 5, 1)];
   double sessionlowLondon = Low[iLowest(NULL, 0, MODE_LOW, 5, 1)];   
   
   
        
      
   if((!CheckIfOpenOrdersByMagicNB(magicNBs, orderComment)) &&  AllowAsianOpen() && (!CheckIfOpenOrdersByMagicNB(magicNBs1, orderComment)))
   {
   
   
    double stopLossPrice = NormalizeDouble((Ask - stoploss * GetPipValue()),Digits);
      
    double takeProfitPrice = NormalizeDouble((Ask + takeprofit * GetPipValue()),Digits);
      
    double takeProfitPrice2 = NormalizeDouble((Bid - takeprofit * GetPipValue()),Digits);
      
    double stopLossPrice2 = NormalizeDouble((Bid + stoploss * GetPipValue()),Digits);
   
   if(buyAsianOpen)
   {          
   
   
      
orderID =   OrderSend(NULL,OP_BUY,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Ask,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs);
   }
      
    if(sellAsianOpen)
   {      
      
orderID =   OrderSend(NULL,OP_SELL,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Bid,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs1);
   }
      
   }
   




   if((!CheckIfOpenOrdersByMagicNB(magicNBs10, orderComment)) &&  AllowNewYorkOpen() && (!CheckIfOpenOrdersByMagicNB(magicNBs11, orderComment)))
   {
   
   
    double stopLossPrice = NormalizeDouble((Ask - stoploss * GetPipValue()),Digits);
      
    double takeProfitPrice = NormalizeDouble((Ask + takeprofit * GetPipValue()),Digits);
      
    double takeProfitPrice2 = NormalizeDouble((Bid - takeprofit * GetPipValue()),Digits);
      
    double stopLossPrice2 = NormalizeDouble((Bid + stoploss * GetPipValue()),Digits);
   
   
   if(buyNewYorkOpen)
   {          
      
orderID =   OrderSend(NULL,OP_BUY,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Ask,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs10);
   }
      
    if(sellNewYorkOpen)
   {      
      
orderID =   OrderSend(NULL,OP_SELL,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Bid,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs11);
   }
      
   }











   if((!CheckIfOpenOrdersByMagicNB(magicNBs12, orderComment)) &&  AllowLondonOpen() && (!CheckIfOpenOrdersByMagicNB(magicNBs13, orderComment)))
   {
   
   
    double stopLossPrice = NormalizeDouble((Ask - stoploss * GetPipValue()),Digits);
      
    double takeProfitPrice = NormalizeDouble((Ask + takeprofit * GetPipValue()),Digits);
      
    double takeProfitPrice2 = NormalizeDouble((Bid - takeprofit * GetPipValue()),Digits);
      
    double stopLossPrice2 = NormalizeDouble((Bid + stoploss * GetPipValue()),Digits);
   
   
   if(buyLondonOpen)
   {          
      
orderID =   OrderSend(NULL,OP_BUY,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Ask,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs12);
   }
      
    if(sellLondonOpen)
   {      
      
orderID =   OrderSend(NULL,OP_SELL,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),Bid,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs13);
   }
      
   
} 
 
 
 
 
 
 
 
 
 
 
   
      
   if(!CheckIfOpenOrdersByMagicNB(magicNBs2, orderComment) && buyLondonLow && AllowLondonClose())
   {
   
      double stopLossPrice = NormalizeDouble((sessionlowLondon - stoploss * GetPipValue()),Digits);
      
      double takeProfitPrice = NormalizeDouble((sessionlowLondon + takeprofit * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_BUYLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionlowLondon,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs2,int(TimeCurrent()+ martinTimer * 3600));

   }

      
   if(!CheckIfOpenOrdersByMagicNB(magicNBs3, orderComment) && sellLondonHigh && AllowLondonClose())
   {
   
         double takeProfitPrice2 = NormalizeDouble((sessionhighLondon - takeprofit * GetPipValue()),Digits);
      
      double stopLossPrice2 = NormalizeDouble((sessionhighLondon + stoploss * GetPipValue()),Digits);
      
orderID =   OrderSend(NULL,OP_SELLLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionhighLondon,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs3,int(TimeCurrent()+ martinTimer * 3600));
      
   }
   
   
        


   if(!CheckIfOpenOrdersByMagicNB(magicNBs4, orderComment) && buyLondonHigh && AllowLondonClose())
   {
   
      double stopLossPrice = NormalizeDouble((sessionhighLondon - stoploss * GetPipValue()),Digits);
      
      double takeProfitPrice = NormalizeDouble((sessionhighLondon + takeprofit * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_BUYLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionhighLondon,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs4,int(TimeCurrent()+ martinTimer * 3600));

      }
      
   if(!CheckIfOpenOrdersByMagicNB(magicNBs5, orderComment) && sellLondonLow && AllowLondonClose())
   {
   
      
      double takeProfitPrice2 = NormalizeDouble((sessionlowLondon - takeprofit * GetPipValue()),Digits);
      
      double stopLossPrice2 = NormalizeDouble((sessionlowLondon + stoploss * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_SELLLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionlowLondon,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs5,int(TimeCurrent()+ martinTimer * 3600));
      
   }
   
   
   
   
   










   if(!CheckIfOpenOrdersByMagicNB(magicNBs6, orderComment) && buyAsianLow && AllowAsianClose())
   {
   
      double stopLossPrice = NormalizeDouble((sessionlowAsian - stoploss * GetPipValue()),Digits);
      
      double takeProfitPrice = NormalizeDouble((sessionlowAsian + takeprofit * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_BUYLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionlowAsian,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs6,int(TimeCurrent()+ martinTimer * 3600));

   }
      
   if(!CheckIfOpenOrdersByMagicNB(magicNBs7, orderComment) && sellAsianHigh && AllowAsianClose() )
   {
   
      
      double takeProfitPrice2 = NormalizeDouble((sessionhighAsian - takeprofit * GetPipValue()),Digits);
      
      double stopLossPrice2 = NormalizeDouble((sessionhighAsian + stoploss * GetPipValue()),Digits);
      
orderID =   OrderSend(NULL,OP_SELLLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionhighAsian,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs7,int(TimeCurrent()+ martinTimer * 3600));
      
   }
   

        


   if(!CheckIfOpenOrdersByMagicNB(magicNBs8, orderComment) && buyAsianHigh && AllowAsianClose())
   {
   
      double stopLossPrice = NormalizeDouble((sessionhighAsian - stoploss * GetPipValue()),Digits);
      
      double takeProfitPrice = NormalizeDouble((sessionhighAsian + takeprofit * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_BUYLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionhighAsian,10,stopLossPrice,takeProfitPrice,orderComment,magicNBs8,int(TimeCurrent()+ martinTimer * 3600));

   }
      
      
   if(!CheckIfOpenOrdersByMagicNB(magicNBs9, orderComment) && sellAsianLow && AllowAsianClose())
   {
   
         double takeProfitPrice2 = NormalizeDouble((sessionlowAsian - takeprofit * GetPipValue()),Digits);
      
      double stopLossPrice2 = NormalizeDouble((sessionlowAsian + stoploss * GetPipValue()),Digits);
      
      
orderID =   OrderSend(NULL,OP_SELLLIMIT,GetRisk(usepercentrisk,uselotsize,percentrisk,stoploss,lotsizee),sessionlowAsian,10,stopLossPrice2,takeProfitPrice2,orderComment,magicNBs9,int(TimeCurrent()+ martinTimer * 3600));
      
   }
   
  
      

   
     
  }
//+------------------------------------------------------------------+



//***************************//
bool AllowAsianOpen(){


if(!UseTimerAsianOpen)return(true);
if(UseTimerAsianOpen&&TimeCurrent()>=StrToTime(StartTimeAsianOpen)&&TimeCurrent()<=StrToTime(StopTimeAsianOpen))return(true);
return(false);
}
//+------------------------------------------------------------------+


//***************************//
bool AllowNewYorkOpen(){


if(!UseTimerNewYorkOpen)return(true);
if(UseTimerNewYorkOpen&&TimeCurrent()>=StrToTime(StartTimeNewYorkOpen)&&TimeCurrent()<=StrToTime(StopTimeNewYorkOpen))return(true);
return(false);
}
//+------------------------------------------------------------------+



//***************************//
bool AllowLondonOpen(){


if(!UseTimerLondonOpen)return(true);
if(UseTimerLondonOpen&&TimeCurrent()>=StrToTime(StartTimeLondonOpen)&&TimeCurrent()<=StrToTime(StopTimeLondonOpen))return(true);
return(false);
}
//+------------------------------------------------------------------+



//***************************//
bool AllowAsianClose(){


if(!UseTimerAsianClose)return(true);
if(UseTimerAsianClose&&TimeCurrent()>=StrToTime(StartTimeAsianClose)&&TimeCurrent()<=StrToTime(StopTimeAsianClose))return(true);
return(false);
}
//+------------------------------------------------------------------+



//***************************//
bool AllowLondonClose(){


if(!UseTimerLondonClose)return(true);
if(UseTimerLondonClose&&TimeCurrent()>=StrToTime(StartTimeLondonClose)&&TimeCurrent()<=StrToTime(StopTimeLondonClose))return(true);
return(false);
}
//+------------------------------------------------------------------+







         
         


//+------------------------------------------------------------------+





