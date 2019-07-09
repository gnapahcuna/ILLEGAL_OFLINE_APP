import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_detailed_fine_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/response/item_compare_response.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/compare_%20suspect.dart';
import 'package:prototype_app_pang/model/test/compare_%20suspect_detail.dart';
import 'package:prototype_app_pang/model/test/compare_case_information.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

import 'model/compare_detail.dart';
import 'model/compare_guiltbase_fine.dart';
import 'model/compare_map_fine_detail.dart';
import 'model/compare_staff.dart';

const double _kPickerSheetHeight = 216.0;
class CompareDetailScreenFragment extends StatefulWidget {
  String Title;
  ItemsListDivisionRate itemsListDivisionRate;
  ItemsCompareMain itemsCompareMain;
  ItemsCompareGuiltbaseFine itemsCompareGuiltbaseFine;
  ItemsCompareArrestMain itemsCompareArrestMain;
  ItemsPersonInformation ItemsPerson;
  ItemsCompareListIndicmentDetail itemsCompareListIndicmentDetail;
  List<ItemsListDocument> ItemsDocument;
  double FINE_VALUE;
  bool IsHaveProve;
  bool IsCreate;
  bool IsPreview;
  CompareDetailScreenFragment({
    Key key,
    @required this.Title,
    @required this.itemsListDivisionRate,
    @required this.itemsCompareMain,
    @required this.itemsCompareGuiltbaseFine,
    @required this.itemsCompareArrestMain,
    @required this.ItemsPerson,
    @required this.itemsCompareListIndicmentDetail,
    @required this.ItemsDocument,
    @required this.FINE_VALUE,
    @required this.IsHaveProve,
    @required this.IsCreate,
    @required this.IsPreview,
  }) : super(key: key);
 /* ItemsCompareCaseInformation ItemInformations;
  ItemsCompareSuspect ItemSuspect;
  ItemsCompareSuspectDetail ItemSuspectDetail;
  CompareDetailScreenFragment({
    Key key,
    @required this.ItemInformations,
    @required this.ItemSuspect,
    @required this.ItemSuspectDetail,
  }) : super(key: key);*/
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareDetailScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;
  //ปล่อยตัวชั่วคราว
  bool IsRelease=false;
  //ไม่ร้องขอ
  bool IsNotRequested=false;
  //ร้องขอ
  bool IsRequested=true;
  //เงินสด
  bool IsCash=true;
  //เครดิต
  bool IsCredit=false;

  
  //ไม่รับเงินสินบน
  bool IsBribe=false;
  //ไม่รับเงินรางวัล
  bool Isaward=false;

  List<Constants> constants = const <Constants>[
    //const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  //node focus
  final FocusNode myFocusNodeCompareNumber = FocusNode();
  final FocusNode myFocusNodeCompareYear = FocusNode();
  final FocusNode myFocusNodeComparePerson = FocusNode();
  final FocusNode myFocusNodeComparePlace= FocusNode();
  final FocusNode myFocusNodeCompareBillNumber= FocusNode();
  final FocusNode myFocusNodeCompareBillBookNo= FocusNode();
  final FocusNode myFocusNodeCompareBail= FocusNode();
  final FocusNode myFocusNodeCompareDepositBail= FocusNode();

  final FocusNode myFocusNodeCompareDate= FocusNode();
  final FocusNode myFocusNodeCompareTime= FocusNode();
  final FocusNode myFocusNodeTaxDueDate= FocusNode();
  final FocusNode myFocusNodeFineDueDate= FocusNode();

  //textfield
  TextEditingController editCompareNumber = new TextEditingController();
  TextEditingController editCompareYear = new TextEditingController();
  TextEditingController editComparePerson = new TextEditingController();
  TextEditingController editComparePlace = new TextEditingController();
  TextEditingController editCompareBillNumber = new TextEditingController();
  TextEditingController editCompareBillBookNo = new TextEditingController();
  TextEditingController editCompareBail= new TextEditingController();
  TextEditingController editCompareDepositBail= new TextEditingController();

  TextEditingController editCompareDate= new TextEditingController();
  TextEditingController editCompareTime= new TextEditingController();
  TextEditingController editTaxDueDate= new TextEditingController();
  TextEditingController editFineDueDate= new TextEditingController();

  //วันเดือนปี เวลา ปัจจุบัน
  String _currentCompareDate,_currentCompareTime;
  var dateFormatDate,dateFormatTime;
  DateTime _initDate=DateTime.now();

  DateTime _dtCompare=DateTime.now();
  //time
  DateTime time = DateTime.now();

  //วันที่กำหนดชำระภาษี
  String _currentTaxDueDate="";
  DateTime _dtTaxDueDate=DateTime.now();
  //วันที่กำหนดชำระค่าปรับ
  String _currentFineDueDate="";
  DateTime _dtFineDueDate=DateTime.now();

  //รูปภาพ
  Future<File> _imageFile;
  List<ItemsListDocument> _arrItemsImageFile = [];
  List<ItemsListDocument> _arrItemsImageFileAdd =[];
  List<int> _arrItemsImageFileDelete =[];
  bool isImage = false;
  VoidCallback listener;

  //model คำพิพากษาศาล
  /*ItemsCompareSuspect itemMain;
  ItemsCompareCaseInformation itemInfor;
  List<ItemsCompareEvidence> itemEvidence;*/

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
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 18.0, color: Colors.black,fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
    color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
    fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);

  String _titleAppbar;
  
  ItemsCompareMain _itemsCompareMain;
  ItemsCompareArrestMain _itemsCompareArrestMain;
  ItemsCompareListIndicmentDetail _indicmentDetail;
  List<ItemsCompareListIndicmentDetail> _listIndicmentDetail=[];

  final formatter = new NumberFormat("#,###.00");
  double FINE_TOTAL=0;
  @override
  void initState() {
    super.initState();

    add_staff_to(27);

    print(widget.itemsListDivisionRate.BRIBE_MAX_MONEY.toString()+" : "+widget.itemsListDivisionRate.BRIBE_RATE.toString());
    //set วันเดือนปี เวลา ปัจจุบัน
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0]+" "+splits[1]+" "+(int.parse(splits[3])+543).toString();
    _currentCompareDate=date;
    _currentCompareTime = dateFormatTime.format(DateTime.now()).toString();

    List splitslawYear = dateFormatDate.format(DateTime.now()).toString().split(
        " ");
    String compare_year = (int.parse(splitslawYear[3]) + 543).toString();
    editCompareYear.text = compare_year;
    editCompareDate.text = date;
    editCompareTime.text = _currentCompareTime;
    editTaxDueDate.text= _currentCompareDate;


    print(widget.ItemsPerson.toString());
    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH!=null
        ?widget.ItemsPerson.TITLE_SHORT_NAME_TH
        :"";
    String firstname =  widget.ItemsPerson.FIRST_NAME!=null
        ?widget.ItemsPerson.FIRST_NAME
        :"";
    String lastname =  widget.ItemsPerson.LAST_NAME!=null
        ?widget.ItemsPerson.LAST_NAME
        :"";
    editComparePerson.text=title+firstname+" "+lastname;;
    /*itemMain=widget.ItemSuspect;
    itemInfor=widget.ItemInformations;

    if(itemMain.SuspectDetails!=null) {
      IsRelease = itemMain.SuspectDetails.IsRelease;
    }

    _onSaved=itemMain.IsActive;
    if(widget.ItemSuspect!=null) {
      itemMain=widget.ItemSuspect;
      _onSaved=true;
      _isFine=itemMain.IsFine;
      _isPeriod=itemMain.IsPeriod;
      _isImprison=itemMain.IsImprison;
      _isDismissed=itemMain.IsDismissed;

      itemMain.IsOneTime?_setInitData1():_setInitData2();

      print("ชื่อศาล : " + itemMain.CourtName);
    }*/
    if(widget.Title.length>17){
      _titleAppbar= widget.Title.substring(0,17)+"...";
    }else{
      _titleAppbar= widget.Title;
    }

    _itemsCompareArrestMain=widget.itemsCompareArrestMain;
    _indicmentDetail=widget.itemsCompareListIndicmentDetail;

    _itemsCompareArrestMain.CompareArrestIndictmentDetail.forEach((item){
      if(item.INDICTMENT_DETAIL_ID != _indicmentDetail.INDICTMENT_DETAIL_ID){
        _listIndicmentDetail.add(item);
      }
    });
    print("_listIndicmentDetail : "+_listIndicmentDetail.length.toString());
    _itemsCompareArrestMain.CompareProveProduct.forEach((item){
      item.Controller.TaxValue = widget.itemsCompareGuiltbaseFine.FINE_RATE;
      item.Controller.FineValue = item.VAT;
      double fine_total = 0;
      if (_itemsCompareArrestMain.FINE_TYPE == 0 ||
          _itemsCompareArrestMain.FINE_TYPE == 1 ||
          _itemsCompareArrestMain.FINE_TYPE == 2) {
        fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
      } else {
        fine_total = item.VAT*widget.itemsCompareGuiltbaseFine.FINE_RATE;
      }
      item.Controller.Payment = fine_total;
      item.Controller.Total = fine_total;
    });
    
    if(widget.IsHaveProve){
      _itemsCompareMain=widget.itemsCompareMain;
      editCompareNumber.text = _itemsCompareMain.COMPARE_NO.toString();
      editCompareYear.text = _convertYear(_itemsCompareMain.COMPARE_NO_YEAR);
    }

    if(widget.IsPreview){
      _onSaved=widget.IsPreview;
      _onEdited=widget.IsCreate;
      _itemsCompareMain=widget.itemsCompareMain;


      List<ItemsListDocument> items = [];
      widget.ItemsDocument.forEach((f){
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items.add(new ItemsListDocument(
          DOCUMENT_ID: f.DOCUMENT_ID,
          REFERENCE_CODE: f.REFERENCE_CODE,
          FILE_PATH: f.FILE_PATH,
          DATA_SOURCE: f.DATA_SOURCE,
          DOCUMENT_TYPE: f.DOCUMENT_TYPE,
          DOCUMENT_NAME: f.DOCUMENT_NAME,
          IS_ACTIVE: f.IS_ACTIVE,
          DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
          CONTENT: f.CONTENT,
          FILE_TYPE: f.FILE_TYPE,
          FOLDER: f.FOLDER,
          FILE_CONTENT: _file,
        ));
      });
      _arrItemsImageFile = items;
    }

    FINE_TOTAL = _indicmentDetail.FINE_TOTAL;
  }

  @override
  void dispose() {
    super.dispose();
    editCompareNumber.dispose();
    editCompareYear.dispose();
    editComparePerson.dispose();
    editComparePlace.dispose();
    editCompareBillNumber.dispose();
    editCompareBillBookNo.dispose();
    editCompareBail.dispose();
    editCompareDepositBail.dispose();
  }

  //ล้างย้อมูลใน textfield
  void clearTextfield(){
    editCompareNumber.clear();
    editCompareYear.clear();
    editComparePerson.clear();
    editComparePlace.clear();
    editCompareBillNumber.clear();
    editCompareBillBookNo.clear();
    editCompareBail.clear();
    editCompareDepositBail.clear();
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
    String result = " เวลา " +
        dateFormatTime.format(dt).toString();
    return result;
  }
  String _convertYear(String sDate){
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(
        " ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }
  //set detail กรณีแก้ไข
  void setTextfield(){
    _itemsCompareMain.CompareMapping.forEach((f){
      f.CompareDetail.forEach((item){
        item.IS_TEMP_RELEASE==1
            ?IsRelease = true
            :IsRelease = false;

        if(item.IS_REQUEST==1){
          IsRequested = true;
          IsNotRequested =false;
        }else{
          IsRequested = false;
          IsNotRequested =true;
        }

        item.CompareDetailPayment.forEach((f){
          if(f.PAYMENT_TYPE == 1) {
            IsCash = true;
            IsCredit = false;
          }else {
            IsCash = false;
            IsCredit = true;
          }
        });
        if(item.PAYMENT_VAT_DUE_DATE!=null){
          editTaxDueDate.text =  _convertDate(item.PAYMENT_VAT_DUE_DATE);
          _dtTaxDueDate = DateTime.parse(item.PAYMENT_VAT_DUE_DATE);
        }

        editCompareBillNumber.text = item.RECEIPT_NO.toString();
        editCompareBillBookNo.text = item.RECEIPT_BOOK_NO.toString();
      });
    });
    editCompareNumber.text = _itemsCompareMain.COMPARE_NO.toString();
    editCompareYear.text = _convertYear(_itemsCompareMain.COMPARE_NO_YEAR);
    editCompareDate.text = _convertDate(_itemsCompareMain.COMPARE_DATE);
    editCompareTime.text =_convertTime(_itemsCompareMain.COMPARE_DATE);
    _dtCompare = DateTime.parse(_itemsCompareMain.COMPARE_DATE);
    time = DateTime.parse(_itemsCompareMain.COMPARE_DATE);

    _itemsCompareMain.CompareStaff.forEach((item){
      editComparePerson.text = item.TITLE_SHORT_NAME_TH+""+item.FIRST_NAME+" "+item.LAST_NAME;
    });
    editComparePlace.text = _itemsCompareMain.OFFICE_NAME.toString();

    //editCompareBail.clear();
    //editCompareDepositBail.clear();
  }

  //popup เมื่อกดแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onFinish = false;
        _onEdited = true;
        setTextfield();
      } else {
        _showDeleteAlertDialog();
      }
    });
  }
  //popup delete
  CupertinoAlertDialog _createCupertinoDeleteDialog() {
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
                Navigator.pop(context,"Back");
                setState(() {
                  _onSaved = false;
                  _onFinish = false;
                  onDeleted();
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
        return _createCupertinoDeleteDialog();
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
                Navigator.pop(mContext,"Back");
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
      /*_arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);*/
      if(_onEdited) {
        _arrItemsImageFileAdd.add(new ItemsListDocument(
            FILE_CONTENT: image,
            DOCUMENT_OLD_NAME: image.path
        ));
      }
      _arrItemsImageFile.add(new ItemsListDocument(
          FILE_CONTENT: image,
          DOCUMENT_NAME: image.path,
          DOCUMENT_OLD_NAME: image.path
      ));
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
  //ไปที่หน้ารายละเอียดค่าปรับ
  _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompareDetailFineScreenFragment(
        indicmentDetail: _indicmentDetail,
          itemsCompareArrestMain : widget.itemsCompareArrestMain,
          itemsCompareGuiltbaseFine: widget.itemsCompareGuiltbaseFine,
      )),
    );
    if(result.toString()!="Back") {
      //itemMain.E.Evidenses = result;
      /*ItemsCompareArrestMain Items  = result;
      Items.CompareArrestIndictmentDetail.fo*/
      setState(() {
        ItemsCompareMapFineDetail itemsCompareMapFineDetail = result;
        _indicmentDetail = itemsCompareMapFineDetail.itemsCompareListIndicmentDetail;
        FINE_TOTAL=_indicmentDetail.FINE_TOTAL;
        print("Back "+itemsCompareMapFineDetail.itemsListEvidenceGetStaff.FIRST_NAME);

        itemsListCompareStaff.add(new ItemsListCompareStaff(
            STAFF_ID: null,
            STAFF_CODE: "",
            STAFF_REF_ID: null,
            ID_CARD: "",
            TITLE_NAME_TH: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.TITLE_SHORT_NAME_TH,
            TITLE_SHORT_NAME_TH: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.TITLE_SHORT_NAME_TH,
            FIRST_NAME: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.FIRST_NAME,
            LAST_NAME: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.LAST_NAME,
            OPREATION_POS_NAME: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.OPREATION_POS_NAME,
            OPREATION_POS_LAVEL_NAME: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.OPREATION_POS_LAVEL_NAME,
            OPERATION_OFFICE_NAME: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.OPERATION_OFFICE_NAME,
            CONTRIBUTOR_ID: itemsCompareMapFineDetail.itemsListEvidenceGetStaff.CONTRIBUTOR_ID,
            IsCheck: false));

        print(itemsListCompareStaff.length);
        itemsListCompareStaff.forEach((f){
          print(f.FIRST_NAME+" : "+f.CONTRIBUTOR_ID.toString());
        });
      });
    }
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
                    color: Colors.white,
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
                            padding: EdgeInsets.only(
                                right: 18.0, top: 8, bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  IsRelease = !IsRelease;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: IsRelease ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(
                                    width: 1.5,
                                      color: Colors.black38
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IsRelease
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
                              "ปล่อยตัวชั่งคราว", style: textStyleLabel,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "คดีเปรียบเทียบที่", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Padding(
                            padding: paddingData,
                            child: new Text("น.",
                              style: textStyleLabel,
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
                                    enabled: widget.IsHaveProve?false:true,
                                    focusNode: myFocusNodeCompareNumber,
                                    controller: editCompareNumber,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                widget.IsHaveProve
                                    ?Container()
                                    :Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
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
                                  child: TextField(
                                    enabled: widget.IsHaveProve?false:true,
                                    focusNode: myFocusNodeCompareYear,
                                    controller: editCompareYear,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                widget.IsHaveProve
                                    ?Container()
                                    :Container(
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
                      child: Row(
                        children: <Widget>[
                          IsRelease?Text(
                            "วันที่บันทึกคำให้การผู้ต้องหา", style: textStyleLabel,):Text(
                            "วันที่เปรียบเทียบปรับ", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new /*ListTile(
                            title: Text(
                              _currentCompareDate, style: textStyleData,),
                            trailing: Icon(
                                FontAwesomeIcons.calendarAlt, size: 28.0),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtCompare);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtCompare = s;
                                  _currentCompareDate = date;
                                });
                              });
                            },
                          ),*/
                          TextField(
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtCompare);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtCompare = s;
                                  _currentCompareDate = date;
                                  editCompareDate.text = _currentCompareDate;
                                });
                              });
                            },
                            focusNode: myFocusNodeCompareDate,
                            controller: editCompareDate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เวลา", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /*new ListTile(
                            title: Text(
                              _currentCompareTime, style: textStyleData,),
                            onTap: () {

                            },
                          ),*/
                          TextField(
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return _buildBottomPicker(
                                    CupertinoDatePicker(
                                      use24hFormat: true,
                                      mode: CupertinoDatePickerMode.time,
                                      initialDateTime: time,
                                      onDateTimeChanged: (
                                          DateTime newDateTime) {
                                        setState(() {
                                          time = newDateTime;
                                          _currentCompareTime = dateFormatTime.format(time)
                                              .toString();
                                          editCompareTime.text = _currentCompareTime;

                                          /*List splitsArrestDate = _dtArrest.toUtc().toLocal().toString().split(" ");
                                          List splitsArrestTime = time.toString().split(" ");
                                          _arrestDate=splitsArrestDate[0].toString()+" "+splitsArrestTime[1].toString();*/
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            focusNode: myFocusNodeCompareTime,
                            controller: editCompareTime,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
                            decoration: InputDecoration(
                              border: InputBorder.none,
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
                      child: Text(
                        "ชื่อผู้เปรียบเทียบคดี", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              enabled: false,
                              focusNode: myFocusNodeComparePerson,
                              controller: editComparePerson,
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
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เขียนที่", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeComparePlace,
                              controller: editComparePlace,
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
                    /*
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "สิทธิ์ให้แจ้งญาติหรือผู้ซึ่งไว้วางใจทราบ",
                        style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            width: ((size.width * 75) / 100) / 2,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 18.0, left: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        IsRequested = true;
                                        IsNotRequested = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: IsRequested
                                            ? Color(0xff3b69f3)
                                            : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: IsRequested
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
                                    "ร้องขอ", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            width: ((size.width * 75) / 100) / 2,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 18.0, left: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        IsRequested = false;
                                        IsNotRequested = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: IsNotRequested ? Color(
                                            0xff3b69f3) : Colors
                                            .white,
                                        border: Border.all(
                                            color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: IsNotRequested
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
                                    "ไม่ร้องขอ", style: textStyleLabel,),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),  */


                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันที่กำหนดชำระภาษี", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /*new ListTile(
                            title: Text(
                              _currentTaxDueDate, style: textStyleData,),
                            trailing: Icon(
                                FontAwesomeIcons.calendarAlt, size: 28.0),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtTaxDueDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtTaxDueDate = s;
                                  _currentTaxDueDate = date;
                                });
                              });
                            },
                          ),*/
                          TextField(
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtTaxDueDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtTaxDueDate = s;
                                  _currentTaxDueDate = date;
                                  editTaxDueDate.text=_currentTaxDueDate;
                                });
                              });
                            },
                            focusNode: myFocusNodeTaxDueDate,
                            controller: editTaxDueDate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    !IsRelease?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "ใบเสร็จเลขที่", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                //padding: paddingData,
                                child: TextField(
                                  focusNode: myFocusNodeCompareBillNumber,
                                  controller: editCompareBillNumber,
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
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "ใบเสร็จเล่มที่", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                //padding: paddingData,
                                child: TextField(
                                  focusNode: myFocusNodeCompareBillBookNo,
                                  controller: editCompareBillBookNo,
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
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "การชำระเงิน",
                            style: textStyleLabel,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                width: ((size.width * 75) / 100) / 2,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            IsCash = true;
                                            IsCredit = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: IsCash
                                                ? Color(0xff3b69f3)
                                                : Colors
                                                .white,
                                            border: Border.all(
                                                color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: IsCash
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
                                        "เงินสด", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                width: ((size.width * 75) / 100) / 2,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          /*setState(() {
                                        IsCash = false;
                                        IsCredit = true;
                                      });*/
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: IsCredit ? Color(
                                                0xff3b69f3) : Colors.grey[400],
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black38),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: IsCredit
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "บัตรเครดิต", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "การขอรับเงิน",
                            style: textStyleLabel,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                             
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            IsBribe = !IsBribe;
                                            if(IsBribe == true && Isaward == true){
                                              IsBribe = false;
                                              Isaward = false;
                                              
                                            }

                                           // Isaward = !Isaward;

                                           
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: IsBribe
                                                ? Color(0xff3b69f3)
                                                : Colors
                                                .white,
                                            border: Border.all(
                                                color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: IsBribe
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
                                        "ไม่รับเงินสินบน", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                             
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 18.0, left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                         // IsBribe = !IsBribe;
                                          Isaward = !Isaward;
                                          if(IsBribe == true && Isaward == true){
                                              IsBribe = false;
                                              Isaward = false;
                                            }
                                      });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(4.0),
                                            color: Isaward ? Color(
                                                0xff3b69f3) : Colors.white,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black12),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Isaward
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "ไม่รับเงินรางวัล", style: textStyleLabel,),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),)
                        ),


                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                              Text("*", style: textStyleStar,),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingData,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /*new ListTile(
                                title: Text(
                                  _currentFineDueDate, style: textStyleData,),
                                trailing: Icon(
                                    FontAwesomeIcons.calendarAlt, size: 28.0),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DynamicDialog(
                                            Current: _dtFineDueDate);
                                      }).then((s) {
                                    String date = "";
                                    List splits = dateFormatDate.format(
                                        s).toString().split(" ");
                                    date = splits[0] + " " + splits[1] +
                                        " " +
                                        (int.parse(splits[3]) + 543)
                                            .toString();
                                    setState(() {
                                      _dtFineDueDate = s;
                                      _currentFineDueDate = date;
                                    });
                                  });
                                },
                              ),*/
                              TextField(
                                enableInteractiveSelection: false,
                                onTap: () {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DynamicDialog(
                                            Current: _dtFineDueDate);
                                      }).then((s) {
                                    String date = "";
                                    List splits = dateFormatDate.format(
                                        s).toString().split(" ");
                                    date = splits[0] + " " + splits[1] +
                                        " " +
                                        (int.parse(splits[3]) + 543)
                                            .toString();
                                    setState(() {
                                      _dtFineDueDate = s;
                                      _currentFineDueDate = date;
                                      editFineDueDate.text=_currentFineDueDate;
                                    });
                                  });
                                },
                                focusNode: myFocusNodeFineDueDate,
                                controller: editFineDueDate,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.grey,),
                                ),
                              ),
                              Container(
                                height: 1.0,
                                color: Colors.grey[300],
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ประกัน", style: textStyleLabel,),
                              ),
                              Container(
                                padding: paddingData,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        focusNode: myFocusNodeCompareBail,
                                        controller: editCompareBail,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[500], width: 0.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400], width: 0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หลักประกัน", style: textStyleLabel,),
                              ),
                              Container(
                                padding: paddingData,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      //padding: paddingData,
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        focusNode: myFocusNodeCompareDepositBail,
                                        controller: editCompareDepositBail,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[500], width: 0.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400], width: 0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  _navigate(context);
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 4.0),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 12.0,top: 12.0, bottom: 4.0),
                            child: Text(
                              "ยอดชำระค่าปรับ", style: textStyleLabel,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 22.0),
                                child:  Icon(
                                  Icons.arrow_forward_ios, color: Colors.grey[400],
                                  size: 18.0,),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 12.0,top: 4.0, bottom: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 22.0),
                                    child: Text(
                                        "ค่าปรับ\t\t\t"+formatter.format(FINE_TOTAL)
                                            .toString()+"\t\t\tบาท",
                                        style: textStyleData),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
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
    var size = MediaQuery
        .of(context)
        .size;

    ItemsCompareDetail itemsCompareDetail;
    _itemsCompareMain.CompareMapping.forEach((f) {
      if (f.INDICTMENT_DETAIL_ID == _indicmentDetail.INDICTMENT_DETAIL_ID) {
        f.CompareDetail.forEach((item) {
          itemsCompareDetail = item;
        });
      }
    });

    final formatter = new NumberFormat("#,###.00");
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                      child: Text("คดีเปรียบเทียบที่", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        /*itemsCompareDetail.IS_TEMP_RELEASE==1
                            ?""
                            :*/
                        ("น." + _itemsCompareMain.COMPARE_NO.toString() + "/" +
                            _convertYear(_itemsCompareMain.COMPARE_NO_YEAR)),
                        style: textInputStyleTitle,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(IsRelease
                          ? "วันที่บันทึกคำให้การผู้ต้องหา"
                          : "วันที่เปรียบเทียบปรับ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        _convertDate(_itemsCompareMain.COMPARE_DATE) +
                            _convertTime(_itemsCompareMain.COMPARE_DATE),
                        style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อผู้เปรียบเทียบคดี", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        _itemsCompareMain.CompareStaff.length > 0
                            ?
                        _itemsCompareMain.CompareStaff[0].TITLE_SHORT_NAME_TH
                            .toString() +
                            _itemsCompareMain.CompareStaff[0].FIRST_NAME
                                .toString() + " " +
                            _itemsCompareMain.CompareStaff[0].LAST_NAME
                                .toString()
                            : ""
                        , style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text("เขียนที่", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        _itemsCompareMain.OFFICE_NAME, style: textStyleData,),
                    ),
                    /*
                    Container(
                      padding: paddingLabel,
                      child: Text("สิทธิ์ให้แจ้งญาติหรือผู้ซึ่งไว้วางใจทราบ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemsCompareDetail.IS_REQUEST==1?"ร้องขอ":"ไม่ร้องขอ", style: textStyleData,),
                    ), */

                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันที่กำหนดชำระภาษี", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        _convertDate(itemsCompareDetail.PAYMENT_VAT_DUE_DATE),
                        style: textStyleData,),
                    ),
                    itemsCompareDetail.IS_TEMP_RELEASE == 1 ?
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "วันที่กำหนดชำระค่าปรับ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              _convertDate(
                                  itemsCompareDetail.PAYMENT_FINE_DUE_DATE),
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("ประกัน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              '-'
                              , style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text("หลักประกัน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              "-", style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ยอดชำระค่าปรับ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              formatter.format(itemsCompareDetail.PAYMENT_FINE)
                                  .toString(), style: textStyleData,),
                          ),
                        ]
                    ) : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("ใบเสร็จเลขที่/ใบเสร็จเล่มที่",
                            style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemsCompareDetail.RECEIPT_NO.toString()
                                + "/" +
                                itemsCompareDetail.RECEIPT_BOOK_NO.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("ยอดชำระค่าปรับ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            formatter.format(itemsCompareDetail.PAYMENT_FINE)
                                .toString(), style: textStyleData,),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text("การชำระเงิน", style: textStyleLabel,),
                        ),
                        Container(
                          padding: paddingLabel,
                          width: ((size.width * 75) / 100) / 2,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right: 18.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      IsCash = true;
                                      IsCredit = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: Color(0xff3b69f3),
                                      border: Border.all(
                                          color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.check,
                                          size: 16.0,
                                          color: Colors.white,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "เงินสด", style: textStyleLabel,),
                              )
                              /*itemMain.SuspectDetails.IsCash?Container(
                                child: Text(
                                  "เงินสด", style: textStyleLabel,),
                              ):Container(
                                child: Text(
                                  "บัตรเครดิต", style: textStyleLabel,),
                              )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              widget.IsPreview
                  ? Container()
                  : Container(
                width: size.width,
                child: _buildButtonImgPicker(),
              ),
              _buildDataImage(context),
            ],
          ),
        )
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
      padding: EdgeInsets.only(bottom: 12.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
              child: Container(
                padding: EdgeInsets.only(left:12.0,top:22.0,bottom: 22.0,right: 12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                      child: Image.file(_arrItemsImageFile[index].FILE_CONTENT,
                        fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageFile[index].DOCUMENT_NAME,
                      style: textStyleData,),
                    trailing: widget.IsPreview
                        ? null
                        : new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: Icon(Icons.delete_outline, size: 32.0,
                          color: Colors.grey[500],),
                        onPressed: () {
                          setState(() {
                            //print(index.toString());
                            if (_onEdited) {
                              try {
                                _arrItemsImageFileDelete.add(
                                    _arrItemsImageFile[index].DOCUMENT_ID);
                              } catch (e) {
                                _arrItemsImageFileAdd.removeAt(index);
                              }
                            }
                            _arrItemsImageFile.removeAt(index);
                            if (_arrItemsImageFile.length == 0) {
                              isImage = false;
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

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext,text) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
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
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showSearchEmptyAlertDialog(context,text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context,text);
      },
    );
  }

  void onDeleted()async{
    ItemsCompareDetail itemsCompareDetail;
    _itemsCompareMain.CompareMapping.forEach((f){
      if(f.INDICTMENT_DETAIL_ID==_indicmentDetail.INDICTMENT_DETAIL_ID){
        f.CompareDetail.forEach((item){
          itemsCompareDetail = item;
        });
      }
    });
    Map map = {
      "COMPARE_DETAIL_ID": itemsCompareDetail.COMPARE_DETAIL_ID
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
    await onLoadActionCompareDetailupdDelete(map);
    Navigator.pop(context);
    Navigator.pop(context,_itemsCompareMain);

  }
  
  void onSaved(BuildContext mContext)async {
    if (editCompareNumber.text.isEmpty||editCompareYear.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขที่คดีเปรียบเทียบ');
    }else if (editCompareDate.text.isEmpty||editCompareTime.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกวันที่และเวลาเปรียบเทียบปรับ');
    }else if (editComparePlace.text.isEmpty) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกช่องเขียนที่');
    }else if (editFineDueDate.text.isEmpty&&IsRelease) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกวันที่กำหนดชำระค่าปรับ');
    }else if (editCompareBillNumber.text.isEmpty&&!IsRelease) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเลขที่ใบเสร็จ');
    }else if (editCompareBillBookNo.text.isEmpty&&!IsRelease) {
      _showSearchEmptyAlertDialog(mContext, 'กรุณากรอกเล่มที่ใบเสร็จ');
    }else {
      if (!_onEdited) {
        if(!widget.IsHaveProve) {
          //กรณีสร้างเปรียบปรับคนแรก

          print("FINE_TOTAL : "+FINE_TOTAL.toString());

          List<Map> map_compare_detail_fine = [];
          _itemsCompareArrestMain.CompareProveProduct.forEach((item) {
            map_compare_detail_fine.add(
                {
                  "FINE_ID": "",
                  "COMPARE_DETAIL_ID": "",
                  "PRODUCT_ID": item.PRODUCT_ID,
                  "FINE_RATE": item.Controller.FineValue,
                  "VAT": item.VAT,
                  "FINE": "",
                  "NET_FINE": item.Controller.Payment,
                  "OLD_PAYMENT_FINE": "",
                  "PAYMENT_FINE": item.Controller.Total,
                  "DIFFERENCE_PAYMENT_FINE": "",
                  // "TREASURY_MONEY": (widget.itemsListDivisionRate
                  //     .TREASURY_RATE * item.Controller.Total) / 100,
                  // "BRIBE_MONEY": (widget.itemsListDivisionRate.BRIBE_RATE *
                  //     item.Controller.Total) / 100,
                  // "REWARD_MONEY": (widget.itemsListDivisionRate.REWARD_RATE *
                  //     item.Controller.Total) / 100,
                   "TREASURY_MONEY": (80 * item.Controller.Total) / 100,
                  "BRIBE_MONEY": (20 *
                      item.Controller.Total) / 100,
                  "REWARD_MONEY": (0 *
                      item.Controller.Total) / 100,
                  "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME,
                  "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME,
                  "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME,
                  "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME,
                  "PRODUCT_SUBSETTYPE_NAME": "",
                  "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH,
                  "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN,
                  "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH,
                  "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN,
                  "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH,
                  "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN,
                  "SIZES": item.SIZES,
                  "SIZES_UNIT": item.SIZES_UNIT,
                  "QUANTITY": item.QUANTITY,
                  "QUANTITY_UNIT": item.QUANTITY_UNIT,
                  "VOLUMN": item.VOLUMN,
                  "VOLUMN_UNIT": item.VOLUMN_UNIT,
                  "IS_ACTIVE": 1
                }
            );
          });

          List<Map> map_compare_mapping = [];
          map_compare_mapping.add({
            "COMPARE_MAPPING_ID": "",
            "COMPARE_ID": "",
            "INDICTMENT_DETAIL_ID": _indicmentDetail.INDICTMENT_DETAIL_ID,
            "PAST_LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
            "IS_EVER_WRONG": 1,
            "IS_ACTIVE": 1,
            "CompareDetail": [
              {
                "COMPARE_DETAIL_ID": "",
                "COMPARE_MAPPING_ID": "",
                "RECEIPT_OFFICE_ID": "",
                "APPROVE_OFFICE_ID": "",
                "MISTREAT_NO": _indicmentDetail.MISTREAT_NO,
                "OLD_PAYMENT_FINE": "",
                "PAYMENT_FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                "DIFFERENCE_PAYMENT_FINE": "",
                // "TREASURY_MONEY": (widget.itemsListDivisionRate.TREASURY_RATE *
                //     /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL) / 100,
                // "BRIBE_MONEY": (widget.itemsListDivisionRate.BRIBE_RATE *
                //     /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL) / 100,
                // "REWARD_MONEY": (widget.itemsListDivisionRate.REWARD_RATE *
                //     /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL) / 100,
                //สัดส่วนอยู่นี่
                //  "TREASURY_MONEY": Isaward ?(60 *FINE_TOTAL) / 100):(80 *FINE_TOTAL) / 100),
                //               "BRIBE_MONEY": Isaward ? ((20 *FINE_TOTAL) / 100):((20 *FINE_TOTAL) / 100),
                //               "REWARD_MONEY":Isaward ? ((20 *FINE_TOTAL) / 100):((20 *FINE_TOTAL) / 100),


                "TREASURY_MONEY": Isaward ?((80 * FINE_TOTAL) / 100):(IsBribe?((80 * FINE_TOTAL) / 100):((60 * FINE_TOTAL)/100)),         
                "BRIBE_MONEY": Isaward ?((20 * FINE_TOTAL) / 100):(IsBribe?((0 * FINE_TOTAL) / 100):((20 * FINE_TOTAL)/100)), 
                "REWARD_MONEY":Isaward ?((0 * FINE_TOTAL) / 100):(IsBribe?((20 * FINE_TOTAL) / 100):((20 * FINE_TOTAL)/100)), 
                "PAYMENT_FINE_DUE_DATE": IsRelease
                    ? _dtFineDueDate.toString()
                    : DateTime.now().toString(),
                "PAYMENT_VAT_DUE_DATE": _dtTaxDueDate.toString(),
                "INSURANCE": editCompareBail.text,
                "GAURANTEE": editCompareDepositBail.text,
                "PAYMENT_DATE": _dtCompare.toString(),
                "RECEIPT_TYPE": 0,
                "RECEIPT_BOOK_NO": editCompareBillBookNo.text,
                "RECEIPT_NO": editCompareBillNumber.text,
                "RECEIPT_OFFICE_CODE": "080700",
                "RECEIPT_OFFICE_NAME": "ส่วนคดี",
                "APPROVE_OFFICE_CODE": "",
                "APPROVE_OFFICE_NAME": "",
                "APPROVE_DATE": "",
                "APPROVE_TYPE": "",
                "COMMAND_NO": "",
                "COMMAND_DATE": "",
                "REMARK_NOT_AGREE": "",
                "REMARK_NOT_APPROVE": "",
                "FACT": "",
                "COMPARE_REASON": "",
                "ADJUST_REASON": "",
                "COMPARE_TYPE": 1,
                "IS_REQUEST": IsRequested ? 1 : 0,
                "IS_TEMP_RELEASE": IsRelease ? 1 : 0,
                "IS_INSURANCE": editCompareBail.text.isEmpty ? 0 : 1,
                "IS_GAURANTEE": editCompareDepositBail.text.isEmpty ? 0 : 1,
                "IS_PAYMENT": 1,
                "IS_REVENUE": 0,
                "IS_AGREE": 0,
                "IS_APPROVE": 0,
                "IS_AUTHORITY": 1,
                "IS_ACTIVE": 1,
              
                "CompareDetailPayment": [
                  {
                    "PAYMENT_ID": "",
                    "COMPARE_DETAIL_ID": "",
                    "PAYMENT_TYPE": IsCash ? 0 : 1,
                    "PAYMENT_FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                    "REFFERENCE_NO": "",
                    "IS_ACTIVE": 1
                  }
                ],
                "CompareDetailFine": map_compare_detail_fine,
                "ComparePayment": [
                  {
                    "PAYMENT_ID": "",
                    "LAWSUIT_DETAIL_ID": _indicmentDetail.INDICTMENT_DETAIL_ID,
                    "COMPARE_DETAIL_ID": "",
                    "FINE_TYPE": 1,
                    "FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                    "PAYMENT_PERIOD_NO": "",
                    "PAYMENT_DATE": IsRelease
                        ? _dtFineDueDate.toString()
                        : DateTime.now().toString(),
                    "IS_REQUEST_REWARD": 0,
                    "IS_ACTIVE": 1,
                    /*"ComparePaymentDetail":
                        [
                          {
                            "PAYMENT_DETAIL_ID": "",
                            "PAYMENT_ID": "",
                            "NOTICE_ID": 2,
                            "IS_REQUEST_BRIBE": 0,
                            "IS_ACTIVE": 1
                          }
                        ]*/
                  }
                ]
              }
            ]
          });
          _listIndicmentDetail.forEach((item) {
            map_compare_mapping.add({
              "COMPARE_MAPPING_ID": "",
              "COMPARE_ID": "",
              "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
              "PAST_LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
              "IS_EVER_WRONG": 1,
              "IS_ACTIVE": 1,
              "CompareDetail": [
                /*{
                  "COMPARE_DETAIL_ID": "",
                  "COMPARE_MAPPING_ID": "",
                  "RECEIPT_OFFICE_ID": "",
                  "APPROVE_OFFICE_ID": "",
                  "MISTREAT_NO": "",
                  "OLD_PAYMENT_FINE": "",
                  "PAYMENT_FINE": "",
                  "DIFFERENCE_PAYMENT_FINE": "",
                  "TREASURY_MONEY": "",
                  "BRIBE_MONEY": "",
                  "REWARD_MONEY": "",
                  "PAYMENT_FINE_DUE_DATE": "",
                  "PAYMENT_VAT_DUE_DATE": "",
                  "INSURANCE": "",
                  "GAURANTEE": "",
                  "PAYMENT_DATE": "",
                  "RECEIPT_TYPE": 0,
                  "RECEIPT_BOOK_NO": "",
                  "RECEIPT_NO": "",
                  "RECEIPT_OFFICE_CODE": "",
                  "RECEIPT_OFFICE_NAME": "",
                  "APPROVE_OFFICE_CODE": "",
                  "APPROVE_OFFICE_NAME": "",
                  "APPROVE_DATE": "",
                  "APPROVE_TYPE": "",
                  "COMMAND_NO": "",
                  "COMMAND_DATE": "",
                  "REMARK_NOT_AGREE": "",
                  "REMARK_NOT_APPROVE": "",
                  "FACT": "",
                  "COMPARE_REASON": "",
                  "ADJUST_REASON": "",
                  "COMPARE_TYPE": 1,
                  "IS_REQUEST": "",
                  "IS_TEMP_RELEASE": "",
                  "IS_INSURANCE": "",
                  "IS_GAURANTEE": "",
                  "IS_PAYMENT": 1,
                  "IS_REVENUE": 0,
                  "IS_AGREE": 0,
                  "IS_APPROVE": 0,
                  "IS_AUTHORITY": 1,
                  "IS_ACTIVE": 1,
                  "CompareDetailPayment": [
                    {
                      "PAYMENT_ID": "",
                      "COMPARE_DETAIL_ID": "",
                      "PAYMENT_TYPE": "",
                      "PAYMENT_FINE": "",
                      "REFFERENCE_NO": "",
                      "IS_ACTIVE": 1
                    }
                  ],
                  "CompareDetailFine": map_compare_detail_fine,
                  "ComparePayment": [
                    {
                      "PAYMENT_ID": "",
                      "LAWSUIT_DETAIL_ID": "",
                      "COMPARE_DETAIL_ID": "",
                      "FINE_TYPE": 1,
                      "FINE": "",
                      "PAYMENT_PERIOD_NO": "",
                      "PAYMENT_DATE": "",
                      "IS_REQUEST_REWARD": 0,
                      "IS_ACTIVE": 1,
                      *//*"ComparePaymentDetail":
                        [
                          {
                            "PAYMENT_DETAIL_ID": "",
                            "PAYMENT_ID": "",
                            "NOTICE_ID": 2,
                            "IS_REQUEST_BRIBE": 0,
                            "IS_ACTIVE": 1
                          }
                        ]*//*
                    }
                  ]
                }*/
              ]
            });
          });

          Map map_compare = {
           
            "COMPARE_ID": "",
            "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
            "OFFICE_ID": "",
            "TREASURY_RATE": widget.itemsListDivisionRate.TREASURY_RATE,
            "BRIBE_RATE": widget.itemsListDivisionRate.BRIBE_RATE,
            "REWARD_RATE": widget.itemsListDivisionRate.REWARD_RATE,
            "OFFICE_CODE": "",
            "OFFICE_NAME": editComparePlace.text,
            "COMPARE_NO": int.parse(editCompareNumber.text),
            "COMPARE_NO_YEAR": DateTime.now().toString(),
            "COMPARE_DATE": _dtCompare.toString(),
            "IS_OUTSIDE": 1,
            "IS_ACTIVE": 1,
            "CREATE_DATE": DateTime.now().toString(),
            "CREATE_USER_ACCOUNT_ID": 1,
            "UPDATE_DATE": "",
            "UPDATE_USER_ACCOUNT_ID": "",
            "CompareMapping": map_compare_mapping,
            "CompareStaff": _createMapStaff()
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
          await onLoadActionCompareInsAll(map_compare);
          Navigator.pop(context);
          Navigator.pop(context, _itemsCompareMain);

        }else{
          //กรณีสร้างเปรียบเทียบปรับคนถัดไป
          Map compare_detail;
          List<Map> compare_detail_fine=[];
          _itemsCompareMain.CompareMapping.forEach((item){
            if(item.INDICTMENT_DETAIL_ID == _indicmentDetail.INDICTMENT_DETAIL_ID){
              _itemsCompareArrestMain.CompareProveProduct.forEach((item) {
                compare_detail_fine.add(
                    {
                      "FINE_ID": "",
                      "COMPARE_DETAIL_ID": "",
                      "PRODUCT_ID": item.PRODUCT_ID,
                      "FINE_RATE": item.Controller.FineValue,
                      "VAT": item.VAT,
                      "FINE": "",
                      "NET_FINE": item.Controller.Payment,
                      "OLD_PAYMENT_FINE": "",
                      "PAYMENT_FINE": item.Controller.Total,
                      "DIFFERENCE_PAYMENT_FINE": "",
                      "TREASURY_MONEY": (widget.itemsListDivisionRate
                          .TREASURY_RATE * item.Controller.Total) / 100,
                      "BRIBE_MONEY": (widget.itemsListDivisionRate.BRIBE_RATE *
                          item.Controller.Total) / 100,
                      "REWARD_MONEY": (widget.itemsListDivisionRate.REWARD_RATE *
                          item.Controller.Total) / 100,
                      "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME,
                      "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME,
                      "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME,
                      "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME,
                      "PRODUCT_SUBSETTYPE_NAME": "",
                      "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH,
                      "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN,
                      "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH,
                      "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN,
                      "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH,
                      "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN,
                      "SIZES": item.SIZES,
                      "SIZES_UNIT": item.SIZES_UNIT,
                      "QUANTITY": item.QUANTITY,
                      "QUANTITY_UNIT": item.QUANTITY_UNIT,
                      "VOLUMN": item.VOLUMN,
                      "VOLUMN_UNIT": item.VOLUMN_UNIT,
                      "IS_ACTIVE": 1
                    }
                );
              });

              compare_detail = {
                "COMPARE_DETAIL_ID": /*item.COMPARE_DETAIL_ID*/"",
                "COMPARE_MAPPING_ID": item.COMPARE_MAPPING_ID,
                "RECEIPT_OFFICE_ID": "",
                "APPROVE_OFFICE_ID": "",
                "MISTREAT_NO": _indicmentDetail.MISTREAT_NO,
                "OLD_PAYMENT_FINE": "",
                "PAYMENT_FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                "DIFFERENCE_PAYMENT_FINE": "",
                "TREASURY_MONEY": (widget.itemsListDivisionRate.TREASURY_RATE *
                    _indicmentDetail.FINE_TOTAL) / 100,
                "BRIBE_MONEY": (widget.itemsListDivisionRate.BRIBE_RATE *
                    _indicmentDetail.FINE_TOTAL) / 100,
                "REWARD_MONEY": (widget.itemsListDivisionRate.REWARD_RATE *
                    _indicmentDetail.FINE_TOTAL) / 100,
                "PAYMENT_FINE_DUE_DATE": IsRelease
                    ? _dtFineDueDate.toString()
                    : DateTime.now().toString(),
                "PAYMENT_VAT_DUE_DATE": _dtTaxDueDate.toString(),
                "INSURANCE": editCompareBail.text,
                "GAURANTEE": editCompareDepositBail.text,
                "PAYMENT_DATE": _dtCompare.toString(),
                "RECEIPT_TYPE": 0,
                "RECEIPT_BOOK_NO": editCompareBillBookNo.text,
                "RECEIPT_NO": editCompareBillNumber.text,
                "RECEIPT_OFFICE_CODE": "080700",
                "RECEIPT_OFFICE_NAME": "ส่วนคดี",
                "APPROVE_OFFICE_CODE": "",
                "APPROVE_OFFICE_NAME": "",
                "APPROVE_DATE": "",
                "APPROVE_TYPE": "",
                "COMMAND_NO": "",
                "COMMAND_DATE": "",
                "REMARK_NOT_AGREE": "",
                "REMARK_NOT_APPROVE": "",
                "FACT": "",
                "COMPARE_REASON": "",
                "ADJUST_REASON": "",
                "COMPARE_TYPE": 1,
                "IS_REQUEST": IsRequested ? 1 : 0,
                "IS_TEMP_RELEASE": IsRelease ? 1 : 0,
                "IS_INSURANCE": editCompareBail.text.isEmpty ? 0 : 1,
                "IS_GAURANTEE": editCompareDepositBail.text.isEmpty ? 0 : 1,
                "IS_PAYMENT": 1,
                "IS_REVENUE": 0,
                "IS_AGREE": 0,
                "IS_APPROVE": 0,
                "IS_AUTHORITY": 1,
                "IS_ACTIVE": 1,
                "CompareDetailPayment": [
                  {
                    "PAYMENT_ID": "",
                    "COMPARE_DETAIL_ID": "",
                    "PAYMENT_TYPE": IsCash ? 0 : 1,
                    "PAYMENT_FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                    "REFFERENCE_NO": "",
                    "IS_ACTIVE": 1
                  }
                ],
                "CompareDetailFine": compare_detail_fine,
                "ComparePayment": [
                  {
                    "PAYMENT_ID": "",
                    "LAWSUIT_DETAIL_ID": _indicmentDetail.INDICTMENT_DETAIL_ID,
                    "COMPARE_DETAIL_ID": "",
                    "FINE_TYPE": 1,
                    "FINE": /*_indicmentDetail.FINE_TOTAL*/FINE_TOTAL,
                    "PAYMENT_PERIOD_NO": "",
                    "PAYMENT_DATE": IsRelease
                        ? _dtFineDueDate.toString()
                        : DateTime.now().toString(),
                    "IS_REQUEST_REWARD": 0,
                    "IS_ACTIVE": 1,
                    /*"ComparePaymentDetail": [
                          {
                            "PAYMENT_DETAIL_ID": "",
                            "PAYMENT_ID": "",
                            "NOTICE_ID": 2,
                            "IS_REQUEST_BRIBE": 0,
                            "IS_ACTIVE": 1
                          }
                        ]*/
                  }
                ]
              };
            }
          });
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CupertinoActivityIndicator(
                  ),
                );
              });
          await onLoadActionCompareDetailInsAll(compare_detail);
          Navigator.pop(context);
        }
      }else{

        // if(Isaward == false && IsBribe == true){
  //****************************เปิด ไม่รับเงินรางวัล************************************* */
//  List<Map> map_compare_mapping=[];
//         _itemsCompareMain.CompareMapping.forEach((item){
//           map_compare_mapping.add({
//             "COMPARE_MAPPING_ID": item.COMPARE_MAPPING_ID,
//             "COMPARE_ID": item.COMPARE_ID,
//             "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
//             "PAST_LAWSUIT_ID": 2,
//             "IS_EVER_WRONG": 1,
//             "IS_ACTIVE": 1,
//             "CompareDetail": []
//           });
//         });

//         Map map_compare_detail=null;
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             map_compare_detail={
//               "COMPARE_DETAIL_ID": detail.COMPARE_DETAIL_ID,
//               "COMPARE_MAPPING_ID": detail.COMPARE_MAPPING_ID,
//               "RECEIPT_OFFICE_ID": "",
//               "APPROVE_OFFICE_ID": "",
//               "MISTREAT_NO": detail.MISTREAT_NO,
//               "OLD_PAYMENT_FINE": "",
//               "PAYMENT_FINE": "1000",
//               "DIFFERENCE_PAYMENT_FINE": "",
//               "TREASURY_MONEY": "600",
//               "BRIBE_MONEY": "200",
//               "REWARD_MONEY": "200",
//               "PAYMENT_FINE_DUE_DATE": IsRelease
//                   ? _dtFineDueDate.toString()
//                   : "",
//               "PAYMENT_VAT_DUE_DATE": _dtTaxDueDate.toString(),
//               "INSURANCE": editCompareBail.text,
//               "GAURANTEE": editCompareDepositBail.text,
//               "PAYMENT_DATE": _dtCompare.toString(),
//               "RECEIPT_TYPE": 0,
//               "RECEIPT_BOOK_NO": editCompareBillBookNo.text,
//               "RECEIPT_NO": editCompareBillNumber.text,
//               "RECEIPT_OFFICE_CODE": "",
//               "RECEIPT_OFFICE_NAME": "ส่วนคดี",
//               "APPROVE_OFFICE_CODE": "",
//               "APPROVE_OFFICE_NAME": "",
//               "APPROVE_DATE": "",
//               "APPROVE_TYPE": "",
//               "COMMAND_NO": "",
//               "COMMAND_DATE": "",
//               "REMARK_NOT_AGREE": "",
//               "REMARK_NOT_APPROVE": "",
//               "FACT": "",
//               "COMPARE_REASON": "",
//               "ADJUST_REASON": "",
//               "IS_REQUEST": IsRequested ? 1 : 0,
//               "IS_TEMP_RELEASE": IsRelease ? 1 : 0,
//               "IS_INSURANCE": editCompareBail.text.isEmpty ? 0 : 1,
//               "IS_GAURANTEE": editCompareDepositBail.text.isEmpty ? 0 : 1,
//               "IS_PAYMENT": 1,
//               "IS_REVENUE": 0,
//               "IS_AGREE": 0,
//               "IS_APPROVE": 0,
//               "IS_AUTHORITY": 1,
//               "IS_ACTIVE": 1
//             };
//           });
//         });
//         List<Map> map_compare_detail_payment=[];
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             detail.CompareDetailPayment.forEach((detail_pay){
//               map_compare_detail_payment.add({
//                 "PAYMENT_ID": detail_pay.PAYMENT_ID,
//                 "COMPARE_DETAIL_ID": detail_pay.COMPARE_DETAIL_ID,
//                 "PAYMENT_TYPE": 0,
//                 "PAYMENT_FINE": widget.FINE_VALUE,
//                 "REFFERENCE_NO": "",
//                 "IS_ACTIVE": 1
//               });
//             });
//           });
//         });
//         List<Map> map_compare_detail_fine=[];
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             detail.CompareDetailFine.forEach((detail_fine){
//               map_compare_detail_fine.add({
//                 "FINE_ID": detail_fine.FINE_ID,
//                 "COMPARE_DETAIL_ID": detail_fine.COMPARE_DETAIL_ID,
//                 "PRODUCT_ID": detail_fine.PRODUCT_ID,
//                 "FINE_RATE": 1,
//                 "VAT": "1000",
//                 "FINE": "",
//                 "NET_FINE": "1000",
//                 "OLD_PAYMENT_FINE": "",
//                 "PAYMENT_FINE": "1000",
//                 "DIFFERENCE_PAYMENT_FINE": "",
//                 "TREASURY_MONEY": "600",
//                 "BRIBE_MONEY": "200",
//                 "REWARD_MONEY": "200",
//                 "IS_ACTIVE": 1
//               });
//             });
//           });
//         });
//         List<Map> map_staff=[];
//         _itemsCompareMain.CompareStaff.forEach((staff){
//            map_staff=[
//             {
//               "STAFF_ID": staff.STAFF_ID,
//               "COMPARE_ID": staff.COMPARE_ID,
//               "COMPARE_DETAIL_ID": staff.COMPARE_DETAIL_ID,
//               "STAFF_REF_ID": "",
//               "TITLE_ID": 1,
//               "STAFF_CODE": "4842",
//               "ID_CARD": "127896325",
//               "STAFF_TYPE": 1,
//               "TITLE_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
//               "TITLE_NAME_EN": "",
//               "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
//               "TITLE_SHORT_NAME_EN": "",
//               "FIRST_NAME":widget.ItemsPerson.FIRST_NAME,
//               "LAST_NAME": widget.ItemsPerson.LAST_NAME,
//               "AGE": "27",
//               "OPERATION_POS_CODE": "",
//               "OPREATION_POS_NAME": widget.ItemsPerson.OPREATION_POS_NAME,
//               "OPREATION_POS_LEVEL": "",
//               "OPERATION_POS_LEVEL_NAME": widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
//               "OPERATION_DEPT_CODE": "",
//               "OPERATION_DEPT_NAME": "",
//               "OPERATION_DEPT_LEVEL": "",
//               "OPERATION_UNDER_DEPT_CODE": "",
//               "OPERATION_UNDER_DEPT_NAME": "",
//               "OPERATION_UNDER_DEPT_LEVEL": "",
//               "OPERATION_OFFICE_CODE":"000000",
//               "OPERATION_OFFICE_NAME":"",
//               "OPERATION_OFFICE_SHORT_NAME":"",
//               "MANAGEMENT_WORK_DEPT_CODE": "",
//               "MANAGEMENT_WORK_DEPT_NAME": "",
//               "MANAGEMENT_WORK_DEPT_LEVEL": "",
//               "MANAGEMENT_OFFICE_CODE": "",
//               "MANAGEMENT_OFFICE_NAME": widget.ItemsPerson.OPERATION_OFFICE_NAME,
//               "MANAGEMENT_OFFICE_SHORT_NAME": "",
//               "REPRESENT_POS_CODE": "",
//               "REPRESENT_POS_NAME": "",
//               "REPRESENT_POS_LEVEL": "",
//               "REPRESENT_POS_LEVEL_NAME": "",
//               "REPRESENT_DEPT_CODE": "",
//               "REPRESENT_DEPT_NAME": "",
//               "REPRESENT_DEPT_LEVEL": "",
//               "REPRESENT_UNDER_DEPT_CODE": "",
//               "REPRESENT_UNDER_DEPT_NAME": "",
//               "REPRESENT_UNDER_DEPT_LEVEL": "",
//               "REPRESENT_WORK_DEPT_CODE": "",
//               "REPRESENT_WORK_DEPT_NAME": "",
//               "REPRESENT_WORK_DEPT_LEVEL": "",
//               "REPRESENT_OFFICE_CODE": "",
//               "REPRESENT_OFFICE_NAME": "",
//               "REPRESENT_OFFICE_SHORT_NAME": "",
//               "STATUS": 1,
//               "REMARK": "",
//               "CONTRIBUTOR_ID": 16,
//               "IS_ACTIVE": 1
//             }
//           ];
//         });

//         print("CompareNumber : "+editCompareNumber.text);
//         Map map_compare=/*{
//           "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
//           "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
//           "OFFICE_ID": "",
//           "TREASURY_RATE": "60",
//           "BRIBE_RATE": "20",
//           "REWARD_RATE": "20",
//           "OFFICE_CODE": "100300",
//           "OFFICE_NAME": "สำนักงานสรรพสเทพฯ 3",
//           "COMPARE_NO": int.parse(editCompareNumber.text),
//           "COMPARE_NO_YEAR": DateTime.now().toString(),
//           "COMPARE_DATE": _dtCompare.toString(),
//           "IS_OUTSIDE": 0,
//           "IS_ACTIVE": 1,
//           "CREATE_DATE": "",
//           "CREATE_USER_ACCOUNT_ID": 1,
//           "UPDATE_DATE": DateTime.now().toString(),
//           "UPDATE_USER_ACCOUNT_ID": "",
//           "CompareMapping": map_compare_mapping,
//           "CompareStaff": map_staff
//         };*/
      
//         {

//           "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
//           "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
//           "OFFICE_ID": "",
//           "TREASURY_RATE": 80,
//           "BRIBE_RATE": 20,
//           "REWARD_RATE": 0,
//           "OFFICE_CODE": "100300",
//           "OFFICE_NAME": "NIDA",
//           "COMPARE_NO": int.parse(editCompareNumber.text),
//           "COMPARE_NO_YEAR": DateTime.now().toString(),
//           "COMPARE_DATE": _dtCompare.toString(),
//           "IS_OUTSIDE": 0,
//           "IS_ACTIVE": 1,
//           "CREATE_DATE": "2019-04-11 08:45:41.434175",
//           "CREATE_USER_ACCOUNT_ID": 1,
//           "UPDATE_DATE": "",
//           "UPDATE_USER_ACCOUNT_ID": "",
//           "CompareMapping": map_compare_mapping,
//           "CompareStaff": map_staff
//         };

//         showDialog(
//             barrierDismissible: false,
//             context: context,
//             builder: (BuildContext context) {
//               return Center(
//                 child: CupertinoActivityIndicator(
//                 ),
//               );
//             });
//         await onLoadActionCompareUpdAll(map_compare);
//         Navigator.pop(context);






// }
// //***************************************ปิด award****************************************** */







// else if(Isaward == true &&IsBribe == false){
//   //****************************เปิด ไม่รับเงินสนบน************************************* */
//  List<Map> map_compare_mapping=[];
//         _itemsCompareMain.CompareMapping.forEach((item){
//           map_compare_mapping.add({
//             "COMPARE_MAPPING_ID": item.COMPARE_MAPPING_ID,
//             "COMPARE_ID": item.COMPARE_ID,
//             "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
//             "PAST_LAWSUIT_ID": 2,
//             "IS_EVER_WRONG": 1,
//             "IS_ACTIVE": 1,
//             "CompareDetail": []
//           });
//         });

//         Map map_compare_detail=null;
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             map_compare_detail={
//               "COMPARE_DETAIL_ID": detail.COMPARE_DETAIL_ID,
//               "COMPARE_MAPPING_ID": detail.COMPARE_MAPPING_ID,
//               "RECEIPT_OFFICE_ID": "",
//               "APPROVE_OFFICE_ID": "",
//               "MISTREAT_NO": detail.MISTREAT_NO,
//               "OLD_PAYMENT_FINE": "",
//               "PAYMENT_FINE": "1000",
//               "DIFFERENCE_PAYMENT_FINE": "",
//               "TREASURY_MONEY": "600",
//               "BRIBE_MONEY": "200",
//               "REWARD_MONEY": "200",
//               "PAYMENT_FINE_DUE_DATE": IsRelease
//                   ? _dtFineDueDate.toString()
//                   : "",
//               "PAYMENT_VAT_DUE_DATE": _dtTaxDueDate.toString(),
//               "INSURANCE": editCompareBail.text,
//               "GAURANTEE": editCompareDepositBail.text,
//               "PAYMENT_DATE": _dtCompare.toString(),
//               "RECEIPT_TYPE": 0,
//               "RECEIPT_BOOK_NO": editCompareBillBookNo.text,
//               "RECEIPT_NO": editCompareBillNumber.text,
//               "RECEIPT_OFFICE_CODE": "",
//               "RECEIPT_OFFICE_NAME": "ส่วนคดี",
//               "APPROVE_OFFICE_CODE": "",
//               "APPROVE_OFFICE_NAME": "",
//               "APPROVE_DATE": "",
//               "APPROVE_TYPE": "",
//               "COMMAND_NO": "",
//               "COMMAND_DATE": "",
//               "REMARK_NOT_AGREE": "",
//               "REMARK_NOT_APPROVE": "",
//               "FACT": "",
//               "COMPARE_REASON": "",
//               "ADJUST_REASON": "",
//               "IS_REQUEST": IsRequested ? 1 : 0,
//               "IS_TEMP_RELEASE": IsRelease ? 1 : 0,
//               "IS_INSURANCE": editCompareBail.text.isEmpty ? 0 : 1,
//               "IS_GAURANTEE": editCompareDepositBail.text.isEmpty ? 0 : 1,
//               "IS_PAYMENT": 1,
//               "IS_REVENUE": 0,
//               "IS_AGREE": 0,
//               "IS_APPROVE": 0,
//               "IS_AUTHORITY": 1,
//               "IS_ACTIVE": 1
//             };
//           });
//         });
//         List<Map> map_compare_detail_payment=[];
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             detail.CompareDetailPayment.forEach((detail_pay){
//               map_compare_detail_payment.add({
//                 "PAYMENT_ID": detail_pay.PAYMENT_ID,
//                 "COMPARE_DETAIL_ID": detail_pay.COMPARE_DETAIL_ID,
//                 "PAYMENT_TYPE": 0,
//                 "PAYMENT_FINE": widget.FINE_VALUE,
//                 "REFFERENCE_NO": "",
//                 "IS_ACTIVE": 1
//               });
//             });
//           });
//         });
//         List<Map> map_compare_detail_fine=[];
//         _itemsCompareMain.CompareMapping.forEach((mapping){
//           mapping.CompareDetail.forEach((detail){
//             detail.CompareDetailFine.forEach((detail_fine){
//               map_compare_detail_fine.add({
//                 "FINE_ID": detail_fine.FINE_ID,
//                 "COMPARE_DETAIL_ID": detail_fine.COMPARE_DETAIL_ID,
//                 "PRODUCT_ID": detail_fine.PRODUCT_ID,
//                 "FINE_RATE": 1,
//                 "VAT": "1000",
//                 "FINE": "",
//                 "NET_FINE": "1000",
//                 "OLD_PAYMENT_FINE": "",
//                 "PAYMENT_FINE": "1000",
//                 "DIFFERENCE_PAYMENT_FINE": "",
//                 "TREASURY_MONEY": "600",
//                 "BRIBE_MONEY": "200",
//                 "REWARD_MONEY": "200",
//                 "IS_ACTIVE": 1
//               });
//             });
//           });
//         });
//         List<Map> map_staff=[];
//         _itemsCompareMain.CompareStaff.forEach((staff){
//            map_staff=[
//             {
//               "STAFF_ID": staff.STAFF_ID,
//               "COMPARE_ID": staff.COMPARE_ID,
//               "COMPARE_DETAIL_ID": staff.COMPARE_DETAIL_ID,
//               "STAFF_REF_ID": "",
//               "TITLE_ID": 1,
//               "STAFF_CODE": "4842",
//               "ID_CARD": "127896325",
//               "STAFF_TYPE": 1,
//               "TITLE_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
//               "TITLE_NAME_EN": "",
//               "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
//               "TITLE_SHORT_NAME_EN": "",
//               "FIRST_NAME":widget.ItemsPerson.FIRST_NAME,
//               "LAST_NAME": widget.ItemsPerson.LAST_NAME,
//               "AGE": "27",
//               "OPERATION_POS_CODE": "",
//               "OPREATION_POS_NAME": widget.ItemsPerson.OPREATION_POS_NAME,
//               "OPREATION_POS_LEVEL": "",
//               "OPERATION_POS_LEVEL_NAME": widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
//               "OPERATION_DEPT_CODE": "",
//               "OPERATION_DEPT_NAME": "",
//               "OPERATION_DEPT_LEVEL": "",
//               "OPERATION_UNDER_DEPT_CODE": "",
//               "OPERATION_UNDER_DEPT_NAME": "",
//               "OPERATION_UNDER_DEPT_LEVEL": "",
//               "OPERATION_OFFICE_CODE":"000000",
//               "OPERATION_OFFICE_NAME":"",
//               "OPERATION_OFFICE_SHORT_NAME":"",
//               "MANAGEMENT_WORK_DEPT_CODE": "",
//               "MANAGEMENT_WORK_DEPT_NAME": "",
//               "MANAGEMENT_WORK_DEPT_LEVEL": "",
//               "MANAGEMENT_OFFICE_CODE": "",
//               "MANAGEMENT_OFFICE_NAME": widget.ItemsPerson.OPERATION_OFFICE_NAME,
//               "MANAGEMENT_OFFICE_SHORT_NAME": "",
//               "REPRESENT_POS_CODE": "",
//               "REPRESENT_POS_NAME": "",
//               "REPRESENT_POS_LEVEL": "",
//               "REPRESENT_POS_LEVEL_NAME": "",
//               "REPRESENT_DEPT_CODE": "",
//               "REPRESENT_DEPT_NAME": "",
//               "REPRESENT_DEPT_LEVEL": "",
//               "REPRESENT_UNDER_DEPT_CODE": "",
//               "REPRESENT_UNDER_DEPT_NAME": "",
//               "REPRESENT_UNDER_DEPT_LEVEL": "",
//               "REPRESENT_WORK_DEPT_CODE": "",
//               "REPRESENT_WORK_DEPT_NAME": "",
//               "REPRESENT_WORK_DEPT_LEVEL": "",
//               "REPRESENT_OFFICE_CODE": "",
//               "REPRESENT_OFFICE_NAME": "",
//               "REPRESENT_OFFICE_SHORT_NAME": "",
//               "STATUS": 1,
//               "REMARK": "",
//               "CONTRIBUTOR_ID": 16,
//               "IS_ACTIVE": 1
//             }
//           ];
//         });

//         print("CompareNumber : "+editCompareNumber.text);
//         Map map_compare=/*{
//           "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
//           "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
//           "OFFICE_ID": "",
//           "TREASURY_RATE": "60",
//           "BRIBE_RATE": "20",
//           "REWARD_RATE": "20",
//           "OFFICE_CODE": "100300",
//           "OFFICE_NAME": "สำนักงานสรรพสเทพฯ 3",
//           "COMPARE_NO": int.parse(editCompareNumber.text),
//           "COMPARE_NO_YEAR": DateTime.now().toString(),
//           "COMPARE_DATE": _dtCompare.toString(),
//           "IS_OUTSIDE": 0,
//           "IS_ACTIVE": 1,
//           "CREATE_DATE": "",
//           "CREATE_USER_ACCOUNT_ID": 1,
//           "UPDATE_DATE": DateTime.now().toString(),
//           "UPDATE_USER_ACCOUNT_ID": "",
//           "CompareMapping": map_compare_mapping,
//           "CompareStaff": map_staff
//         };*/
      
//         {

//           "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
//           "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
//           "OFFICE_ID": "",
//           "TREASURY_RATE": 80,
//           "BRIBE_RATE": 0,
//           "REWARD_RATE": 20,
//           "OFFICE_CODE": "100300",
//           "OFFICE_NAME": "NIDA",
//           "COMPARE_NO": int.parse(editCompareNumber.text),
//           "COMPARE_NO_YEAR": DateTime.now().toString(),
//           "COMPARE_DATE": _dtCompare.toString(),
//           "IS_OUTSIDE": 0,
//           "IS_ACTIVE": 1,
//           "CREATE_DATE": "2019-04-11 08:45:41.434175",
//           "CREATE_USER_ACCOUNT_ID": 1,
//           "UPDATE_DATE": "",
//           "UPDATE_USER_ACCOUNT_ID": "",
//           "CompareMapping": map_compare_mapping,
//           "CompareStaff": map_staff
//         };

//         showDialog(
//             barrierDismissible: false,
//             context: context,
//             builder: (BuildContext context) {
//               return Center(
//                 child: CupertinoActivityIndicator(
//                 ),
//               );
//             });
//         await onLoadActionCompareUpdAll(map_compare);
//         Navigator.pop(context);






// }
// //***************************************ปิด bribe****************************************** */







 
  //****************************เปิด ไม่รับอะไรเลย************************************* */



        List<Map> map_compare_mapping=[];
        _itemsCompareMain.CompareMapping.forEach((item){
          map_compare_mapping.add({
            "COMPARE_MAPPING_ID": item.COMPARE_MAPPING_ID,
            "COMPARE_ID": item.COMPARE_ID,
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "PAST_LAWSUIT_ID": 2,
            "IS_EVER_WRONG": 1,
            "IS_ACTIVE": 1,
            "CompareDetail": []
          });
        });

        Map map_compare_detail=null;
        _itemsCompareMain.CompareMapping.forEach((mapping){
          mapping.CompareDetail.forEach((detail){
            map_compare_detail={
              "COMPARE_DETAIL_ID": detail.COMPARE_DETAIL_ID,
              "COMPARE_MAPPING_ID": detail.COMPARE_MAPPING_ID,
              "RECEIPT_OFFICE_ID": "",
              "APPROVE_OFFICE_ID": "",
              "MISTREAT_NO": detail.MISTREAT_NO,
              "OLD_PAYMENT_FINE": "",
              "PAYMENT_FINE": "1000",
              "DIFFERENCE_PAYMENT_FINE": "",
              "TREASURY_MONEY": "600",
              "BRIBE_MONEY": "200",
              "REWARD_MONEY": "200",
              "PAYMENT_FINE_DUE_DATE": IsRelease
                  ? _dtFineDueDate.toString()
                  : "",
              "PAYMENT_VAT_DUE_DATE": _dtTaxDueDate.toString(),
              "INSURANCE": editCompareBail.text,
              "GAURANTEE": editCompareDepositBail.text,
              "PAYMENT_DATE": _dtCompare.toString(),
              "RECEIPT_TYPE": 0,
              "RECEIPT_BOOK_NO": editCompareBillBookNo.text,
              "RECEIPT_NO": editCompareBillNumber.text,
              "RECEIPT_OFFICE_CODE": "",
              "RECEIPT_OFFICE_NAME": "ส่วนคดี",
              "APPROVE_OFFICE_CODE": "",
              "APPROVE_OFFICE_NAME": "",
              "APPROVE_DATE": "",
              "APPROVE_TYPE": "",
              "COMMAND_NO": "",
              "COMMAND_DATE": "",
              "REMARK_NOT_AGREE": "",
              "REMARK_NOT_APPROVE": "",
              "FACT": "",
              "COMPARE_REASON": "",
              "ADJUST_REASON": "",
              "IS_REQUEST": IsRequested ? 1 : 0,
              "IS_TEMP_RELEASE": IsRelease ? 1 : 0,
              "IS_INSURANCE": editCompareBail.text.isEmpty ? 0 : 1,
              "IS_GAURANTEE": editCompareDepositBail.text.isEmpty ? 0 : 1,
              "IS_PAYMENT": 1,
              "IS_REVENUE": 0,
              "IS_AGREE": 0,
              "IS_APPROVE": 0,
              "IS_AUTHORITY": 1,
              "IS_ACTIVE": 1
            };
          });
        });
        List<Map> map_compare_detail_payment=[];
        _itemsCompareMain.CompareMapping.forEach((mapping){
          mapping.CompareDetail.forEach((detail){
            detail.CompareDetailPayment.forEach((detail_pay){
              map_compare_detail_payment.add({
                "PAYMENT_ID": detail_pay.PAYMENT_ID,
                "COMPARE_DETAIL_ID": detail_pay.COMPARE_DETAIL_ID,
                "PAYMENT_TYPE": 0,
                "PAYMENT_FINE": widget.FINE_VALUE,
                "REFFERENCE_NO": "",
                "IS_ACTIVE": 1
              });
            });
          });
        });
        List<Map> map_compare_detail_fine=[];
        _itemsCompareMain.CompareMapping.forEach((mapping){
          mapping.CompareDetail.forEach((detail){
            detail.CompareDetailFine.forEach((detail_fine){
              map_compare_detail_fine.add({
                "FINE_ID": detail_fine.FINE_ID,
                "COMPARE_DETAIL_ID": detail_fine.COMPARE_DETAIL_ID,
                "PRODUCT_ID": detail_fine.PRODUCT_ID,
                "FINE_RATE": 1,
                "VAT": "1000",
                "FINE": "",
                "NET_FINE": "1000",
                "OLD_PAYMENT_FINE": "",
                "PAYMENT_FINE": "1000",
                "DIFFERENCE_PAYMENT_FINE": "",
                "TREASURY_MONEY": "600",
                "BRIBE_MONEY": "200",
                "REWARD_MONEY": "200",
                "IS_ACTIVE": 1
              });
            });
          });
        });
        List<Map> map_staff=[];
        _itemsCompareMain.CompareStaff.forEach((staff){
           map_staff.add( {
             "STAFF_ID": staff.STAFF_ID,
             "COMPARE_ID": staff.COMPARE_ID,
             "COMPARE_DETAIL_ID": staff.COMPARE_DETAIL_ID,
             "STAFF_REF_ID": "",
             "TITLE_ID": 1,
             "STAFF_CODE": "4842",
             "ID_CARD": "127896325",
             "STAFF_TYPE": 1,
             "TITLE_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
             "TITLE_NAME_EN": "",
             "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
             "TITLE_SHORT_NAME_EN": "",
             "FIRST_NAME":widget.ItemsPerson.FIRST_NAME,
             "LAST_NAME": widget.ItemsPerson.LAST_NAME,
             "AGE": "27",
             "OPERATION_POS_CODE": "",
             "OPREATION_POS_NAME": widget.ItemsPerson.OPREATION_POS_NAME,
             "OPREATION_POS_LEVEL": "",
             "OPERATION_POS_LEVEL_NAME": widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
             "OPERATION_DEPT_CODE": "",
             "OPERATION_DEPT_NAME": "",
             "OPERATION_DEPT_LEVEL": "",
             "OPERATION_UNDER_DEPT_CODE": "",
             "OPERATION_UNDER_DEPT_NAME": "",
             "OPERATION_UNDER_DEPT_LEVEL": "",
             "OPERATION_OFFICE_CODE":"000000",
             "OPERATION_OFFICE_NAME":"",
             "OPERATION_OFFICE_SHORT_NAME":"",
             "MANAGEMENT_WORK_DEPT_CODE": "",
             "MANAGEMENT_WORK_DEPT_NAME": "",
             "MANAGEMENT_WORK_DEPT_LEVEL": "",
             "MANAGEMENT_OFFICE_CODE": "",
             "MANAGEMENT_OFFICE_NAME": widget.ItemsPerson.OPERATION_OFFICE_NAME,
             "MANAGEMENT_OFFICE_SHORT_NAME": "",
             "REPRESENT_POS_CODE": "",
             "REPRESENT_POS_NAME": "",
             "REPRESENT_POS_LEVEL": "",
             "REPRESENT_POS_LEVEL_NAME": "",
             "REPRESENT_DEPT_CODE": "",
             "REPRESENT_DEPT_NAME": "",
             "REPRESENT_DEPT_LEVEL": "",
             "REPRESENT_UNDER_DEPT_CODE": "",
             "REPRESENT_UNDER_DEPT_NAME": "",
             "REPRESENT_UNDER_DEPT_LEVEL": "",
             "REPRESENT_WORK_DEPT_CODE": "",
             "REPRESENT_WORK_DEPT_NAME": "",
             "REPRESENT_WORK_DEPT_LEVEL": "",
             "REPRESENT_OFFICE_CODE": "",
             "REPRESENT_OFFICE_NAME": "",
             "REPRESENT_OFFICE_SHORT_NAME": "",
             "STATUS": 1,
             "REMARK": "",
             "CONTRIBUTOR_ID": 16,
             "IS_ACTIVE": 1
           });
        });

        print("CompareNumber : "+editCompareNumber.text);
        Map map_compare=/*{
          "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
          "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
          "OFFICE_ID": "",
          "TREASURY_RATE": "60",
          "BRIBE_RATE": "20",
          "REWARD_RATE": "20",
          "OFFICE_CODE": "100300",
          "OFFICE_NAME": "สำนักงานสรรพสเทพฯ 3",
          "COMPARE_NO": int.parse(editCompareNumber.text),
          "COMPARE_NO_YEAR": DateTime.now().toString(),
          "COMPARE_DATE": _dtCompare.toString(),
          "IS_OUTSIDE": 0,
          "IS_ACTIVE": 1,
          "CREATE_DATE": "",
          "CREATE_USER_ACCOUNT_ID": 1,
          "UPDATE_DATE": DateTime.now().toString(),
          "UPDATE_USER_ACCOUNT_ID": "",
          "CompareMapping": map_compare_mapping,
          "CompareStaff": map_staff
        };*/
      
        {

          "COMPARE_ID": _itemsCompareMain.COMPARE_ID,
          "LAWSUIT_ID": _itemsCompareArrestMain.LAWSUIT_ID,
          "OFFICE_ID": "",
          "TREASURY_RATE": _itemsCompareMain.TREASURY_RATE,
          "BRIBE_RATE": _itemsCompareMain.BRIBE_RATE,
          "REWARD_RATE": _itemsCompareMain.REWARD_RATE,
          "OFFICE_CODE": "100300",
          "OFFICE_NAME": "NIDA",
          "COMPARE_NO": int.parse(editCompareNumber.text),
          "COMPARE_NO_YEAR": DateTime.now().toString(),
          "COMPARE_DATE": _dtCompare.toString(),
          "IS_OUTSIDE": 0,
          "IS_ACTIVE": 1,
          "CREATE_DATE": "2019-04-11 08:45:41.434175",
          "CREATE_USER_ACCOUNT_ID": 1,
          "UPDATE_DATE": "",
          "UPDATE_USER_ACCOUNT_ID": "",
          "CompareMapping": map_compare_mapping,
          "CompareStaff": map_staff
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
        await onLoadActionCompareUpdAll(map_compare);
        Navigator.pop(context);
      }

      setState(() {
        _onSaved = true;
        _onFinish = true;
      });
    }
    
    
   
  //****************************ปิด ไม่เลือกอะไรเลย************************************* */
  }
  ItemsArrestResponseInsAll insAll;
  List<ItemsListDocument> itemsDocument =[];
  Future<bool> onLoadActionCompareInsAll(Map map) async {
    await new CompareFuture().apiRequestCompareinsAll(map).then((onValue) {
      print("Insert : "+onValue.IsSuccess.toString());
      insAll = onValue;
    });


    //Insert DocumentImage
    List<Map> _arrJsonImg=[];
    int index=0;
    _arrItemsImageFile.forEach((_file){
      String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
      index++;
      _arrJsonImg.add({
        "DATA_SOURCE": "",
        "DOCUMENT_ID": "",
        "DOCUMENT_NAME": editCompareNumber.text+"_"+editCompareYear.text+"_"+index.toString(),
        "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "6",
        "FILE_TYPE": "jpg",
        "FOLDER": "Document",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": insAll.COMPARE_ID,
        "CONTENT":base64Image
      });
    });

    for(int i=0;i<_arrJsonImg.length;i++){
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
        print("["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
      });
    }



    Map map_compare={
      "COMPARE_ID":insAll.COMPARE_ID
    };
    print(map_compare.toString());
    await new CompareFuture().apiRequestComparegetByCon(map_compare).then((onValue) {
      _itemsCompareMain = onValue;
    });
    print("COMPARE_ID : "+_itemsCompareMain.COMPARE_ID.toString());




    //get DocumentImage
    map = {
      "DOCUMENT_TYPE": 6,
      "REFERENCE_CODE": _itemsCompareMain.COMPARE_ID
    };

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item){
        print(item.DOCUMENT_NAME);
        if(int.parse(item.IS_ACTIVE)==1){
          items.add(item);
        }
      });
      itemsDocument = items;
      List<ItemsListDocument> items_fill = [];
      itemsDocument.forEach((f){
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items_fill.add(new ItemsListDocument(
          DOCUMENT_ID: f.DOCUMENT_ID,
          REFERENCE_CODE: f.REFERENCE_CODE,
          FILE_PATH: f.FILE_PATH,
          DATA_SOURCE: f.DATA_SOURCE,
          DOCUMENT_TYPE: f.DOCUMENT_TYPE,
          DOCUMENT_NAME: f.DOCUMENT_NAME,
          IS_ACTIVE: f.IS_ACTIVE,
          DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
          CONTENT: f.CONTENT,
          FILE_TYPE: f.FILE_TYPE,
          FOLDER: f.FOLDER,
          FILE_CONTENT: _file,
        ));
      });
      _arrItemsImageFile = items_fill;
    });



    setState(() {});
    return true;
  }
  Future<bool> onLoadActionCompareUpdAll(Map map) async {
    //Update Data Compare
    await new CompareFuture().apiRequestCompareupdByCon(map).then((onValue) {
      print("Update Compare : "+onValue.IsSuccess.toString());
    });

    //Add || Delete Document
    for(int i=0;i<_arrItemsImageFileDelete.length;i++){
      Map map ={
        "DOCUMENT_ID": _arrItemsImageFileDelete[i]
      };
      print(map);
      await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
        print("Delete ["+i.toString()+"] : "+onValue.Msg.toString());
      });
    }

    List<Map> _arrJsonImg=[];
    int index=_arrItemsImageFile.length;
    _arrItemsImageFileAdd.forEach((_file){
      String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
      index++;
      _arrJsonImg.add({
        "DATA_SOURCE": "",
        "DOCUMENT_ID": "",
        "DOCUMENT_NAME": editCompareNumber.text+"_"+editCompareYear.text+"_"+index.toString(),
        "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "6",
        "FILE_TYPE": "jpg",
        "FOLDER": "Document",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": _itemsCompareMain.COMPARE_ID,
        "CONTENT":base64Image
      });
    });
    for(int i=0;i<_arrJsonImg.length;i++){
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
        print("Update Add ["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
      });
    }



    //getBycon
    Map map_compare={
      "COMPARE_ID":_itemsCompareMain.COMPARE_ID
    };
    print(map_compare.toString());
    await new CompareFuture().apiRequestComparegetByCon(map_compare).then((onValue) {
      _itemsCompareMain = onValue;
    });



    //get DocumentImage
    map = {
      "DOCUMENT_TYPE": 6,
      "REFERENCE_CODE": _itemsCompareMain.COMPARE_ID
    };

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item){
        if(int.parse(item.IS_ACTIVE)==1){
          items.add(item);
        }
      });
      itemsDocument = items;
      List<ItemsListDocument> items_fill = [];
      itemsDocument.forEach((f){
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items_fill.add(new ItemsListDocument(
          DOCUMENT_ID: f.DOCUMENT_ID,
          REFERENCE_CODE: f.REFERENCE_CODE,
          FILE_PATH: f.FILE_PATH,
          DATA_SOURCE: f.DATA_SOURCE,
          DOCUMENT_TYPE: f.DOCUMENT_TYPE,
          DOCUMENT_NAME: f.DOCUMENT_NAME,
          IS_ACTIVE: f.IS_ACTIVE,
          DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
          CONTENT: f.CONTENT,
          FILE_TYPE: f.FILE_TYPE,
          FOLDER: f.FOLDER,
          FILE_CONTENT: _file,
        ));
      });
      _arrItemsImageFile = items_fill;
    });



    setState(() {});
    return true;
  }

  Future<bool> onLoadActionCompareDetailInsAll(Map map) async {
    print(map.toString());
    await new CompareFuture().apiRequestCompareDetailinsAll(map).then((onValue) {
      print("Insert Compare Continues: "+onValue.COMPARE_DETAIL_ID.toString());
    });
    Map map_compare={
      "COMPARE_ID":_itemsCompareMain.COMPARE_ID
    };
    print(map_compare.toString());
    await new CompareFuture().apiRequestComparegetByCon(map_compare).then((onValue) {
      _itemsCompareMain = onValue;
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionCompareDetailupdDelete(Map map) async {
    await new CompareFuture().apiRequestCompareDetailupdDelete(map).then((onValue) {
      print("Delete Compare Detail: "+onValue.IsSuccess.toString());
    });

    Map map_compare={
      "COMPARE_ID":_itemsCompareMain.COMPARE_ID
    };
    print(map_compare.toString());
    await new CompareFuture().apiRequestComparegetByCon(map_compare).then((onValue) {
      _itemsCompareMain = onValue;
    });


    bool IsDelAll = false;
    print("CompareMapping : "+_itemsCompareMain.CompareMapping.length.toString());
    _itemsCompareMain.CompareMapping.forEach((f){
      print(f.INDICTMENT_DETAIL_ID.toString()+" : "+_indicmentDetail.INDICTMENT_DETAIL_ID.toString());
      if(f.INDICTMENT_DETAIL_ID==_indicmentDetail.INDICTMENT_DETAIL_ID){
        print(f.CompareDetail.length.toString());
        if(f.CompareDetail.length==0){
          IsDelAll = true;
          print("IsDelAll in : "+IsDelAll.toString());
        }
      }
    });
    print(IsDelAll);
    if(IsDelAll){
      Map map_compare={
        "COMPARE_ID":_itemsCompareMain.COMPARE_ID
      };
      await new CompareFuture().apiRequestCompareupdDelete(map_compare).then((onValue) {
        print("Delete Compare All: "+onValue.IsSuccess.toString());
      });

      /*map_compare={
        "COMPARE_ID":_itemsCompareMain.COMPARE_ID
      };
      print(map_compare.toString());
      await new CompareFuture().apiRequestComparegetByCon(map_compare).then((onValue) {
        _itemsCompareMain = onValue;
      });*/
      _itemsCompareMain = null;
    }


    setState(() {});
    return true;
  }

  List<ItemsListCompareStaff> itemsListCompareStaff = [];
  void add_staff_to(int CONTRIBUTOR_ID) {
    /*37=ผู้เปรียบเทียบ
      38=ผู้มีอำนาจ*/

    itemsListCompareStaff.add(new ItemsListCompareStaff(
        STAFF_ID: null,
        STAFF_CODE: "",
        STAFF_REF_ID: null,
        ID_CARD: "",
        TITLE_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        TITLE_SHORT_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        FIRST_NAME: widget.ItemsPerson.FIRST_NAME,
        LAST_NAME: widget.ItemsPerson.LAST_NAME,
        OPREATION_POS_NAME: widget.ItemsPerson.OPREATION_POS_NAME,
        OPREATION_POS_LAVEL_NAME: widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
        OPERATION_OFFICE_NAME: widget.ItemsPerson.OPERATION_OFFICE_NAME,
        CONTRIBUTOR_ID: CONTRIBUTOR_ID,
        IsCheck: false)
    );
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
          width: width / 3.5,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :
                _onSaved ? Navigator.pop(context, _itemsCompareMain) :
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
      Expanded(
          child: Center(child: Text(_titleAppbar, style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3.5,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved ? (_onSave ? new FlatButton(
                  onPressed: () {
                    print("asdasd");
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
                            child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily)),)
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
                child: new Row(
                    children: rowContents),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverFillRemaining(
              child: Scaffold(
                backgroundColor: Colors.grey[200],
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //height: 34.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
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
                                'ILG60_B_04_00_05_00', style: textStylePageName,),
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
              ),
            ),
          ],
        ),
      ),
    );
  }





  List<Map> _createMapStaff(){
    List<Map> items = [];
    itemsListCompareStaff.forEach((item){
      items.add({
        "STAFF_ID": "",
        "COMPARE_ID": "",
        "COMPARE_DETAIL_ID": "",
        "STAFF_REF_ID": "",
        "TITLE_ID": "",
        "STAFF_CODE": "",
        "ID_CARD": "",
        "STAFF_TYPE": 1,
        "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
        "TITLE_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": "",
        "FIRST_NAME": item.FIRST_NAME,
        "LAST_NAME": item.LAST_NAME,
        "AGE": "",
        "OPERATION_POS_CODE": "",
        "OPREATION_POS_NAME": item.OPREATION_POS_NAME,
        "OPREATION_POS_LEVEL": "",
        "OPERATION_POS_LEVEL_NAME": item
            .OPREATION_POS_LAVEL_NAME,
        "OPERATION_DEPT_CODE": "",
        "OPERATION_DEPT_NAME": "",
        "OPERATION_DEPT_LEVEL": "",
        "OPERATION_UNDER_DEPT_CODE": "",
        "OPERATION_UNDER_DEPT_NAME": "",
        "OPERATION_UNDER_DEPT_LEVEL": "",
        "OPERATION_OFFICE_CODE": "",
        "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME,
        "OPERATION_OFFICE_SHORT_NAME": "",
        "MANAGEMENT_WORK_DEPT_CODE": "",
        "MANAGEMENT_WORK_DEPT_NAME": "",
        "MANAGEMENT_WORK_DEPT_LEVEL": "",
        "MANAGEMENT_OFFICE_CODE": "",
        "MANAGEMENT_OFFICE_NAME": "",
        "MANAGEMENT_OFFICE_SHORT_NAME": "",
        "REPRESENT_POS_CODE": "",
        "REPRESENT_POS_NAME": "",
        "REPRESENT_POS_LEVEL": "",
        "REPRESENT_POS_LEVEL_NAME": "",
        "REPRESENT_DEPT_CODE": "",
        "REPRESENT_DEPT_NAME": "",
        "REPRESENT_DEPT_LEVEL": "",
        "REPRESENT_UNDER_DEPT_CODE": "",
        "REPRESENT_UNDER_DEPT_NAME": "",
        "REPRESENT_UNDER_DEPT_LEVEL": "",
        "REPRESENT_WORK_DEPT_CODE": "",
        "REPRESENT_WORK_DEPT_NAME": "",
        "REPRESENT_WORK_DEPT_LEVEL": "",
        "REPRESENT_OFFICE_CODE": "",
        "REPRESENT_OFFICE_NAME": "",
        "REPRESENT_OFFICE_SHORT_NAME": "",
        "STATUS": 1,
        "REMARK": "",
        "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
        "IS_ACTIVE": 1
      });
    });

    return items;
  }

}









  // "IS_BRIBE": IsBribe ?1:0,
  // "IS_REWARD": Isaward ?1:0,