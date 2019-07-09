import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_saver/image_picker_saver.dart' as image_saver;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:exif/exif.dart';
import 'package:http/http.dart' as http;

int ye = 543;
String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('  HH:mm น. d-MM-2562');
  return formatter.format(now);
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ItemsData> _messages;
  ScrollController scrollController;

  File imageFile;

  Future<String> getExifFromFile() async {
    if (imageFile == null) {
      return null;
    }

    var bytes = await imageFile.readAsBytes();
    var tags = await readExifFromBytes(bytes);
    var sb = StringBuffer();

    tags.forEach((k, v) {
      sb.write("$k: $v \n");
    });
    for (String key in tags.keys) {
      print("$key (${tags[key].tagType}): ${tags[key]}");
    }

    return sb.toString();
  }

  pickImageFromGallery(ImageSource source)async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      imageFile=image;
      _messages.add(ItemsData("",imageFile,DateTime.now().toString(),false));

    });
    String base64Image = base64Encode(image.readAsBytesSync());
    String fileName = image.path.split("/").last;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    //Map map = {'TEXT_SEARCH': text, 'ACCOUNT_OFFICE_CODE': widget.ItemsData.UnderOffCode};
    Map map = {
      "DATA_SOURCE": "",
      "DOCUMENT_ID": "",
      "DOCUMENT_NAME": "asdasdasdasdasd",
      "DOCUMENT_OLD_NAME": "testWordOld",
      "DOCUMENT_TYPE": "3",
      "FILE_TYPE": "jpg",
      "FOLDER": "Person",
      "IS_ACTIVE": "1",
      "REFERENCE_CODE": "1111",
      "CONTENT":base64Image
    };

    await onLoadAction(map);
  }
  Future<bool> onLoadAction(Map map) async {
    await new TransectionFuture().apiRequestDocumentinsAll(map).then((onValue) {
      print("");
    });
    setState(() {});
    return true;
  }

  pickCamera(ImageSource source)async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      imageFile=image;

      if(imageFile!=null){
        _messages.add(ItemsData("",imageFile,DateTime.now().toString(),false));
      }

    });
  }

  TextEditingController textEditingController;

  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    _messages = List<ItemsData>();
    _messages.add(ItemsData("สวัสดีครับ",null, "2019-05-27 05:01",true));
    _messages.add(ItemsData("สวัสดีครับ",null, "2019-06-27 05:01",true));
    _messages.add(ItemsData("ครับว่าไง",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("เป็นไงบ้าง",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("สบายดี",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("ครับ",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("คดีเสือดำเป็นไงบ้าง",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("ทำสำนวนคดีอยู่ครับ",null,DateTime.now().toString(),true));
    _messages.add(ItemsData("บิ้ก สำนวนคดีอย่าลืมส่งมานะ",null,DateTime.now().toString(),true));

    textEditingController = TextEditingController();

    scrollController = ScrollController();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');

    super.initState();
  }

  void handleSendMessage() {
    var text = textEditingController.value.text;
    textEditingController.clear();
    setState(() {
      _messages.add(ItemsData(text,null,DateTime.now().toString(),true));

      enableButton = false;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          curve: Curves.ease, duration: Duration(milliseconds: 500));
    });
  }

  bool enableButton = false;


  @override
  Widget build(BuildContext context) {
    TextStyle textLabelStyle =
    TextStyle(fontSize: 16.0,
        fontFamily: FontStyles().FontFamily,
        color: Colors.white);
    TextStyle textLabelSubStyle =
    TextStyle(fontSize: 14.0,
        fontFamily: FontStyles().FontFamily,
        color: Colors.grey[400]);
    TextStyle textLabelSubStyleAction =
    TextStyle(fontSize: 14.0,
        fontFamily: FontStyles().FontFamily,
        decoration: TextDecoration.underline,
        color: Colors.grey[400]);
    TextStyle textLabelHintStyle =
    TextStyle(fontSize: 16.0,
        fontFamily: FontStyles().FontFamily,
        color: Colors.grey[400]);
    TextStyle textLabelDateStyle =
    TextStyle(fontSize: 16.0,
        fontFamily: FontStyles().FontFamily,
        color: Colors.grey[700]);
    TextStyle textLabelStyle1 =
    TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle3 =
    TextStyle(fontSize: 13.0, fontFamily: FontStyles().FontFamily);

    TextStyle textLabelLink =
    TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);

    var textInput = Container(
      height: 60,
      child: Row(
        // mainAxisAlignment: prefix0.MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.camera_alt, color: Color(0xff549ee8), size: 32.0,),
              onPressed: () {
                pickCamera(ImageSource.camera);
              }),
          IconButton(
            icon: Icon(Icons.photo, color: Color(0xff549ee8), size: 32.0,),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(Icons.folder, color: Colors.orangeAccent, size: 32.0,),
            onPressed: () async {
              File file = await FilePicker.getFile(type: FileType.ANY);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    enableButton =
                        text.isNotEmpty; //อนูญาตให้ใช้ปุ่มเมื่อช่องไม่ว่าง
                  });
                },
                decoration: InputDecoration.collapsed(
                    hintText: "พิมพ์ข้อความ", hintStyle: textLabelHintStyle),
                controller: textEditingController,
              ),
            ),
          ),
          enableButton
              ? IconButton(
            color: Colors.blue,
            icon: Icon(Icons.send),
            disabledColor: Colors.grey,
            onPressed: handleSendMessage,
          )
              : IconButton(
            color: Colors.blue,
            icon: Icon(Icons.send),
            disabledColor: Colors.grey,
            onPressed: null,
          )
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "จ่าตุ่น",
          style: textLabelStyle1,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,), onPressed: () {
          Navigator.pop(context);
        }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info_outline,), onPressed: () {
            //Navigator.pop(context);
            new InforDialog(
                context,
                "แจ้งเตือน",
                "ประวัติข้อมูลการสนทนา สามารถเก็บได้ 7 วัน"
            );
          }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    bool reverse = false;

                    if (index % 2 == 0) {
                      reverse = true;
                    }

                    var messagebody = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xff549ee8),
                              borderRadius: BorderRadius.circular(8)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _messages[index].message,
                                style: textLabelStyle,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(_convertTime(_messages[index].time_stamp),
                            style: textLabelSubStyle,),
                        )
                      ],
                    );

                    Widget message;

                    if (reverse) {
                      message = Stack(
                        children: <Widget>[
                          messagebody,
                        ],
                      );
                    } else {
                      message = Stack(
                        children: <Widget>[
                          messagebody,
                        ],
                      );
                    }
                    if (index == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              _convertDate(_messages[index].time_stamp),
                              style: textLabelDateStyle,),
                          )
                        ],
                      );
                    }

                    var imagebody;
                    if (!_messages[index].IsText) {
                      imagebody = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 250.0,
                            height: 250.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.white30),
                            ),
                            //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                            padding: const EdgeInsets.all(3.0),
                            child: Image.file(
                              _messages[index].file, fit: BoxFit.contain,),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  _convertTime(_messages[index].time_stamp),
                                  style: textLabelSubStyle,),
                              ),
                              /*Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: FlatButton(
                                    onPressed: () {

                                    },
                                    child: Text(
                                      "save",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFFbdbdbd),
                                        fontFamily: FontStyles().FontFamily,
                                        fontSize: 14.0,),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: FlatButton(
                                    onPressed: () {
                                    },
                                    child: Text(
                                      "forword?",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFFbdbdbd),
                                        fontFamily: FontStyles().FontFamily,
                                        fontSize: 14.0,),
                                    )),
                              ),*/
                              new ButtonTheme(
                                minWidth: 44.0,
                                padding: new EdgeInsets.all(4.0),
                                child: new ButtonBar(children: <Widget>[
                                  new FlatButton(
                                    child: new Text("บันทึก",style: textLabelSubStyleAction,),
                                    onPressed: () {
                                      _onImageSaveButtonPressed(context,_messages[index].file);
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text("ส่งต่อ",style: textLabelSubStyleAction,),
                                    onPressed: () => debugPrint("Button 2"),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          /*FutureBuilder(
                            future: getExifFromFile(),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  return Text(snapshot.data);
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }
                              return Container();
                            },
                          ),*/
                        ],
                      );
                    }

                    if (reverse) {
                      var avatar = /*Padding(
                        padding:
                        const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                        child: Icon(
                          Icons.person_pin,
                          color: Color(0xff5887f9),
                          size: 40,
                        ),
                      );*/
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30),
                        ),
                        //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                        padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: new Image(
                              fit: BoxFit.cover,
                              image: new AssetImage(
                                  'assets/images/avatar.jpg')),
                        ),
                      );

                      return Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _messages[index].IsText ? message :
                                  imagebody
                              ),
                              avatar,
                            ],
                          ),
                        ],
                      );
                    } else {
                      var avatar = Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30),
                        ),
                        //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                        padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: new Image(
                              fit: BoxFit.cover,
                              image: new AssetImage(
                                  'assets/images/avatar_chat.jpeg')),
                        ),
                      );
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          avatar,
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _messages[index].IsText ? message :
                              imagebody
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 2,
              ),
              textInput,
            ],
          ),
        ],
      ),
    );
  }
  String _convertDate(String sDate){
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(
        " ");
    result = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();


    return result;
  }
  String _convertTime(String sDate){
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " +
        dateFormatTime.format(dt).toString();
    return result;
  }

  void _onImageSaveButtonPressed(BuildContext context,File imageFIle) async {
   /* print("_onImageSaveButtonPressed");
    var response = await http
        .get('http://upload.art.ifeng.com/2017/0425/1493105660290.jpg');

    debugPrint(response.statusCode.toString());
*/
    var filePath = await image_saver.ImagePickerSaver.saveFile(
        fileData: imageFIle.readAsBytesSync(), title: 'ImagePickerPicture',
        description: 'example of image picker saver');

    var savedFile= File.fromUri(Uri.file(filePath));
    setState(() {
      Future<File>.sync(() => savedFile);
      Scaffold.of(context).showSnackBar(new SnackBar(
        content:  new Text("บันทึกสำเร็จ"),
      ));
      //_imageFile = Future<File>.sync(() => savedFile);
    });
  }
}

class ItemsData {
  String message;
  File file;
  String time_stamp;
  bool IsText;
  ItemsData(this.message,
      this.file,
      this.time_stamp,
      this.IsText);
}
