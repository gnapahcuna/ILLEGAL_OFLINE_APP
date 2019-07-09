import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/musuim/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_history_detail.dart';

import 'model/balance.dart';
import 'model/balance_type.dart';
import 'model/stock_main.dart';
import 'model/stock_main.dart';

class StockHistoryFragment extends StatefulWidget {
  List<ItemsStockBalanceType> itemMain;
  String Title;
  StockHistoryFragment({
    Key key,
    @required this.itemMain,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<StockHistoryFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  List<ItemsStockBalanceType> itemMain;
  int countItems;
  int stockTotal = 0;
  List ItemsAll = [];
  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    super.initState();
    itemMain = widget.itemMain;
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  String _typeHistory(String hisKey) {
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String result;
    String numkey = hisKey.substring(0, 2);
    if (numkey == 'RC') {
      result = 'รับ';
    } else if (numkey == 'RT') {
      result = 'คืน';
    } else if (numkey == 'DT') {
      result = 'ทำลาย';
    } else if (numkey == 'BO') {
      result = 'นำออก';
    } else if (numkey == 'IN') {
      result = 'อื่นๆ';
    }
    return result;
  }

  String dateAll = '', dateDay = '', dateMon = '', dateYear = '', dateNew = '';
  int dateDay_int = 0,
      dateDay_int_pre = 0,
      dateMon_int = 0,
      dateMon_int_pre = 0,
      dateYear_int = 0;
  String editDate = '';
  String _reverse_time() {
    print(DateTime.now().toString());
    dateAll = DateTime.now().toString();

    // Day
    dateDay = dateAll.substring(8, 11);
    dateDay_int = int.parse(dateDay);
    dateDay_int_pre = dateDay_int - 7;
    print(dateDay_int_pre.toString());

    //Monu
    dateMon = dateAll.substring(5, 7);
    dateMon_int = int.parse(dateMon);
    print(dateMon_int);
    dateMon_int_pre = dateMon_int - 1;

    //Year
    dateYear = dateAll.substring(0, 4);
    dateYear_int = int.parse(dateYear);

    // เปลี่ยน ปี
    if (dateMon_int_pre < 1) {
      dateMon_int_pre = 12;
      dateYear_int = dateYear_int - 1;
      dateYear = dateYear_int.toString();
    }

    print(dateYear);
    if (dateDay_int_pre < 1) {
      if (dateMon_int_pre == 1 ||
          dateMon_int_pre == 3 ||
          dateMon_int_pre == 5 ||
          dateMon_int_pre == 7 ||
          dateMon_int_pre == 8 ||
          dateMon_int_pre == 10 ||
          dateMon_int_pre == 12) {
        if (dateMon_int_pre == 1 ||
            dateMon_int_pre == 3 ||
            dateMon_int_pre == 5 ||
            dateMon_int_pre == 7 ||
            dateMon_int_pre == 8) {
          String MonString = dateMon_int_pre.toString();
          dateMon = '0' + MonString;
        } else {
          String MonString = dateMon_int_pre.toString();
          dateMon = MonString;
        }
        dateDay_int = 31 - dateDay_int;
        dateDay = dateDay_int.toString();
      } else if (dateMon_int_pre == 4 ||
          dateMon_int_pre == 6 ||
          dateMon_int_pre == 9 ||
          dateMon_int_pre == 11) {
        if (dateMon_int_pre == 1 ||
            dateMon_int_pre == 4 ||
            dateMon_int_pre == 6 ||
            dateMon_int_pre == 9) {
          String MonString = dateMon_int_pre.toString();
          dateMon = '0' + MonString;
        } else {
          String MonString = dateMon_int_pre.toString();
          dateMon = '0' + MonString;
        }
        dateDay_int = 30 - dateDay_int;
        dateDay = dateDay_int.toString();
      } else {
        dateDay_int = 28 - dateDay_int;
        dateDay = dateDay_int.toString();
      }
      // result
      dateNew = dateYear + "-" + dateMon + "-" + dateDay;
      editDate = dateNew;
      print(editDate);
      // result
    }
    if (dateDay_int_pre > 6) {
      dateDay = dateDay_int_pre.toString();
      if (dateDay_int_pre < 10) {
        dateDay = dateDay_int_pre.toString();
        dateDay = '0' + dateDay;
      }
      // result
      dateNew = dateYear + "-" + dateMon + "-" + dateDay;
      editDate = dateNew;
      print(editDate);
      // result
    }
    String result;
    DateTime dt = DateTime.parse(editDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();
    print(result);
    return result;
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: itemMain.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockHistoryDetailFragment(
                          Items: itemMain[index].BalanceDetails,
                          Title: itemMain[index].Number_Name,
                        ),
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
                      )),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
                    child: Stack(
                      children: <Widget>[
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
                                    "เลขที่" +
                                        _typeHistory(
                                            itemMain[index].Number_Name),
                                    style: textLabelStyle,
                                  ),
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
                                itemMain[index].Number_Name,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "วันที่ ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _convertDate(itemMain[index].Date),
                                //_convertDate(itemMain[index].Date),
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0,
        color: Color(0xff087de1),
        fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              widget.Title,
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
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockBookSearchScreenFragment(),
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
                      )),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: new Text('ตั้งแต่ ' + _reverse_time(),
                                style: textLabelStyle),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: new Text('ถึง', style: textLabelStyle),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: new Text(
                                'วันนี้ ' +
                                    _convertDate(DateTime.now().toString()),
                                style: textLabelStyle),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 1.0),
                            child: new Text(
                                'จำนวน ' +
                                    itemMain.length.toString() +
                                    ' รายการ',
                                style: textLabelStyle),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      )
                    ],
                  )),
              Expanded(
                child: _buildContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    return result;
  }
}
