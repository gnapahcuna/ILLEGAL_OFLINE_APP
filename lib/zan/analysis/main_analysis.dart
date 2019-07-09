import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'network.dart';
import 'report.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/zan/analysis/networksearch.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'dart:async';

Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleSelect = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


class NetPerson extends StatefulWidget {
  ItemsListArrestPerson ItemsSuspect;
  
  ItemsMasterTitleResponse itemsTitle;
  List ItemsDataGet;
  NetPerson({
    Key key,
    @required this.ItemsSuspect,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  _NetPersonState createState() => _NetPersonState();
}

class _NetPersonState extends State<NetPerson> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
           bottom: TabBar(
            
             labelStyle: textLabelStyle,
            tabs: <Widget>[
              Tab(text: "ผู้ต้องหา",),
              Tab(text: "รายงาน"),
              
            ],
          ),
          
          title: Text('วิเคราะห์ข้อมูลผู้ต้องหา',style: styleTextAppbar,),
          leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          centerTitle: true,

        ),
        
        body: TabBarView(
          children: <Widget>[
            NetworkSuspect(ItemsSuspect: widget.ItemsSuspect),
            ReportPerson(),
            
          ],
        ),
      ),
    );
  }
}




