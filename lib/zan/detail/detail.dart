

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';


Color labelColor = Color(0xff087de1);
TextStyle textInputStyle = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
TextStyle textAppbar = TextStyle(fontSize: 18.0,color: Colors.white,fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(fontSize: 16.0,color: labelColor ,fontFamily: FontStyles().FontFamily);
TextStyle textStyleSelect = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


class DetaiLow extends StatefulWidget {
  String nTopic;
  String nLow;
  DetaiLow(this.nTopic,this.nLow);
  @override
  _DetaiLowState createState() => _DetaiLowState(nTopic,nLow);
}

class _DetaiLowState extends State<DetaiLow> {
  String nTopic;
  String nLow;
  _DetaiLowState(this.nTopic,this.nLow);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar:
          AppBar(title: Text('เลขรับคำกล่าวโทษ $nTopic',style: textAppbar,), centerTitle: true),
      body: ListView(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('เลขรับคำกล่าวโทษ',
                              style: textLabelStyle),
                          Text(nTopic, style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('มาตรา',
                              style: textLabelStyle),
                          Text(nLow, style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ฐาน',
                              style: textLabelStyle),
                          Text('มีไว้ครอบครองโดยมิได้เสียภาษี',
                              style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('วันที่จับกุม',
                              style: textLabelStyle),
                          Text('09 กันยายน 2561',
                              style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ประเภทของกลาง',
                              style: textLabelStyle),
                          Text('สุรา', style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('สถานที่จับกุม',
                              style: textLabelStyle),
                          Text(
                              'ร้านค้าสุรายาสูบ เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น',
                              style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('เลขที่เปรียบเทียบคดี',
                              style: textLabelStyle),
                          Text('1/2561', style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ค่าปรับ',
                              style: textLabelStyle),
                          Text('10,000  บาท', style: textStyleSelect)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('คดีสิ้นสุดชั้น',
                              style: textLabelStyle),
                          Text('กรมสรรพสามิต', style: textStyleSelect)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}






















