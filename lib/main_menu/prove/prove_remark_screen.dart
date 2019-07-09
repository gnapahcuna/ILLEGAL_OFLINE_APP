
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_size.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_search_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/choice.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'future/prove_future.dart';
import 'model/prove_arrest_product.dart';
import 'model/prove_indicment_product.dart';
import 'model/prove_main.dart';

class ProveRemarkScreenFragment extends StatefulWidget {
  String  PROVE_RESULT;
  bool IsCreate;
  bool IsPreview;
  ItemsProveMain itemsProveMain;
  ProveRemarkScreenFragment({
    Key key,
    @required this.PROVE_RESULT,
    @required this.IsCreate,
    @required this.IsPreview,
    @required this.itemsProveMain,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveRemarkScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;

  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;

  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  //ItemsProveArrestIndicmentProduct ItemsMain;
  String PROVE_RESULT;

  //node focus
  final FocusNode myFocusNodeRemark = FocusNode();
  TextEditingController editRemark = new TextEditingController();


  TextStyle textLabelEditNonCheckStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.red[100],
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = TextStyle(
      fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(
      fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff31517c),
      fontFamily: FontStyles().FontFamily);
  TextStyle TitleStyle = TextStyle(
      fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.red,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(
      fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  double VAT_TOTAL = 0;
  bool IsEnableVatTotal = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      PROVE_RESULT = widget.PROVE_RESULT;
      editRemark.text = PROVE_RESULT;

      if (widget.IsPreview) {
        _onSaved = true;
        _onFinish = true;
      }else{
        _onSaved = false;
        _onFinish = false;
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    editRemark.dispose();
  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(
          left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          )
      ),
      child: new Container(
        //padding: paddingData,
        child: TextField(
          focusNode: myFocusNodeRemark,
          controller: editRemark,
          keyboardType: TextInputType.multiline,
          textCapitalization:
          TextCapitalization.words,
          style: textStyleData,
          maxLines: 20,
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[800], width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[600], width: 0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent_saved() {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Container(
          padding: paddingData,
          child: Text(PROVE_RESULT!=null
              ?PROVE_RESULT.toString():"", style: textStyleData,),
        )
    );
  }

  void onSaved(BuildContext mContext) async {
    print("PROVE_ID : "+widget.itemsProveMain.PROVE_ID.toString());
    if(widget.itemsProveMain!=null){
      Map map = {
        "PROVE_ID": widget.itemsProveMain.PROVE_ID,
        "LAWSUIT_ID": widget.itemsProveMain.LAWSUIT_ID,
        "DELIVERY_OFFICE_ID": "1",
        "RECEIVE_OFFICE_ID": "1",
        "PROVE_TYPE": "1",
        "DELIVERY_DOC_NO_1": "",
        "DELIVERY_DOC_NO_2": "",
        "DELIVERY_DOC_DATE": "",
        "DELIVERY_OFFICE_CODE": "",
        "DELIVERY_OFFICE_NAME": "",
        "RECEIVE_OFFICE_CODE": "",
        "RECEIVE_OFFICE_NAME": widget.itemsProveMain.RECEIVE_OFFICE_NAME,
        "PROVE_NO": widget.itemsProveMain.PROVE_NO,
        "PROVE_NO_YEAR": widget.itemsProveMain.PROVE_NO_YEAR,
        "RECEIVE_DOC_DATE": widget.itemsProveMain.RECEIVE_DOC_DATE,
        "COMMAND": widget.itemsProveMain.COMMAND!=null
            ?widget.itemsProveMain.COMMAND:"",
        "LAWSUIT_NO": widget.itemsProveMain.LAWSUIT_NO,
        "LAWSUIT_NO_YEAR": DateTime.now().toString(),
        "OCCURRENCE_DATE": /*"2018-02-05 10:55:00.1234567 +7:00"*/ "",
        "OUT_OFFICE_NAME": "",
        "IS_OUTSIDE": "1",
        "IS_SCIENCE": widget.itemsProveMain.IS_SCIENCE,
        "IS_RECEIVE": "1",
        "PROVE_DATE":  widget.itemsProveMain.PROVE_DATE,
        "PROVE_RESULT": widget.itemsProveMain.PROVE_RESULT,
        "IS_ACTIVE": "1"
      };
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(
              ),
            );
          });
      await onLoadActionUpdate(map);
      Navigator.pop(context);

    }else{
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(
              ),
            );
          });
      await onLoadAction();
      Navigator.pop(context);
      setState(() {
        PROVE_RESULT = editRemark.text;
        _onSaved = true;
        _onFinish = true;
      });
    }
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> onLoadActionUpdate(Map map) async {
    await new ProveFuture().apiRequestProveupdByCon(map).then((onValue) {
      print("Update Prove : " + onValue.Msg);
    });
    //get by con
    Map map_prove_id = {"PROVE_ID": widget.itemsProveMain.PROVE_ID};
    await new ProveFuture()
        .apiRequestProvegetByCon(map_prove_id)
        .then((onValue) {
      PROVE_RESULT = onValue.PROVE_RESULT;
    });

    _onSaved = true;
    _onFinish = true;
    setState(() {});
    return true;
  }

  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        editRemark.text = PROVE_RESULT;
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการยกเลิกข้อมูลทั้งหมด.",
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
                Navigator.pop(context);
                Navigator.pop(mContext, "Back");
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  //แสดง dialog ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }


  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                // _onSaved ? Navigator.pop(context, itemMain) :
                if (_onSaved) {
                  Navigator.pop(context, PROVE_RESULT);
                } else {
                  _showCancelAlertDialog(context);
                }
              },
              padding: EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  !_onSaved
                      ? new Text(
                    "ยกเลิก",
                    style: appBarStyle,
                  )
                      : new Container(),
                ],
              ),
            ),
          )),
      Expanded(
          child: Center(
            child: Text(/*"สรุปผลรายงานการพิสูจน์"*/"สรุปผลรายงาน...", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[_onSaved ? (_onSave ? new FlatButton(
                onPressed: () {
                  setState(() {
                    _onSaved = true;
                    _onSave = false;
                    _onEdited = false;
                  });
                  //TabScreenArrest1().createAcceptAlert(context);
                },
                child: Text('บันทึก', style: appBarStyle))
                :
            PopupMenuButton<Constants>(
              onSelected: choiceAction,
              icon: Icon(Icons.more_vert, color: Colors.white,),
              itemBuilder: (BuildContext context) {
                return constants.map((Constants contants) {
                  return PopupMenuItem<Constants>(
                    value: contants,
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            contants.icon, color: Colors.grey[400],),),
                        Padding(padding: EdgeInsets.only(left: 4.0),
                          child: Text(contants.text),)
                      ],
                    ),
                  );
                }).toList();
              },
            )
            )
                :
            new FlatButton(
                onPressed: () {
                  onSaved(context);
                },
                child: Text('บันทึก', style: appBarStyle)),
            ],
          )
      )
    ];
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          /*appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: Text("สรุปผลรายงานการพิสูจน์",
                style: styleTextAppbar,
              ),
              actions: <Widget>[
                _onSaved ? (_onSave ? new FlatButton(
                    onPressed: () {
                      setState(() {
                        _onSaved = true;
                        _onSave = false;
                        _onEdited = false;
                      });
                      //TabScreenArrest1().createAcceptAlert(context);
                    },
                    child: Text('บันทึก', style: appBarStyle))
                    :
                PopupMenuButton<Constants>(
                  onSelected: choiceAction,
                  icon: Icon(Icons.more_vert, color: Colors.white,),
                  itemBuilder: (BuildContext context) {
                    return constants.map((Constants contants) {
                      return PopupMenuItem<Constants>(
                        value: contants,
                        child: Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                contants.icon, color: Colors.grey[400],),),
                            Padding(padding: EdgeInsets.only(left: 4.0),
                              child: Text(contants.text),)
                          ],
                        ),
                      );
                    }).toList();
                  },
                )
                )
                    :
                new FlatButton(
                    onPressed: () {
                      onSaved(context);
                    },
                    child: Text('บันทึก', style: appBarStyle)),
              ],
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    if (_onSaved) {
                      Navigator.pop(context, ItemsMain);
                    } else {
                      _showCancelAlertDialog(context);
                    }
                  }),
            ),
          ),*/
          body: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                primary: true,
                pinned: false,
                flexibleSpace: new BottomAppBar(
                  elevation: 0.0,
                  color: Color(0xff2e76bc),
                  child: new Row(children: rowContents),
                ),
                automaticallyImplyLeading: false,
              ),
              SliverFillRemaining(
                child: Scaffold(
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
                                    border: Border(
                                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                      bottom: BorderSide(
                                          color: Colors.grey[300], width: 1.0),
                                    )
                                ),
                              ),
                              Expanded(
                                child: new ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: SingleChildScrollView(
                                    child: _onSaved
                                        ? _buildContent_saved()
                                        : _buildContent(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
      ),
    );
  }
}
