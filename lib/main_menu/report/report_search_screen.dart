import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/check_evidence_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_search_result_screen_2.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_list.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/lawsuit_screen_2_search_result.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

class ReportMainScreenFragmentSearch extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  ReportMainScreenFragmentSearch({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ReportMainScreenFragmentSearch> {

  final FocusNode myFocusNodeDepartmentLevel = FocusNode();
  final FocusNode myFocusNodeProductCate = FocusNode();
  final FocusNode myFocusNodeReportDateStart= FocusNode();
  final FocusNode myFocusNodeReportDateEnd= FocusNode();

  TextEditingController editDepartmentLevel = new TextEditingController();
  TextEditingController editProductCate = new TextEditingController();
  TextEditingController editReportDateStart = new TextEditingController();
  TextEditingController editReportDateEnd = new TextEditingController();

  String _currentDateReportStart, _currentDateReportEnd;
  DateTime _dtDateReportStart, _dtDateReportEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;
  List<ItemsCompareList> _searchResult = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    _currentDateReportStart = date;
    _currentDateReportEnd=date;
    _dtDateReportStart = DateTime.now();
    _dtDateReportEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ไม่พบข้อมูล.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                editDepartmentLevel.clear();
                editProductCate.clear();
                editReportDateStart.clear();
                editReportDateEnd.clear();
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showSearchEmptyAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context);
      },
    );
  }
  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new CompareFuture().apiRequestCompareListgetByConAdv(map).then((onValue) {
      _searchResult = onValue;
      print(onValue.length);
    });
    setState(() {});
    return true;
  }
  onSearchTextSubmitted(Map map, mContext,IsAction) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      if(!IsAction){
        _showSearchEmptyAlertDialog(mContext);
      }
    }else{
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompareMainScreenFragmentSearchResult(
          ItemsPerson: widget.ItemsPerson,
          ItemSearch: _searchResult,
        )),
      );
    }
  }


  @override
  void dispose() {
    super.dispose();
    editReportDateStart.dispose();
    editReportDateEnd.dispose();
    editProductCate.dispose();
    editDepartmentLevel.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: labelColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                /*Map map = {
                                  //
                                };
                                onSearchTextSubmitted(map, context,false);*/
                                _showSearchEmptyAlertDialog(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("ค้นหา", style: textLabelStyle,),),
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _buildInput() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleSelect = TextStyle(fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return Container(
      padding: EdgeInsets.only(top: 22.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: size.width / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("วันที่รับคดี", style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(
                              new FocusNode());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(
                                    Current: _dtDateReportStart,
                                    MaxDate: _dtMaxDate,
                                    MinDate: null);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _dtDateReportStart = s;
                              _currentDateReportStart = date;
                              editReportDateStart.text =
                                  _currentDateReportStart;
                            });
                          });
                        },
                        focusNode: myFocusNodeReportDateStart,
                        controller: editReportDateStart,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                            color: Colors.grey,),
                        ),
                      ),
                    ),
                    _buildLine,
                  ],
                ),
              ),
              Container(
                width: size.width / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("ถึง", style: textLabelStyle,),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(
                              new FocusNode());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(
                                  Current: _dtDateReportEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateReportStart,);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _dtDateReportEnd = s;
                              _currentDateReportEnd = date;
                              editReportDateEnd.text = _currentDateReportEnd;
                            });
                          });
                        },
                        focusNode: myFocusNodeReportDateEnd,
                        controller: editReportDateEnd,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                            color: Colors.grey,),
                        ),
                      ),
                    ),
                    _buildLine,
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: paddingLabel,
            child: Text("ระดับหน่วยงาน", style: textLabelStyle,),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeDepartmentLevel,
              controller: editDepartmentLevel,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              style: textInputStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          _buildLine,
          Container(
            padding: paddingLabel,
            child: Text("หมวดของกลาง", style: textLabelStyle,),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeProductCate,
              controller: editProductCate,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              style: textInputStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          _buildLine,
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Text("ค้นหาสถิติ",
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
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_02_00_02_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                      ),
                    ],
                  ),
                  ],
                )*/
            ),
            Expanded(
              child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(context),
                  )
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}