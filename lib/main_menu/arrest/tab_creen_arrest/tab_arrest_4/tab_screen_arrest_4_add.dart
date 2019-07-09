import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add_service_reg.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search_face.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_search.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest4Add extends StatefulWidget {
  ItemsMasterTitleResponse itemsTitle;
  TabScreenArrest4Add({
    Key key,
    @required this.itemsTitle,
  }) : super(key: key);
  @override
  TabScreenArrest4AddState createState() => new TabScreenArrest4AddState();
}
class TabScreenArrest4AddState extends State<TabScreenArrest4Add> {
  List<ItemsListArrestLawbreaker> itemSearch=[];

  //node type1
  final FocusNode myFocusNodeIdentifyNumber = FocusNode();
  final FocusNode myFocusCompanyRegistationNo = FocusNode();
  final FocusNode myFocusPassportNo = FocusNode();
  final FocusNode myFocusNodeNameSus = FocusNode();
  final FocusNode myFocusAgentName = FocusNode();

  final FocusNode myFocusNodeNameFather_1 = FocusNode();
  final FocusNode myFocusNodeNameMother_1 = FocusNode();
  final FocusNode myFocusNodePlace = FocusNode();

  //node type1
  TextEditingController editIdentifyNumber = new TextEditingController();
  TextEditingController editCompanyRegistationNo = new TextEditingController();
  TextEditingController editPassportNo = new TextEditingController();
  TextEditingController editAgentName = new TextEditingController();

  TextEditingController editNameSus = new TextEditingController();
  TextEditingController editFather = new TextEditingController();
  TextEditingController editMother = new TextEditingController();
  TextEditingController editPlace = new TextEditingController();

  //dropbox type1
  String dropdownValue_1 = 'นาย';
  List<String> dropdownItems_1 = ['นาย', 'นาง', 'นางสาว', "รต.ต.ต."];

  //node type2
  final FocusNode myFocusNodeEntityNumber = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();
  final FocusNode myFocusNodeExciseRegistrationNumber = FocusNode();
  final FocusNode myFocusNodeCompanyNameTitle = FocusNode();
  final FocusNode myFocusNodeCompanyHeadName = FocusNode();
  final FocusNode myFocusNodeNameFather_2 = FocusNode();
  final FocusNode myFocusNodeNameMother_2 = FocusNode();

  //node type2
  TextEditingController editEntityNumber = new TextEditingController();
  TextEditingController editCompanyName = new TextEditingController();
  TextEditingController editExciseRegistrationNumber = new TextEditingController();
  TextEditingController editCompanyNameTitle = new TextEditingController();
  TextEditingController editCompanyHeadName = new TextEditingController();
  TextEditingController editNameFather_2 = new TextEditingController();
  TextEditingController editNameMother_2 = new TextEditingController();

  //dropbox type2
  String dropdownValue_2 = 'นาย';
  List<String> dropdownItems_2 = ['นาย', 'นาง', 'นางสาว', "รต.ต.ต."];

  bool _suspectType1 = false;
  bool _suspectType2 = false;
  /*bool _nationalityType1 = false;
  bool _nationalityType2 = false;*/

  List _itemsData = [];

  Future<File> _imageFile;
  VoidCallback listener;


  TextStyle textSearchByImgStyle = TextStyle(
      fontSize: 16.0, color: Colors.blue.shade400,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);


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
      MaterialPageRoute(builder: (mContext) => TabScreenArrest4SearchFace(ImageFile: _imageFile,)),
    );
    if(result.toString()!="back"){
      _itemsData = result;
      Navigator.pop(context,result);
    }
  }

  @override
  void initState() {
    super.initState();
    _suspectType1 = true;
    //_nationalityType1 = true;

    listener = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    super.dispose();
    //node type1
    editIdentifyNumber.dispose();
    editCompanyRegistationNo.dispose();
    editPassportNo.dispose();
    editAgentName.dispose();
    editNameSus.dispose();
    editPlace.dispose();

    //node type2
    editEntityNumber.dispose();
    editCompanyName.dispose();
    editExciseRegistrationNumber.dispose();
    editCompanyNameTitle.dispose();
    editCompanyHeadName.dispose();
    editNameMother_2.dispose();
    editNameFather_2.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    //EdgeInsets paddingLabelSearchImg = EdgeInsets.only(top: 8.0);
    var size = MediaQuery
        .of(context)
        .size;


    return Container(
        decoration: BoxDecoration(
            //color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0,left: 22.0,right: 22.0),
            //width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //padding: paddingLabelSearchImg,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new ButtonTheme(
                        padding: new EdgeInsets.all(0.0),
                        child: new FlatButton(
                            onPressed: () {
                              _showDialogPicker();
                            },
                            child: Text(
                              "ค้นหาด้วยรูปภาพ",
                              style: textSearchByImgStyle,
                            )
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  //padding: paddingLabel,
                  child: Text("ประเภทบุคคล", style: textLabelStyle,),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width / 2.4,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _suspectType1 = true;
                                _suspectType2 = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _suspectType1 ? Color(0xff3b69f3) : Colors
                                    .white,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: _suspectType1
                                      ? Icon(
                                    Icons.check,
                                    size: 30.0,
                                    color: Colors.white,
                                  )
                                      : Container(
                                    height: 30.0,
                                    width: 30.0,
                                    color: Colors.transparent,
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('บุคคลธรรมดา',
                              style: textStyleSelect,),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: size.width / 2.4,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _suspectType2 = true;
                                  _suspectType1 = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _suspectType2 ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: _suspectType2
                                        ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.white,
                                    )
                                        : Container(
                                      height: 30.0,
                                      width: 30.0,
                                      color: Colors.transparent,
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('ผู้ประกอบการ',
                                style: textStyleSelect,),
                            )
                          ],
                        )
                    )
                  ],
                ),
                /*Container(
                  padding: paddingLabel,
                  child: Text("ประเภทผู้ต้องหา", style: textLabelStyle,),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width / 2.4,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                _nationalityType1 = true;
                                _nationalityType2 = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _nationalityType1 ? Color(0xff3b69f3) : Colors
                                    .white,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: _nationalityType1
                                      ? Icon(
                                    Icons.check,
                                    size: 30.0,
                                    color: Colors.white,
                                  )
                                      : Container(
                                    height: 30.0,
                                    width: 30.0,
                                    color: Colors.transparent,
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('คนไทย',
                              style: textStyleSelect,),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: size.width / 2.4,
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _nationalityType2 = true;
                                  _nationalityType1 = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _nationalityType2
                                      ? Color(0xff3b69f3)
                                      : Colors.white,
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: _nationalityType2
                                        ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.white,
                                    )
                                        : Container(
                                      height: 30.0,
                                      width: 30.0,
                                      color: Colors.transparent,
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('คนต่างชาติ',
                                style: textStyleSelect,),
                            )
                          ],
                        )
                    )
                  ],
                ),*/
                _suspectType1 ? _buildInputType1() : _buildInputType2(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: labelColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          elevation: 0.0,
                          child: Container(
                            width: 80.0,
                            child: MaterialButton(
                              onPressed: () {
                                _navigateSearch(context);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text("ค้นหา", style: textLabelStyle,),),
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _buildInputType1() {
    Widget _buildLine = Container(
      padding: EdgeInsets.only(bottom: 4.0,left: 22.0,right: 22.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("หมายเลขบัตรประชาชน", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeIdentifyNumber,
            controller: editIdentifyNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text("หมายเลขทะเบียนนิติบุคคล", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusCompanyRegistationNo,
            controller: editCompanyRegistationNo,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
        Container(
          padding: paddingLabel,
          child: Text("หมายเลขหนังสือเดินทาง", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusPassportNo,
            controller: editPassportNo,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อผู้ต้องหา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
       /* Container(
          padding: paddingLabel,
          child: Text("ชื่อสถานประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeCompanyHeadName,
            controller: editCompanyHeadName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
        /*Container(
          padding: paddingLabel,
          child: Text("คำนำหน้าชื่อ", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue_1,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_1 = newValue;
                });
              },
              items: dropdownItems_1
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ),
        _buildLine,*/
        Container(
          padding: paddingLabel,
          child: Text("บิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameFather_1,
            controller: editFather,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("มารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameMother_1,
            controller: editMother,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text("ที่อยู่สถานที่ประกอบ (ตำบล/อำเภอ/จังหวัด)",
            style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodePlace,
            controller: editPlace,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
      ],
    );
  }

  Widget _buildInputType2() {
    var size = MediaQuery
        .of(context)
        .size;
    //final double Width = (size.width * 80) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      //width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("หมายเลขทะเบียนนิติบุคคล", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeEntityNumber,
            controller: editEntityNumber,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("หมายเลขทะเบียนสรรพสามิต", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeExciseRegistrationNumber,
            controller: editExciseRegistrationNumber,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("ชื่อผู้ประกอบการ", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyName,
            controller: editCompanyName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text(
            "คำนำหน้าชื่อตัวแทนสถานประกอบการ", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValue_2,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_2 = newValue;
                });
              },
              items: dropdownItems_2
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ),
        ),
        _buildLine,*/
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อตัวแทน", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameSus,
            controller: editNameSus,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        /*Container(
          padding: paddingLabel,
          child: Text("บิดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameFather_2,
            controller: editFather,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text("มารดา", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeNameMother_2,
            controller: editMother,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,*/
      ],
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor,fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: boxColor, width: 1.5),
                  borderRadius: BorderRadius.circular(42.0)
              ),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {

                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload, size: 32, color: uploadColor,),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "แนบรูปผู้ต้องหา", style: textLabelStyle,),),

                        ],
                      )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new ArrestFuture().apiRequestMasPersongetByConAdv(map).then((onValue) {
      itemSearch = onValue;
    });
    setState(() {});
    return true;
  }

  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {
      "TEXT_SEARCH" : ""
    };
    Map map_country = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    setState(() {});
    return true;
  }

  _navigateCreate(BuildContext mContext)async{
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionCountryMaster();
    Navigator.pop(context);

    if(itemsCountry!=null){
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Create(
          ItemTitle: widget.itemsTitle,
          ItemCountry: itemsCountry,
          IsUpdate: false,
          ItemsPerson: null,
          Title: "สร้างผู้ต้องหา",
        )),
      );
      if(result.toString()!="back"){
        Navigator.pop(context, result);
      }
    }
  }

  _navigateSearch(BuildContext mContext) async {
    int ENTITY_TYPE;
    int PERSON_TYPE;
    if(_suspectType1){
      ENTITY_TYPE=0;
    }else{
      ENTITY_TYPE=1;
    }
    /*if(_nationalityType1){
      PERSON_TYPE=0;
    }else{
      PERSON_TYPE=1;
    }*/

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    Map map = {
      'ENTITY_TYPE': ENTITY_TYPE,
      'PERSON_TYPE': "",
      'ID_CARD':editIdentifyNumber.text,
      'COMPANY_REGISTRATION_NO': editCompanyRegistationNo.text,
      'PASSPORT_NO': editPassportNo.text,
      'PERSON_NAME':editNameSus.text,
      'AGENT_NAME': editPassportNo.text,
      'FATHER_NAME':editNameFather_2.text,
      'MOTHER_NAME':editNameMother_2.text,
    };
    await onLoadAction(map);
    Navigator.pop(context);

    if(itemSearch.length>0){
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(builder: (context) => TabScreenArrest4Search(
          ItemsDataGet: itemSearch,
          itemsTitle: widget.itemsTitle,
        )),
      );
      if(result.toString()!="back"){
        _itemsData = result;
        Navigator.pop(mContext,result);
      }
    }else{
      if(_suspectType2){
        _showEmptyAlertDialog(mContext,"ไม่พบข้อมูลผู้ต้องหา, ต้องการค้นหาข้อมูลทะเบียนผู้ประกอบการกรมสรรพสามิตหรือไม่");
      }else{
        new EmptyDialog(mContext, "ไม่พบข้อมูลผู้ต้องหา");
      }
    }
  }

  _navigat_service_reg(BuildContext mContext)async{
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(builder: (context) => TabScreenArrest4AddServiceReg(
        itemsTitle: widget.itemsTitle,
      )),
    );
  }
  CupertinoAlertDialog _cupertinoNetworkError(mContext,text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonCancelStyle = TextStyle(
        fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                _navigat_service_reg(mContext);
              },
              child: new Text('ตกลง', style: ButtonAcceptStyle)),
        ],
    );
  }

  void _showEmptyAlertDialog(context,text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoNetworkError(context,text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Padding(
              padding: EdgeInsets.only(right: 22.0),
              child: new Text("ค้นหาผู้ต้องหา",
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
              new FlatButton(
                onPressed: () {
                  _navigateCreate(context);
                },
                child: Text("สร้าง",
                  style: styleTextAppbar,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //height: 34.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_12_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),
                  Expanded(
                    child: new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SingleChildScrollView(
                        child: _buildContent(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
  void _showImage(context) {
    _onImageButtonPressed(ImageSource.camera,context);
  }

  void _showDialogPicker(){
    showDialog(context: context,builder: (context) => _onTapImage(context)); // Call the Dialog.
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
