import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class ReportPerson extends StatelessWidget {
  @override
Color labelColor = Color(0xff087de1);
TextStyle textInputStyle = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
TextStyle textAppbar = TextStyle(fontSize: 18.0,color: Colors.white,fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
TextStyle textStyleSelect = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            new Column(
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  onPressed: () {},
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('1. ทะเบียนประวัติผู้กระทำผิด ', style: textStyleSelect),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('2. รายละเอียดการกระทำผิดของผู้กระทำผิด',style: textStyleSelect,),
                            
                        Icon(Icons.navigate_next)
                      ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
