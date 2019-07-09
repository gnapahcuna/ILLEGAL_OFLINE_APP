/*import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


import 'main_menu/future/transection_future.dart';

class TestPage extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<TestPage> {
  //final imgUrl = "https://unsplash.com/photos/iEJVyyevw-U/download?force=true";
  //final imgUrl = "http://103.233.193.94:2223/XCS60/downloadFile.html/7";
  final imgUrl = "http://103.233.193.62:8000/Report_XCS/ILG60_00_03_001.aspx";
  bool downloading = false;
  var progressString = "";

  @override
  void initState() {
    super.initState();

    //downloadFile();
    getImage();
  }
  Future<void> getImage() async{
    var uri = Uri.parse("http://103.233.193.62:8000/Report_XCS/ILG60_00_03_001.aspx");

    Map body = {
      'ArrestCode': "TN1004006201941"};
    try {
      final response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: utf8.encode(json.encode(body)));

      if (response.contentLength == 0){
        return;
      }
      //var dir = await getApplicationDocumentsDirectory();

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = new File('$tempPath/TN1004006201942.pdf');
      await file.writeAsBytes(response.bodyBytes);
      //displayImage(file);

    }
    catch (value) {
      print(value);
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(imgUrl, "${dir.path}/test7.pdf",
          queryParameters: {"ArrestCode" : "TN1004006201941"},
          onReceiveProgress: (rec, total) {
            print("Rec: $rec , Total: $total");

            setState(() {
              downloading = true;
              progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
            });
          });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");

 *//*var dio = new Dio();
    dio.interceptors.add(LogInterceptor());
    // This is big file(about 200M)
//   var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";

    var url =
        "https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg";

    // var url = "https://www.baidu.com/img/bdlogo.gif";
    // await download1(dio, url, "./example/book1.jpg");
    //await download1(dio, url, (HttpHeaders headers)=>"./example/book1.jpg");
    var dir = await getApplicationDocumentsDirectory();
    await download2(dio, imgUrl, "${dir.path}/test6.pdf");

  }


  Future download1(Dio dio, String url, savePath) async {
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: showDownloadProgress,
      );
    } catch (e) {
      print(e);
    }
  }*//*

//Another way to downloading small file
  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.post(
        url,
        queryParameters: {"ArrestCode" : "TN1004006201941"},
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      print("hh : "+response.headers.toString());
      File file = new File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Center(
        child: downloading
            ? Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Downloading File: $progressString",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
            : Text("No Data"),
      ),
    );
  }
}*/

/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class TestPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TestPage> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {

    var dir = await getApplicationDocumentsDirectory();
    String tempPath = dir.path;
    File file = new File('$tempPath/TN1004006201942.pdf');
    document = await PDFDocument.fromFile(file);
    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/TN1004006201942.pdf');
      document = await PDFDocument.fromFile(file);
    } else if (value == 3) {
      document = await PDFDocument.fromURL(
          "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }
  void share() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/TN1004006201942.pdf");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 36),
              ListTile(
                title: Text('Load from Assets'),
                onTap: () {
                  changePDF(1);
                },
              ),
              ListTile(
                title: Text('Load from URL'),
                onTap: () {
                  changePDF(2);
                },
              ),
              ListTile(
                title: Text('Restore default'),
                onTap: () {
                  changePDF(4);
                },
              ),
              ListTile(
                title: Text('Path'),
                onTap: () {
                  changePDF(3);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('FlutterPluginPDFViewer'),
          actions: <Widget>[
            RaisedButton(
              child: Text('asdasd'),
              onPressed: () {
                share();
              },
            )
          ],
        ),
        body: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(
              showIndicator: false,
              showPicker: false,
              document: document,
            )),
      ),
    );
  }
}
*/

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_renderer/flutter_pdf_renderer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TestPage> {
  Future<String> downloadedFilePath;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PdfRenderer example app'),
        ),
        body: Column(children: <Widget>[
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter URL here...',
            ),
          ),
          RaisedButton(
            onPressed: download,
            child: Text('Render PDF'),
          ),
          FutureBuilder<String>(
            future: downloadedFilePath,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              Text text = Text('');
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  text = Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  text = Text('Data: ${snapshot.data}');
                  return PdfRenderer(pdfFile: snapshot.data, width: MediaQuery.of(context).size.width);
                } else {
                  text = Text('Unavailable');
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                text = Text('Downloading PDF File...');
              } else {
                text = Text('Please load a PDF file.');
              }
              return Container(
                child: text,
              );
            },
          ),
        ]),
      ),
    );
  }

  void download() {
    setState(() {
      downloadedFilePath = downloadPdfFile(controller.text);
    });
  }

  Future<String> downloadPdfFile(String url) async {
    final filename = "TN1004006200029_1.pdf";
    String dir = (await getApplicationDocumentsDirectory()).path;

    File file = new File('$dir/$filename');
    bool exist = false;
    try {
      await file.length().then((len) {
        exist = true;
      });
    } catch (e) {
      print(e);
    }
    if (!exist) {
      Map jsonMap = {
        "ArrestCode" : "TN1004006200029"
      };
      var body =  utf8.encode(json.encode(jsonMap));
      final response = await http.post(
        "http://103.233.193.62:8000/Report_XCS/ILG60_00_03_001.aspx",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      await file.writeAsBytes(response.bodyBytes);
    }
    return file.path;
  }
}
