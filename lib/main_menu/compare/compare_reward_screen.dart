import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';
import 'package:prototype_app_pang/model/test/compare_case_information.dart';

import 'model/compare_detail_fine.dart';
import 'model/compare_main.dart';

class CompareRewardScreenFragment extends StatefulWidget {
  ItemsCompareArrestMain itemsCompareListIndicment;
  ItemsCompareMain itemsCompareMain;
  CompareRewardScreenFragment({
    Key key,
    @required this.itemsCompareListIndicment,
    @required this.itemsCompareMain,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareRewardScreenFragment>  with TickerProviderStateMixin {

  ItemsCompareMain itemMain;
  ItemsCompareArrestMain itemCompareIndicment;

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);

  TextStyle textStyleBill = TextStyle(
      color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonAccept = TextStyle(
      fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  TextStyle textStyleDataSub = TextStyle(
      fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleDetailLabel = TextStyle(fontSize: 14,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleDetailData = TextStyle(
      fontSize: 14, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily,
      fontSize: 12.0);
  TextStyle styleTextAppbar = TextStyle(
      fontSize: 18.0, fontFamily: FontStyles().FontFamily);

  final formatter = new NumberFormat("#,##0.00");
  final formatint = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    itemMain = widget.itemsCompareMain;
    itemCompareIndicment = widget.itemsCompareListIndicment;
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    double PAYMENT_FINE = 0;
    double TREASURY_MONEY = 0;
    double BRIBE_MONEY = 0;
    double REWARD_MONEY = 0;
    double TREASURY_MONEY_TOTAL = 0;
    double BRIBE_MONEY_TOTAL = 0;
    double REWARD_MONEY_TOTAL = 0;
    itemMain.CompareMapping.forEach((map) {
      map.CompareDetail.forEach((item) {
        PAYMENT_FINE = item.PAYMENT_FINE;
        TREASURY_MONEY = item.TREASURY_MONEY;
        BRIBE_MONEY=item.BRIBE_MONEY;
        REWARD_MONEY=item.REWARD_MONEY;

        TREASURY_MONEY_TOTAL+=item.TREASURY_MONEY;
        BRIBE_MONEY_TOTAL += item.BRIBE_MONEY;
        REWARD_MONEY_TOTAL += item.REWARD_MONEY;
      });
    });


    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 4.0),
                width: size.width,
                child: Container(
                    padding: EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "สินบน-รางวัลรายคดี",
                            style: textStyleLabel,),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[
                                Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "ค่าปรับรวม  ",
                                      style: textStyleDetailLabel,),
                                  ),
                                  Container(
                                    padding: paddingData,
                                    child: Text(
                                      formatter.format(PAYMENT_FINE).toString(),
                                      style: textStyleDetailData,),
                                  ),

                          ],),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เงินสินบน ("+formatint.format((BRIBE_MONEY_TOTAL/PAYMENT_FINE)*100).toString()+")",
                                      style: textStyleDetailLabel,),
                                  ),
                                  Container(
                                    padding: paddingData,
                                    child: Text(
                                      formatter.format(BRIBE_MONEY_TOTAL).toString(),
                                      style: textStyleDetailData,),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เงินรางวัล ("+formatint.format((REWARD_MONEY_TOTAL/PAYMENT_FINE)*100).toString()+")",
                                      style: textStyleDetailLabel,),
                                  ),
                                  Container(
                                    padding: paddingData,
                                    child: Text(
                                      formatter.format(REWARD_MONEY_TOTAL).toString(),
                                      style: textStyleDetailData,),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เงินส่งคลัง ("+formatint.format((TREASURY_MONEY_TOTAL/PAYMENT_FINE)*100).toString()+")",
                                      style: textStyleDetailLabel,),
                                  ),
                                  Container(
                                    padding: paddingData,
                                    child: Text(
                                      formatter.format(TREASURY_MONEY_TOTAL).toString(),
                                      style: textStyleDetailData,),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),
              Container(
                width: size.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemMain.CompareMapping.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildExpandableContent(index);
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildExpandableContent(int index) {
    double PAYMENT_FINE = 0;
    double TREASURY_MONEY_TOTAL = 0;
    double BRIBE_MONEY_TOTAL = 0;
    double REWARD_MONEY_TOTAL = 0;
    List<ItemsCompareDetailFine> listCompareDetailFine = [];
    itemMain.CompareMapping[index].CompareDetail.forEach((detail) {
      listCompareDetailFine = detail.CompareDetailFine;

      TREASURY_MONEY_TOTAL += detail.TREASURY_MONEY;
      BRIBE_MONEY_TOTAL += detail.BRIBE_MONEY;
      REWARD_MONEY_TOTAL += detail.REWARD_MONEY;

      PAYMENT_FINE = detail.PAYMENT_FINE;
    });
    Widget _buildExpanded(index) {
      return Container(
        //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(
                            color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingData,
                        child: Text(
                          itemCompareIndicment
                              .CompareArrestIndictmentDetail[index]
                              .TITLE_SHORT_NAME_TH +
                              itemCompareIndicment
                                  .CompareArrestIndictmentDetail[index]
                                  .FIRST_NAME + " " +
                              itemCompareIndicment
                                  .CompareArrestIndictmentDetail[index]
                                  .LAST_NAME,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          'ค่าปรับ : ' + formatter.format(PAYMENT_FINE).toString(),
                          style: textStyleDataSub,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text('สุรา',
                                style: textStyleDetailLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เงินสินบน",
                                style: textStyleDetailLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text(
                                "เงินรางวัล",
                                style: textStyleDetailLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text(
                                "เงินส่งคลัง",
                                style: textStyleDetailLabel,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemCompareIndicment.CompareProveProduct
                              .length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            double TREASURY_MONEY=0;
                            double BRIBE_MONEY=0;
                            double REWARD_MONEY=0;
                           try{
                             TREASURY_MONEY = listCompareDetailFine[index]
                                 .TREASURY_MONEY;
                             BRIBE_MONEY = listCompareDetailFine[index]
                                 .BRIBE_MONEY;
                             REWARD_MONEY = listCompareDetailFine[index]
                                 .REWARD_MONEY;
                           }catch(e){

                           }

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    itemCompareIndicment
                                        .CompareProveProduct[index]
                                        .PRODUCT_BRAND_NAME_TH.toString(),
                                    style: textStyleDetailData,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(BRIBE_MONEY).toString(),
                                    style: textStyleDetailData,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(REWARD_MONEY).toString(),
                                    style: textStyleDetailData,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(TREASURY_MONEY).toString(),
                                    style: textStyleDetailData,),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text('รวม',
                                style: textStyleDetailLabel,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text(
                                formatter.format(BRIBE_MONEY_TOTAL).toString(),
                                style: textStyleDetailData,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text(
                                formatter.format(REWARD_MONEY_TOTAL).toString(),
                                style: textStyleDetailData,),
                            ),
                            Container(
                              padding: paddingData,
                              child: Text(
                                formatter.format(TREASURY_MONEY_TOTAL)
                                    .toString(),
                                style: textStyleDetailData,),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          )
      );
    }
    Widget _buildCollapsed(int index) {
      return Container(
        //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(
                            color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingData,
                        child: Text(
                          itemCompareIndicment
                              .CompareArrestIndictmentDetail[index]
                              .TITLE_SHORT_NAME_TH +
                              itemCompareIndicment
                                  .CompareArrestIndictmentDetail[index]
                                  .FIRST_NAME + " " +
                              itemCompareIndicment
                                  .CompareArrestIndictmentDetail[index]
                                  .LAST_NAME,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          'ค่าปรับ : ' + formatter.format(PAYMENT_FINE).toString(),
                          style: textStyleDataSub,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "เงินสินบน",
                                    style: textStyleDetailLabel,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(BRIBE_MONEY_TOTAL)
                                        .toString(),
                                    style: textStyleDetailData,),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "เงินรางวัล",
                                    style: textStyleDetailLabel,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(REWARD_MONEY_TOTAL)
                                        .toString(),
                                    style: textStyleDetailData,),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "เงินส่งคลัง",
                                    style: textStyleDetailLabel,),
                                ),
                                Container(
                                  padding: paddingData,
                                  child: Text(
                                    formatter.format(TREASURY_MONEY_TOTAL)
                                        .toString(),
                                    style: textStyleDetailData,),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          )
      );
    }

    return ExpandableNotifier(
      //controller: itemMain.Evidenses[index].EvidenceTaxValues.expController,
      child: Stack(
        children: <Widget>[
          Expandable(
              collapsed: _buildCollapsed(index),
              expanded: _buildExpanded(index)
          ),
          Align(
            alignment: Alignment.topRight,
            child: Builder(

                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return IconButton(
                    icon: Icon(
                      exp.expanded ? Icons.keyboard_arrow_up : Icons
                          .keyboard_arrow_down, size: 32.0,
                      color: Colors.grey,),
                    onPressed: () {
                      exp.toggle();
                    },
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: Text("คำนวณสินบน-รางวัล",
              style: styleTextAppbar,
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "Back");
                }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_04_00_07_00', style: textStylePageName,),
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildContent(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
