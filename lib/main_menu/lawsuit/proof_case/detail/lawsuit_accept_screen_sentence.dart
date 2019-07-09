import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_deatail.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

const double _kPickerSheetHeight = 216.0;
class LawsuitAcceptSentenceScreenFragment extends StatefulWidget {
  ItemsListLawsuitDetail ItemSentence;
  bool IsPreview;
  bool IsUpdate;
  LawsuitAcceptSentenceScreenFragment({
    Key key,
    @required this.ItemSentence,
    @required this.IsPreview,
    @required this.IsUpdate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitAcceptSentenceScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;
  //ศาลยกฟ้อง
  bool _isDismissed=false;
  //สั่งปรับ
  bool _isFine=true;
  //สั่งจำคุก
  bool _isImprison=false;
  //จ่ายครั้งเดียว
  bool _isOneTime=true;
  //แบ่งจ่ายเป็นงวด
  bool _isPeriod=false;

  //dropdown หน่วยการชำระเงินเป็นงวด
  String dropdownValueFine = 'วัน';
  List<String> dropdownItemsFine = ['วัน','สัปดาห์', 'เดือน', 'ปี'];
  //dropdown หน่วยการสั่งจำคุก
  String dropdownValueImprison = 'วัน';
  List<String> dropdownItemsImprison = ['วัน', 'เดือน', 'ปี'];

  //node focus
  final FocusNode myFocusNodeCourtName = FocusNode();
  final FocusNode myFocusNodeUndecidedCase = FocusNode();
  final FocusNode myFocusNodeUndecidedYear = FocusNode();
  final FocusNode myFocusNodeDateReadCase = FocusNode();
  final FocusNode myFocusNodeDateFine = FocusNode();
  final FocusNode myFocusNodeDecidedCase = FocusNode();
  final FocusNode myFocusNodeDecidedYear = FocusNode();
  final FocusNode myFocusNodeFineValue= FocusNode();
  final FocusNode myFocusNodeImprison= FocusNode();
  final FocusNode myFocusNodePeriod= FocusNode();
  final FocusNode myFocusNodePeriodNum= FocusNode();

  //textfield
  TextEditingController editCourtName = new TextEditingController();
  TextEditingController editUndecidedCase= new TextEditingController();
  TextEditingController editUndecidedYear= new TextEditingController();
  TextEditingController editDateReadCase = new TextEditingController();
  TextEditingController editDateFine = new TextEditingController();
  TextEditingController editDecidedCase= new TextEditingController();
  TextEditingController editDecidedYear= new TextEditingController();
  TextEditingController editFineValue= new TextEditingController();
  TextEditingController editImprison= new TextEditingController();
  TextEditingController editPeriod= new TextEditingController();
  TextEditingController editPeriodNum= new TextEditingController();

  String dropdownValueCourtType="ศาลชั้นต้น";
  List<String> dropdownItemsCourtType = ["ศาลชั้นต้น","ศาลอุทธรณ์"];

  final formatter = new NumberFormat("#,###.#");
  final formatter1 = new NumberFormat("####");
  final formatter_fine = new NumberFormat("#,###.00");

  //วันเดือนปี เวลา ปัจจุบัน
  String _currentDate,_currentTime;
  var dateFormatDate,dateFormatTime;
  DateTime _initDate=DateTime.now();
  //วันที่กำหนดชำระค่าปรับ
  String _currentDateFine;
  DateTime _dtDateFine=DateTime.now();
  DateTime _dtUndecidedDateFine=DateTime.now();
  DateTime _dtDecidedDateFine=DateTime.now();

  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //model คำพิพากษาศาล
  ItemsListLawsuitDetail itemMain;
  //style text
  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData1 = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0);
  TextStyle textStyleStar = TextStyle(color: Colors.red,fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff31517c),fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(fontSize: 16.0,color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0,fontFamily: FontStyles().FontFamily);


  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
    color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
    fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];
  @override
  void initState() {
    super.initState();
    //set วันเดือนปี เวลา ปัจจุบัน
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0]+" "+splits[1]+" "+(int.parse(splits[3])+543).toString();
    _currentDate=date;
    _currentDateFine=date;
    _currentTime = dateFormatTime.format(DateTime.now()).toString();

    editDateReadCase.text= _currentDate;
    editDateFine.text=_currentDateFine;

    itemMain=widget.ItemSentence;

    //_dtUndecidedDateFine=DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    //_dtDecidedDateFine=DateTime.parse(itemMain.DECIDE_NO_YEAR_2);

    _isFine=itemMain.IS_FINE==0?false:true;
    //_isPeriod=itemMain.IS_PAYONCE==0?false:true;
    _isImprison=itemMain.IS_IMPRISON==0?false:true;
    _isDismissed=false;

    if(itemMain.IS_PAYONCE==1){
      _setInitData1();
      _isPeriod=false;
      _isOneTime=true;
    }else{
      _isPeriod=true;
      _isOneTime=false;
      _setInitData2();
    }

    if(widget.IsPreview){
      _onSaved=widget.IsPreview;
      _onFinish=widget.IsPreview;
      _onSave=widget.IsPreview;
      _onEdited=widget.IsUpdate;
    }else{
      _onSaved=widget.IsPreview;
      _onFinish=widget.IsPreview;
      _onSave=widget.IsPreview;
      _onEdited=widget.IsUpdate;
    }



  }

  @override
  void dispose() {
    super.dispose();
    editCourtName.dispose();
    editUndecidedCase.dispose();
    editDecidedCase.dispose();
    editFineValue.dispose();
    editImprison.dispose();
    editPeriod.dispose();
    editPeriodNum.dispose();
    editDateReadCase.dispose();
    editDateFine.dispose();
    editUndecidedYear.dispose();
    editDecidedYear.dispose();
  }

  // set text data ชำระครั้งเดียว
  void _setInitData1(){
    String sentence_date = "";
    String fine_date = "";
    DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/
    DateTime dt_fine_date = itemMain.FINE_DATE!=null
        ?DateTime.parse(itemMain.FINE_DATE)
        :DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(
        " ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(
        " ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " +
        (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " +
        (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = DateTime.parse(itemMain.DECIDE_NO_YEAR_2);
    DateTime dt_Undecide_date = DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(
        " ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(
        " ");
    DECIDE_NO_YEAR_2=(int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2=(int.parse(splitsUndecideDate[3]) + 543).toString();


    editCourtName.text=itemMain.COURT_NAME;
    editUndecidedCase.text=itemMain.UNDECIDE_NO_2.toString();
    editUndecidedYear.text=UNDECIDE_NO_YEAR_2;
    editDecidedCase.text=itemMain.DECIDE_NO_2.toString();
    editDecidedYear.text=DECIDE_NO_YEAR_2;
    editFineValue.text=formatter1.format(itemMain.FINE).toString();
    editImprison.text=formatter1.format(itemMain.IMPRISON_TIME).toString();
    if(itemMain.IMPRISON_TIME_UNIT==0){
      dropdownValueImprison = "วัน";
    }else if(itemMain.IMPRISON_TIME_UNIT==1){
      dropdownValueImprison = "เดือน";
    }else{
      dropdownValueImprison = "ปี";
    }
  }
  // set text data ชำระเป็นงวด
  void _setInitData2(){
    String sentence_date = "";
    String fine_date = "";
    DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/
    DateTime dt_fine_date = itemMain.FINE_DATE!=null
        ?DateTime.parse(itemMain.FINE_DATE)
        :DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(
        " ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(
        " ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " +
        (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " +
        (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = DateTime.parse(itemMain.DECIDE_NO_YEAR_2);
    DateTime dt_Undecide_date = DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(
        " ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(
        " ");
    DECIDE_NO_YEAR_2=(int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2=(int.parse(splitsUndecideDate[3]) + 543).toString();


    editCourtName.text=itemMain.COURT_NAME;
    editUndecidedCase.text=itemMain.UNDECIDE_NO_2.toString()+"/"+UNDECIDE_NO_YEAR_2;
    editDecidedCase.text=itemMain.DECIDE_NO_2.toString()+"/"+DECIDE_NO_YEAR_2;
    editFineValue.text=formatter1.format(itemMain.FINE).toString();
    editImprison.text=formatter1.format(itemMain.IMPRISON_TIME).toString();
    if(itemMain.IMPRISON_TIME_UNIT==0){
      dropdownValueImprison = "วัน";
    }else if(itemMain.IMPRISON_TIME_UNIT==1){
      dropdownValueImprison = "เดือน";
    }else{
      dropdownValueImprison = "ปี";
    }
    _currentDate=sentence_date;
    _currentDateFine=fine_date;

    editDateReadCase.text= _currentDate;
    editDateFine.text=_currentDateFine;
    editPeriod.text=itemMain.PAYMENT_PERIOD.toString();
    editPeriodNum.text=itemMain.PAYMENT_PERIOD_DUE.toString();

    if(itemMain.PAYMENT_PERIOD_DUE_UNIT==0){
      dropdownValueFine = "วัน";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==1){
      dropdownValueFine = "สัปดาห์";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==2){
      dropdownValueFine = "เดือน";
    }else{
      dropdownValueFine = "ปี";
    }

  }

  //ล้างย้อมูลใน textfield
  void clearTextfield(){
    editCourtName.clear();
    editUndecidedCase.clear();
    editDecidedCase.clear();
    editFineValue.clear();
    editImprison.clear();
    editPeriod.clear();
    editPeriodNum.clear();
  }

  //popup เมื่อกดแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;

      } else {
        _showDeleteAlertDialog();
      }
    });
  }
  //popup delete
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูลทั้งหมด.",
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
                setState(() {
                  _onSaved = false;
                  _onEdited = false;
                  _onSave = false;
                  itemMain=null;
                  clearTextfield();
                  Navigator.pop(context,itemMain);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  // popup layout ยกเลิกรายการ
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext){
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
                Navigator.pop(mContext,itemMain);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  // popup method ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }
  //แสดง popup ปฏิทิน วันอ่านคำพิพากษา
  Future<DateTime> _selectDateSentence(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
  //แสดง popup ปฏิทิน วันที่กำหนดชำระค่าปรับ
  Future<DateTime> _selectDateFine(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
  //get file รูปภาพ
  Future getImage(ImageSource source,mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
    Navigator.pop(mContext);
  }

  //แสดง popup ให้เลือกรูปจากกล้องหรทอแกลอรี่
  void _showDialogImagePicker(){
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
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.camera_alt, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.camera,context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(Icons.image, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.gallery,context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0,fontFamily: FontStyles().FontFamily
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      locale: Locale('th', 'TH'),
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),

    );
  }

  //ส่วนของ body
  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 18.0,top: 8,bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isDismissed = !_isDismissed;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _isDismissed ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(color: Colors.black38,width: 1.5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: _isDismissed
                                        ? Icon(
                                      Icons.check,
                                      size: 16.0,
                                      color: Colors.white,
                                    )
                                        : Container(
                                      height: 16.0,
                                      width: 16.0,
                                      color: Colors.transparent,
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "ศาลยกฟ้อง", style: textStyleLabel,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ประเภทศาล", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      width: size.width,
                      //padding: paddingInputBox,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValueCourtType,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueCourtType= newValue;
                            });
                          },
                          items: dropdownItemsCourtType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: textStyleData),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("ชื่อศาล", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeCourtName,
                              controller: editCourtName,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("หมายเลขคดีดำ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Container(
                              padding: paddingLabel,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeUndecidedCase,
                                      controller: editUndecidedCase,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Padding(
                            padding: paddingData,
                            child: new Text("/",
                              style: textStyleData,
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    enableInteractiveSelection: false,
                                    onTap: () {
                                      /*FocusScope.of(context).requestFocus(
                                          new FocusNode());
                                      showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return _buildBottomPicker(
                                            CupertinoDatePicker(
                                              mode: CupertinoDatePickerMode.date,
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged: (DateTime newDateTime) {
                                                setState(() {
                                                 *//* lawsuitTime = newDateTime;
                                                  _currentTimeLawsuit =
                                                      dateFormatTime.format(lawsuitTime)
                                                          .toString();
                                                  editLawsuitTime.text =
                                                      _currentTimeLawsuit;

                                                  List splitsArrestDate = _dtDateLawsuit
                                                      .toUtc().toLocal().toString().split(
                                                      " ");
                                                  List splitsArrestTime = lawsuitTime
                                                      .toString().split(" ");
                                                  _lawsuitDate =
                                                      splitsArrestDate[0].toString() +
                                                          " " +
                                                          splitsArrestTime[1].toString();*//*
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      );*/
                                    },
                                    focusNode: myFocusNodeUndecidedYear,
                                    controller: editUndecidedYear,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("หมายเลขคดีแดง", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Container(
                              padding: paddingLabel,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeDecidedCase,
                                      controller: editDecidedCase,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Padding(
                            padding: paddingData,
                            child: new Text("/",
                              style: textStyleData,
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDecidedYear,
                                    controller: editDecidedYear,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันอ่านคำพิพากษา", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DynamicDialog(
                                    Current: _initDate);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _initDate=s;
                              _currentDate=date;
                              editDateReadCase.text = _currentDate;
                            });
                          });
                        },
                        focusNode: myFocusNodeDateReadCase,
                        controller: editDateReadCase,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    !_isDismissed?Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 18.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isFine = !_isFine;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: _isFine ? Color(0xff3b69f3) : Colors
                                            .white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: _isFine
                                              ? Icon(
                                            Icons.check,
                                            size: 16.0,
                                            color: Colors.white,
                                          )
                                              : Container(
                                            height: 16.0,
                                            width: 16.0,
                                            color: Colors.transparent,
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "สั่งปรับเป็นจำนวน", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                          _isFine
                              ?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingData,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        focusNode: myFocusNodeFineValue,
                                        controller: editFineValue,
                                        keyboardType: TextInputType.number,
                                        textCapitalization: TextCapitalization
                                            .words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixText: 'บาท',
                                            suffixStyle: textStyleSubData
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 18.0, left: 12.0,bottom: 8,top: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _isOneTime = true;
                                                    _isPeriod = false;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _isOneTime ? Color(0xff3b69f3) : Colors
                                                        .white,
                                                    border: Border.all(color: Colors.black12),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: _isOneTime
                                                          ? Icon(
                                                        Icons.check,
                                                        size: 16.0,
                                                        color: Colors.white,
                                                      )
                                                          : Container(
                                                        height: 16.0,
                                                        width: 16.0,
                                                        color: Colors.transparent,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "ชำระครั้งเดียว", style: textStyleData1,),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: paddingLabel,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 18.0, left: 12.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _isPeriod = true;
                                                    _isOneTime = false;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _isPeriod ? Color(0xff3b69f3) : Colors
                                                        .white,
                                                    border: Border.all(color: Colors.black12),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: _isPeriod
                                                          ? Icon(
                                                        Icons.check,
                                                        size: 16.0,
                                                        color: Colors.white,
                                                      )
                                                          : Container(
                                                        height: 16.0,
                                                        width: 16.0,
                                                        color: Colors.transparent,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "เเบ่งชำระเป็นงวด", style: textStyleData1,),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              _isPeriod?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text("จำนวนงวด", style: textStyleLabel,),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            focusNode: myFocusNodePeriodNum,
                                            controller: editPeriodNum,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization
                                                .words,
                                            style: textStyleData,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 1.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ):Container(),
                              Container(
                                padding: paddingLabel,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        "วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                                    ),
                                    Padding(
                                      padding: paddingData,
                                      child: TextField(
                                        enableInteractiveSelection: false,
                                        onTap: () {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DynamicDialog(
                                                    Current: _dtDateFine);
                                              }).then((s) {
                                            String date = "";
                                            List splits = dateFormatDate.format(
                                                s).toString().split(" ");
                                            date = splits[0] + " " + splits[1] +
                                                " " +
                                                (int.parse(splits[3]) + 543)
                                                    .toString();
                                            setState(() {
                                              _dtDateFine=s;
                                              _currentDateFine=date;
                                              editDateFine.text=_currentDateFine;
                                            });
                                          });
                                        },
                                        focusNode: myFocusNodeDateFine,
                                        controller: editDateFine,
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                              _isPeriod?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text("รอบชำระค่าปรับทุก", style: textStyleLabel,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: ((size.width * 75) / 100) / 1.5,
                                        child: Container(
                                          padding: paddingData,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Container(
                                                //padding: paddingData,
                                                child: TextField(
                                                  focusNode: myFocusNodePeriod,
                                                  controller: editPeriod,
                                                  keyboardType: TextInputType.number,
                                                  textCapitalization: TextCapitalization
                                                      .words,
                                                  style: textStyleData,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 1.0,
                                                color: Colors.grey[300],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: ((size.width * 75) / 100) / 2.5,
                                        child:  Container(
                                          padding: paddingData,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Container(
                                                //padding: paddingData,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      DropdownButtonHideUnderline(
                                                        child: DropdownButton<String>(
                                                          value: dropdownValueFine,
                                                          onChanged: (String newValue) {
                                                            setState(() {
                                                              dropdownValueFine = newValue;
                                                            });
                                                          },
                                                          items: dropdownItemsFine
                                                              .map<DropdownMenuItem<String>>((String value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value,style: textStyleData1,),
                                                            );
                                                          })
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              Container(
                                                height: 1.0,
                                                color: Colors.grey[300],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ):Container(),
                            ],
                          ):Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 18.0, /*left: 12.0*/),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isImprison = !_isImprison;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: _isImprison ? Color(0xff3b69f3) : Colors
                                                .white,
                                            border: Border.all(color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: _isImprison
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                                color: Colors.transparent,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "สั่งจำคุกเป็นจำนวน", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                              _isImprison
                                  ?Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ((size.width * 75) / 100) / 1.5,
                                    child: Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeImprison,
                                              controller: editImprison,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ((size.width * 75) / 100) / 2.5,
                                    child:  Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      value: dropdownValueImprison,
                                                      onChanged: (String newValue) {
                                                        setState(() {
                                                          dropdownValueImprison = newValue;
                                                        });
                                                      },
                                                      items: dropdownItemsImprison
                                                          .map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,style: textStyleData1,),
                                                        );
                                                      })
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ):Container()
                            ],
                          )
                        ],
                      ),
                    ):Container()
                  ],
                ),
              ),
              Container(
                width: size.width,
                child: _buildButtonImgPicker(),
              ),
              _buildDataImage(context),
            ],
          ),
        )
    );
  }
  Widget _buildContent_saved(BuildContext context) {
    String IMPRISON_TIME_UNIT="";
    if(itemMain.IMPRISON_TIME_UNIT==0){
      IMPRISON_TIME_UNIT="วัน";
    }else if(itemMain.IMPRISON_TIME_UNIT==1){
      IMPRISON_TIME_UNIT="เดือน";
    }else{
      IMPRISON_TIME_UNIT="ปี";
    }

    String PAYMENT_PERIOD_DUE_UNIT="";
    if(itemMain.PAYMENT_PERIOD_DUE_UNIT==0){
      PAYMENT_PERIOD_DUE_UNIT="วัน";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==1){
      PAYMENT_PERIOD_DUE_UNIT="สับดาห์";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==2){
      PAYMENT_PERIOD_DUE_UNIT="เดือน";
    }else{
      PAYMENT_PERIOD_DUE_UNIT="ปี";
    }

    String sentence_date = "";
    String fine_date = "";
    DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/
    DateTime dt_fine_date = itemMain.FINE_DATE!=null
        ?DateTime.parse(itemMain.FINE_DATE)
        :DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(
        " ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(
        " ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " +
        (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " +
        (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = DateTime.parse(itemMain.DECIDE_NO_YEAR_2);
    DateTime dt_Undecide_date = DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(
        " ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(
        " ");
    DECIDE_NO_YEAR_2=(int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2=(int.parse(splitsUndecideDate[3]) + 543).toString();

    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("หมายเลขคดีเเดง", style: textStyleLabel,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemMain.DECIDE_NO_2.toString()+"/"+DECIDE_NO_YEAR_2,
                          style: textStyleData,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: paddingData,
                    child: Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  /*itemMain.IS_ACTIVE==0?Container(
                    padding: paddingLabel,
                    child: Text("ศาลยกฟ้อง", style: textStyleLink,),
                  ):Container(),*/
                  Container(
                    padding: paddingLabel,
                    child: Text("ประเภทศาล", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      "ศาลชั้นต้น",
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("ชื่อศาล", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.COURT_NAME,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("หมายเลขคดีดำ", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      itemMain.UNDECIDE_NO_2.toString()+"/"+UNDECIDE_NO_YEAR_2, style: textStyleData,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text("วันอ่านคำพิพากษาศาล", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      sentence_date, style: textStyleData,),
                  ),
                  itemMain.IS_FINE==1?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text("สั่งปรับเป็นจำนวน", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          formatter_fine.format(itemMain.FINE).toString()+" บาท", style: textStyleData,),
                      ),
                      itemMain.IS_PAYONCE==1?Container(
                        padding: paddingLabel,
                        child: Text("ชำระครั้งเดียว", style: textStyleLink,),
                      )
                          :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("แบ่งชำระเป็นงวด", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("จำนวนงวด", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.PAYMENT_PERIOD.toString(), style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("รอบชำระค่าปรับทุก", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemMain.PAYMENT_PERIOD_DUE.toString()+" "+PAYMENT_PERIOD_DUE_UNIT, style: textStyleData,),
                          ),
                        ],
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          fine_date, style: textStyleData,),
                      ),
                    ],
                  ):Container(),
                  itemMain.IS_IMPRISON==1?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text( "สั่งจำคุกเป็นจำนวน", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          formatter.format(itemMain.IMPRISON_TIME).toString()+" "+IMPRISON_TIME_UNIT, style: textStyleData,),
                      ),
                    ],
                  ):Container()
                ],
              ),
              /*Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<Constants>(
                  onSelected: choiceAction,
                  icon: Icon(Icons.more_vert, color: Colors.black,),
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
                              child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily)),)
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              )*/
            ],
          )
        ),
      ),
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    return Container(
      padding: EdgeInsets.only(left:18.0,top: 18.0),
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
                    //_onImageButtonPressed(ImageSource.gallery, context);
                    //getImage();
                    _showDialogImagePicker();
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
                              "เลือกไฟล์/รูปภาพ", style: textLabelStyle,),
                          ),

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
  Widget _buildDataImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30),
                      ),
                      //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(_arrItemsImageFile[index],fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageName[index],
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: Icon(Icons.delete_outline,size: 32.0,),
                        onPressed: (){
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if(_arrItemsImageFile.length==0){
                              isImage=false;
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      //
                    }
                ),
              ),
            );
          }
      ),
    );
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Widget _buildBottom(BuildContext context){
    var size = MediaQuery
        .of(context)
        .size;
    return  widget.IsUpdate ? Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          bool success=false;
          if(_isDismissed){
            if(editCourtName.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกชื่อศาล");
            }else if(editUndecidedCase.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกหมายเลขคดีดำ");
            }else if(editDecidedCase.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกหมายเลขคดีแดง");
            }else{
              success=true;
            }
          }else{
            if(editCourtName.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกชื่อศาล");
            }else if(editUndecidedCase.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกหมายเลขคดีดำ");
            }else if(editDecidedCase.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกหมายเลขคดีแดง");
            }else if(editFineValue.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกจำนวนเงินค่าปรับ");
            }else if(!_isOneTime&&(editPeriodNum.text.isEmpty||editPeriod.text.isEmpty)){
              new VerifyDialog(context,"กรุณากรอกจำนวนงวดหรือรอบชำระค่าปรับ");
            }else if(editImprison.text.isEmpty){
              new VerifyDialog(context,"กรุณากรอกจำนวนที่สั่งจำคุก");
            }else if(!_isFine&&!_isImprison){
              new VerifyDialog(context,"กรุณาติ๊กเลือก สั่งปรับเป็นจำนวน หรือ สั่งจำคุกเป็นจำนวน หรือ เลือกอย่างใดอย่างหนึ่ง");
            }else{
              success=true;
            }
          }

          print(success);
          if(success){
            if(!dropdownValueCourtType.endsWith("ศาลชั้นต้น")){
              itemMain.DECIDE_NO_1 =int.parse(editDecidedCase.text);
              itemMain.DECIDE_NO_YEAR_1=editDecidedYear.text;
              itemMain.UNDECIDE_NO_1 =int.parse(editUndecidedCase.text);
              //itemMain.UNDECIDE_NO_YEAR_1 =_dtUndecidedDateFine.toString();
              itemMain.UNDECIDE_NO_YEAR_1 =DateTime.now().toString();
              itemMain.DECIDE_NO_YEAR_1 =DateTime.now().toString();
              itemMain.UNDECIDE_NO_YEAR_2 ="";
              itemMain.DECIDE_NO_YEAR_2 ="";
            }else{
              itemMain.DECIDE_NO_2 =int.parse(editDecidedCase.text);
              itemMain.DECIDE_NO_YEAR_2=editDecidedYear.text;
              itemMain.UNDECIDE_NO_2 =int.parse(editUndecidedCase.text);
              //itemMain.UNDECIDE_NO_YEAR_2 =_dtDecidedDateFine.toString();
              itemMain.UNDECIDE_NO_YEAR_1 ="";
              itemMain.DECIDE_NO_YEAR_1 ="";
              itemMain.UNDECIDE_NO_YEAR_2 =DateTime.now().toString();
              itemMain.DECIDE_NO_YEAR_2 =DateTime.now().toString();
            }

            itemMain.COURT_NAME=editCourtName.text;
            itemMain.JUDGEMENT_DATE=_initDate.toString();

            if(_isFine){
              itemMain.IS_FINE =1;
              itemMain.FINE=double.parse(int.parse(editFineValue.text).toString());
              itemMain.FINE_DATE=_dtDateFine.toString();

              if(dropdownValueFine.trim().endsWith("วัน")){
                itemMain.PAYMENT_PERIOD_DUE_UNIT=0;
              }else if(dropdownValueFine.trim().endsWith("เดือน")){
                itemMain.PAYMENT_PERIOD_DUE_UNIT=1;
              }else{
                itemMain.PAYMENT_PERIOD_DUE_UNIT=2;
              }
              if(_isOneTime){
                itemMain.IS_PAYONCE=1;
              }else{
                itemMain.IS_PAYONCE=0;
                itemMain.PAYMENT_PERIOD=int.parse(editPeriodNum.text);
                itemMain.PAYMENT_PERIOD_DUE=int.parse(editPeriod.text);
              }
            }else{
              itemMain.IS_FINE = 0;
              itemMain.FINE=null;
              itemMain.FINE_DATE=null;
              itemMain.PAYMENT_PERIOD_DUE_UNIT=null;
            }

            if(_isImprison){
              itemMain.IS_IMPRISON =1;
              itemMain.IMPRISON_TIME=double.parse(editImprison.text);
              if(dropdownValueImprison.trim().endsWith("วัน")){
                itemMain.IMPRISON_TIME_UNIT=0;
              }else if(dropdownValueImprison.trim().endsWith("เดือน")){
                itemMain.IMPRISON_TIME_UNIT=1;
              }else{
                itemMain.IMPRISON_TIME_UNIT=2;
              }
            }else{
              itemMain.IS_IMPRISON =0;
              itemMain.IMPRISON_TIME=null;
              itemMain.IMPRISON_TIME_UNIT=null;
            }
            Navigator.pop(context,itemMain);
          }

        },
        child: Center(
          child: Text('ตกลง',style: textStyleButton,),
        ),
      ),
    ) : null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
               /* _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
                _onSaved ? Navigator.pop(context, itemMain) :
                _showCancelAlertDialog(context);
              },
              padding: EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.arrow_back_ios, color: Colors.white,),
                  !_onSaved
                      ? new Text("ยกเลิก", style: appBarStyle,)
                      : new Container(),
                ],
              ),
            ),
          )
      ),
    ];

    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              centerTitle: true,
              title: Text("คำพิพากษาศาล", style: appBarStyle),
              flexibleSpace: new BottomAppBar(
                elevation: 0.0,
                color: Color(0xff2e76bc),
                child: new Row(
                    children: rowContents),
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
                            //height: 34.0,
                            decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                )
                            ),
                            /*child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text(
                                'ILG60_B_02_00_06_00', style: textStylePageName,),
                            )
                          ],
                        ),*/
                          ),
                          Expanded(
                            child: _onSaved?_buildContent_saved(context):_buildContent(),
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
        bottomNavigationBar: _buildBottom(context),
      ),
    );
  }
}
