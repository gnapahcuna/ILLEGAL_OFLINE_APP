import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:expandable/expandable.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

class TabScreenArrest2Search extends StatefulWidget {
  @override
  _TabScreenArrest2SearchState createState() => new _TabScreenArrest2SearchState();
}
class _TabScreenArrest2SearchState extends State<TabScreenArrest2Search> {
  Future<List<ItemsList>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddress + "/ArrestNoticegetByKeyword",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsList.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  TabController tabController;
  TextEditingController controller = new TextEditingController();
  List _searchResult = [];
  int _countItem = 0;
  List _itemsData = [];
  List<bool> _value = [];

  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textExpandStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(
      color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextSearch = TextStyle(
      fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await apiRequest(map).then((onValue) {
      _searchResult = onValue;
    });
    setState(() {});
    return true;
  }

  //on submitted search
  onSearchTextSubmitted(String text, mContext) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {'TEXT_SEARCH': text};
    /*if(text.isEmpty){
      _showSearchEmptyAlertDialog(mContext,"ยังไม่มีข้อมูลค้นหา");
    }else {
      await onLoadAction(map);
    }*/
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      new EmptyDialog(mContext, "ไม่พบใบแจ้งความ");
    }
  }

  String _convertDate(String sDate){
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(
        " ");
    result = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();


    return result;
  }

  String _convertTime(String sDate){
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " +
        dateFormatTime.format(dt).toString();
    return result;
  }

  buildCollapsedNonCheck(index, expandContext) {
    String title = _searchResult[index].STAFF_TITLE_SHORT_NAME_TH != null
        ? _searchResult[index].STAFF_TITLE_SHORT_NAME_TH
        : _searchResult[index].STAFF_TITLE_NAME_TH;
    String firstname = _searchResult[index].STAFF_FIRST_NAME != null
        ? _searchResult[index].STAFF_FIRST_NAME
        : "";
    String lastname = _searchResult[index].STAFF_LAST_NAME != null
        ? _searchResult[index].STAFF_LAST_NAME
        : "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบแจ้งความ", style: textLabelStyle,),
              ),
            ),
            Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _searchResult[index].IsCheck =
                      !_searchResult[index].IsCheck;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _searchResult[index].IsCheck
                          ? Color(0xff3b69f3)
                          : Colors.white,
                      border: _searchResult[index].IsCheck
                          ? Border.all(color: Color(0xff3b69f3), width: 2)
                          : Border.all(color: Colors.grey[400], width: 2),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: _searchResult[index].IsCheck
                            ? Icon(
                          Icons.check,
                          size: 18.0,
                          color: Colors.white,
                        )
                            : Container(
                          height: 18.0,
                          width: 18.0,
                          color: Colors.transparent,
                        )
                    ),
                  ),
                )
            ),
          ],
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            title + firstname + " " + lastname
            , style: textInputStyle,),
        ),

      ],
    );
  }

  buildCollapsedChecked(index, expandContext) {
    String title = _searchResult[index].STAFF_TITLE_SHORT_NAME_TH != null
        ? _searchResult[index].STAFF_TITLE_SHORT_NAME_TH
        : _searchResult[index].STAFF_TITLE_NAME_TH;
    String firstname = _searchResult[index].STAFF_FIRST_NAME != null
        ? _searchResult[index].STAFF_FIRST_NAME
        : "";
    String lastname = _searchResult[index].STAFF_LAST_NAME != null
        ? _searchResult[index].STAFF_LAST_NAME
        : "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบแจ้งความ", style: textLabelStyle,),
              ),
            ),
            Center(
              child: Builder(
                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return InkWell(
                    onTap: () {
                      exp.toggle();
                      setState(() {
                        _searchResult[index].IsCheck =
                        !_searchResult[index].IsCheck;
                        exp.expanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _searchResult[index].IsCheck
                            ? Color(0xff3b69f3)
                            : Colors.white,
                        border: _searchResult[index].IsCheck
                            ? Border.all(color: Color(0xff3b69f3), width: 2)
                            : Border.all(color: Colors.grey[400], width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _searchResult[index].IsCheck
                              ? Icon(
                            Icons.check,
                            size: 18.0,
                            color: Colors.white,
                          )
                              : Container(
                            height: 18.0,
                            width: 18.0,
                            color: Colors.transparent,
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            title + firstname + " " + lastname
            , style: textInputStyle,),
        ),
      ],
    );
  }

  buildExpandedChecked(index, expandContext) {
    String title = _searchResult[index].STAFF_TITLE_SHORT_NAME_TH != null
        ? _searchResult[index].STAFF_TITLE_SHORT_NAME_TH
        : _searchResult[index].STAFF_TITLE_NAME_TH;
    String firstname = _searchResult[index].STAFF_FIRST_NAME != null
        ? _searchResult[index].STAFF_FIRST_NAME
        : "";
    String lastname = _searchResult[index].STAFF_LAST_NAME != null
        ? _searchResult[index].STAFF_LAST_NAME
        : "";

    String suspect_name = "";
    String title_susp = _searchResult[index].SUSPECT_TITLE_SHORT_NAME_TH != null
        ? _searchResult[index].SUSPECT_TITLE_SHORT_NAME_TH
        : "";
    String firstname_susp = _searchResult[index].SUSPECT_FIRST_NAME != null
        ? _searchResult[index].SUSPECT_FIRST_NAME
        : "";
    String lastname_susp = _searchResult[index].SUSPECT_LAST_NAME != null
        ? _searchResult[index].SUSPECT_LAST_NAME
        : "";
    suspect_name = title + firstname_susp + " " + lastname_susp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text("เลขที่ใบแจ้งความ", style: textLabelStyle,),
              ),
            ),
            Center(
              child: Builder(
                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return InkWell(
                    onTap: () {
                      exp.toggle();
                      setState(() {
                        _searchResult[index].IsCheck =
                        !_searchResult[index].IsCheck;
                        exp.expanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _searchResult[index].IsCheck
                            ? Color(0xff3b69f3)
                            : Colors.white,
                        border: _searchResult[index].IsCheck
                            ? Border.all(color: Color(0xff3b69f3), width: 2)
                            : Border.all(color: Colors.grey[400], width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _searchResult[index].IsCheck
                              ? Icon(
                            Icons.check,
                            size: 18.0,
                            color: Colors.white,
                          )
                              : Container(
                            height: 18.0,
                            width: 18.0,
                            color: Colors.transparent,
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index].NOTICE_CODE, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้รับแจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            title + firstname + " " + lastname
            , style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องสงสัย", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            suspect_name, style: textInputStyle,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("วันที่แจ้งความ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index]!=null
                ?(_convertDate(_searchResult[index].NOTICE_DATE)+" "+
                _convertTime(_searchResult[index].NOTICE_DATE))
                :"", style: textInputStyle,),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: !_searchResult[index].IsCheck ? buildCollapsedNonCheck(
                index, context)
                :
            ExpandableNotifier(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expandable(
                    collapsed: buildExpandedChecked(index, context),
                    expanded: buildCollapsedChecked(index, context),
                  ),
                  _searchResult[index].IsCheck ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Builder(
                        builder: (context) {
                          var exp = ExpandableController.of(context);
                          return FlatButton(
                              onPressed: () {
                                exp.toggle();
                              },
                              child: Text(
                                exp.expanded ? "ดูเพิ่มเติม..." : "ย่อ...",
                                style: textExpandStyle,
                              )
                          );
                        },
                      ),
                    ],
                  ) : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery
        .of(context)
        .size;
    bool isCheck = false;
    _countItem = 0;
    _searchResult.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return isCheck ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          _searchResult.forEach((item) {
            if (item.IsCheck)
              _itemsData.add(item);
          });
          Navigator.pop(context, _itemsData);
        },
        child: Center(
          child: Text('เลือก (${_countItem})', style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Theme(
        data: new ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.white,
            hintColor: Colors.grey[400]
        ),
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Row(children: <Widget>[
                  new SizedBox(width: 10.0,),
                  new Expanded(child: new Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        new TextField(
                          decoration: InputDecoration(
                            hintText: 'ค้นหา', hintStyle: styleTextSearch,),
                          onChanged: (text) {
                            setState(() {
                              print(text);
                            });
                          },
                          onSubmitted: (String text) {
                            onSearchTextSubmitted(text, context);
                          },
                          controller: controller,),
                        controller.text.length > 0 ? new IconButton(
                            icon: new Icon(Icons.clear), onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        }) : new Container(height: 0.0,)
                      ]
                  ),),
                ],
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,), onPressed: () {
                Navigator.pop(context, _itemsData);
              }),
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
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
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text('ILG60_B_01_00_06_00',
                        style: textStylePageName,),
                    )
                  ],
                ),*/
                    ),
                    Expanded(
                      child: _searchResult.length != 0 ||
                          controller.text.isNotEmpty
                          ? _buildSearchResults() : new Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottom(),
        ),
      ),
    );
  }
}
