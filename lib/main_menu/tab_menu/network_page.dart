import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/zan/analysis_recog_search_screen.dart';
import 'package:prototype_app_pang/zan/search/SearchPerson.dart';
import 'package:prototype_app_pang/zan/search/result/Search_result_Camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_face.dart';


Color labelColor = Color(0xff087de1);
TextStyle textInputStyle = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
TextStyle textappbar = TextStyle(fontSize: 18.0,color: Colors.white,fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
TextStyle textStyleSelect = TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: FontStyles().FontFamily);
EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

List _itemsData = [];

class NetworkFragment extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<NetworkFragment> {
  Future<File> _imageFile;

  void _showImage(context) {
    _onImageButtonPressed(ImageSource.camera,context);
  }

  void _showDialogPicker(){
    showDialog(context: context,builder: (context) => _onTapImage(context)); // Call the Dialog.
  }


  void _onImageButtonPressed(ImageSource source,mContext) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
      print(_imageFile.toString());
      _imageFile.then((f){
        List splits = f.path.split("/");
        print(splits[splits.length-1]);
        _navigateSearchFace(context,_imageFile);
      });
      Navigator.pop(mContext);
    });
  }
  _navigateSearchFace(BuildContext mContext,_imageFile) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (mContext) => AnalysisRecognitionSearchScreenFragment(ImageFile: _imageFile,)),
    );
    if(result.toString()!="back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }
  }








  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        /*appBar: AppBar(
        title: Text('วิเคราะห์ข้อมูลผู้ต้องหา',
            style: TextStyle(fontFamily: 'Kanit')),
        centerTitle: true,
        backgroundColor: Color(0xff2e76bc),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchPerson(),
                  ))),
        ],
      ),*/
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: SingleChildScrollView(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    /*FlatButton(
                        onPressed: () {
                          _showDialogPicker();
                        },
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              size: 200,
                              color: Color(0xff2e76bc),
                            ),
                            Text(
                              'ค้นหาด้วยรูปภาพ',
                              style: TextStyle(
                                  fontFamily: FontStyles().FontFamily, fontSize: 25),
                            )
                          ],
                        ))*/
                    new SizedBox(
                      height: (size.width * 40) / 100,
                      width: (size.width * 40) / 100,
                      child: new RawMaterialButton(
                        onPressed: () {
                          _showDialogPicker();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(28.0),
                          child: Image(
                            image: AssetImage(
                                "assets/icons/landing/network_landing.png"),
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                        ),
                        shape: new CircleBorder(),
                        elevation: 2.0,
                        fillColor: Color(0xff087de1),
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 32.0),
                      child: Text("ค้นหาด้วยรูปภาพ", style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily),),)
                  ],
                ),
              ),)
          ],
        )
    );
  }

  _onTapImage(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child:  Container(
                  width: width/3,
                  height: height/7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child:Icon(Icons.camera_alt,color: Colors.blue,size: 38.0,),
                ),
                onTap: (){_showImage(context);},
              ),
              GestureDetector(
                child: Container(
                  width: width/3,
                  height: height/7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(Icons.image,color: Colors.blue,size: 38.0,),
                ),
                onTap: (){
                  _onImageButtonPressed(ImageSource.gallery,context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }


}