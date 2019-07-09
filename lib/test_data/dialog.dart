import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tip_dialog/tip_dialog.dart';


class MyAppDialog extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyAppDialog> {
  Widget _buildItem(String name, VoidCallback callback) {
    return new GestureDetector(
      onTap: callback,
      child: new ListTile(
        title: new Text(name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new TipDialogContainer(
        duration: const Duration(seconds: 2),
    child: new Scaffold(
      appBar: new AppBar(
        title: new Text("asdas"),
        elevation: 0.5,
      ),
      body: new TipDialogConnector(
        builder: (context, tipController) {
          return new ListView(children: <Widget>[
            _buildItem("Loading Type Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                      type: TipDialogType.LOADING, tip: "Loading"),
                  isAutoDismiss: false);
              await new Future.delayed(new Duration(seconds: 3));
              tipController.dismiss();
            }),
            new Divider(),
            _buildItem("Success Type Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                    type: TipDialogType.SUCCESS,
                    tip: "บันทึกเรียบร้อย",
                  ));
            }),
            new Divider(),
            _buildItem("Fail Type Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                    type: TipDialogType.FAIL,
                    tip: "Load Failed ",
                  ));
            }),
            new Divider(),
            _buildItem("Info Type Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                    type: TipDialogType.INFO,
                    tip: "Do Not Repeat",
                  ));
            }),
            new Divider(),
            _buildItem("Only Icon Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                    type: TipDialogType.SUCCESS,
                  ));
            }),
            new Divider(),
            _buildItem("Only text Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog(
                    type: TipDialogType.NOTHING,
                    tip: "Do Not Repeat",
                  ));
            }),
            new Divider(),
            _buildItem("Custom Icon Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog.customIcon(
                    icon: new Icon(
                      Icons.file_download,
                      color: Colors.white,
                      size: 30.0,
                      textDirection: TextDirection.ltr,
                    ),
                    tip: "Download",
                  ));
            }),
            new Divider(),
            _buildItem("Custom Body Tip Dialog", () async {
              tipController.show(
                  tipDialog: new TipDialog.builder(
                    bodyBuilder: (context) {
                      return new Container(
                        width: 120.0,
                        height: 90.0,
                        alignment: Alignment.center,
                        child: new Text(
                          "Custom",
                          style: new TextStyle(color: Colors.white),

                          /// if TipDialogContainer are outside of MaterialApp,
                          /// here is a must to set
                          textDirection: TextDirection.ltr,
                        ),
                      );
                    },
                    color: Colors.blue.withAlpha(150),
                  ));
            }),
            new Divider(),
          ]);
        },
      ),
    ),
    );
  }
}