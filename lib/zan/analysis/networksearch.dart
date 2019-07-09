import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_relationship.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'dart:async';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
 
 
 TextStyle textStyleLabel = TextStyle(
        fontSize: 16,
        color: Color(0xff087de1),
        fontFamily: FontStyles().FontFamily);
    TextStyle textStyleData = TextStyle(
        fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelEditStyle = TextStyle(
        fontSize: 16.0,
        color: Colors.red[200],
        fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

class NetworkSuspect extends StatefulWidget {
  ItemsListArrestPerson ItemsSuspect;
ItemsListArrestPersonRelationShip Itemsus;

  ItemsMasterTitleResponse itemsTitle;

  List ItemsDataGet;

  NetworkSuspect({
    Key key,
    @required this.ItemsSuspect,
    @required this.itemsTitle,
    @required this.Itemsus,

  }) : super(key: key);
  @override
  _NetworkSuspectState createState() => new _NetworkSuspectState();
}

class _NetworkSuspectState extends State<NetworkSuspect>
    with TickerProviderStateMixin {
  ItemsListArrestPerson ItemsPreviewIndicmentDetail = null;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildContent() {
    var size = MediaQuery.of(context).size;
   

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        //    Navigator.of(context).push( new MaterialPageRoute(builder: (context) => HistorySuspect( ItemsSuspect: widget.ItemsSuspect)));
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabScreenArrest4Suspect2(
                                  ItemsSuspect: widget.ItemsSuspect)),
                        );*/
                      },
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/images/zan/arest.jpg',
                                width: 130.0, height: 130.0),
                            Text(
                              widget.ItemsSuspect.TITLE_SHORT_NAME_TH +
                                  widget.ItemsSuspect.FIRST_NAME +
                                  " " +
                                  widget.ItemsSuspect.LAST_NAME,
                              style: textStyleData,
                            ),
                          ],
                        ),
                      )),
                  Divider(),


                ],
              ),
            ],
          ),
        ),


       
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(
        color: Colors.grey[400],
        fontFamily: FontStyles().FontFamily,
        fontSize: 12.0);
    TextStyle styleTextAppbar =
        TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_01_00_15_00', style: textStylePageName,),
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
