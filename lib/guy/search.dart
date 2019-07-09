import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'chat.dart';
import 'package:flutter/cupertino.dart';

 TextStyle textLabelStyle =
        TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle1 =
        TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
        TextStyle styleTextSearch = TextStyle(fontSize: 16.0);
String name = "Boss";
int name1 ;

 void _showDialog() {
    // flutter defined function
    showDialog(
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


class Search1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.text,
                style: styleTextSearch,

                decoration: new InputDecoration(
                  hintText: "ค้นหา",
                  hintStyle: styleTextSearch,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                  ),
                ),
                onSubmitted: (String name1) {
                  if (name1 == name) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new MyApp()),
                    );
                  } else if (name1 != name) {
                    TextStyle TitleStyle = TextStyle(
                        fontSize: 16.0, fontFamily: FontStyles().FontFamily);
                    TextStyle ButtonAcceptStyle = TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontStyles().FontFamily);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
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
                                    Navigator.pop(context);
                                  },
                                  child: new Text(
                                      'ยืนยัน', style: ButtonAcceptStyle)),
                            ]
                        );
                      },
                    );
                  } else {

                  }
                },
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,), onPressed: () {
              Navigator.pop(context, "Back");
            }),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}