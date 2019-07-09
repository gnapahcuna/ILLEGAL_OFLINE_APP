import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_face.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search.dart';
import 'package:prototype_app_pang/main_menu/future/item_service_uat.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest4AddServiceReg extends StatefulWidget {
  ItemsMasterTitleResponse itemsTitle;
  TabScreenArrest4AddServiceReg({
    Key key,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  TabScreenArrest4AddState createState() => new TabScreenArrest4AddState();
}
class TabScreenArrest4AddState extends State<TabScreenArrest4AddServiceReg> {
  List<ItemsListArrestLawbreaker> itemSearch=[];

  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();

  List _itemsData = [];


  TextStyle textSearchByImgStyle = TextStyle(
      fontSize: 16.0, color: Colors.blue.shade400,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    editIdentifyNumber.dispose();

  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    var size = MediaQuery
        .of(context)
        .size;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(bottom: 4.0,left: 22.0,right: 22.0),
      height: 1.0,
      color: Colors.grey[300],
    );

    return Container(
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0,left: 22.0,right: 22.0),
            //width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text("หมายเลขบัตรประชาชน",
                        style: textLabelStyle,),
                      Text(" *", style: textStyleStar,),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodeIdentifyNumber,
                    controller: editIdentifyNumber,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
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
                            width: 80.0,
                            child: MaterialButton(
                              onPressed: () {
                                if(editIdentifyNumber.text.isEmpty){
                                  new VerifyDialog(context, "กรุณากรอกหมายเลขบัตรประชาชน");
                                }else{
                                  _navigateSearch(context);
                                }
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
  ItemsListFactoryInfo itemsListFactoryInfo;
  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new TransectionFuture().apiRequestEDRestServicesUAT(map).then((onValue) {
      //itemSearch = onValue;
      itemsListFactoryInfo=onValue.ResponseData;
    });

    if(itemsListFactoryInfo!=null){
      List<Map> map_adress = [];
      itemsListFactoryInfo.Address.forEach((item){
        map_adress.add({
          "PERSON_ADDRESS_ID": "",
          "PERSON_ID": "",
          "SUB_DISTRICT_ID": item.SubDistrictCode,
          "GPS": "",
          "ADDRESS_NO": "",
          "VILLAGE_NO": item.MooIdentifier,
          "BUILDING_NAME": item.BuildingName,
          "ROOM_NO": item.RoomIdentifier,
          "FLOOR": item.FloorIdentifier,
          "VILLAGE_NAME": item.VillageName,
          "ALLEY": "",
          "LANE": item.SoiName,
          "ROAD": item.StreetName,
          "ADDRESS_TYPE": 4,
          "ADDRESS_DESC": "",
          "ADDRESS_STATUS": 0,
          "IS_ACTIVE": 1
        });
      });

      map={
        "PERSON_ID": "",
        "COUNTRY_ID": 1,
        "NATIONALITY_ID": 1,
        "RACE_ID": 1,
        "RELIGION_ID": 1,
        "TITLE_ID": "",
        "PERSON_TYPE": 0,
        "ENTITY_TYPE": 1,
        "TITLE_NAME_TH": "\t",
        "TITLE_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": "\t",
        "TITLE_SHORT_NAME_EN": "",
        "FIRST_NAME": itemsListFactoryInfo.FirstName,
        "MIDDLE_NAME": "",
        "LAST_NAME": "\t",
        "OTHER_NAME": "",
        "COMPANY_NAME" : itemsListFactoryInfo.Name,
        "COMPANY_REGISTRATION_NO": itemsListFactoryInfo.Pin,
        "COMPANY_FOUND_DATE": "",
        "COMPANY_LICENSE_NO": "",
        "COMPANY_LICENSE_DATE_FROM": "",
        "COMPANY_LICENSE_DATE_TO": "",
        "EXCISE_REGISTRATION_NO": "",
        "GENDER_TYPE": 0,
        "ID_CARD": "",
        "BIRTH_DATE": "",
        "BLOOD_TYPE": "",
        "PASSPORT_NO": "",
        "VISA_TYPE": "",
        "PASSPORT_DATE_IN": "",
        "PASSPORT_DATE_OUT": "",
        "MARITAL_STATUS": 0,
        "CAREER": "",
        "PERSON_DESC": "",
        "EMAIL": "",
        "TEL_NO": "",
        "MISTREAT_NO": 1,
        "IS_ILLEGAL": 1,
        "IS_ACTIVE": 1,
        "MasPersonAddress":map_adress
      };

      int PERSON_ID;
      await new ArrestFutureMaster().apiRequestMasPersoninsAll(map).then((onValue) {
        PERSON_ID = onValue.RESPONSE_DATA;
      });

      if(PERSON_ID!=null){
        Map map_person={
          "TEXT_SEARCH" : "",
          "PERSON_ID" : PERSON_ID
        };
        print(map_person.toString());
        await new ArrestFutureMaster().apiRequestMasPersongetByCon(map_person).then((onValue) {
          onValue.RESPONSE_DATA.forEach((f){
            f.IsCreate=true;
          });
          itemSearch = onValue.RESPONSE_DATA;
          Navigator.pop(context);
        });
      }
    }

    setState(() {});
    return true;
  }

  _navigateSearch(BuildContext mContext) async {

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
      "SystemId":"WSS",
      "UserName":"wss001",
      "Password":"123456",
      "IpAddress":"10.1.1.1",
      "requestData":{
        "RegId":editIdentifyNumber.text
      }
    };
    await onLoadAction(map);
    Navigator.pop(context);

    if(itemSearch.length>0){
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Search(
          ItemsDataGet: itemSearch,
          itemsTitle: widget.itemsTitle,
        )),
      );
      if(result.toString()!="back"){
        _itemsData = result;
        Navigator.pop(mContext,result);
      }
    }else{
      new EmptyDialog(mContext, "ไม่พบข้อมูลผู้ต้องหา");
    }
  }

  CupertinoAlertDialog _cupertinoNetworkError(mContext,text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonCancelStyle = TextStyle(
        fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
              },
              child: new Text('ตกลง', style: ButtonAcceptStyle)),
        ],
    );
  }

  void _showEmptyAlertDialog(context,text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context,text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("ค้นหาผู้ต้องหา",
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
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
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
                          child: new Text('ILG60_B_01_00_12_00',
                            style: textStylePageName,),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
