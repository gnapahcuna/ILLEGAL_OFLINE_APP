import 'dart:async';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_office.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/lawsuit_accept_case_penalty_screen.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_deatail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/detail/lawsuit_accept_screen_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_form_list.dart';
import 'package:flutter/services.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/future/prove_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_indicment_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_product.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_science.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_staff.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

const double _kPickerSheetHeight = 216.0;
class LawsuitAcceptCaseMainScreenNonProofFragment extends StatefulWidget {
  ItemsLawsuitArrestMain itemsLawsuitMain ;
  ItemsPersonInformation ItemsPerson;
  ItemsArrestResponseGetOffice itemsOffice;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  bool IsPreview;
  bool IsEdit;
  bool IsCreate;
  ItemsLawsuitMain itemsPreview;
  LawsuitAcceptCaseMainScreenNonProofFragment({
    Key key,
    @required this.itemsLawsuitMain,
    @required this.ItemsPerson,
    @required this.IsPreview,
    @required this.IsEdit,
    @required this.IsCreate,
    @required this.itemsPreview,
    @required this.itemsOffice,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<LawsuitAcceptCaseMainScreenNonProofFragment>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  //เลือกของกลางทั้งหมด
  bool isCheckAll = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลรับคำกล่าวโทษ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  ItemsLawsuitArrestMain _itemsLawsuitArrestMain;
  ItemsLawsuitMain _itemsLawsuitMain;
  var _itemsStaff;
  var _itemStaffUpdate;

  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  String _lawsuitDate,_proveDate;
  String _currentDateLawsuit, _currentTimeLawsuit, _currentDateProof,
      _currentTimeProof;
  var dateFormatDate, dateFormatTime;
  DateTime _initDate = DateTime.now();

  DateTime _dtDateLawsuit,_dtDateProof;
  DateTime lawsuitTime = DateTime.now();
  DateTime proofTime = DateTime.now();
  String _lawsuitTime;

  @override
  void initState() {
    super.initState();

    /*****************************controller main tab**************************/
    setAutoCompleteOffice();

    var formatter = new DateFormat('yyyy');
    String year = formatter.format(DateTime.now());
    editLawsuitYear.text = (int.parse(year) + 543).toString();
    editProofYear.text = (int.parse(year) + 543).toString();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    _currentDateLawsuit = date;
    editLawsuitDate.text = _currentDateLawsuit;

    _currentTimeLawsuit = dateFormatTime.format(DateTime.now()).toString();
    editLawsuitTime.text = _currentTimeLawsuit;

    _lawsuitDate = DateTime.now().toString();
    _proveDate = DateTime.now().toString();


    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH!=null
        ?widget.ItemsPerson.TITLE_SHORT_NAME_TH
        :"";
    String firstname =  widget.ItemsPerson.FIRST_NAME!=null
        ?widget.ItemsPerson.FIRST_NAME
        :"";
    String lastname =  widget.ItemsPerson.LAST_NAME!=null
        ?widget.ItemsPerson.LAST_NAME
        :"";
    editLawsuitPersonName.text = title+firstname+" "+lastname;
    _itemsStaff=widget.ItemsPerson;


    //widget.itemsLawsuitMain.IS_PROVE=1;
    //กรณีพิสูจน์
    if (widget.itemsLawsuitMain.IS_PROVE==1) {
      /*editProofPerson.text = title + firstname + " " + lastname;
      choices.insert(1, Choice(title: "นำส่งเพื่อพิสูจน์"));*/
    }

    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    _currentDateProof = date;
    _currentTimeProof = dateFormatTime.format(DateTime.now()).toString();
    editProofDate.text = _currentDateProof;
    editProofTime.text = _currentTimeProof;

    _dtDateLawsuit=DateTime.now();
    _dtDateProof=DateTime.now();

    print("IsPreview : "+widget.IsPreview.toString());

    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsLawsuitMain;
      _itemsLawsuitMain = widget.itemsPreview;
      print("_itemsLawsuitMain : "+_itemsLawsuitMain.LawsuitDetail[0].INDICTMENT_DETAIL_ID.toString());
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsLawsuitMain;
      //_setInitDataLawsuit();
    }
    if(widget.IsCreate){
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _itemsLawsuitArrestMain = widget.itemsLawsuitMain;
    }

    setTestimony(_currentTimeLawsuit);
  }

  void setTestimony(String date) {
    String law = "";
    int index = 0;
    if (_itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length > 0) {
      _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((item) {
        index++;
        law += index.toString() + " ." + item.TITLE_SHORT_NAME_TH.toString() +
            item.FIRST_NAME.toString() + " " + item.LAST_NAME.toString() + " ";
      });
    }

    editTestimony.text = "วันนี้ เวลา " +
        date + " ข้าพเจ้าพร้อมด้วยพวกได้ดำเนินการจับกุม " +
        law + "พร้อมของกลาง ตามบัญชีของกลาง ส.ส.2/4 โดยแจ้งข้อกล่าวหา" +
        _itemsLawsuitArrestMain.GUILTBASE_NAME.toString() +
        " ให้ทราบ และ นำตัวผู้ต้องหาพร้อมของกลางส่งพนักงานสอบสวน เพื่อดำเนินคดี แต่ผู้ต้องหายินยอมชำระค่าปรับ ในความผิดที่ถูกกล่าวหา จึงได้นำตัวส่ง " +
        widget.ItemsPerson.OPERATION_OFFICE_NAME.toString() + " เพื่อดำเนินการต่อไป";
  }

  /*****************************view tab1**************************/
  //node focus
  //lawsuit
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeLawsuitDate = FocusNode();
  final FocusNode myFocusNodeLawsuitTime = FocusNode();
  final FocusNode myFocusNodeLawsuitPlace = FocusNode();
  final FocusNode myFocusNodeLawsuitPersonName = FocusNode();
  final FocusNode myFocusNodeLawsuitTestimony = FocusNode();

  //poof
  final FocusNode myFocusNodeProofNumber = FocusNode();
  final FocusNode myFocusNodeProofYear = FocusNode();
  final FocusNode myFocusNodeProofDate = FocusNode();
  final FocusNode myFocusNodeProofTime = FocusNode();
  final FocusNode myFocusNodeProofPerson = FocusNode();

  //textfield
  //lawsuit
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editLawsuitDate = new TextEditingController();
  TextEditingController editLawsuitTime = new TextEditingController();
  TextEditingController editLawsuitPlace = new TextEditingController();
  TextEditingController editLawsuitPersonName = new TextEditingController();
  TextEditingController editTestimony = new TextEditingController();

  //poof
  TextEditingController editProofNumber = new TextEditingController();
  TextEditingController editProofYear = new TextEditingController();
  TextEditingController editProofDate  = new TextEditingController();
  TextEditingController editProofTime  = new TextEditingController();
  TextEditingController editProofPerson  = new TextEditingController();

  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white,fontFamily: FontStyles().FontFamily);

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textDataTitleStyle = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0);
  TextStyle textStyleStar = TextStyle(color: Colors.red,fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  EdgeInsets paddindSentence = EdgeInsets.only(
      top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2),fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleCheckAll = TextStyle(
      fontSize: 16.0, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  /*void _setInitDataLawsuit() {
    editLawsuitNumber.text = widget.itemsLawsuitMainAcceptCase.LawsuitNumber;
    editLawsuitYear.text = widget.itemsLawsuitMainAcceptCase.LawsuitYear;
    _currentDateLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitDate;
    _currentTimeLawsuit = widget.itemsLawsuitMainAcceptCase.LawsuitTime;
    editLawsuitPlace.text = widget.itemsLawsuitMainAcceptCase.LawsuitPlace;
    editLawsuitPersonName.text =
        widget.itemsLawsuitMainAcceptCase.LawsuitPersonName;
    editTestimony.text = widget.itemsLawsuitMainAcceptCase.LawsuitTestimony;
  }

  void _setInitDataProof() {
    editProofNumber.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber;
    editProofYear.text = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofNumber1;
    _currentDateProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
    _currentTimeProof = widget.itemsLawsuitMainAcceptCase.Informations.Proof.ProofDate;
  }*/

  void _setDataSaved() {
    //is active false

    itemsFormsTab3=[];
    itemsFormsTab3 = [];
    itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55","ILG60_00_04_001"));
    itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
    itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));

    choices.add(Choice(title: 'แบบฟอร์ม'));
    tabController =
        TabController(length: choices.length, vsync: this);
    _tabPageSelector =
    new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();
    editLawsuitNumber.dispose();
    editLawsuitYear.dispose();
    editLawsuitPlace.dispose();
    editLawsuitPersonName.dispose();
    editTestimony.dispose();
    editLawsuitDate.dispose();
    editLawsuitTime.dispose();

    //proof
    editProofNumber.dispose();
    editProofYear.dispose();
    editProofDate.dispose();
    editProofTime.dispose();
    editProofPerson.dispose();
  }

  void _setTextField(){
    String lawsuit_date = "";
    String lawsuit_year = "";
    DateTime dt_lawsuit_date = DateTime.parse(_itemsLawsuitMain.LAWSUIT_DATE);
    DateTime dt_lawsuit_year = DateTime.parse(_itemsLawsuitMain.LAWSUIT_NO_YEAR);
    List splitslawDate = dateFormatDate.format(dt_lawsuit_date).toString().split(
        " ");
    List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(
        " ");
    lawsuit_date = splitslawDate[0] + " " + splitslawDate[1] + " " +
        (int.parse(splitslawDate[3]) + 543).toString();
    lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();

    editLawsuitNumber.text=_itemsLawsuitMain.LAWSUIT_NO.toString();
    editLawsuitYear.text=lawsuit_year;
    editLawsuitDate.text=lawsuit_date;
    editLawsuitTime.text = dateFormatTime.format(dt_lawsuit_date).toString();

    sOffice = _itemsLawsuitMain.OFFICE;
    editOffice.text = sOffice.OFFICE_NAME;
    //editLawsuitPlace.text=_itemsLawsuitMain.OFFICE_NAME;

    editTestimony.text=_itemsLawsuitMain.TESTIMONY;
    _itemsLawsuitMain.LawsuitStaff.forEach((f){
      //editLawsuitPersonName.text = f.TITLE_SHORT_NAME_TH+f.FIRST_NAME+" "+f.LAST_NAME;
      editLawsuitPersonName.text = f.TITLE_NAME_TH+f.FIRST_NAME+" "+f.LAST_NAME;
    });


    if(_itemsLawsuitArrestMain.IS_PROVE==1){
      DateTime dt_proof_date = DateTime.parse(_itemsLawsuitMain.DELIVERY_DOC_DATE);
      List splitsProofDate = dateFormatDate.format(dt_proof_date).toString().split(
          " ");
      String proof_date = splitsProofDate[0] + " " + splitsProofDate[1] + " " +
          (int.parse(splitsProofDate[3]) + 543).toString();
      editProofNumber.text=_itemsLawsuitMain.DELIVERY_DOC_NO_1;
      editProofYear.text=_itemsLawsuitMain.DELIVERY_DOC_NO_2;
      editProofDate.text=proof_date;
      editProofTime.text=dateFormatTime.format(dt_proof_date).toString();
    }
  }
  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onFinish=false;
        _onEdited = true;

        final pos=tabController.length-1;
        choices.removeAt(pos);
        tabController = TabController(initialIndex: 0,length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);

        _setTextField();
      } else {
        _onDeleted=true;
        _showDeleteAlertDialog();
      }
    });
  }

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
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void onDeleted()async{
    Map map = {
      "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
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
    await onLoadActionInsLawsuitDelete(map);
    Navigator.pop(context,"Delete");
  }
  Future<bool> onLoadActionInsLawsuitDelete(Map map) async {
    Map map_indic={
      "INDICTMENT_ID" : _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdDeleteIndictmentComplete(map_indic).then((onValue) {
      print("Delete IndictmentComplete : "+onValue.Msg);
    });
    Map map_arrest={
      "ARREST_ID" : _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdDeleteArrestComplete(map_arrest).then((onValue) {
      print("Delete ArrestComplete : "+onValue.Msg);
    });

    List<Map> map_mistreat=[];
    _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((law) {
      map_mistreat.add({
        "PERSON_ID": law.PERSON_ID
      });
    });
    print("mistreat : "+map_mistreat.toString());
    for(int i=0;i<map_mistreat.length;i++){
      await new LawsuitFuture().apiRequestLawsuitMistreatNoupdDelete(map_mistreat[i]).then((onValue) {
        print("Update ArrestComplete : "+onValue.Msg);
      });
    }


    List<Map> map_pay=[];
    /*_itemsLawsuitMain.LawsuitDetail.forEach((item){
      item.LawsuitPayment.forEach((item){
        map_pay.add({
          "PAYMENT_ID" : item.PAYMENT_ID
        });
      });
    });*/

    if(map_pay.isNotEmpty){
      await new LawsuitFuture().apiRequestLawsuitPaymentupdDelete(map_pay).then((onValue) {
        print("Delete Payment : "+onValue.Msg);
      });
    }


    await new LawsuitFuture().apiRequestLawsuitupdDelete(map).then((onValue) {
      setState(() {
        _onSaved = false;
        _onEdited = true;
        _onSave = false;
        clearTextfield();
        choices.removeAt(choices.length-1);

        Navigator.pop(context,_itemsLawsuitMain);
      });
    });
    setState(() {});
    return true;
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  void onProve()async{
    Map map = {
      "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
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
    await onLoadActionProveGet(map);
    Navigator.pop(context);
  }

  ItemsProveArrest itemsProveArrest;
  List<ItemsProveArrestIndicmentProduct> _listProveIndicmentProduct=[];
  List<ItemsProveArrestProduct> _listItemsProveArrestProduct = [];

  Future<bool> onLoadActionProveGet(Map map) async {
    int lawsuitID;
    int proveID;
    bool IsProveNull=false;
    await new LawsuitFuture().apiRequestLawsuiltProvegetByLawsuitID(map).then((onValue) {
      if(onValue!=null){
        IsProveNull=false;
        lawsuitID = onValue.LAWSUIT_ID;
        proveID = onValue.PROVE_ID;
        print(onValue.PROVE_ID.toString()+" , "+onValue.LAWSUIT_ID.toString());
      }else{
        IsProveNull=true;
      }
    });

    if((proveID!=null||proveID!=0)&&!IsProveNull){
      print("เรียกดูพิสูจน์");
      //เรียกดูพิสูจน์
      //**************tab_1*******************
      map = {
        "LAWSUIT_ID": lawsuitID
      };
      await new ProveFuture()
          .apiRequestProveArrestgetByCon(map)
          .then((onValue) {
        itemsProveArrest = onValue.first;
      });
      map = {
        "INDICTMENT_ID": itemsProveArrest.INDICTMENT_ID
      };
      print(map.toString());
      await new ProveFuture()
          .apiRequestProveArrestIndictmentProductgetByCon(map)
          .then((onValue) {
        _listProveIndicmentProduct = onValue;
      });

      _listItemsProveArrestProduct=[];
      for(int i=0;i<_listProveIndicmentProduct.length;i++){
        Map map = {"PRODUCT_ID": _listProveIndicmentProduct[i].PRODUCT_ID};
        await new ProveFuture()
            .apiRequestProveArrestProductgetByCon(map)
            .then((onValue) {
          _listItemsProveArrestProduct.add(onValue);
        });
      }
      //****************************************

      //****************tab_1-3*****************
      ItemsProveMain itemsProveMain;
      List<ItemsProveStaff> itemsProveSatff=[];
      ItemsProveScience itemsProveScience;
      List<ItemsProveProduct> itemsProveProduct=[];
      map = {
        "PROVE_ID": proveID
      };
      await new ProveFuture()
          .apiRequestProvegetByCon(map)
          .then((onValue) {
        itemsProveMain = onValue;
      });
      await new ProveFuture()
          .apiRequestProveStaffgetByCon(map)
          .then((onValue) {
        itemsProveSatff = onValue;
      });
      await new ProveFuture()
          .apiRequestProveSciencegetByCon(map)
          .then((onValue) {
            if(onValue.length>0){
              itemsProveScience = onValue.first;
            }

      });
      await new ProveFuture()
          .apiRequestProveProductgetByProveId(map)
          .then((onValue) {
        itemsProveProduct = onValue;
      });
      //****************************************

      if(itemsProveMain!=null
          ||itemsProveArrest!=null
          ||_listProveIndicmentProduct.length!=0){
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProveMainScreenFragment(
            itemsProveMain: itemsProveMain,
            itemsProveSatff: itemsProveSatff,
            itemsProveScience: itemsProveScience,
            itemsProveProduct: itemsProveProduct,
            itemsProveArrest: itemsProveArrest,
            //itemsIndicmentProduct: _listProveIndicmentProduct,
            itemsProveArrestProduct: _listItemsProveArrestProduct,
            ItemsPerson: widget.ItemsPerson,
            IsCreate: false,
            IsEdit: false,
            IsPreview: true,
            itemsMasProductUnit: widget.itemsMasProductUnit,
            itemsMasProductSize: widget.itemsMasProductSize,
          )),
        );
        if(result.toString()!="Back") {
          //
        }
      }

    }else{
      //สร้างพิสูจน์
      map = {
        "LAWSUIT_ID": lawsuitID
      };
      await new ProveFuture()
          .apiRequestProveArrestgetByCon(map)
          .then((onValue) {
        itemsProveArrest = onValue.first;
      });
      map = {
        "INDICTMENT_ID": itemsProveArrest.INDICTMENT_ID
      };
      await new ProveFuture()
          .apiRequestProveArrestIndictmentProductgetByCon(map)
          .then((onValue) {
        _listProveIndicmentProduct = onValue;
      });
      setState(() {});

      if(itemsProveArrest!=null||_listProveIndicmentProduct.length!=0){
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProveMainScreenFragment(
            itemsProveArrest: itemsProveArrest,
            //itemsIndicmentProduct: _listProveIndicmentProduct,
            itemsProveArrestProduct: _listItemsProveArrestProduct,
            IsCreate: true,
            IsEdit: false,
            IsPreview: false,
            ItemsPerson: widget.ItemsPerson,
            itemsMasProductUnit: widget.itemsMasProductUnit,
            itemsMasProductSize: widget.itemsMasProductSize,
          )),
        );
        if(result.toString()!="Back") {
          //
        }
      }
    }

    setState(() {});
    return true;
  }

  void clearTextfield() {
    editLawsuitNumber.clear();
    editLawsuitYear.clear();
    editLawsuitPlace.clear();
    editLawsuitPersonName.clear();
    editTestimony.clear();

    editProofYear.clear();
    editProofNumber.clear();

    /*widget.itemsCaseInformation.Evidenses.forEach((item){
      item.IsCkecked=false;
    });*/
  }

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

                if(!_onEdited) {
                  Navigator.pop(mContext,"Back");
                }else{
                  setState(() {
                    _onSaved=true;
                    _onEdited=false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  /*****************************method for main tab1**************************/
  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }

  void onSaved(BuildContext mContext)async{
    if (editLawsuitNumber.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่รับคำกล่าวโทษ');
    }else if (editLawsuitPlace.text.isEmpty/*sOffice==null*/) {
      new VerifyDialog(mContext, 'กรุณากรอกสถานที่ทำการ');
    }else if (editTestimony.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกคำให้การของผู้กล่าวโทษ');
    }/*else if (_itemsLawsuitArrestMain.IS_PROVE==1&&(editProofNumber.text.isEmpty||editProofYear.text.isEmpty)) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่งให้ครบทุกช่อง');
    }*/else{
      if(!_onEdited){
        List<Map> LawsuitDetail =[];
        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((item){
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": "",
            "LAWSUIT_ID": "",
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": "",
            "UNDECIDE_NO_1": "",
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": "",
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": "",
            "UNDECIDE_NO_YEAR_2": "",
            "DECIDE_NO_2": "",
            "DECIDE_NO_YEAR_2": "",
            "JUDGEMENT_NO": "",
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": "",
            "IS_IMPRISON": "",
            "IMPRISON_TIME": "",
            "IMPRISON_TIME_UNIT": "",
            "IS_FINE": "",
            "FINE": "",
            "IS_PAYONCE": "",
            "FINE_DATE": "",
            "PAYMENT_PERIOD": "",
            "PAYMENT_PERIOD_DUE": "",
            "PAYMENT_PERIOD_DUE_UNIT": "",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_BANK": "",
            "PAYMENT_REF_NO": "",
            "PAYMENT_DATE": "",
            "IS_DISMISS": "",
            "IS_ACTIVE": 1
          });
        });

        Map map = {
          "LAWSUIT_ID": "",
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": /*sOffice.OFFICE_ID*/"",
          "OFFICE_CODE": /*sOffice.OFFICE_CODE*/"",
          "OFFICE_NAME": /*sOffice.OFFICE_NAME*/editLawsuitPlace.text,
          "IS_LAWSUIT": 1,
          "REMARK_NOT_LAWSUIT": "",
          "LAWSUIT_NO": int.parse(editLawsuitNumber.text),
          "LAWSUIT_NO_YEAR": DateTime.now().toString(),
          "LAWSUIT_DATE": _lawsuitDate,
          "TESTIMONY": editTestimony.text,
          /*"DELIVERY_DOC_NO_1": _itemsLawsuitArrestMain.IS_PROVE==1?editProofNumber.text:"",
          "DELIVERY_DOC_NO_2": _itemsLawsuitArrestMain.IS_PROVE==1?editProofYear.text:"",
          "DELIVERY_DOC_DATE": _itemsLawsuitArrestMain.IS_PROVE==1?_proveDate:"",*/
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitStaff": [
            {
              "STAFF_ID": "",
              "LAWSUIT_ID": "",
              "STAFF_REF_ID": 1,
              "TITLE_ID": "1",
              "STAFF_CODE": "",
              "ID_CARD": "",
              "STAFF_TYPE": 1,
              "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
              "TITLE_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": "",
              "FIRST_NAME":_itemsStaff.FIRST_NAME,
              "LAST_NAME": _itemsStaff.LAST_NAME,
              "AGE": "",
              "OPERATION_POS_CODE": "",
              "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME,
              "OPREATION_POS_LEVEL": "",
              "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME,
              "OPERATION_DEPT_CODE": "",
              "OPERATION_DEPT_NAME": "",
              "OPERATION_DEPT_LEVEL": "",
              "OPERATION_UNDER_DEPT_CODE": "",
              "OPERATION_UNDER_DEPT_NAME": "",
              "OPERATION_UNDER_DEPT_LEVEL": "",
              "OPERATION_OFFICE_CODE":"",
              "OPERATION_OFFICE_NAME":"",
              "OPERATION_OFFICE_SHORT_NAME":"",
              "MANAGEMENT_WORK_DEPT_CODE": "",
              "MANAGEMENT_WORK_DEPT_NAME": "",
              "MANAGEMENT_WORK_DEPT_LEVEL": "",
              "MANAGEMENT_OFFICE_CODE": "",
              "MANAGEMENT_OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME,
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
            }
          ],
          "LawsuitDetail": LawsuitDetail
        };

        List<Map> map_pay = [];
        /*_itemsLawsuitMain.LawsuitDetail.forEach((item){
          map_pay.add({
            "PAYMENT_ID": "",
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "COMPARE_DETAIL_ID": 0,
            "FINE_TYPE": item.IS_FINE,
            "FINE": item.FINE,
            "PAYMENT_PERIOD_NO": 1,
            "PAYMENT_DATE": item.FINE_DATE,
            "IS_REQUEST_REWARD": 0,
            "IS_ACTIVE": 1,
            "LawsuitPaymentDetail":
            [
              {
                "PAYMENT_DETAIL_ID": "",
                "PAYMENT_ID": "",
                "NOTICE_ID": 1,
                "IS_REQUEST_BRIBE": 0,
                "IS_ACTIVE": 1
              }
            ]
          });
        });
        print("map_pay : "+map_pay.isNotEmpty.toString());*/

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionInsLawsuitAll(mContext,map,map_pay.isNotEmpty,map_pay);
        Navigator.pop(context);


        if(IsHaveLawNo){
          new VerifyDialog(mContext, 'มีเลขที่รับคำกล่าวโทษนี้ในระบบแล้ว');
        }
      }else{
        List<Map> LawsuitDetail =[];
        _itemsLawsuitMain.LawsuitDetail.forEach((item){
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "LAWSUIT_ID": item.LAWSUIT_ID,
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": item.COURT_NAME!=null?item.COURT_NAME:"",
            "UNDECIDE_NO_1": 1,
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": 2,
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": item.UNDECIDE_NO_2!=null?item.UNDECIDE_NO_2:"",
            "UNDECIDE_NO_YEAR_2": item.UNDECIDE_NO_YEAR_2!=null?item.UNDECIDE_NO_YEAR_2:"",
            "DECIDE_NO_2": item.DECIDE_NO_2!=null?item.DECIDE_NO_2:"",
            "DECIDE_NO_YEAR_2":item.DECIDE_NO_YEAR_2!=null?item.DECIDE_NO_YEAR_2:"",
            "JUDGEMENT_NO": 12,
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": item.JUDGEMENT_DATE!=null?item.JUDGEMENT_DATE:"",
            "IS_IMPRISON": item.IS_IMPRISON!=null?item.IS_IMPRISON:"",
            "IMPRISON_TIME": item.IMPRISON_TIME!=null?item.IMPRISON_TIME:"",
            "IMPRISON_TIME_UNIT": item.IMPRISON_TIME_UNIT!=null?item.IMPRISON_TIME_UNIT:"",
            "IS_FINE": item.IS_FINE!=null?item.IS_FINE:"",
            "FINE": item.FINE!=null?item.FINE:"",
            "IS_PAYONCE": item.IS_PAYONCE!=null?item.IS_PAYONCE:"",
            "FINE_DATE": item.FINE_DATE!=null?item.FINE_DATE:"",
            "PAYMENT_PERIOD": item.PAYMENT_PERIOD!=null?item.PAYMENT_PERIOD:"",
            "PAYMENT_PERIOD_DUE": item.PAYMENT_PERIOD_DUE!=null?item.PAYMENT_PERIOD_DUE:"",
            "PAYMENT_PERIOD_DUE_UNIT": item.PAYMENT_PERIOD_DUE_UNIT!=null?item.PAYMENT_PERIOD_DUE_UNIT:"",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_BANK": "",
            "PAYMENT_REF_NO": "",
            "PAYMENT_DATE": "",
            "IS_DISMISS": "",
            "IS_ACTIVE": 1
          });
        });

        print(sOffice.OFFICE_NAME.toString());
        Map map = {
          "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": /*sOffice.OFFICE_ID*/"",
          "OFFICE_CODE": /*sOffice.OFFICE_CODE*/"",
          "OFFICE_NAME": /*sOffice.OFFICE_NAME*/editLawsuitPlace.text,
          "IS_LAWSUIT": _itemsLawsuitMain.IS_LAWSUIT,
          "REMARK_NOT_LAWSUIT": "",
          "LAWSUIT_NO": int.parse(editLawsuitNumber.text),
          "LAWSUIT_NO_YEAR": DateTime.now().toString(),
          "LAWSUIT_DATE": _lawsuitDate,
          "TESTIMONY": editTestimony.text,
          /*"DELIVERY_DOC_NO_1": _itemsLawsuitArrestMain.IS_PROVE==1?editProofNumber.text:"",
          "DELIVERY_DOC_NO_2": _itemsLawsuitArrestMain.IS_PROVE==1?editProofYear.text:"",
          "DELIVERY_DOC_DATE": _itemsLawsuitArrestMain.IS_PROVE==1?_proveDate:"",*/
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitDetail": LawsuitDetail
        };
        List<Map> map_staff = [];
        if(_itemStaffUpdate!=null){
          map_staff.add({
            "STAFF_ID": _itemsLawsuitMain.LawsuitStaff[0].STAFF_ID,
            "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
            "STAFF_REF_ID": 1,
            "TITLE_ID": "1",
            "STAFF_CODE": _itemStaffUpdate.STAFF_CODE,
            "ID_CARD": "",
            "STAFF_TYPE": 1,
            "TITLE_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME":_itemStaffUpdate.FIRST_NAME,
            "LAST_NAME": _itemStaffUpdate.LAST_NAME,
            "AGE": "",
            "OPERATION_POS_CODE": "",
            "OPREATION_POS_NAME": _itemStaffUpdate.OPREATION_POS_NAME,
            "OPREATION_POS_LEVEL": "",
            "OPERATION_POS_LEVEL_NAME": _itemStaffUpdate.OPREATION_POS_LAVEL_NAME,
            "OPERATION_DEPT_CODE": "",
            "OPERATION_DEPT_NAME": "",
            "OPERATION_DEPT_LEVEL": "",
            "OPERATION_UNDER_DEPT_CODE": "",
            "OPERATION_UNDER_DEPT_NAME": "",
            "OPERATION_UNDER_DEPT_LEVEL": "",
            "OPERATION_OFFICE_CODE":"",
            "OPERATION_OFFICE_NAME":"",
            "OPERATION_OFFICE_SHORT_NAME":"",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": _itemStaffUpdate.OPERATION_OFFICE_NAME,
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
        }
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(
                ),
              );
            });
        await onLoadActionInsLawsuitUpAll(map,map_staff.isEmpty,map_staff);
        Navigator.pop(context);


        if(IsHaveLawNo){
          new VerifyDialog(mContext, 'มีเลขที่รับคำกล่าวโทษนี้ในระบบแล้ว');
        }
      }
    }
  }

  bool IsHaveLawNo=false;
  Future<bool> onLoadActionInsLawsuitAll(BuildContext mContext,Map map,IsPayment,List<Map> map_pay) async {
    IsHaveLawNo=false;
    Map map_verify = {
      "LAWSUIT_NO": editLawsuitNumber.text,
      "LAWSUIT_NO_YEAR": (int.parse(editLawsuitYear.text)-543).toString(),
      "IS_OUTSIDE": 1,
      "ACCOUNT_OFFICE_CODE": ""
    };
    print(map_verify);
    await new LawsuitFuture().apiRequestLawsuitVerifyLawsuitNo(map_verify).then((onValue) {
      if(onValue.length>0){
        IsHaveLawNo=true;
      }
    });

    if(IsHaveLawNo){
      //
    }else{
      int LAWSUIT_ID;
      await new LawsuitFuture().apiRequestLawsuitinsAll(map).then((onValue) {
        LAWSUIT_ID = onValue.LAWSUIT_ID;
      });

      Map map_indic = {
        "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
      };
      await new LawsuitFuture()
          .apiRequestLawsuiltArrestIndictmentupdIndictmentComplete(map_indic)
          .then((onValue) {
        print("Update IndictmentComplete : " + onValue.Msg);
      });
      Map map_arrest = {
        "ARREST_ID": _itemsLawsuitArrestMain.ARREST_ID,
      };
      await new LawsuitFuture()
          .apiRequestLawsuiltArrestIndictmentupdArrestComplete(map_arrest)
          .then((onValue) {
        print("Update ArrestComplete : " + onValue.Msg);
      });
      List<Map> map_mistreat = [];
      _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((law) {
        map_mistreat.add({
          "PERSON_ID": law.PERSON_ID
        });
      });
      print("mistreat : " + map_mistreat.toString());
      for (int i = 0; i < map_mistreat.length; i++) {
        await new LawsuitFuture().apiRequestLawsuitMistreatNoupdByCon(
            map_mistreat[i]).then((onValue) {
          print("Update ArrestComplete : " + onValue.Msg);
        });
      }

      if (IsPayment) {
        await new LawsuitFuture().apiRequestLawsuitPaymentinsAll(map_pay).then((
            onValue) {
          print("Add Payment : " + onValue.Msg);
        });
      }

      if (LAWSUIT_ID != null) {
        Map map = {
          "LAWSUIT_ID": LAWSUIT_ID
        };
        await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
          _itemsLawsuitMain = onValue;
        });


        map = {
          "LawsuitID" : _itemsLawsuitMain.LAWSUIT_ID
        };
        await new TransectionFuture().apiRequestILG60_00_04_001(map).then((onValue) {
          print("res PDF 04_001 : "+onValue);
        });
        await new TransectionFuture().apiRequestILG60_00_06_004(map).then((onValue) {
          print("res PDF 06_004 : "+onValue);
        });
        map = {
          "ArrestCode" : _itemsLawsuitArrestMain.ARREST_CODE
        };
        await new TransectionFuture().apiRequestILG60_00_04_002(map).then((onValue) {
          print("res PDF 04_002 : "+onValue);
        });



        _onSaved = true;
        _onFinish = true;

        itemsFormsTab3 = [];
        itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55","ILG60_00_04_001"));
        itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
        itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));
        choices.add(Choice(title: 'แบบฟอร์ม'));
        tabController =
            TabController(length: choices.length, vsync: this);
        _tabPageSelector =
        new TabPageSelector(controller: tabController);
        tabController.animateTo(choices.length - 1);

      }
    }
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionInsLawsuitUpAll(Map map,bool IsStaffUpdate,List<Map> map_staff) async {
    IsHaveLawNo=false;
    if(int.parse(editLawsuitNumber.text)!=_itemsLawsuitMain.LAWSUIT_NO) {
      Map map_verify = {
        "LAWSUIT_NO": editLawsuitNumber.text,
        "LAWSUIT_NO_YEAR": (int.parse(editLawsuitYear.text) - 543).toString(),
        "IS_OUTSIDE": 1,
        "ACCOUNT_OFFICE_CODE": ""
      };
      print(map_verify);
      await new LawsuitFuture()
          .apiRequestLawsuitVerifyLawsuitNo(map_verify)
          .then((onValue) {
        if (onValue.length > 0) {
          IsHaveLawNo = true;
        }
      });
    }

    if(IsHaveLawNo){
      //
    }else{
      await new LawsuitFuture().apiRequestLawsuitupdAll(map).then((onValue) {
      });
      if(!IsStaffUpdate){
        await new LawsuitFuture().apiRequestLawsuitStaffupdAll(map_staff).then((onValue) {
        });
      }
      if(_itemsLawsuitMain.LAWSUIT_ID!=null){
        Map map = {
          "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID
        };
        await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
          _itemsLawsuitMain = onValue;
        });

        map = {
          "LawsuitID" : _itemsLawsuitMain.LAWSUIT_ID
        };
        await new TransectionFuture().apiRequestILG60_00_04_001(map).then((onValue) {
          print("res PDF 04_001 : "+onValue);
        });
        await new TransectionFuture().apiRequestILG60_00_06_004(map).then((onValue) {
          print("res PDF 06_004 : "+onValue);
        });
        map = {
          "ArrestCode" : _itemsLawsuitArrestMain.ARREST_CODE
        };
        await new TransectionFuture().apiRequestILG60_00_04_002(map).then((onValue) {
          print("res PDF 04_002 : "+onValue);
        });

        _onSaved = true;
        _onFinish = true;
        _onEdited = false;
        //add item tab 3
        itemsFormsTab3 = [];
        itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55","ILG60_00_04_001"));
        itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
        itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));
        choices.add(Choice(title: 'แบบฟอร์ม'));
        tabController =
            TabController(length: choices.length, vsync: this);
        _tabPageSelector =
        new TabPageSelector(controller: tabController);
        tabController.animateTo(choices.length-1);

        tabController =
            TabController(length: choices.length, vsync: this);
        _tabPageSelector =
        new TabPageSelector(controller: tabController);
        tabController.animateTo(choices.length-1);
      }
    }

    setState(() {});
    return true;
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
                /*_onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
                _onSaved ? Navigator.pop(context, "Back") :
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
          child: Center(child: Text("รับคำกล่าวโทษ", style: appBarStyle),
          )),
      new SizedBox(
          width: width / 3,
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
              widget.itemsLawsuitMain.IS_PROVE == 1 ? ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: () {
                      //เมื่อพิสูจน์
                      onProve();
                    },
                    child: Row(
                      children: <Widget>[
                        Text('พิสูจน์', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )) : (_itemsLawsuitArrestMain.IS_COMPARE == 1
                  ? new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: FlatButton(
                    onPressed: () {
                      //เมื่อชำระค่าปรับ
                      _navigate_compare(
                          context, _itemsLawsuitArrestMain.INDICTMENT_ID);
                    },
                    child: Row(
                      children: <Widget>[
                        Text('ชำระค่าปรับ', style: appBarStylePay),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  )
              )
                  : Container())
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
              Navigator.pop(context, widget.itemsLawsuitMain);
            }
          } else {
            Navigator.pop(context, widget.itemsLawsuitMain);
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
                    isScrollable: choices.length > 2 ? true : false,
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
                      children: widget.itemsLawsuitMain.IS_PROVE == 1
                          ? (_onFinish ? <
                          Widget>[
                        //กรณีพิสูจน์
                        _buildContent_tab_1(),
                        //_buildContent_tab_proof(),
                        _buildContent_tab_2(),
                        _buildContent_tab_3(),
                      ] :
                      <Widget>[
                        _buildContent_tab_1(),
                        //_buildContent_tab_proof(),
                        _buildContent_tab_2(),
                      ])
                          : _onFinish ? <Widget>[
                        //กรณีไม่พิสูจน์
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ItemsCompareArrestMain compareArrestMain;
  ItemsListDivisionRate itemsListDivisionRate;
  ItemsCompareMain itemsCompareMain;
  Future<bool> onLoadActionGetCompareIndicment(Map map) async {
    await new CompareFuture()
        .apiRequestCompareArrestgetByIndictmentID(map)
        .then((onValue) {
      compareArrestMain = onValue[0];
    });
    map = {
      "TEXT_SEARCH" : "",
      "DIVISIONRATE_ID" : ""
    };
    await new ArrestFutureMaster()
        .apiRequestMasDivisionRategetByCon(map)
        .then((onValue) {
      itemsListDivisionRate = onValue.RESPONSE_DATA.first;
    });

    int compareID;
    int lawsuitID;
    bool IsCompareNull=false;

    map = {
      "LAWSUIT_ID" : _itemsLawsuitMain.LAWSUIT_ID
    };
    await new LawsuitFuture()
        .apiRequestLawsuiltComparegetByLawsuitID(map)
        .then((onValue) {
          if(onValue!=null){
            IsCompareNull=false;
            compareID = onValue.COMPARE_ID;
            lawsuitID=onValue.LAWSUIT_ID;
            print(compareID.toString()+" , "+lawsuitID.toString());
          }else{
            IsCompareNull=true;
          }
    });

    print("IsCompareNull : "+IsCompareNull.toString());

    if((compareID!=null||compareID!=0)&&!IsCompareNull){
      //เรียกดู compare
      map = {
        "COMPARE_ID": compareID
      };
      await new CompareFuture().apiRequestComparegetByCon(map).then((onValue) {
        itemsCompareMain = onValue;
      });

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            CompareMainScreenFragment(
              itemsListDivisionRate: itemsListDivisionRate,
              itemsCompareMain: itemsCompareMain,
              itemsCompareArrestMain: compareArrestMain,
              ItemsPerson: widget.ItemsPerson,
              IsEdit: false,
              IsPreview: true,
              IsCreate: false,
            )),
      );
    }else{
      //สร้าง compare
      if (compareArrestMain != null) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              CompareMainScreenFragment(
                itemsCompareMain: null,
                itemsCompareArrestMain: compareArrestMain,
                itemsListDivisionRate: itemsListDivisionRate,
                ItemsPerson: widget.ItemsPerson,
                IsEdit: false,
                IsPreview: false,
                IsCreate: true,
              )),
        );
        /*if (result.toString() != "Back") {
        itemMain = result;
      }*/
      }
    }
    setState(() {});
    return true;
  }

  _navigate_compare(BuildContext context, int INDICTMENT_ID) async {
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
      "INDICTMENT_ID": INDICTMENT_ID
    };
    await onLoadActionGetCompareIndicment(map);
    Navigator.pop(context);
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

  //************************start_tab_1*****************************
  ItemsListOffice sOffice;
  AutoCompleteTextField _textListOffice;
  TextEditingController editOffice = new TextEditingController();
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListOffice>>();
  void setAutoCompleteOffice(){
    _textListOffice = new AutoCompleteTextField<ItemsListOffice>(
      style: textStyleData,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item){
        setState(() {
          _textListOffice.controller.text = item.OFFICE_NAME.toString();
          sOffice = item;
        });
      },
      key: key,
      controller: editOffice,
      suggestions: widget.itemsOffice.RESPONSE_DATA,
      itemBuilder: (context, suggestion) =>
      sOffice==null
          ?new Padding(
          child: new ListTile(
            title: new Text(suggestion.OFFICE_NAME.toString(),style: textStyleData),),
          padding: EdgeInsets.all(8.0)):Container(),
      itemSorter: (a, b) => a.OFFICE_ID == b.OFFICE_ID ? 0 : a.OFFICE_ID > b.OFFICE_ID ? -1 : 1,
      itemFilter: (suggestion, input){
        sOffice=null;
        return suggestion.OFFICE_NAME.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  Widget _buildContent_tab_1() {

    _navigateLawsuitAcceptCaseSentence(BuildContext context,
        ItemsListLawsuitDetail itemSentence,index) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            LawsuitAcceptSentenceScreenFragment(
              ItemSentence: itemSentence,
              IsPreview: _onSaved,
              IsUpdate: _onEdited,
            )),
      );
      if (result.toString() != "Back") {
        if(_onEdited){
          _itemsLawsuitMain.LawsuitDetail[index] = result;

          _itemsLawsuitMain.LawsuitDetail.forEach((item){

          });
        }
      }
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
                  padding: EdgeInsets.all(18.0),
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
                            Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
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
                                      focusNode: myFocusNodeLawsuitNumber,
                                      controller: editLawsuitNumber,
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
                                      enabled: false,
                                      focusNode: myFocusNodeLawsuitYear,
                                      controller: editLawsuitYear,
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(
                                new FocusNode());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DynamicDialog(
                                      Current: _dtDateLawsuit);
                                }).then((s) {
                              String date = "";
                              List splits = dateFormatDate.format(
                                  s).toString().split(" ");
                              date = splits[0] + " " + splits[1] +
                                  " " +
                                  (int.parse(splits[3]) + 543)
                                      .toString();
                              setState(() {
                                _dtDateLawsuit = s;
                                _currentDateLawsuit = date;
                                editLawsuitDate.text = _currentDateLawsuit;
                                _lawsuitDate = _dtDateLawsuit.toString();
                              });
                            });
                          },
                          focusNode: myFocusNodeLawsuitDate,
                          controller: editLawsuitDate,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(FontAwesomeIcons.calendarAlt,
                              color: Colors.grey,),
                          ),
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
                            Text("เวลา", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      /*Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              title: Text(
                                _currentTimeLawsuit, style: textStyleData,),
                              onTap: () {

                              },
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(
                                new FocusNode());
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomPicker(
                                  CupertinoDatePicker(
                                    use24hFormat: true,
                                    mode: CupertinoDatePickerMode.time,
                                    initialDateTime: lawsuitTime,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() {
                                        lawsuitTime = newDateTime;
                                        _currentTimeLawsuit =
                                            dateFormatTime.format(lawsuitTime)
                                                .toString();
                                        editLawsuitTime.text =
                                            _currentTimeLawsuit;

                                        setTestimony(_currentTimeLawsuit);

                                        List splitsArrestDate = _dtDateLawsuit
                                            .toUtc().toLocal().toString().split(
                                            " ");
                                        List splitsArrestTime = lawsuitTime
                                            .toString().split(" ");
                                        _lawsuitDate =
                                            splitsArrestDate[0].toString() +
                                                " " +
                                                splitsArrestTime[1].toString();
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          focusNode: myFocusNodeLawsuitTime,
                          controller: editLawsuitTime,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
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
                     
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("สถานที่ทำการ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              //padding: paddingData,
                              child: TextField(
                                focusNode: myFocusNodeLawsuitPlace,
                                controller: editLawsuitPlace,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                        //_textListOffice,
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
                      Container(
                        padding: paddingData,
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
                                  //_navigateSearchStaff(context);
                                },
                                focusNode: myFocusNodeLawsuitPersonName,
                                controller: editLawsuitPersonName,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  /*suffixIcon: Icon(
                                    Icons.search, color: Colors.grey,),*/
                                ),
                              ),
                            ),
                            /*Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),*/
                          ],
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
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
                                focusNode: myFocusNodeLawsuitTestimony,
                                controller: editTestimony,
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
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
                  child: Container(
                      padding: EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 1.0),
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("ผู้ต้องหา", style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // new
                                itemCount: _itemsLawsuitArrestMain
                                    .LawsuitArrestIndictmentDetail.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int j) {
                                  int LAWSUIT_TYPE;
                                  /*ItemsListLawsuitDetail lawDetail =_itemsLawsuitMain.LawsuitDetail[j];
                                  var lawIndicDetail = _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j];
                                  if(_itemsLawsuitMain.LawsuitDetail[j].LAWSUIT_TYPE==0||
                                      _itemsLawsuitMain.LawsuitDetail[j].LAWSUIT_TYPE==2){
                                    LAWSUIT_TYPE=1;
                                  }else{
                                    LAWSUIT_TYPE=0;
                                  }
                                  print("type : "+_itemsLawsuitMain.LawsuitDetail[j].LAWSUIT_TYPE.toString());*/


                                  ItemsListLawsuitDetail lawDetail;
                                  var lawIndicDetail;
                                  if(_itemsLawsuitMain==null){
                                    lawIndicDetail=_itemsLawsuitArrestMain
                                        .LawsuitArrestIndictmentDetail[j];

                                    LAWSUIT_TYPE=0;
                                  }else {
                                    for (int i = 0; i <
                                        _itemsLawsuitMain.LawsuitDetail.length;
                                    i++) {

                                      if (_itemsLawsuitArrestMain
                                          .LawsuitArrestIndictmentDetail[j]
                                          .INDICTMENT_DETAIL_ID ==
                                          _itemsLawsuitMain.LawsuitDetail[i]
                                              .INDICTMENT_DETAIL_ID) {
                                        if (_itemsLawsuitMain.LawsuitDetail[i]
                                            .LAWSUIT_TYPE == 0 ||
                                            _itemsLawsuitMain.LawsuitDetail[i]
                                                .LAWSUIT_TYPE == 2) {
                                          LAWSUIT_TYPE = 1;
                                        } else
                                        if (_itemsLawsuitMain.LawsuitDetail[i]
                                            .LAWSUIT_TYPE == 1) {
                                          LAWSUIT_TYPE = 0;
                                        }

                                        lawDetail =
                                        _itemsLawsuitMain.LawsuitDetail[i];
                                        lawIndicDetail = _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentDetail[j];
                                        break;
                                      }
                                    }
                                  }

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingData,
                                        child: Text((j + 1).toString() + ". " +
                                            lawIndicDetail
                                                .TITLE_SHORT_NAME_TH +
                                            lawIndicDetail
                                                .FIRST_NAME + " " +
                                          lawIndicDetail
                                                .LAST_NAME,
                                          style: textStyleData,),
                                      ),
                                      LAWSUIT_TYPE == 0
                                          ? Container(
                                        padding: paddingData,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  //
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff3b69f3),
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(4.0),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: paddingData,
                                              child: Text("เปรียบเทียบ",
                                                style: textStyleSubData,),
                                            )
                                          ],
                                        ),
                                      )
                                          : Container(
                                        child: new InkWell(
                                          child: Card(
                                            shape: new RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: Color(0xff087de1),
                                                    width: 1.5),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10.0)
                                            ),
                                            elevation: 0.0,
                                            child: Padding(
                                                padding: paddindSentence,
                                                child: Text('คำพิพากษาศาล',
                                                  style: textStyleSentence,)
                                            ),
                                          ),
                                          onTap: () {
                                             _navigateLawsuitAcceptCaseSentence(
                                                      context,  lawDetail,j);
                                          },
                                        ),
                                      ),
                                      _itemsLawsuitArrestMain
                                          .LawsuitArrestIndictmentDetail
                                          .length > 1 && j !=
                                          _itemsLawsuitArrestMain
                                              .LawsuitArrestIndictmentDetail
                                              .length - 1 ?
                                      Container(
                                        padding: paddingData,
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ) : Container(),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          )
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname="";
      String lastname="";
      _itemsLawsuitMain.LawsuitStaff.forEach((item){
        title = item.TITLE_SHORT_NAME_TH!=null
            ?item.TITLE_SHORT_NAME_TH
            :item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      String lawsuit_date = "";
      String lawsuit_time = "";
      String lawsuit_year = "";
      DateTime dt_lawsuit_date = DateTime.parse(_itemsLawsuitMain.LAWSUIT_DATE);
      DateTime dt_lawsuit_year = DateTime.parse(_itemsLawsuitMain.LAWSUIT_NO_YEAR);
      List splitslawDate = dateFormatDate.format(dt_lawsuit_date).toString().split(
          " ");
      List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(
          " ");
      lawsuit_date = splitslawDate[0] + " " + splitslawDate[1] + " " +
          (int.parse(splitslawDate[3]) + 543).toString();
      lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();

      lawsuit_time = dateFormatTime.format(DateTime.parse(_itemsLawsuitMain.LAWSUIT_DATE)).toString();

      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                        child: Text("เลขที่รับคำกล่าวโทษ", style: textStyleLabel,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: paddingData,
                            child: new Text("น. ",
                              style: textStyleLabel,
                            ),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              _itemsLawsuitMain.LAWSUIT_NO.toString() + '/' +
                                  lawsuit_year,
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
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วันที่รับคดีคำกล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          lawsuit_date+" เวลา "+lawsuit_time,
                          style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้รับคดี", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                         title+firstname+" "+lastname, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ลักษณะคดีรายผู้ต้องหา", style: textStyleLabel,),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // new
                            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              EdgeInsets paddingSuspect = EdgeInsets.only(
                                  left: 8.0, top: 4, bottom: 4);
                              int LAWSUIT_TYPE;
                              ItemsListLawsuitDetail lawDetail;
                              for(int i=0;i<_itemsLawsuitMain.LawsuitDetail.length;i++){
                                lawDetail=_itemsLawsuitMain.LawsuitDetail[i];
                                if(_itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].INDICTMENT_DETAIL_ID ==
                                    _itemsLawsuitMain.LawsuitDetail[i].INDICTMENT_DETAIL_ID){
                                  if(_itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==0||
                                      _itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==2){
                                    LAWSUIT_TYPE = 1;
                                  }else if(_itemsLawsuitMain.LawsuitDetail[i].LAWSUIT_TYPE==1){
                                    LAWSUIT_TYPE = 0;
                                  }
                                  break;
                                }
                              }
                              /*int LAWSUIT_TYPE;
                              ItemsListLawsuitDetail lawDetail =_itemsLawsuitMain.LawsuitDetail[index];
                              var lawIndicDetail = _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index];
                              if(_itemsLawsuitMain.LawsuitDetail[index].LAWSUIT_TYPE==0||
                                  _itemsLawsuitMain.LawsuitDetail[index].LAWSUIT_TYPE==2){
                                LAWSUIT_TYPE=1;
                              }else{
                                LAWSUIT_TYPE=0;
                              }*/
                              print("type : "+_itemsLawsuitMain.LawsuitDetail[index].LAWSUIT_TYPE.toString());
                              print("lawDetail : "+lawDetail.toString());

                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: paddingSuspect,
                                    child: Text((index + 1).toString() + '. ' +
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH+
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].FIRST_NAME+" "+
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[index].LAST_NAME,
                                      style: textStyleData,),
                                  ),
                                  LAWSUIT_TYPE==0 ? Padding(
                                    padding: paddingSuspect,
                                    child: Text('(' +
                                       "เปรียบเทียบปรับ" + ')',
                                      style: textStyleSub,),
                                  )
                                      : Container(
                                    child: new InkWell(
                                      child: Card(
                                        shape: new RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color: Color(0xff087de1),
                                                width: 1.5),
                                            borderRadius: BorderRadius.circular(
                                                10.0)
                                        ),
                                        elevation: 0.0,
                                        child: Padding(padding: paddindSentence,
                                            child: Text('คำพิพากษาศาล',
                                              style: textStyleSentence,)
                                        ),
                                      ),
                                      onTap: () {
                                        _navigateLawsuitAcceptCaseSentence(
                                            context,  lawDetail,index);
                                      },
                                    ),
                                  )
                                ],
                              );
                            }
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text("สถานที่ทำการ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _itemsLawsuitMain.OFFICE.OFFICE_NAME, style: textStyleData,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "คำให้การของผู้กล่าวโทษ", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _itemsLawsuitMain.TESTIMONY, style: textStyleData,),
                      ),
                    ],
                  ),
                  _itemsLawsuitMain.IS_OUTSIDE==1?Align(
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
                                  child: Text(contants.text,style: TextStyle(fontFamily: FontStyles().FontFamily),),)
                              ],
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ):Container()
                ],
              )
          ),
        ),
      );
    }
    return Column(
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
                    'ILG60_B_02_00_03_00', style: textStylePageName,),
                )
              ],
            ),*/
        ),
        Expanded(
          child: _onSaved ? _buildContent_saved(context) : _buildContent(
              context),
        ),
      ],
    );
  }

//************************end_tab_1*******************************

//************************start_tab_2*****************************
  buildCollapsed() {
    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    List splits = dateFormatDate.format(dt_occourrence).toString().split(
        " ");
    arrest_date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_CODE,
            style: textDataTitleStyle,),
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_itemsLawsuitArrestMain.OCCURRENCE_DATE)+" "
                +_convertTime(_itemsLawsuitArrestMain.OCCURRENCE_DATE),
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH+
                _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME+" "+
                _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: paddingData,
                      child: Text((j + 1).toString() + '. ' +
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME+" "+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
                        style: textStyleData,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Map map={
                            "TEXT_SEARCH" : "",
                            "PERSON_ID" : _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID
                          };
                          _navigatePreviewIndicmentDetail(context, map);
                          /* Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j],)));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),

        













        Container(
          padding: paddingLabel,
          child: Text("มาตรา", style: textStyleLabel,)
        ),
          

        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new  Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูบทกำหนดโทษ",
                          style: textStyleLink,),
                        onPressed: () {

                        _navigatePreviewpernalty(context);
                         
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),



















        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
      ],
    );
  }
  buildExpanded() {
    String address = "error";
    /*_itemsLawsuitArrestMain.LawsuitLocale.forEach((item) {
      address = item.ADDRESS_NO+(item.ALLEY==null?"":" ซอย "+item.ALLEY)
          +(item.ROAD==null?"":" ถนน "+item.ROAD)
          + " อำเภอ/เขต " +  item.DISTRICT_NAME_TH
          + " ตำบล/แขวง " +
          item.SUB_DISTRICT_NAME_TH + " จังหวัด " +
          item.PROVINCE_NAME_TH;
    });*/

    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    List splits = dateFormatDate.format(dt_occourrence).toString().split(
        " ");
    arrest_date = splits[0] + " " + splits[1] + " " +
        (int.parse(splits[3]) + 543).toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text("เลขที่ใบงาน", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_CODE,
            style: textDataTitleStyle,),
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
          child: Text("วันที่จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_itemsLawsuitArrestMain.OCCURRENCE_DATE)+" "
            +_convertTime(_itemsLawsuitArrestMain.OCCURRENCE_DATE),
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้จับกุม", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH+
                _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME+" "+
                _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("ผู้ต้องหา", style: textStyleLabel,),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text((j + 1).toString() + '. ' +
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH+
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME+" "+
                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
                      style: textStyleData,),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูประวัติผู้ต้องหา",
                          style: textStyleLink,),
                        onPressed: () {
                          Map map={
                            "TEXT_SEARCH" : "",
                            "PERSON_ID" : _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID
                          };
                          _navigatePreviewIndicmentDetail(context, map);
                          /*Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j])));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
       

        Container(
          padding: paddingLabel,
          child: Text("มาตรา", style: textStyleLabel,)
        ),
          

        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new  Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text("ดูบทกำหนดโทษ",
                          style: textStyleLink,),
                        onPressed: () {

                        _navigatePreviewpernalty(context);
                         
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),



        Container(
          padding: paddingLabel,
          child: Text("ฐานความผิด", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,),
        ),
        Container(
          padding: paddingLabel,
          child: Text("เขียนที่", style: textStyleLabel,),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.ARREST_OFFICE_NAME,
            style: textStyleData,),
        ),
        /*Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลางลำดับ "+(j+1).toString(), style: textStyleLabel,),
                  ),
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME+" / "+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH
                      ,
                      style: textStyleData,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("จำนวน", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ขนาด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณสุทธิ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN.toString(),
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j<_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length-1?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: Width,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ):Container()
                ],
              );
            },
          ),
        ),*/
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text("ของกลาง", style: textStyleLabel,),
            ),
            _itemsLawsuitArrestMain
                .LawsuitArrestIndictmentProduct.length==0
                ?Container(
              padding: paddingData,
              child: Text(
                "ไม่มีของกลาง",style: textStyleData,
              ),
            )
                :Container(
              padding: paddingLabel,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // new
                  itemCount: _itemsLawsuitArrestMain
                      .LawsuitArrestIndictmentProduct.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TabScreenArrest6Product(
                                        ItemsProduct: _itemsLawsuitArrestMain
                                            .LawsuitArrestIndictmentProduct[index],
                                        IsComplete: true,
                                      )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingData,
                                  child: Text(
                                    (index + 1).toString() + ". " +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_GROUP_NAME != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_GROUP_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_CATEGORY_NAME != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_CATEGORY_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_TYPE_NAME != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_TYPE_NAME
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_BRAND_NAME_TH != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_BRAND_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_BRAND_NAME_EN != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_BRAND_NAME_EN
                                            .toString() + ' ')
                                            : '') +

                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_SUBBRAND_NAME_TH != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_SUBBRAND_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_SUBBRAND_NAME_EN != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_SUBBRAND_NAME_EN
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_MODEL_NAME_TH != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_MODEL_NAME_TH
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_MODEL_NAME_EN != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].PRODUCT_MODEL_NAME_EN
                                            .toString() + ' ')
                                            : '') +
                                        (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].DEGREE != null
                                            ? (_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].DEGREE.toString() +
                                            ' ดีกรี ')
                                            : ' ') +
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].SIZES.toString() + ' ' +
                                        _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index].SIZES_UNIT.toString(),
                                    style: textStyleData,),
                                ),
                              ),
                              Icon(Icons.navigate_next),
                            ],
                          ),
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ],
    );
  }

  //bool Success=false;
  //ItemsListArrestPerson ItemsPreviewIndicmentDetail=null;
  ItemsListPersonNetMain itemsListPersonNetMain=null;
  //on show dialog
  Future<bool> onLoadActionIndicmentDetail(BuildContext context,Map map) async {
    /* await new ArrestFuture().apiRequestMasPersongetByCon(map).then((onValue) {
      Success = onValue.SUCCESS;
      onValue.RESPONSE_DATA.forEach((item){
        ItemsPreviewIndicmentDetail=item;
      });
    });*/
    await new PersonNetFuture().apiRequestPersonDetailgetByPersonId(map).then((onValue) {
      itemsListPersonNetMain = onValue;
    });
    setState(() {});
    return true;
  }


















 _navigatePreviewpernalty(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Pernalty(
                itemsLawsuitMain: _itemsLawsuitArrestMain,
              )),
    );
  }


























































  _navigatePreviewIndicmentDetail(BuildContext context,Map map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionIndicmentDetail(context,map);
    Navigator.pop(context);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Suspect2(itemsListPersonNetMain: itemsListPersonNetMain,)),
    );
  }

  Widget _buildContent_tab_2() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      return Container(
        padding: EdgeInsets.only(
            left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Stack(children: <Widget>[
          ExpandableNotifier(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed(),
                  expanded: buildExpanded(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var exp = ExpandableController.of(context);
                        return FlatButton(
                            onPressed: () {
                              exp.toggle();
                            },
                            child: Text(
                              exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                              style: textStyleLink,
                            )
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        ),
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
                        'ILG60_B_02_00_04_00', style: textStylePageName,),
                    )
                  ],
                ),*/
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
    );
  }

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          //margin: EdgeInsets.all(4.0),
          child: ListView.builder(
              itemCount: itemsFormsTab3.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //padding: EdgeInsets.only(top: 2, bottom: 2),
                  child: Container(
                    padding: EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: index==0
                            ?Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                            :Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                    child: ListTile(
                        title: Text((index + 1).toString() + '. ' +
                            itemsFormsTab3[index].FormsName,
                          style: textInputStyleTitle,),
                        trailing: Icon(
                          Icons.arrow_forward_ios, color: Colors.grey[300],),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TabScreenArrest8Dowload(
                                Title: itemsFormsTab3[index].FormsName,
                                FILE_NAME: itemsFormsTab3[index].FormsCode,
                              ),
                              ));
                        }
                    ),
                  ),
                );
              }
          ),
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
                      'ILG60_B_02_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

//************************end_tab_3*******************************

//************************start_tab_proof*****************************
  Widget _buildContent_tab_proof() {
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
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                            Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
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
                              child: new Text("กค.",
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
                                      focusNode: myFocusNodeProofNumber,
                                      controller: editProofNumber,
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
                                      focusNode: myFocusNodeProofYear,
                                      controller: editProofYear,
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
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
                                      Current: _dtDateProof);
                                }).then((s) {
                              String date = "";
                              List splits = dateFormatDate.format(
                                  s).toString().split(" ");
                              date = splits[0] + " " + splits[1] +
                                  " " +
                                  (int.parse(splits[3]) + 543)
                                      .toString();
                              setState(() {
                                _dtDateProof=s;
                                _currentDateProof=date;
                                editProofDate.text = _currentDateProof;
                                _proveDate = _dtDateProof.toString();
                              });
                            });
                          },
                          focusNode: myFocusNodeProofDate,
                          controller: editProofDate,
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
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text("เวลา", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
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
                                    initialDateTime: proofTime,
                                    onDateTimeChanged: (
                                        DateTime newDateTime) {
                                      setState(() {
                                        proofTime = newDateTime;
                                        _currentTimeProof = dateFormatTime.format(proofTime)
                                            .toString();
                                        editProofTime.text = _currentTimeProof;

                                        List splitsArrestDate = _dtDateProof.toUtc().toLocal().toString().split(" ");
                                        List splitsArrestTime = proofTime.toString().split(" ");
                                        _proveDate=splitsArrestDate[0].toString()+" "+splitsArrestTime[1].toString();
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          focusNode: myFocusNodeProofTime,
                          controller: editProofTime,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
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
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้นำส่งของกลางไปพิสูจน์", style: textStyleLabel,),
                      ),
                      Padding(
                        padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                          },
                          focusNode: myFocusNodeProofPerson,
                          controller: editProofPerson,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
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
      );
    }
    Widget _buildContent_saved(BuildContext context) {
      String delivery_date = "";
      DateTime dt_occourrence = DateTime.parse(_itemsLawsuitMain.DELIVERY_DOC_DATE);
      List splits = dateFormatDate.format(dt_occourrence).toString().split(
          " ");
      delivery_date = splits[0] + " " + splits[1] + " " +
          (int.parse(splits[3]) + 543).toString()+" เวลา ";

      String title = "";
      String firstname="";
      String lastname="";
      _itemsLawsuitMain.LawsuitStaff.forEach((item){
        title = item.TITLE_SHORT_NAME_TH!=null
            ?item.TITLE_SHORT_NAME_TH
            :item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 18.0, bottom: 18.0),
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
                            child: Text("เลขที่หนังสือนำส่ง", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                             _itemsLawsuitMain.DELIVERY_DOC_NO_1 + '/' + _itemsLawsuitMain.DELIVERY_DOC_NO_2,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "วันที่ออกหนังสือ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              delivery_date,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ผู้นำส่งของกลางไปพิสูจน์", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              title+firstname+" "+lastname,
                              style: textStyleData,),
                          ),
                        ],
                      ),
                      _itemsLawsuitMain.IS_OUTSIDE==1?Align(
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
                      ):Container()
                    ],
                  )
              ),
              /*Container(
                padding: paddingLabel,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget
                      .itemsCaseInformation.Proof.Evidences.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 0.1, bottom: 0.1),
                      child: Container(
                        padding: EdgeInsets.all(22.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300],
                                  width: 1.0),
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Text((index+1).toString()+'. '+
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductCategory +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductType + ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .MainBrand +
                                        widget
                                            .itemsCaseInformation
                                            .Evidenses[index]
                                            .ProductModel +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubProductType +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .SubSetProductType +
                                        ' > ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .Capacity.toString() +
                                        ' ' +
                                        widget
                                            .itemsCaseInformation
                                            .Proof
                                            .Evidences[index]
                                            .ProductUnit,
                                      style: textStyleData,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),*/
            ],
          )
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
                      'ILG60_B_02_00_11_00', style: textStylePageName,),
                  )
                ],
              ),*/
          ),
          Expanded(
            child: _onSaved&&widget.itemsLawsuitMain.IS_PROVE!=0?_buildContent_saved(context):_buildContent(context),
          ),
        ],
      ),
    );
  }
//************************end_tab_poof*******************************

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
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }
}
