import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/zan/analysis/networksearch.dart';
import 'package:prototype_app_pang/zan/analysis/main_analysis.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

import '../../analysis_screen.dart';
class NetworkMainScreenFragmentSearchResult extends StatefulWidget {
  List ItemsDataGet;
  ItemsMasterTitleResponse itemsTitle;
  NetworkMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsDataGet,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _NetworkMainScreenFragmentSearchResultState createState() => new _NetworkMainScreenFragmentSearchResultState();
}
class _NetworkMainScreenFragmentSearchResultState extends State<NetworkMainScreenFragmentSearchResult> {
  List _itemsInit = [];
  int _countItem = 0;
  List _itemsData = [];
  List<bool> _value = [];
  bool isCheckAll=false;


  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 14.0, color: Colors.grey[500],fontFamily: FontStyles().FontFamily);
  TextStyle textPreviewStyle = TextStyle(fontSize: 14.0, color: Color(0xff2e76bc),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);
  TextStyle textCheckAllStyle = TextStyle(fontSize: 16.0, color: Color(0xff2e76bc),fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);


  bool Success=false;
  ItemsListPersonNetMain itemsListPersonNetMain=null;
  @override
  void initState() {
    super.initState();
    _itemsInit=widget.ItemsDataGet;
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _itemsInit.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Map map={
              "PERSON_ID" : _itemsInit[index].PERSON_ID//21
            };
            _navigatePreview(context,map,_itemsInit[index].PERSON_ID);
          },

          child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 18.0),
                        child: Container(
                          width: 70.0,
                          height: 70.0,

                          decoration: BoxDecoration(

                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white30),
                          ),
                          //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                          padding: const EdgeInsets.all(3.0),
                          child: ClipOval(
                            child: new Image(
                                fit: BoxFit.cover,
                                image: new AssetImage(
                                    'assets/images/avatar.png')),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: paddingLabel,
                          child: Text(_itemsInit[index].TITLE_SHORT_NAME_TH.toString() + ' ' +
                              _itemsInit[index].FIRST_NAME.toString()+" "+
                              _itemsInit[index].LAST_NAME.toString(),
                            style: textInputStyleTitle,),
                        ),
                      ),
                      Center(
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.navigate_next,size: 28,color: Colors.grey[400],)

                          ),
                      ),
                    ],
                  ),

                  _itemsInit[index].IsCheck?Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: InkWell(
                            onTap: () {
                              Map map={
                                "PERSON_ID" : _itemsInit[index].PERSON_ID
                              };
                              _navigatePreview(context,map,_itemsInit[index].PERSON_ID);
                            },

                          )
                      ),
                    ],
                  ):Container(),
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
    _itemsInit.forEach((item) {
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
          _itemsInit.forEach((item) {
            if (item.IsCheck)
              _itemsData.add(item);
          });
          Navigator.pop(context, _itemsData);
        },
      
      ),
    ) : null;
  }

  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {
      "TEXT_SEARCH": ""
    };
    Map map_country = {
      "TEXT_SEARCH": ""
    };
    await new ArrestFutureMaster()
        .apiRequestMasCountrygetByCon(map_country)
        .then((onValue) {
      itemsCountry = onValue;
    });
  }
  _navigateCreate(BuildContext mContext) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);
  }

  //on show dialog
  Future<bool> onLoadAction(BuildContext context,Map map) async {
    await new PersonNetFuture().apiRequestPersonDetailgetByPersonId(map).then((onValue) {
      itemsListPersonNetMain = onValue;
    });
    setState(() {});
    return true;
  }
  _navigatePreview(BuildContext context,Map map,int PERSON_ID) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction(context,map);
    Navigator.pop(context);

    if(itemsListPersonNetMain!=null){
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnalysisMainScreenFragment(
          itemsListPersonNetMain: itemsListPersonNetMain,
          PERSON_ID: PERSON_ID,
        )),
      );
      print(result);
      /*_itemsData=result;
      Navigator.pop(context,_itemsData);*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: new Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("วิเคราะห์ข้อมูลผู้ต้องหา",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "back");
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
                          child: new Text('ILG60_B_01_00_13_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
              ),
              
              
              Expanded(
                child: _buildSearchResults(),
              ),
            ],
          ),
        ),
    
      ),
    );
  }
}