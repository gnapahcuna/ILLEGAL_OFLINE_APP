
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'story.dart';


    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black,fontFamily: FontStyles().FontFamily);
    TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
TextStyle textStyleLabel = TextStyle(fontSize: 16,color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
TextStyle textInputStyle = TextStyle(fontSize: 16,color: Colors.black,fontFamily: FontStyles().FontFamily);
class NetworkPerson extends StatelessWidget {
  var arr = ['ใบงานจับกุมเดียวกัน', 'บิดา - มารดา', 'ที่อยู่ เดียวกัน'];
  var group = [
    'นางวิไล เมืองใจ',
    'นายธันวา เด่นไกล',
    'นายเสนาะ อุตโม',
    'นายสมชาย ไขแสง'
  ];

  var family = ['นายกลั่า อุตโม'];

  var address = [
    'นายอลังการ แสนสาน',
    'นายออด เกิดพูล',
    'นายเทพ ทวี',
    'นายกวิน ปิ่นมงคล',
    'นายสิธา คล้ายสุบรรณ',
    'นายสวด ภูมิคอนสาร'
  ];

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      
      children: <Widget>[
        
        Container(
          margin: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  color: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => StoryPerson(),
                      )),
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/person_1.jpg',
                            width: 100.0, height: 100.0),
                        Text('นายเสนาะ อุตโม', style: textInputStyle),
                      ],
                    ),
                  ))
            ],
          ),
        ),

          Container(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(arr[0],
                          style: textStyleLabel),
                    ],
                  ), 
                ],  
              );   
            },
          ),
         ),

        Container(
          margin: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/person_1.jpg',
                              width: 100.0, height: 100.0),
                          Text('นายอลัง แสน', style: textInputStyle),
                        ],
                      ),
                    )),
                RaisedButton(
                    color: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/person_1.jpg',
                              width: 100.0, height: 100.0),
                          Text('นายออด เกิดพูล', style: textInputStyle),
                        ],
                      ),
                    )),
                RaisedButton(
                    color: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/person_1.jpg',
                              width: 100.0, height: 100.0),
                          Text('นายเทพ ทวี', style: textInputStyle),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),


         Container(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(arr[1],
                          style: textStyleLabel),
                    ],
                  ),
                ],
              );
            },
          ),
        ),




        Container(
          margin: EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/person_1.jpg',
                              width: 100.0, height: 100.0),
                          Text('นางสิธา คล้ายสุ', style: textInputStyle),
                        ],
                      ),
                    )),
                
                RaisedButton(
                    color: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/person_1.jpg',
                              width: 100.0, height: 100.0),
                          Text('นายสวน อุตโม', style: textInputStyle),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}







































