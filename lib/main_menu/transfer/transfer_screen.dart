import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_warehouse.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/evidence_search_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_get_staff.dart';
import 'package:prototype_app_pang/main_menu/destroy/destroy_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection_item.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_inventory_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/approve.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/tranfer.dart';
import 'package:prototype_app_pang/main_menu/transfer/model/transfer_main.dart';
import 'package:prototype_app_pang/main_menu/transfer/transfer_book_search_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';

class TransferMainScreenFragment extends StatefulWidget {
  ItemsEvidenceOutMain ItemsdestroyMain;
  ItemsPersonInformation ItemsPerson;
  ItemsMasWarehouseResponse itemsMasWarehouse;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  TransferMainScreenFragment({
    Key key,
    @required this.ItemsdestroyMain,
    @required this.ItemsPerson,
    @required this.itemsMasWarehouse,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<TransferMainScreenFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'การอนุมัติ'),
    Choice(title: 'ของกลาง'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //List<EvidenceInventoryList> itemEvidence = [];
  List itemEvidence = [];
  //item หลักทั้งหมด
  ItemsEvidenceOutMain itemMain;

  //item forms
  List<ItemsListArrest8> itemsFormsTab = [];

  //time
  DateTime offerTime = DateTime.now();
  DateTime considerTime = DateTime.now();
  DateTime destroyTime = DateTime.now();
  String _offertime, _considertime, _destroytime;

  //วันที่อละเวลาปัจจุบัน
  String _currentOfferDate, _currentConsiderDate, _currentDestroyDate,
      _currentOfferTime, _currentConsiderTime, _currentDestroyTime;
  var dateFormatDate, dateFormatTime, _dtOfferDate, _dtConsiderDate,
      _dtDestroyDate;

  //_dt
  DateTime _dtCheckEvidence = DateTime.now();

  //node focus การอนุมัติ
  final FocusNode myFocusNodeDeliveredNumber = FocusNode();
  final FocusNode myFocusNodeDeliveredYear = FocusNode();
  final FocusNode myFocusNodeApproveNumber = FocusNode();
  final FocusNode myFocusNodeOfferDate = FocusNode();
  final FocusNode myFocusNodeOfferTime = FocusNode();
  final FocusNode myFocusNodePersonTransfer = FocusNode();
  final FocusNode myFocusNodeTransferDepartment = FocusNode();
  final FocusNode myFocusNodeDestinationDepartment = FocusNode();
  final FocusNode myFocusNodeDestinationStock = FocusNode();
  final FocusNode myFocusNodeSourceStock = FocusNode();
  final FocusNode myFocusNodePersonConsider = FocusNode();
  final FocusNode myFocusNodeConsiderDepartment = FocusNode();
  final FocusNode myFocusNodeConsiderDate = FocusNode();
  final FocusNode myFocusNodeConsiderTime = FocusNode();
  final FocusNode myFocusNodeCommentTranfer = FocusNode();

  //textfield การอนุมัติ
  TextEditingController editDeliveredNumber = new TextEditingController();
  TextEditingController editDeliveredYear = new TextEditingController();
  TextEditingController editApproveNumber = new TextEditingController();
  TextEditingController editOfferDate = new TextEditingController();
  TextEditingController editOfferTime = new TextEditingController();
  TextEditingController editPersonTransfer = new TextEditingController();
  TextEditingController editTransferDepartment = new TextEditingController();
  TextEditingController editDestinationDepartment = new TextEditingController();
  TextEditingController editDestinationStock = new TextEditingController();
  TextEditingController editSourceStock = new TextEditingController();
  TextEditingController editPersonConsider = new TextEditingController();
  TextEditingController editConsiderDepartment = new TextEditingController();
  TextEditingController editConsiderDate = new TextEditingController();
  TextEditingController editConsiderTime = new TextEditingController();
  TextEditingController editCommentTranfer = new TextEditingController();

  //node focus ของกลาง
  final FocusNode myFocusNodeDesployNumber = FocusNode();
  final FocusNode myFocusNodeDesployDate = FocusNode();
  final FocusNode myFocusNodeDesployTime = FocusNode();
  final FocusNode myFocusNodeDesployPerson = FocusNode();
  final FocusNode myFocusNodeDesployDepartment = FocusNode();

  //textfield ของกลาง
  TextEditingController editDesployNumber = new TextEditingController();
  TextEditingController editDesployDate = new TextEditingController();
  TextEditingController editDesployTime = new TextEditingController();
  TextEditingController editDesployPerson = new TextEditingController();
  TextEditingController editDesployDepartment = new TextEditingController();

  //node focus ลบ
  final FocusNode myFocusNodeCommentDelete = FocusNode();

  //textfield ลบ
  TextEditingController editCommentDelete = new TextEditingController();


  //dropdown คลังจัดเก็บต้นทาง
  ItemsMasWarehouseResponse dropdownItemsSourceStock;
  //dropdown คลังจัดเก็บปลายทาง
  ItemsListWarehouse dropdownValueDestinationStock;
  //ItemsMasWarehouseResponse dropdownItemsDestinationStock;

  //app bar
  TextStyle tabStyle = TextStyle(fontSize: 16.0,
      color: Colors.black54,
      fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle textDataTitleStyle = TextStyle(
      fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(
      fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyleSub = TextStyle(
      fontSize: 14.0,
      color: Colors.black54,
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelDeleteStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.red[200],
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubCont = TextStyle(
      fontSize: 14.0,
      color: Colors.grey[500],
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(
      color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = TextStyle(
      color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditNonCheckStyle = TextStyle(
      fontSize: 16.0, color: Colors.red[100]);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);


  //dialog
  TextStyle TitleStyle = TextStyle(
      fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0,
      color: Colors.red,
      fontWeight: FontWeight.w500,
      fontFamily: FontStyles().FontFamily);

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  String _offerDate,_ConsiderDate,_DestroyDate;

  @override
  void initState() {
    super.initState();

    dropdownItemsSourceStock = widget.itemsMasWarehouse;

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();

    _offertime = dateFormatTime.format(DateTime.now()).toString();
    _considertime = dateFormatTime.format(DateTime.now()).toString();
    _destroytime = dateFormatTime.format(DateTime.now()).toString();
    editOfferTime.text = _offertime;
    editOfferDate.text = date;
    editConsiderTime.text = _considertime;
    editConsiderDate.text = date;
    editDesployTime.text = _destroytime;
    editDesployDate.text = date;

    _offerDate = DateTime.now().toString();
    _ConsiderDate = DateTime.now().toString();
    _DestroyDate = DateTime.now().toString();

    _dtOfferDate = DateTime.now();
    _currentOfferDate = date;
    _currentOfferTime = dateFormatTime.format(DateTime.now()).toString();

    _dtConsiderDate = DateTime.now();
    _currentConsiderDate = date;
    _currentConsiderTime = dateFormatTime.format(DateTime.now()).toString();

    _dtDestroyDate = DateTime.now();
    _currentDestroyDate = date;
    _currentDestroyTime = dateFormatTime.format(DateTime.now()).toString();



    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;

      itemMain = widget.ItemsdestroyMain;
      _setDataSaved();
    }
    if (widget.IsUpdate) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      itemMain = widget.ItemsdestroyMain;
      _setInitDataEvidence();
    }
  }

  void _setDataSaved() {
    _onFinish = true;
    if (choices.length == 2) {
      //เพิ่ม tab แบบฟอร์ม
      choices.add(Choice(title: 'แบบฟอร์ม'));
      //เพิ่ม item forms
      itemsFormsTab.add(
          new ItemsListArrest8("บัญชีรายการโอนย้ายของกลาง",""));
    }
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }


  @override
  void dispose() {
    super.dispose();


    editDeliveredNumber.dispose();
    editDeliveredYear.dispose();
    editApproveNumber.dispose();
    editOfferTime.dispose();
    editPersonTransfer.dispose();
    editTransferDepartment.dispose();
    editPersonConsider.dispose();
    editConsiderDepartment.dispose();
    editConsiderDate.dispose();
    editConsiderTime.dispose();
    editOfferDate.dispose();
    editDestinationDepartment.dispose();
    editDestinationStock.dispose();
    editSourceStock.dispose();
    editCommentTranfer.dispose();


    editDesployNumber.dispose();
    editDesployDate.dispose();
    editDesployTime.dispose();
    editDesployPerson.dispose();
    editDesployDepartment.dispose();
  }

  void _setInitDataEvidence(){
    editApproveNumber.text = itemMain.EVIDENCE_OUT_NO!=null
        ?(itemMain.EVIDENCE_OUT_NO.substring(1,itemMain.EVIDENCE_OUT_NO.indexOf("/")))
        :"";
    _dtOfferDate = itemMain.APPROVE_DATE!=null
        ?DateTime.parse(itemMain.APPROVE_DATE)
        :"";
    _dtConsiderDate = DateTime.parse(itemMain.EVIDENCE_OUT_NO_DATE);
    _dtOfferDate = DateTime.parse(itemMain.EVIDENCE_OUT_DATE);

    _currentOfferDate = _convertDate(_dtOfferDate.toString());
    _currentOfferTime = dateFormatTime.format(_dtOfferDate).toString();
    _currentConsiderDate = _convertDate(_dtConsiderDate.toString());
    _currentConsiderTime = dateFormatTime.format(_dtConsiderDate).toString();
    _currentDestroyDate = _convertDate(_dtOfferDate.toString());
    _currentDestroyTime = dateFormatTime.format(_dtOfferDate).toString();

    editOfferDate.text = _currentOfferDate;
    editOfferTime.text = _currentOfferTime;
    editConsiderDate.text =_currentOfferDate;
    editConsiderTime.text = _currentConsiderTime;
    editDesployDate.text = _currentDestroyDate;
    editDesployTime.text = _currentDestroyTime;

   /* editPersonOffer.text =  get_staff_name(itemMain.EvidenceOutStaff, 72);
    editPersonConsider.text =get_staff_name(itemMain.EvidenceOutStaff, 73);
    editDesployPerson.text=get_staff_name(itemMain.EvidenceOutStaff, 74);

    editOfferDepartment.text = get_office_name(itemMain.EvidenceOutStaff, 72);
    editConsiderDepartment.text =get_staff_name(itemMain.EvidenceOutStaff, 73);
    editDesployDepartment.text=get_staff_name(itemMain.EvidenceOutStaff, 74);*/

    itemEvidence.forEach((item){
      _setCalItem(item);
    });
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        _onFinish=false;

        final pos=tabController.length-1;
        choices.removeAt(pos);
        tabController = TabController(initialIndex: 0,length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);

        _setInitDataEvidence();
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text("เหตุผลการลบ.",
                  style: textLabelStyle,
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: TextField(
                  maxLines: 5,
                  focusNode: myFocusNodeCommentDelete,
                  controller: editCommentDelete,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[500], width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[400], width: 0.5),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade50),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                editCommentDelete.dispose();
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                onDeleted();
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  //แสดง dialog ลบรายการ
  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  void onDeleted()async{
    Map map_evidence = {
      "EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID
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
    await onLoadActionInsLawsuitDelete(map_evidence);
    Navigator.pop(context,"Delete");
  }
  Future<bool> onLoadActionInsLawsuitDelete(Map map_evidence) async {
    await new ManageEvidenceFuture().apiRequestEvidenceOutupdDelete(map_evidence).then((onValue) {
      print("Delete Evidence Out : "+onValue.Msg);
    });

    _onSaved = false;
    _onEdited = true;
    _onSave = false;
    choices.removeAt(choices.length-1);
    Navigator.pop(context);

    setState(() {});
    return true;
  }

  //ล้างข้อมูลใน text field
  void clearTextfield() {

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

                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  setState(() {
                    _onSaved = true;
                    _onEdited = false;
                    _setDataSaved();
                  });
                }
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

  //เมื่อกดปุ่มบันทึก
  void onSaved(BuildContext mContext) async {
    if (editDeliveredNumber.text.isEmpty||editDeliveredYear.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่ง');
    }else if (editPersonTransfer.text.isEmpty||editTransferDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องผู้ขอโอนย้ายหรือหน่วยงานผู้ขอโอนย้าย');
    }else if (editPersonConsider.text.isEmpty||editConsiderDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องผู้พิจารณาอนุมัติหรือหน่วยงานผู้พิจารณาอนุมัติ');
    }else if (editDesployPerson.text.isEmpty||editDesployDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องผู้นำออกหรือหน่วยงานผู้นำออก');
    }/*else if (editDestinationDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกหน่วยงานปลายทาง');
    }*/else if (/*editDestinationStock.text.isEmpty*/dropdownValueDestinationStock==null) {
      new VerifyDialog(mContext, 'กรุณากรอกคลังจัดเก็บปลายทาง');
    }else if (editApproveNumber.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสืออนุมัติ');
    }else if (editCommentTranfer.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเหตุผลในการนำออก');
    }else if (itemEvidence.length == 0) {
      new VerifyDialog(mContext, 'กรุณาเพิ่มของกลางเพื่อโอนย้าย');
    } else {
      if(_onEdited){
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionUpdAllEvidenceOut();
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
        await onLoadActionInsAllEvidenceOut();
        Navigator.pop(context);
      }
    }

  }


  Future<String> _transection_running()async{
    Map map_transec = {
      "RUNNING_TABLE": "OPS_EVIDENCE_OUT",
      "RUNNING_OFFICE_CODE": widget.ItemsPerson.WorkOffCode
    };
    await new TransectionFuture()
        .apiRequestTransactionRunninggetByCon(map_transec)
        .then((onValue) {
      _itemTransection = onValue;
      if (_itemTransection.length != 0) {
        IsEvidenceCode = true;
        transection_no = (_itemTransection.last.RUNNING_NO + 1).toString();
        if (transection_no.length != 5) {
          String sum = "";
          for (int i = 0; i < 5 - transection_no.length; i++) {
            sum += "0";
          }
          transection_no = _itemTransection.last.RUNNING_PREFIX
              + _itemTransection.last.RUNNING_OFFICE_CODE +
              _itemTransection.last.RUNNING_YEAR +
              sum + transection_no;
        }
      } else {
        IsEvidenceCode = false;
        DateFormat format_auto = DateFormat("yyyy");
        String date_auto = (int.parse(
            format_auto.format(DateTime.now()).toString()) + 543)
            .toString()
            .substring(2);
        transection_no =
            "DT" + widget.ItemsPerson.WorkOffCode + date_auto + "00001";
      }
    });
    print("transection_no : " + transection_no);
    return transection_no;
  }

  void _transection_update()async{
    if (IsEvidenceCode) {
      Map map_tran_up = {
        "RUNNING_ID": _itemTransection.last.RUNNING_ID,
      };
      await new TransectionFuture()
          .apiRequestTransactionRunningupdByCon(map_tran_up)
          .then((onValue) {
        print("Update Transection : " + onValue.Msg);
      });
    } else {
      Map map_tran_ins = {
        "RUNNING_OFFICE_ID": 30,
        "RUNNING_OFFICE_CODE": widget.ItemsPerson.WorkOffCode,
        "RUNNING_TABLE": "OPS_EVIDENCE_OUT",
        "RUNNING_PREFIX": "DT"
      };
      print(map_tran_ins.toString());
      await new TransectionFuture().apiRequestTransactionRunninginsAll(
          map_tran_ins).then((onValue) {
        print("Insert Transection : " + onValue.Msg);
      });
    }
  }

  List<ItemsListTransection> _itemTransection = [];
  List<ItemsListTransectionItem> _itemTransectionitem = [];
  String transection_no,transection_item_no;
  bool IsEvidenceCode,IsEvidenceItemCode;
  //timing progress dialog
  Future<bool> onLoadActionInsAllEvidenceOut() async {

    String tran_evidence_no;
    await _transection_running().then((s){
      print("report : "+s);
      tran_evidence_no = s;
    });

    Map map_evidence = {
      "EVIDENCE_OUT_ID": "",
      "EVIDENCE_IN_ID": "1",
      "WAREHOUSE_ID": dropdownValueDestinationStock!=null?dropdownValueDestinationStock.WAREHOUSE_ID:"",
      "OFFICE_CODE": "",
      "EVIDENCE_OUT_CODE": tran_evidence_no,
      "EVIDENCE_OUT_DATE": _DestroyDate,
      "EVIDENCE_OUT_TYPE": 8,
      "EVIDENCE_OUT_NO": editDeliveredNumber.text+"/"+editDeliveredYear.text,
      "EVIDENCE_OUT_NO_DATE": _offerDate,
      "BOOK_NO": "",
      "RECEIPT_NO": "",
      "PAY_DATE": "",
      "APPROVE_DATE": _ConsiderDate,
      "RETURN_DATE": "",
      "REMARK": editCommentTranfer.text,
      "APPROVE_NO": editApproveNumber.text,
      "IS_ACTIVE": "1",
      "EvidenceOutItem": _createMapEvidenceItem(false),
      "EvidenceOutStaff": _createMapStaff()
    };

    int EVIDENCE_OUT_ID;
    await new ManageEvidenceFuture()
        .apiRequestEvidenceOutinsAll(map_evidence)
        .then((onValue) {
      EVIDENCE_OUT_ID =onValue.EVIDENCE_OUT_ID;
      print("Insert EvidenceOut :" + onValue.Msg.toString());
      print(onValue.EVIDENCE_OUT_ID.toString());
    });

    double sum_dest = 0;
    itemEvidence.forEach((item){
      sum_dest+=double.parse(item.ItemsController.editTotalNumber.text);
    });
    print("BALANCE_QTY : "+sum_dest.toString());
    Map map_balance={
      "STOCK_ID": 1,
      "BALANCE_QTY": sum_dest
    };
    await new ManageEvidenceFuture()
        .apiRequestEvidenceOutStockBalanceupdByCon(map_balance)
        .then((onValue) {
      print("Update Balance Stock :" + onValue.Msg.toString());
    });

    _transection_update();



    //getByCon
    if(EVIDENCE_OUT_ID!=null){
      Map map_con = {
        "EVIDENCE_OUT_ID": EVIDENCE_OUT_ID,
      };
      await new ManageEvidenceFuture()
          .apiRequestEvidenceOutgetByCon(map_con)
          .then((onValue) {
        if(onValue!=null){
          itemMain = onValue;
          itemEvidence = itemMain.EvidenceOutIn.EvidenceOutInItem;
        }else{
          //error
        }

      });



      List<Map> _arrJsonImg=[];
      int index=0;
      _arrItemsImageFile.forEach((_file){
        String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
        index++;
        _arrJsonImg.add({
          "DATA_SOURCE": "",
          "DOCUMENT_ID": "",
          "DOCUMENT_NAME": itemMain.EVIDENCE_OUT_CODE+"_"+index.toString(),
          "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
          "DOCUMENT_TYPE": "12",
          "FILE_TYPE": "jpg",
          "FOLDER": "Product",
          "IS_ACTIVE": "1",
          "REFERENCE_CODE": itemMain.EVIDENCE_OUT_ID,
          "CONTENT":base64Image
        });
      });

      for(int i=0;i<_arrJsonImg.length;i++){
        await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
          print("["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
        });
      }
    }


    Map map = {
      "DOCUMENT_TYPE": 12,
      "REFERENCE_CODE": itemMain.EVIDENCE_OUT_ID
    };
    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue){
      List<ItemsListDocument> items = [];
      onValue.forEach((f){
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
      setState(() {});
    });


    itemsListEvidenceStaff = [];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionUpdAllEvidenceOut() async {

    Map map = {
      "EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID,
      "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
      "WAREHOUSE_ID": dropdownValueDestinationStock!=null?dropdownValueDestinationStock.WAREHOUSE_ID:"",
      "OFFICE_CODE": "",
      "EVIDENCE_OUT_CODE": itemMain.EVIDENCE_OUT_CODE,
      "EVIDENCE_OUT_DATE": _DestroyDate,
      "EVIDENCE_OUT_TYPE": 8,
      "EVIDENCE_OUT_NO": editDeliveredNumber.text+"/"+editDeliveredYear.text,
      "EVIDENCE_OUT_NO_DATE": _offerDate,
      "BOOK_NO": "",
      "RECEIPT_NO": "",
      "PAY_DATE": "",
      "APPROVE_DATE": _ConsiderDate,
      "RETURN_DATE": "",
      "REMARK": editCommentTranfer.text,
      "APPROVE_NO": editApproveNumber.text,
      "IS_ACTIVE": "1",
      "EvidenceOutItem": _createMapEvidenceItem(true),
      "EvidenceOutStaff": _createMapStaff()
    };
    await new ManageEvidenceFuture()
        .apiRequestEvidenceOutupdByCon(map)
        .then((onValue) {
      print("Update EvidenceOut :" + onValue.Msg.toString());
    });

    int sum_dest = 0;
    itemEvidence.forEach((item){
      try{
        sum_dest+=int.parse(item.ItemsController.editTotalVolumn.text);
      }catch(e){
        item.EvidenceOutStockBalance.forEach((item){
          sum_dest+=item.BALANCE_QTY.toInt();
        });
      }
    });
    print("BALANCE_QTY : "+sum_dest.toString());
    Map map_balance={
      "STOCK_ID": 1,
      "BALANCE_QTY": sum_dest
    };
    await new ManageEvidenceFuture()
        .apiRequestEvidenceOutStockBalanceupdByCon(map_balance)
        .then((onValue) {
      print("Update Balance Stock :" + onValue.Msg.toString());
    });



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
        "DOCUMENT_NAME": itemMain.EVIDENCE_OUT_CODE+"_"+index.toString(),
        "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "12",
        "FILE_TYPE": "jpg",
        "FOLDER": "Product",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": itemMain.EVIDENCE_OUT_ID,
        "CONTENT":base64Image
      });
    });
    for(int i=0;i<_arrJsonImg.length;i++){
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
        print("Update Add ["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
      });
    }



    //getByCon
    Map map_con = {
      "EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID,
    };
    await new ManageEvidenceFuture()
        .apiRequestEvidenceOutgetByCon(map_con)
        .then((onValue) {
      if(onValue!=null){
        itemMain = onValue;
        itemEvidence = onValue.EvidenceOutIn.EvidenceOutInItem;
      }else{
        //error
      }
    });

    Map map_doc = {
      "DOCUMENT_TYPE": 12,
      "REFERENCE_CODE": itemMain.EVIDENCE_OUT_ID
    };
    await new TransectionFuture().apiRequestGetDocumentByCon(map_doc).then((onValue){
      List<ItemsListDocument> items = [];
      onValue.forEach((f){
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
      setState(() {});
    });

    itemsListEvidenceStaff = [];

    _arrItemsImageFileAdd=[];
    _arrItemsImageFileDelete=[];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0,
        color: Colors.black54,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);

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
          width: width / 4,
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
      Expanded(
          child: Center(child: Text("โอนย้ายของกลาง", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 4,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
                            child: Text(contants.text, style: TextStyle(
                                fontFamily: FontStyles().FontFamily)),)
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

    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context);
              //Navigator.pop(context, itemMain);
            }
          } else {
            Navigator.pop(context);
            //Navigator.pop(context, itemMain);
          }
        });
      },
      child: Scaffold(
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
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(140.0),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[500],
                      labelStyle: tabStyle,
                      controller: tabController,
                      isScrollable: false,
                      tabs: choices.map((Choice choice) {
                        return Tab(
                          text: choice.title,
                        );
                      }).toList(),
                    ),
                  ),
                  body: Stack(
                    children: <Widget>[
                      BackgroundContent(),
                      TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: _onFinish ? <Widget>[
                          _buildContent_tab_1(),
                          _buildContent_tab_2(),
                          _buildContent_tab_3(),
                        ] :
                        <Widget>[
                          _buildContent_tab_1(),
                          _buildContent_tab_2(),
                        ],
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

  //************************start_tab_1*****************************
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0, fontFamily: FontStyles().FontFamily
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

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      final double Width = (size.width * 85) / 100;

      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[300],
      );
      final focus = FocusNode();

      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    width: Width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("เลขที่หนังสือนำส่ง",
                                  style: textLabelStyle,),
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
                                  padding: paddingInputBox,
                                  child: new Text("กค.",
                                    style: textLabelStyle,
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
                                          focusNode: myFocusNodeDeliveredNumber,
                                          controller: editDeliveredNumber,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization
                                              .words,
                                          style: textInputStyle,
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
                                new Padding(
                                  padding: paddingInputBox,
                                  child: new Text("/",
                                    style: textInputStyle,
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
                                          focusNode: myFocusNodeDeliveredYear,
                                          controller: editDeliveredYear,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization
                                              .words,
                                          style: textInputStyle,
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
                            child: Row(
                              children: <Widget>[
                                Text("ลงวันที่", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                              padding: paddingInputBox,
                              child: IgnorePointer(
                                ignoring: false,
                                child: TextField(
                                  enableInteractiveSelection: false,
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(
                                        new FocusNode());
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtOfferDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtOfferDate = s;
                                        _currentOfferDate = date;
                                        editOfferDate.text = _currentOfferDate;


                                      });
                                    });
                                  },
                                  focusNode: myFocusNodeOfferDate,
                                  controller: editOfferDate,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(
                                          FontAwesomeIcons.calendarAlt)
                                  ),
                                ),
                              )
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("เวลา", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeOfferTime,
                              controller: editOfferTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: offerTime,
                                        onDateTimeChanged: (
                                            DateTime newDateTime) {
                                          setState(() {
                                            offerTime = newDateTime;
                                            _offertime =
                                                dateFormatTime.format(offerTime)
                                                    .toString();
                                            editOfferTime.text = _offertime;

                                            List splitsArrestDate = _dtOfferDate
                                                .toUtc().toLocal()
                                                .toString()
                                                .split(" ");
                                            List splitsArrestTime = offerTime
                                                .toString().split(" ");
                                            _offerDate =
                                                splitsArrestDate[0].toString() +
                                                    " " + splitsArrestTime[1]
                                                    .toString();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("ผู้ขอโอนย้าย", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                _navigateSearchStaff(context,81);
                              },
                              focusNode: myFocusNodePersonTransfer,
                              controller: editPersonTransfer,
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
                            child: Row(
                              children: <Widget>[
                                Text("หน่วยงาน", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeTransferDepartment,
                              controller: editTransferDepartment,
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "คลังจัดเก็บปลายทาง", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          /*Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeDestinationStock,
                              controller: editDestinationStock,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),*/
                          Container(
                            width: size.width,
                            padding: paddingLabel,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ItemsListWarehouse>(
                                value: dropdownValueDestinationStock,
                                onChanged: (ItemsListWarehouse newValue) {
                                  setState(() {
                                    dropdownValueDestinationStock = newValue;
                                  });
                                },
                                items: dropdownItemsSourceStock.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListWarehouse>>((ItemsListWarehouse value) {
                                  return DropdownMenuItem<ItemsListWarehouse>(
                                    value: value,
                                    child: Text(value.WAREHOUSE_NAME.toString(), style: textInputStyle,),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("เลขที่หนังสืออนุมัติ",
                                  style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeApproveNumber,
                              controller: editApproveNumber,
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
                            child: Row(
                              children: <Widget>[
                                Text("วันที่อนุมัติ", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                              padding: paddingInputBox,
                              child: IgnorePointer(
                                ignoring: false,
                                child: TextField(
                                  enableInteractiveSelection: false,
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(
                                        new FocusNode());
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtConsiderDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtConsiderDate = s;
                                        _currentConsiderDate = date;
                                        editConsiderDate.text =
                                            _currentConsiderDate;
                                      });
                                    });
                                  },
                                  focusNode: myFocusNodeConsiderDate,
                                  controller: editConsiderDate,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(
                                          FontAwesomeIcons.calendarAlt)
                                  ),
                                ),
                              )
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("เวลา", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeConsiderTime,
                              controller: editConsiderTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: considerTime,
                                        onDateTimeChanged: (
                                            DateTime newDateTime) {
                                          setState(() {
                                            considerTime = newDateTime;
                                            _considertime =
                                                dateFormatTime.format(
                                                    considerTime)
                                                    .toString();
                                            editConsiderTime.text =
                                                _considertime;


                                            List splitsArrestDate = _dtConsiderDate
                                                .toUtc().toLocal()
                                                .toString()
                                                .split(" ");
                                            List splitsArrestTime = considerTime
                                                .toString().split(" ");
                                            _ConsiderDate =
                                                splitsArrestDate[0].toString() +
                                                    " " + splitsArrestTime[1]
                                                    .toString();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ผู้พิจารณาอนุมัติ", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                _navigateSearchStaff(context,82);
                              },
                              style: textInputStyle,
                              focusNode: myFocusNodePersonConsider,
                              controller: editPersonConsider,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text("หน่วยงาน", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeConsiderDepartment,
                              controller: editConsiderDepartment,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เหตุผลในการนำออก", style: textLabelStyle,),
                                Text("*", style: textStyleStar,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeCommentTranfer,
                              controller: editCommentTranfer,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return itemMain == null ? Container() : Container(
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        padding: EdgeInsets.only(
            top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0.0,
              color: Colors.transparent,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เลขที่หนังสือ", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("กค."+itemMain.EVIDENCE_OUT_NO.toString(),
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("ลงวันที่", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(_convertDate(itemMain.EVIDENCE_OUT_NO_DATE)+" "+_convertTime1(itemMain.EVIDENCE_OUT_NO_DATE),
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("ผู้ขอโอนย้าย", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(get_staff_name(itemMain.EvidenceOutStaff, 81),
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("หน่วยงาน", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(get_office_name(itemMain.EvidenceOutStaff, 81),
                          style: textInputStyle,),
                      ),
                      /*Padding(
                        padding: paddingInputBox,
                        child: Text("หน่วยงานปลายทาง", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("",
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("คลังจัดเก็บต้นทาง", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("",
                          style: textInputStyle,),
                      ),*/
                      Container(
                        padding: paddingLabel,
                        child: Text("คลังจัดเก็บปลายทาง", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(get_warehouse_name()!=null
                            ?get_warehouse_name()
                            :"",
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("เลขที่หนังสืออนุมัติ", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(itemMain.APPROVE_NO.toString(),
                          style: textInputStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text("วันที่อนุมัติ", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(_convertDate(itemMain.APPROVE_DATE)+" "+_convertTime1(itemMain.APPROVE_DATE),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้พิจารณาอนุมัติ", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(get_staff_name(itemMain.EvidenceOutStaff, 82),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("หน่วยงาน", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(get_office_name(itemMain.EvidenceOutStaff, 82),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("เหตุผลในการนำออก", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          itemMain.REMARK!=null?itemMain.REMARK:"", style: textInputStyle,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            //height: 34.0,
            decoration: BoxDecoration(
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_08_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved ? _buildContent_saved(context) : _buildContent(
                    context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

  //************************start_tab_2*****************************
  //รูปภาพ
  Future<File> _imageFile;
  List<ItemsListDocument> _arrItemsImageFile = [];
  List<ItemsListDocument> _arrItemsImageFileAdd =[];
  List<int> _arrItemsImageFileDelete =[];
  bool isImage = false;
  VoidCallback listener;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      if(widget.IsUpdate) {
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
  void _showDialogImagePicker() {
    showDialog(context: context,
        builder: (context) => _onTapImage(context)); // Call the Dialog.
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
                  getImage(ImageSource.camera, context);
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
                  getImage(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    return Container(
      padding: EdgeInsets.only(top: 18.0),
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
                width: size.width / 2.2,
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : _showDialogImagePicker();
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
                              Icons.file_upload, size: 22, color: uploadColor,),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "อัพโหลดรูปภาพ", style: textLabelStyle,),
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

  navigateDeliveredBook(BuildContext context,index,bool IsUpdate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DestroyBookSearchScreenFragment(IsUpdate: IsUpdate,
          )),
    );
    if (result.toString() != "Back") {
      setState(() {
        if(_onEdited){
          try{
            List<EvidenceInventoryList> item = result;
            item.forEach((item) {
              itemEvidence[index] = item;
            });
            itemEvidence.forEach((item){
              _setCalItem(item);
            });
          }catch(e){
            print("error : "+e.toString());
          }

        }else {
          List<EvidenceInventoryList> item = result;
          if(IsUpdate){
            item.forEach((item) {
              itemEvidence[index] = item;
            });

          }else{
            item.forEach((item) {
              itemEvidence.add(item);
            });
          }
          itemEvidence.forEach((item) {
            _setCalItem(item);
          });
        }
        /*ItemsEvidence item = result;
        itemEvidence.add(item);
        itemEvidence.forEach((item){
          item.EvidenceDetailController.expController.expanded=true;
        });*/
      });
    }
  }

  Widget _buildButtonSelectEvidence() {
    var size = MediaQuery
        .of(context)
        .size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    return Container(
      padding: EdgeInsets.only(left: 18.0, top: 18.0),
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
                width: size.width / 2.2,
                //padding: EdgeInsets.all(4.0),
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : navigateDeliveredBook(context,null,false);
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
                            child: Text(
                              "เพิ่มของกลาง", style: textLabelStyle,),
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
                      child: Image.file(
                        _arrItemsImageFile[index].FILE_CONTENT, fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageFile[index].DOCUMENT_NAME,
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: !_onSaved ? Icon(
                          Icons.delete_outline, size: 32.0,) : Icon(null),
                        onPressed: () {
                          setState(() {
                            if(widget.IsUpdate){
                              try{
                                _arrItemsImageFileDelete.add(_arrItemsImageFile[index].DOCUMENT_ID);
                              }catch(e){
                                _arrItemsImageFileAdd.removeAt(index);
                              }
                            }
                            _arrItemsImageFile.removeAt(index);
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
  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoDeleteEvidenceDialog(index) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการลบข้อมูล.",
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
                  itemEvidence.removeAt(index);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }
  //แสดง dialog ลบรายการ
  void _showDeleteEvidenceAlertDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteEvidenceDialog(index);
      },
    );
  }

  Widget _buildContent_tab_2() {
    Widget _buildExpandableContent(int index) {
      var size = MediaQuery
          .of(context)
          .size;
      Widget _buildExpanded(index) {
        return Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "เลขทะเบียนบัญชี", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(
                    itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(), style: textInputStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อของกลาง", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(
                    itemEvidence[index].PRODUCT_DESC.toString(), style: textInputStyle,),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวน", style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .ItemsController
                                    .myFocusNodeDeliveredNumber,
                                controller: itemEvidence[index]
                                    .ItemsController.editDeliveredNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textInputStyle,
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
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวนทำลาย", style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: itemEvidence[index]
                                    .ItemsController
                                    .myFocusNodeDefectiveNumber,
                                controller: itemEvidence[index]
                                    .ItemsController.editDefectiveNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textInputStyle,
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
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวนคงเหลือ", style: textLabelStyle,),
                            ),
                            new IgnorePointer(
                              ignoring: true,
                              child: Padding(
                                padding: paddingInputBox,
                                child: TextField(
                                  focusNode: itemEvidence[index]
                                      .ItemsController
                                      .myFocusNodeToalNumber,
                                  controller: itemEvidence[index]
                                      .ItemsController.editTotalNumber,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization
                                      .words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textLabelStyle,),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: new FocusNode(),
                                controller: itemEvidence[index]
                                    .ItemsController.editProductUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization
                                    .words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            widget.IsCreate ? Padding(
              padding: EdgeInsets.only(top: 36.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    padding: EdgeInsets.all(6.0),
                    child: InkWell(
                        onTap: () {
                          _showDeleteEvidenceAlertDialog(index);
                        },
                        child: Text(
                          "ลบ", style: textLabelEditNonCheckStyle,)
                    )
                ),
              ),
            ) : Container()
          ],
        );
      }
      Widget _buildCollapsed(int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "เลขทะเบียนบัญชี", style: textLabelStyle,),
            ),
            Container(
              padding: paddingInputBox,
              child: Text(
                itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(), style: textInputStyle,),
            ),
            Container(
              padding: paddingLabel,
              child: Text(
                "ชื่อของกลาง", style: textLabelStyle,),
            ),
            Container(
              padding: paddingInputBox,
              child: Text(
                itemEvidence[index].PRODUCT_DESC.toString(), style: textInputStyle,),
            ),
          ],
        );
      }
      return ExpandableNotifier(
        controller: itemEvidence[index].ItemsController.expController,
        child: Stack(
          children: <Widget>[
            Expandable(
                collapsed: _buildCollapsed(index),
                expanded: _buildExpanded(index)
            ),
            Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Builder(
                        builder: (context) {
                          var exp = ExpandableController.of(context);
                          return IconButton(
                            icon: Icon(
                              exp.expanded ? Icons.keyboard_arrow_up : Icons
                                  .keyboard_arrow_down, size: 24.0,
                              color: Colors.grey,),
                            onPressed: () {
                              exp.toggle();
                            },
                          );
                        }
                    ),
                  ],
                )
            )
          ],
        ),
      );
    }

    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
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
                      child: Text(
                        "เลขที่นำออก", style: textLabelStyle,),
                    ),
                    Container(
                      padding: paddingInputBox,
                      child: Text(
                        "Auto Gen", style: textInputStyle,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่นำออก", style: textLabelStyle,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Padding(
                        padding: paddingInputBox,
                        child: IgnorePointer(
                          ignoring: false,
                          child: TextField(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(
                                        Current: _dtDestroyDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(
                                    s).toString().split(" ");
                                date = splits[0] + " " + splits[1] +
                                    " " +
                                    (int.parse(splits[3]) + 543)
                                        .toString();
                                setState(() {
                                  _dtDestroyDate = s;
                                  _currentDestroyDate = date;
                                  editDesployDate.text = _currentDestroyDate;
                                });
                              });
                            },
                            focusNode: myFocusNodeDesployDate,
                            controller: editDesployDate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textInputStyle,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                    FontAwesomeIcons.calendarAlt)
                            ),
                          ),
                        )
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text("เวลา", style: textLabelStyle,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeDesployTime,
                        controller: editDesployTime,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: destroyTime,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      destroyTime = newDateTime;
                                      _destroytime =
                                          dateFormatTime.format(destroyTime)
                                              .toString();
                                      editDesployTime.text = _destroytime;


                                      List splitsArrestDate = _dtDestroyDate
                                          .toUtc().toLocal()
                                          .toString()
                                          .split(" ");
                                      List splitsArrestTime = destroyTime
                                          .toString().split(" ");
                                      _DestroyDate =
                                          splitsArrestDate[0].toString() +
                                              " " + splitsArrestTime[1]
                                              .toString();
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "ผู้นำออก", style: textLabelStyle,),
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
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(
                                    new FocusNode());
                                _navigateSearchStaff(context,83);
                              },
                              focusNode: myFocusNodeDesployPerson,
                              controller: editDesployPerson,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textInputStyle,
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
                            "หน่วยงาน", style: textLabelStyle,),
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
                              focusNode: myFocusNodeDesployDepartment,
                              controller: editDesployDepartment,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textInputStyle,
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
              itemEvidence.length > 0 ?
              Container(
                width: size.width,
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemEvidence.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: size.width,
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            _buildExpandableContent(index),
                          ],
                        )
                    );
                  },
                ),
              ) : Container(),
              /*itemMain.CheckEvidenceType == 1 && widget.IsCreate?
              Container(
                padding: EdgeInsets.only(left: 22.0, bottom: 22.0),
                child: _buildButtonImgPicker(),
              )
                  :*/ Container(
                width: size.width,
                padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildButtonImgPicker(),
                      _buildButtonSelectEvidence()
                    ],
                  ),
                )
              ),
              _buildDataImage(context),
            ],
          ),
        ),
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1));
      EdgeInsets paddindSentence = EdgeInsets.only(
          top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
      var size = MediaQuery
          .of(context)
          .size;

      Widget _buildExpandableContent(int index) {
        var size = MediaQuery
            .of(context)
            .size;
        EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
        Widget _buildExpanded(index) {
          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "เลขทะเบียนบัญชี", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(
                      itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(), style: textInputStyle,),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ชื่อของกลาง", style: textLabelStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(
                      itemEvidence[index].PRODUCT_DESC.toString(),
                      style: textInputStyle,),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 3.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวน", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text('', style: textInputStyle,),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text("จำนวนทำลาย", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text('', style: textInputStyle,),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนคงเหลือ", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text('', style: textInputStyle,),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 3.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text("หน่วย", style: textLabelStyle,),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text('', style: textInputStyle,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }
        Widget _buildCollapsed(int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขทะเบียนบัญชี", style: textLabelStyle,),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(
                  itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(), style: textInputStyle,),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ชื่อของกลาง", style: textLabelStyle,),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(
                  itemEvidence[index].PRODUCT_DESC.toString(),
                  style: textInputStyle,),
              ),
            ],
          );
        }
        return ExpandableNotifier(
          controller: itemEvidence[index]
              .ItemsController
              .expController,
          child: Stack(
            children: <Widget>[
              Expandable(
                  collapsed: _buildCollapsed(index),
                  expanded: _buildExpanded(index)
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Builder(
                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return IconButton(
                              icon: Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons
                                    .keyboard_arrow_down, size: 24.0,
                                color: Colors.grey,),
                              onPressed: () {
                                exp.toggle();
                              },
                            );
                          }
                      ),
                    ],
                  )
              )
            ],
          ),
        );
      }


      return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width,
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
                        child: Text("เลขที่นำออก", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          itemMain.EVIDENCE_OUT_CODE.toString(),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("วันที่นำออก", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          _convertDate(itemMain.EVIDENCE_OUT_DATE)+" "+_convertTime1(itemMain.EVIDENCE_OUT_DATE),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้นำออก", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          get_staff_name(itemMain.EvidenceOutStaff, 83),
                          style: textInputStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("หน่วยงาน", style: textLabelStyle,),
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          get_office_name(itemMain.EvidenceOutStaff, 83),
                          style: textInputStyle,),
                      ),
                    ],
                  ),
                ),
                itemEvidence.length > 0 ?
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemEvidence.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: size.width,
                          padding: EdgeInsets.all(22.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[300], width: 1.0),
                              )
                          ),
                          child: Stack(
                            children: <Widget>[
                              _buildExpandableContent(index),
                            ],
                          )
                      );
                    },
                  ),
                ) : Container(),
                _onSaved
                    ?Container()
                    :Container(
                  padding: EdgeInsets.only(left: 22.0, bottom: 22.0),
                  child: _buildButtonImgPicker(),
                ),
                _buildDataImage(context),
              ],
            ),
          )
      );
    }
    //data result when search data
    return Container(
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
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_08_00_04_00', style: textStylePageName,),
                    )
                  ],
                ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: _onSaved
                  ? _buildContent_saved(context)
                  : _buildContent(
                  context),
            ),
          ),
        ],
      ),
    );
  }


//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      leading: Padding(padding: paddingLabel,
                        child: Text((index + 1).toString() + '. ',
                          style: textInputStyleTitle,),),
                      title: Padding(padding: paddingLabel,
                        child: Text(itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[300],
                        size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[index].FormsName,
                                  FILE_NAME: itemsFormsTab[index].FormsCode,
                                ),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    //data result when search data
    return Center(
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
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_08_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _buildContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
//************************end_tab_3*******************************



  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime(String sDate) {
    /* DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();*/
    String result = "เวลา "+sDate.substring(3)+" น.";
    return result;
  }
  String _convertTime1(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

  String get_staff_name(var Items, int CONTRIBUTOR_ID){
    String name="";
    Items.forEach((item){
      if(item.CONTRIBUTOR_ID==CONTRIBUTOR_ID){
        name = item.TITLE_SHORT_NAME_TH+item.FIRST_NAME+" "+item.LAST_NAME;
      }
    });
    return name;
  }
  String get_office_name(var Items, int CONTRIBUTOR_ID){
    String office="";
    Items.forEach((item){
      if(item.CONTRIBUTOR_ID==CONTRIBUTOR_ID){
        office = item.OPERATION_OFFICE_NAME;
      }
    });
    return office;
  }
  String get_pos_name(var Items, int CONTRIBUTOR_ID){
    String pos="";
    Items.forEach((item){
      if(item.CONTRIBUTOR_ID==CONTRIBUTOR_ID){
        pos = item.OPREATION_POS_NAME;
      }
    });
    return pos;
  }

  String get_warehouse_name(){
    String warehouse;
    itemMain.EvidenceOutIn.EvidenceOutInItem.forEach((item){
      item.EvidenceOutStockBalance.forEach((item){
        widget.itemsMasWarehouse.RESPONSE_DATA.forEach((itm){
          print(itm.WAREHOUSE_ID);
          if(itm.WAREHOUSE_ID == item.WAREHOUSE_ID){
            warehouse = itm.WAREHOUSE_NAME.toString();
          }
        });
      });
    });
    return warehouse;
  }

  void _setCalItem(var item){
    try{
      double BALANCE_QTY=0;
      String BALANCE_QTY_UNIT="";
      item.EvidenceOutStockBalance.forEach((f){
        if(item.EVIDENCE_IN_ITEM_ID==f.EVIDENCE_IN_ITEM_ID){
          BALANCE_QTY = f.BALANCE_QTY;
          BALANCE_QTY_UNIT = f.BALANCE_QTY_UNIT;
        }
      });
      item.ItemsController.editDeliveredNumber.text= BALANCE_QTY.toInt().toString();
      item.ItemsController.editDefectiveNumber.text = 0.toInt().toString();
      item.ItemsController.editTotalNumber.text= (BALANCE_QTY - 0).toInt().toString();
      item.ItemsController.editProductUnit.text= BALANCE_QTY_UNIT.toString();
    }catch(e){
      item.ItemsController.editDeliveredNumber.text= item.BALANCE_QTY.toInt().toString();
      item.ItemsController.editDefectiveNumber.text = 0.toInt().toString();
      item.ItemsController.editTotalNumber.text= (item.BALANCE_QTY - 0).toInt().toString();
      item.ItemsController.editProductUnit.text= item.BALANCE_QTY_UNIT.toString();
    }
  }


  List<ItemsListEvidenceGetStaff> itemsListEvidenceStaff = [];
  void add_staff_to(int CONTRIBUTOR_ID) {
    /*81=ผู้ขอโอนย้าย
      82=ผู้พิจารณาอนุมัติโอนย้าย
      83=ผู้โอนย้าย*/

    itemsListEvidenceStaff.add(new ItemsListEvidenceGetStaff(
        STAFF_ID: null,
        STAFF_TYPE: widget.ItemsPerson.STAFF_TYPE,
        STAFF_CODE: "",
        STAFF_REF_ID: null,
        ID_CARD: "",
        TITLE_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        TITLE_SHORT_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        FIRST_NAME: widget.ItemsPerson.FIRST_NAME,
        LAST_NAME: widget.ItemsPerson.LAST_NAME,
        OPREATION_POS_NAME: "",
        OPREATION_POS_LAVEL_NAME: widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
        OPERATION_OFFICE_NAME: "",
        OPERATION_OFFICE_SHORT_NAME: "",
        CONTRIBUTOR_ID: CONTRIBUTOR_ID,
        IsCheck: false)
    );
  }
  _navigateSearchStaff(BuildContext context,int CONTRIBUTOR_ID) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TabScreenSearchStaff(
              CONTRIBUTOR_ID: CONTRIBUTOR_ID
          )),
    );

    if (result.toString() != "back") {
      var Item = result;
      if (_onEdited) {
        if (itemMain.EvidenceOutStaff.length > 0) {
          for(int i=0;i<itemMain.EvidenceOutStaff.length;i++){
            if (Item.CONTRIBUTOR_ID == itemMain.EvidenceOutStaff[i].CONTRIBUTOR_ID) {
              itemMain.EvidenceOutStaff[i]=Item;
            }
          }
        }
        print(itemMain.EvidenceOutStaff.length);
      } else {
        if (itemsListEvidenceStaff.length > 0) {
          if(itemsListEvidenceStaff.where((food) => food.CONTRIBUTOR_ID==(Item.CONTRIBUTOR_ID)).toList().length>0){
            for(int i=0;i<itemsListEvidenceStaff.length;i++){
              if(Item.CONTRIBUTOR_ID==itemsListEvidenceStaff[i].CONTRIBUTOR_ID){
                itemsListEvidenceStaff[i] = Item;
              }
            }
          }else{
            itemsListEvidenceStaff.add(Item);
          }
        }else{
          itemsListEvidenceStaff.add(Item);
        }
        print(itemsListEvidenceStaff.length);
      }

      //ผู้โอนย้าย
      editDesployPerson.text = get_staff_name(itemsListEvidenceStaff, 83);
      editDesployDepartment.text = get_office_name(itemsListEvidenceStaff, 83);

      //ผู้เสนออนุมัติโอนย้าย
      editPersonTransfer.text = get_staff_name(itemsListEvidenceStaff, 81);
      editTransferDepartment.text = get_office_name(itemsListEvidenceStaff, 81);

      //ผผู้พิจารณาอนุมัติโอนย้าย
      editPersonConsider.text = get_staff_name(itemsListEvidenceStaff, 82);
      editConsiderDepartment.text = get_office_name(itemsListEvidenceStaff, 82);

    }
  }


  List<Map> _createMapStaff(){
    List<Map> items = [];
    if(_onEdited){
      print("Update Staff");
      itemMain.EvidenceOutStaff.forEach((item){
        items.add({
          "EVIDENCE_OUT_STAFF_ID": item.EVIDENCE_OUT_STAFF_ID,
          "EVIDENCE_OUT_ID": item.EVIDENCE_OUT_ID,
          "STAFF_REF_ID": "",
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": "",
          "STAFF_TYPE": item.STAFF_TYPE,
          "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "",
          "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": "",
          "FIRST_NAME": item.FIRST_NAME,
          "LAST_NAME":item.LAST_NAME,
          "AGE": "",
          "OPERATION_POS_CODE": "",
          "OPREATION_POS_NAME": item.LAST_NAME,
          "OPREATION_POS_LEVEL": "",
          "OPERATION_POS_LEVEL_NAME": "",
          "OPERATION_DEPT_CODE": "",
          "OPERATION_DEPT_NAME": "",
          "OPERATION_DEPT_LEVEL": "",
          "OPERATION_UNDER_DEPT_CODE": "",
          "OPERATION_UNDER_DEPT_NAME": "",
          "OPERATION_UNDER_DEPT_LEVEL": 0,
          "OPERATION_WORK_DEPT_CODE": null,
          "OPERATION_WORK_DEPT_NAME": null,
          "OPERATION_WORK_DEPT_LEVEL": 0,
          "OPERATION_OFFICE_CODE": "",
          "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME,
          "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME,
          "MANAGEMENT_POS_CODE": null,
          "MANAGEMENT_POS_NAME": null,
          "MANAGEMENT_POS_LEVEL": null,
          "MANAGEMENT_POS_LEVEL_NAME": null,
          "MANAGEMENT_DEPT_CODE": null,
          "MANAGEMENT_DEPT_NAME": null,
          "MANAGEMENT_DEPT_LEVEL": 0,
          "MANAGEMENT_UNDER_DEPT_CODE": null,
          "MANAGEMENT_UNDER_DEPT_NAME": null,
          "MANAGEMENT_UNDER_DEPT_LEVEL": 0,
          "MANAGEMENT_WORK_DEPT_CODE": null,
          "MANAGEMENT_WORK_DEPT_NAME": null,
          "MANAGEMENT_WORK_DEPT_LEVEL": 0,
          "MANAGEMENT_OFFICE_CODE": null,
          "MANAGEMENT_OFFICE_NAME": null,
          "MANAGEMENT_OFFICE_SHORT_NAME": null,
          "REPRESENT_POS_CODE": "",
          "REPRESENT_POS_NAME": "",
          "REPRESENT_POS_LEVEL": null,
          "REPRESENT_POS_LEVEL_NAME": null,
          "REPRESENT_DEPT_CODE": null,
          "REPRESENT_DEPT_NAME": null,
          "REPRESENT_DEPT_LEVEL": 0,
          "REPRESENT_UNDER_DEPT_CODE": null,
          "REPRESENT_UNDER_DEPT_NAME": null,
          "REPRESENT_UNDER_DEPT_LEVEL": 0,
          "REPRESENT_WORK_DEPT_CODE": null,
          "REPRESENT_WORK_DEPT_NAME": null,
          "REPRESENT_WORK_DEPT_LEVEL": 0,
          "REPRESENT_OFFICE_CODE": null,
          "REPRESENT_OFFICE_NAME": null,
          "REPRESENT_OFFICE_SHORT_NAME": null,
          "STATUS": 1,
          "REMARK": null,
          "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
          "IS_ACTIVE": 1
        });
      });
    }else{
      print("Add Staff");
      itemsListEvidenceStaff.forEach((item){
        items.add({
          "EVIDENCE_OUT_STAFF_ID": "",
          "EVIDENCE_OUT_ID": "",
          "STAFF_REF_ID": item.STAFF_ID,
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": "",
          "STAFF_TYPE": item.STAFF_TYPE,
          "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "",
          "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": "",
          "FIRST_NAME": item.FIRST_NAME,
          "LAST_NAME":item.LAST_NAME,
          "AGE": "",
          "OPERATION_POS_CODE": "",
          "OPREATION_POS_NAME": item.OPREATION_POS_NAME,
          "OPREATION_POS_LEVEL": "",
          "OPERATION_POS_LEVEL_NAME": item.OPREATION_POS_LAVEL_NAME,
          "OPERATION_DEPT_CODE": "",
          "OPERATION_DEPT_NAME": "",
          "OPERATION_DEPT_LEVEL": "",
          "OPERATION_UNDER_DEPT_CODE": "",
          "OPERATION_UNDER_DEPT_NAME": "",
          "OPERATION_UNDER_DEPT_LEVEL": 0,
          "OPERATION_WORK_DEPT_CODE": null,
          "OPERATION_WORK_DEPT_NAME": null,
          "OPERATION_WORK_DEPT_LEVEL": 0,
          "OPERATION_OFFICE_CODE": "",
          "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME,
          "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME,
          "MANAGEMENT_POS_CODE": null,
          "MANAGEMENT_POS_NAME": null,
          "MANAGEMENT_POS_LEVEL": null,
          "MANAGEMENT_POS_LEVEL_NAME": null,
          "MANAGEMENT_DEPT_CODE": null,
          "MANAGEMENT_DEPT_NAME": null,
          "MANAGEMENT_DEPT_LEVEL": 0,
          "MANAGEMENT_UNDER_DEPT_CODE": null,
          "MANAGEMENT_UNDER_DEPT_NAME": null,
          "MANAGEMENT_UNDER_DEPT_LEVEL": 0,
          "MANAGEMENT_WORK_DEPT_CODE": null,
          "MANAGEMENT_WORK_DEPT_NAME": null,
          "MANAGEMENT_WORK_DEPT_LEVEL": 0,
          "MANAGEMENT_OFFICE_CODE": null,
          "MANAGEMENT_OFFICE_NAME": null,
          "MANAGEMENT_OFFICE_SHORT_NAME": null,
          "REPRESENT_POS_CODE": "",
          "REPRESENT_POS_NAME": "",
          "REPRESENT_POS_LEVEL": null,
          "REPRESENT_POS_LEVEL_NAME": null,
          "REPRESENT_DEPT_CODE": null,
          "REPRESENT_DEPT_NAME": null,
          "REPRESENT_DEPT_LEVEL": 0,
          "REPRESENT_UNDER_DEPT_CODE": null,
          "REPRESENT_UNDER_DEPT_NAME": null,
          "REPRESENT_UNDER_DEPT_LEVEL": 0,
          "REPRESENT_WORK_DEPT_CODE": null,
          "REPRESENT_WORK_DEPT_NAME": null,
          "REPRESENT_WORK_DEPT_LEVEL": 0,
          "REPRESENT_OFFICE_CODE": null,
          "REPRESENT_OFFICE_NAME": null,
          "REPRESENT_OFFICE_SHORT_NAME": null,
          "STATUS": 1,
          "REMARK": null,
          "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
          "IS_ACTIVE": 1
        });
      });
    }
    return items;
  }

  List<Map> _createMapEvidenceItem(bool IsUpdate) {
    List<Map> items = [];
    if(_onEdited) {
      print("Update Item");
      itemMain.EvidenceOutItem.forEach((item){
        if (IsUpdate) {
          items.add({
            "EVIDENCE_OUT_ITEM_ID": item.EVIDENCE_OUT_ITEM_ID,
            "EVIDENCE_OUT_ID": item.EVIDENCE_OUT_ID,
            "STOCK_ID": "1",
            "QTY": /*double.parse(
                item.ItemsController.editDefectiveNumber.text)*/item.QTY,
            "QTY_UNIT": item.QTY_UNIT,
            "PRODUCT_SIZE": "",
            "PRODUCT_SIZE_UNIT": "",
            "NET_VOLUMN": "",
            "NET_VOLUMN_UNIT": "",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });
        }
      });
    }else {
      for (int i = 0; i < itemEvidence.length; i++) {
        if (IsUpdate) {
          /*items.add({
            "EVIDENCE_OUT_ITEM_ID": "1",
            "EVIDENCE_OUT_ID": "1",
            "STOCK_ID": "1",
            "QTY": "10",
            "QTY_UNIT": "กระป๋อง",
            "PRODUCT_SIZE": "0.36",
            "PRODUCT_SIZE_UNIT": "ลิตร",
            "NET_VOLUMN": "36",
            "NET_VOLUMN_UNIT": "ลิตร",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });*/
        } else {
          print("Add Item");
          items.add({
            "EVIDENCE_OUT_ITEM_ID": "",
            "EVIDENCE_OUT_ID": "",
            "STOCK_ID": "1",
            "QTY": double.parse(
                itemEvidence[i].ItemsController.editDefectiveNumber.text),
            "QTY_UNIT": itemEvidence[i].BALANCE_QTY_UNIT,
            "PRODUCT_SIZE": "",
            "PRODUCT_SIZE_UNIT": "",
            "NET_VOLUMN": "",
            "NET_VOLUMN_UNIT": "",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });
        }
      }
    }

    return items;
  }
}
