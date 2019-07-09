import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/zan/detail/topic_detaillow.dart';

import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_not_accept_screen_offense_list.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';



Color labelColor = Color(0xff087de1);
TextStyle textInputStyle = TextStyle(
    fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
TextStyle textAppbar = TextStyle(
    fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(
    fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
TextStyle textStyleSelect = TextStyle(
    fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
TextStyle textedit = TextStyle(
    fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily,);
EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);



class StoryPerson extends StatefulWidget {
  @override
  
  ItemsLawsuitSuspect ItemsSuspect;
  StoryPerson({
    Key key,
    @required this.ItemsSuspect,
  }) : super(key: key);


  _StoryPersonState createState() => _StoryPersonState();
}

class _StoryPersonState extends State<StoryPerson> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ประวัติผู้ต้องหา',
            style: textAppbar,
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    
                                    Text("ชื่อผู้ต้องหา" ,style: textLabelStyle,),
                                    
                                    
                                  ],
                                ),
                              ),               
                              Text("อุตโม", style: textStyleSelect),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทผู้ต้องหา', style: textLabelStyle),
                              Text(' บุคคลธรรมดา', style: textStyleSelect),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทบุคคล', style: textLabelStyle),
                              Text(' คนไทย', style: textStyleSelect),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(' เลขที่บัตรประชาชน', style: textLabelStyle),
                            Text(' 155600009661', style : textStyleSelect),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ที่อยู่',
                                  textAlign: TextAlign.left,
                                  style: textLabelStyle),
                              Text(
                                ' เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น',
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: textStyleSelect,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TopicDetailLow(),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('จำนวนครั้งที่กระทำผิด',
                                style: textLabelStyle),
                            Text('2 ครั้ง', style: textStyleSelect)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[Icon(Icons.chevron_right)],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  
  }
}






















































/*
class StoryPerson extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ประวัติผู้ต้องหา',
            style: textAppbar,
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    
                                    Text("ชื่อผู้ต้องหา" ,style: textLabelStyle,),
                                    
                                    FlatButton(
                                      child: Text(
                                        "แก้ไข",
                                        style: textedit,
                                      ),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditSuspecMainScreenFragment(),
                                          )),
                                    )
                                  ],
                                ),
                              ),               
                              Text(' นายเสนาะ อุตโม', style: textStyleSelect),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทผู้ต้องหา', style: textLabelStyle),
                              Text(' บุคคลธรรมดา', style: textStyleSelect),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ประเภทบุคคล', style: textLabelStyle),
                              Text(' คนไทย', style: textStyleSelect),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(' เลขที่บัตรประชาชน', style: textLabelStyle),
                            Text(' 155600009661', style: textStyleSelect),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(' ที่อยู่',
                                  textAlign: TextAlign.left,
                                  style: textLabelStyle),
                              Text(
                                ' เลขที่ 146 หมู่ที่ 8 ถนนเบย ต.หนองห้อง อ.หนองสองห้อง จ.ขอนแก่น',
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: textStyleSelect,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TopicDetailLow(),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('จำนวนครั้งที่กระทำผิด',
                                style: textLabelStyle),
                            Text('2 ครั้ง', style: textStyleSelect)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[Icon(Icons.chevron_right)],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
*/