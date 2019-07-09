import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/musuim/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/model/balance_detail.dart';

class StockDetailScreenFragment extends StatefulWidget {
  ItemsStockBalanceDetail Items;
  StockDetailScreenFragment({
    Key key,
    @required this.Items,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<StockDetailScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textInputSubStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelHeadStyle = TextStyle(
        fontSize: 18.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  width: size.width,
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
                    child: Stack(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ตรวจรับของกลาง", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items.Number,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่รับ ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items.Date,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ของกลาง ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items.Evidences.ProductCategory +
                                  ">" +
                                  widget.Items.Evidences.ProductGroup +
                                  ">" +
                                  widget.Items.Evidences.ProductType +
                                  ">" + widget.Items.Evidences.MainBrand,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนของกลาง", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items.Counts.toString() + " " +
                                  widget.Items.CountUnit,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ปริมาณสุทธิ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items.Volumn.toString() + " " +
                                  widget.Items.VolumnUnit,
                              style: textInputStyle,),
                          ),
                        ],
                      ),
                    ],
                    ),
                  )
              ),
    ListView.builder(
    itemCount: widget.Items.Status,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
                height: size.height/3.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(
                          color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 12.0, right: 12.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: size.width / 4,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 22.0),
                          width: 38,
                          height: 38,
                          decoration: new BoxDecoration(
                            color: widget.Items.Status>1?(index==widget.Items.Status-1?Color(0xfff18488):Color(0xff63d8d9))
                                :Color(0xff63d8d9),
                            shape: BoxShape.circle,
                          ),
                          child: new Icon(
                            null,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ตรวจรับของกลาง",
                              style: textLabelHeadStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text("วันที่รับ : " +
                                "9 กันยายน 2561",
                              style: textInputSubStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text("หน่วยงาน : " +
                                "สสท. ระยอง",
                              style: textInputSubStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text("เลขที่คดี : " +
                                "1/2561",
                              style: textInputSubStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text("วันที่กำหนดชำระค่าปรับ : " +
                                "16 กันยายน 2561",
                              style: textInputSubStyle,),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
            index!=widget.Items.Status-1?Positioned(
                bottom: -30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width/4,
                      child: Center(
                        child: Container(
                          width: 1,
                          height: (size.height/3.2)/1.9,
                          color: Color(0xff63d8d9),
                        ),
                      ),
                    )
                  ],
                )
            ):Container(),
            index!=0?Positioned(
                top: -(size.height/3.2)/1.5,
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width/4,
                      child: Center(
                        child: Container(
                          width: 1,
                          height: (size.height/3.2)/2.2,
                          color: Color(0xff63d8d9),
                        ),
                      ),
                    )
                  ],
                )
            ):Container(),
          ],
        ),
      );
    },
    )
              /*Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                      height: size.height/3.2,
                      padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            //top: BorderSide(color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 12.0, bottom: 12.0, right: 12.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: size.width / 4,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 0.0, bottom: 22.0),
                                width: 38,
                                height: 38,
                                decoration: new BoxDecoration(
                                  color: Color(0xff63d8d9),
                                  shape: BoxShape.circle,
                                ),
                                child: new Icon(
                                  null,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ตรวจรับของกลาง",
                                    style: textLabelHeadStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text("วันที่รับ : " +
                                      "9 กันยายน 2561",
                                    style: textInputSubStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text("หน่วยงาน : " +
                                      "สสท. ระยอง",
                                    style: textInputSubStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text("เลขที่คดี : " +
                                      "1/2561",
                                    style: textInputSubStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: Text("วันที่กำหนดชำระค่าปรับ : " +
                                      "16 กันยายน 2561",
                                    style: textInputSubStyle,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  Positioned(
                      bottom: -30,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width/4,
                            child: Center(
                              child: Container(
                                width: 1,
                                height: (size.height/3.2)/1.8,
                                color: Color(0xff63d8d9),
                              ),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: size.height/3.2,
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(color: Colors.grey[300], width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 22.0, bottom: 22.0, right: 12.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: size.width / 4,
                                child: Container(
                                  padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                  width: 38,
                                  height: 38,
                                  decoration: new BoxDecoration(
                                    color: Color(0xff63d8d9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: new Icon(
                                    null,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "รออนุมัติทำลายของกลาง",
                                      style: textLabelHeadStyle,),
                                  ),
                                  Padding(
                                    padding: paddingInputBox,
                                    child: Text("วันที่ขอทำลาย : " +
                                        "9 กันยายน 2561",
                                      style: textInputSubStyle,),
                                  ),
                                  Padding(
                                    padding: paddingInputBox,
                                    child: Text("ผู้เสนออนุมัติ : " +
                                        "นายสิทธชัย พงเลิศ",
                                      style: textInputSubStyle,),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  Positioned(
                      bottom: -30,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width/4,
                            child: Center(
                              child: Container(
                                width: 1,
                                height: (size.height/3.2)/1.9,
                                color: Color(0xff63d8d9),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                  Positioned(
                    top: -(size.height/3.2)/1.5,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width/4,
                            child: Center(
                              child: Container(
                                width: 1,
                                height: (size.height/3.2)/2.2,
                                color: Color(0xff63d8d9),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: size.height/3.2,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(color: Colors.grey[300], width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 22.0, bottom: 22.0, right: 12.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: size.width / 4,
                                child: Container(
                                  padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                  width: 38,
                                  height: 38,
                                  decoration: new BoxDecoration(
                                    color: Color(0xfff18488),
                                    shape: BoxShape.circle,
                                  ),
                                  child: new Icon(
                                    null,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "ทำลายของกลาง", style: textLabelHeadStyle,),
                                  ),
                                  Padding(
                                    padding: paddingInputBox,
                                    child: Text("วันที่อนุมัติทำลาย : " +
                                        "9 กันยายน 2561",
                                      style: textInputSubStyle,),
                                  ),
                                  Padding(
                                    padding: paddingInputBox,
                                    child: Text("ผู้อนุมัติ : " +
                                        "นายธนากร ศักดิ์สิทธิ์",
                                      style: textInputSubStyle,),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  Positioned(
                      top: -(size.height/3.2)/1.5,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width/4,
                            child: Center(
                              child: Container(
                                width: 1,
                                height: (size.height/3.2)/2.2,
                                color: Color(0xff63d8d9),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ],
              )*/
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
        color: Color(0xff087de1),
        fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ประวัติบัญชีของกลาง",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                /*child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: new Text('ILG60_B_12_00_13_00',
                            style: TextStyle(color: Colors.grey[400],
                                fontFamily: FontStyles().FontFamily,
                                fontSize: 12.0),),
                        ),
                      ],
                    ),
                  ],
                )*/
            ),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    ),
    );
  }
}