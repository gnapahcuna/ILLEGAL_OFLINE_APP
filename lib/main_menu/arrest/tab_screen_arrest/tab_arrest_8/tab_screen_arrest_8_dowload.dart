import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:share_extend/share_extend.dart';

class TabScreenArrest8Dowload extends StatefulWidget {
  String Title;
  String FILE_NAME;
  TabScreenArrest8Dowload({
    Key key,
    @required this.Title,
    @required this.FILE_NAME,
  }) : super(key: key);
  @override
  _TabScreenArrest8DowloadState createState() => new _TabScreenArrest8DowloadState();
}
class _TabScreenArrest8DowloadState extends State<TabScreenArrest8Dowload> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    if (widget.FILE_NAME.isNotEmpty) {
      loadDocument(widget.FILE_NAME);
    }
  }

  loadDocument(String FILE_NAME) async {
    setState(() => _isLoading = true);
    var dir = await getApplicationDocumentsDirectory();
    String tempPath = dir.path;
    print('$tempPath/$FILE_NAME.pdf');
    File file = new File('$tempPath/$FILE_NAME.pdf');
    document = await PDFDocument.fromFile(file);
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _isLoading = false;
  }

  void share(String FILE_NAME) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/$FILE_NAME.pdf");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle styleTextEmpty = TextStyle(fontSize: 18.0,
        fontFamily: FontStyles().FontFamily);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(widget.Title,
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
          actions: <Widget>[
            widget.FILE_NAME.isNotEmpty
                ? new FlatButton(
              onPressed: () {
                share(widget.FILE_NAME);
              },
              child: Icon(Icons.file_download, color: Colors.white,),
            )
                : Container(),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          Center(
              child: widget.FILE_NAME.isNotEmpty
                  ? (_isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : PDFViewer(
                showPicker: false,
                document: document,
              )
              )
                  : Text('ไม่พบแบบฟอร์ม', style: styleTextEmpty,)
          ),
        ],
      ),
    );
  }
}