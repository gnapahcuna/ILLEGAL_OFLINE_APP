import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/lawsuit_not_accept_case_screen_1.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';

class LawsuitMainScreenFragmentSearch extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  LawsuitMainScreenFragmentSearch({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _LawsuitMainScreenFragmentSearchSearchState createState() => new _LawsuitMainScreenFragmentSearchSearchState();
}
class _LawsuitMainScreenFragmentSearchSearchState extends State<LawsuitMainScreenFragmentSearch> {
  TextEditingController controller = new TextEditingController();
  List<ItemsLawsuitList> _searchResult = [];
  int _countItem = 0;
  List<ItemsListArrestSearch> _itemsData = [];

  ItemsLawsuitArrestMain lawsuitMain;
  ItemsLawsuitMain _itemsLawsuitMain;

  @override
  void initState() {
    super.initState();
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
                controller.clear();
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
    await new LawsuitFuture().apiRequestLawsuiltListgetByKeyword(map).then((onValue) {
      _searchResult = onValue;/*
      _searchResult.forEach((f){
        print(f.LAWSUIT_ID);
      });*/
    });
    setState(() {});
    return true;
  }
  //on submitted search
  onSearchTextSubmitted(String text, mContext,IsAction) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    //Map map = {'TEXT_SEARCH': text, 'ACCOUNT_OFFICE_CODE': widget.ItemsPerson.UnderOffCode};
    Map map = {'TEXT_SEARCH': text,"ACCOUNT_OFFICE_CODE": "000000"};
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      if(!IsAction){
        _showSearchEmptyAlertDialog(mContext);
      }
    }
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit= Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview,fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit,fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(fontSize: 16,color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16,color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);

    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {

        String suspect="";
        String subSuspect = "";
        if(_searchResult[index].IndicmentDetail.length>0){
          suspect = _searchResult[index].IndicmentDetail[0]
              .TITLE_SHORT_NAME_TH +
              _searchResult[index].IndicmentDetail[0]
                  .FIRST_NAME + " " +
              _searchResult[index].IndicmentDetail[0]
                  .LAST_NAME;

          if( _searchResult[index].IndicmentDetail.length==2){
            subSuspect+=_searchResult[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _searchResult[index].IndicmentDetail[1]
                    .FIRST_NAME + " " +
                _searchResult[index].IndicmentDetail[1]
                    .LAST_NAME;
          }else if(_searchResult[index].IndicmentDetail.length>2){
            subSuspect+=_searchResult[index].IndicmentDetail[1]
                .TITLE_SHORT_NAME_TH +
                _searchResult[index].IndicmentDetail[1]
                    .FIRST_NAME + " " +
                _searchResult[index].IndicmentDetail[1]
                    .LAST_NAME+" และคนอื่นๆ "+(_searchResult[index].IndicmentDetail.length-2).toString()+" คน";
          }
        }else{
          suspect="-";
        }

        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("เลขที่รับคำกล่าวโทษ", style: textLabelStyle,),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _searchResult[index].ARREST_CODE, style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อผู้ต้องหา", style: textLabelStyle,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingInputBox,
                        child: Text(suspect,
                          style: textInputStyle,),
                      ),
                      _searchResult[index].IndicmentDetail.length>1?Container(
                        padding: paddingInputBox,
                        child: Text(subSuspect,
                          style: textStyleDataSub,),
                      )
                          :Container(),
                    ],
                  ),
                ],
              ),
              _searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE==1
                  ?Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: new Card(
                            color:labelColor,
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: labelColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigateLawsuitPreview(context,_searchResult[index].INDICTMENT_ID,true,false,_searchResult[index].LAWSUIT_ID);
                                    },
                                    splashColor: labelColor,
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("เรียกดู", style: textPreviewStyle,),),
                                  ),
                                )
                            )
                        ),
                      ),
                    ],
                  )
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: new Card(
                            color: Color(0xff087de1),
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 0.0,
                            child: Container(
                                width: 100.0,
                                //height: 40,
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _navigateLawsuitAcceptCase(
                                          context,_searchResult[index].INDICTMENT_ID);
                                    },
                                    splashColor: Color(0xff087de1),
                                    //highlightColor: Colors.blue,
                                    child: Center(
                                      child: Text("รับคดี",
                                        style: textStyleButtonAccept,),),
                                  ),
                                )
                            )
                        ),
                      ),
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Color(0xff087de1), width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                              width: 100.0,
                              //height: 40,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    _navigateLawsuitNotAcceptCase(
                                        context,_searchResult[index].INDICTMENT_ID);
                                  },
                                  splashColor: Color(0xff087de1),
                                  //highlightColor: Colors.blue,
                                  child: Center(
                                    child: Text("ไม่รับคดี",
                                      style: textStyleButtonNotAccept,),),
                                ),
                              )
                          )
                      ),
                    ],
                  )
                ],
              ),
            ],
            ),
          ),
        );
      },
    );
  }
  Future<bool> onLoadActionGetLawsuitIndicment(Map map,bool IsPreview,LAWSUIT_ID) async {
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentgetByCon(map).then((onValue) {
      lawsuitMain = onValue;
    });
    if(IsPreview){
      Map map_law = {
        "LAWSUIT_ID": LAWSUIT_ID
        /*"LAWSUIT_ID": 161*/
      };
      await new LawsuitFuture().apiRequestLawsuitgetByCon(map_law).then((onValue) {
        print(onValue.LAWSUIT_ID);
        _itemsLawsuitMain = onValue;
      });
    }

    setState(() {});
    return true;
  }
  _navigateLawsuitPreview(BuildContext context,int INDICTMENT_ID,IsPreview,IsUpdate,LAWSUIT_ID) async {
    print(LAWSUIT_ID);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      "INDICTMENT_ID" : INDICTMENT_ID
      /*"INDICTMENT_ID" : 272*/
    };
    await onLoadActionGetLawsuitIndicment(map,true,LAWSUIT_ID);
    Navigator.pop(context);
    if (lawsuitMain!= null||_itemsLawsuitMain!=null) {
      if(_itemsLawsuitMain.IS_LAWSUIT==0){
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LawsuitNotAcceptCaseMainScreenFragment(
            ItemsPerson: widget.ItemsPerson,
            itemsLawsuitMain: lawsuitMain,
            IsPreview: true,
            itemsPreview: _itemsLawsuitMain,
          )),
        );
      }else{
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
            itemsLawsuitMain: lawsuitMain,
            ItemsPerson: widget.ItemsPerson,
            IsEdit: IsUpdate,
            IsPreview: IsPreview,
            IsCreate: false,
            itemsPreview: _itemsLawsuitMain,
          )),
        );
      }
      onSearchTextSubmitted(controller.text, context,true);
    }
  }

  _navigateLawsuitNotAcceptCase(BuildContext context,int INDICTMENT_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      "INDICTMENT_ID" : INDICTMENT_ID
    };
    await onLoadActionGetLawsuitIndicment(map,false,null);
    Navigator.pop(context);
    if (lawsuitMain!= null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LawsuitNotAcceptCaseMainScreenFragment(
          ItemsPerson: widget.ItemsPerson,
          itemsLawsuitMain: lawsuitMain,
          IsPreview: false,
        )),
      );
      onSearchTextSubmitted(controller.text, context,true);
    }

  }
  _navigateLawsuitAcceptCase(BuildContext context,int INDICTMENT_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      "INDICTMENT_ID" : INDICTMENT_ID
    };
    await onLoadActionGetLawsuitIndicment(map,false,null);
    Navigator.pop(context);
    if (lawsuitMain!= null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
          itemsLawsuitMain: lawsuitMain,
          ItemsPerson: widget.ItemsPerson,
          IsEdit: false,
          IsPreview: false,
          IsCreate: true,
          itemsPreview: null,
        )),
      );
      onSearchTextSubmitted(controller.text, context,true);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextSearch = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    var size = MediaQuery
        .of(context)
        .size;

    return new Theme(
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
              child: new TextField(
                style: styleTextSearch,
                controller: controller,
                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onSubmitted: (String text) {
                  onSearchTextSubmitted(text, context,false);
                },
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context,_itemsData);
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
                height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text('ILG60_B_02_00_02_00',
                        style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults() : new Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
