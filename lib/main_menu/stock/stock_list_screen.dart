import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/musuim/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_detail_screen.dart';

class StockListScreenFragment extends StatefulWidget {
  List Items;
  String Title;
  StockListScreenFragment({
    Key key,
    @required this.Items,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<StockListScreenFragment> {
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
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      StockDetailScreenFragment(
                        Items: widget.Items[index],),
                  ));
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
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
                    padding: EdgeInsets.only(left: 22.0,right: 22.0,top: 12.0,bottom: 12.0),
                    child: Stack(children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขทะเบียนบัญชี", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Icon(Icons.navigate_next),
                              ),
                            ],
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].Number,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("วันที่รับ ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].Date,
                              style: textInputStyle,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ของกลาง ", style: textLabelStyle,),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              widget.Items[index].Evidences.ProductCategory +
                                  ">" +
                                  widget.Items[index].Evidences.ProductGroup +
                                  ">" +
                                  widget.Items[index].Evidences.ProductType +
                                  ">" + widget.Items[index].Evidences.MainBrand,
                              style: textInputStyle,),
                          ),
                        ],
                      ),
                    ],
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text(widget.Title,
            style: styleTextAppbar,
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      StockBookSearchScreenFragment(),
                  ));
            })
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                        child: new Text('ILG60_B_12_00_05_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                      ),
                    ],
                  ),*/
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                          child: new Text('จำนวน '+widget.Items.length.toString()+' รายการ',
                            style: textLabelStyle),
                        ),
                      ],
                    ),
                  ],
                )
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