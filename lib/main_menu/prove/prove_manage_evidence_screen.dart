
import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_size.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_search_screen.dart';
import 'package:prototype_app_pang/main_menu/prove/select_price_evidence_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/choice.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'future/prove_future.dart';
import 'model/prove_arrest_product.dart';
import 'model/prove_indicment_product.dart';

class ProveManageEvidenceScreenFragment extends StatefulWidget {
  var itemsProduct;
  int SECTION_ID;
  //ItemsProveArrestIndicmentProduct itemsArrestProduct;
  bool IsScientific;
  bool IsCreate;
  bool IsPreview;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  List<ItemsListDocument> ItemsDocument;
  ProveManageEvidenceScreenFragment({
    Key key,
    @required this.SECTION_ID,
    @required this.itemsProduct,
    //@required this.itemsArrestProduct,
    @required this.IsCreate,
    @required this.IsPreview,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    @required this.ItemsDocument,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveManageEvidenceScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;

  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;

  bool IsProve = false;

  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  //ItemsProveArrestIndicmentProduct ItemsMain;
  var ItemsMain;

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
  ];

  //node focus
  final FocusNode myFocusNodeProductCount = FocusNode();
  final FocusNode myFocusNodeProductCountUnit = FocusNode();
  final FocusNode myFocusNodeProductCapacity = FocusNode();
  final FocusNode myFocusNodeProductVolume = FocusNode();

  final FocusNode myFocusNodeProductCapacityUnit = FocusNode();
  final FocusNode myFocusNodeProductVolumeUnit = FocusNode();
  final FocusNode myFocusNodeProductTaxUnit = FocusNode();

  //textfield
  TextEditingController editProductCount = new TextEditingController();
  TextEditingController editProductCountUnit = new TextEditingController();
  TextEditingController editProductCapacity = new TextEditingController();
  TextEditingController editProductVolume = new TextEditingController();

  TextEditingController editProductCapacityUnit = new TextEditingController();
  TextEditingController editProductVolumeUnit = new TextEditingController();
  TextEditingController editProductTaxUnit = new TextEditingController();

  //nod focus มูลค่าภาษี
  final FocusNode myFocusNodeTaxValue = FocusNode();
  final FocusNode myFocusNodeTaxVolumnBy = FocusNode();
  final FocusNode myFocusNodeTaxVolumnAlcohol = FocusNode();
  final FocusNode myFocusNodeTaxVolumnSugar = FocusNode();
  final FocusNode myFocusNodeTaxVolumnCo2 = FocusNode();
  final FocusNode myFocusNodeTaxUnit = FocusNode();
  final FocusNode myFocusNodeRetailPrice = FocusNode();
  final FocusNode myFocusNodeProveValue = FocusNode();

  final FocusNode myFocusNodeMotorNo1= FocusNode();
  final FocusNode myFocusNodeMotorNo2 = FocusNode();

  //textfield มูลค่าภาษี
  TextEditingController editTaxValue = new TextEditingController();
  TextEditingController editTaxVolumnBy = new TextEditingController();
  TextEditingController editTaxVolumnAlcohol = new TextEditingController();
  TextEditingController editTaxVolumnSugar = new TextEditingController();
  TextEditingController editTaxVolumnCo2 = new TextEditingController();
  TextEditingController editTaxUnit = new TextEditingController();
  TextEditingController editTaxRetailPrice = new TextEditingController();
  TextEditingController editTaxProveValue = new TextEditingController();

  TextEditingController editTaxMotorNo1 = new TextEditingController();
  TextEditingController editTaxMotorNo2 = new TextEditingController();
  //controller expandable
  ExpandableController myExpandableController = new ExpandableController();

  //nod focus ของกลางคงเหลือพิสูจน์
  final FocusNode myFocusRemainingEvidenceCount = FocusNode();
  final FocusNode myFocusRemainingEvidenceVolumn = FocusNode();
  final FocusNode myFocusRemainingEvidenceComment = FocusNode();

  //textfield ของกลางคงเหลือพิสูจน์
  TextEditingController editRemainingEvidenceCount = new TextEditingController();
  TextEditingController editRemainingEvidenceVolumn = new TextEditingController();
  TextEditingController editRemainingEvidenceComment = new TextEditingController();

  //nod focus รายละเอียดการตวรจพิสูจน์ของกลาง*
  final FocusNode myFocusProveDescription = FocusNode();

  //textfield ผลทาง Lab*
  TextEditingController editProveDescription = new TextEditingController();

  //nod focus ผลทาง Lab*
  final FocusNode myFocusLabResult = FocusNode();

  //textfield รายละเอียดการตวรจพิสูจน์ของกลาง*
  TextEditingController editLabResult = new TextEditingController();

  /*String dropdownValueProductUnit = "ขวด";
  String dropdownValueCapacityUnit = "มิลลิกรัม";
  String dropdownValueVolumeUnit = "มิลลิกรัม";
  List<String> dropdownItemsProductUnit = ['ขวด', 'ลัง','ซอง','มวน'];
  List<String> dropdownItemsCapacityUnit = ['ลิตร', 'มิลลิกรัม'];
  List<String> dropdownItemsVolumeUnit = ['ลิตร', 'มิลลิกรัม'];*/
  ItemsMasProductUnitResponse dropdownItemsProductUnit;
  ItemsMasProductSizeResponse dropdownItemsCapacityUnit;
  ItemsMasProductSizeResponse dropdownItemsVolumeUnit;
  ItemsListProductUnit dropdownValueProductUnit = null;
  ItemsListProductSize dropdownValueCapacityUnit = null;
  ItemsListProductSize dropdownValueVolumeUnit = null;

  ItemsMasProductUnitResponse dropdownItemsTaxUnit;
  ItemsListProductUnit dropdownValueTaxUnit = null;
  /*String dropdownValueTaxUnit = "มิลลิกรัม";
  List<String> dropdownItemsTaxUnit = ['ลิตร', 'มิลลิกรัม'];*/

  ItemsMasProductUnitResponse dropdownItemsRemainingEvidenceCountUnit;
  ItemsMasProductSizeResponse dropdownItemsRemainingEvidenceVolumnUnit;
  ItemsListProductUnit dropdownValueRemainingEvidenceCountUnit = null;
  ItemsListProductSize dropdownValueRemainingEvidenceVolumnUnit = null;
  /*String dropdownValueRemainingEvidenceCountUnit = "ขวด";
  String dropdownValueRemainingEvidenceVolumnUnit = "มิลลิกรัม";
  List<String> dropdownItemsRemainingEvidenceCountUnit = ['ขวด', 'ลัง'];
  List<String> dropdownItemsRemainingEvidenceVolumnUnit = ['ลิตร', 'มิลลิกรัม'];*/


  TextStyle textLabelEditNonCheckStyle = TextStyle(
      fontSize: 16.0, color: Colors.red[100],fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = TextStyle(
      fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = TextStyle(color: Colors.red,fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff31517c),fontFamily: FontStyles().FontFamily);
  TextStyle TitleStyle = TextStyle(fontSize: 16.0,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(
    color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(
    fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.w500,fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0,fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonAccept = TextStyle(fontSize: 16,color: Colors.white,fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  final formatter = new NumberFormat("#,##0.00");
  double VAT_TOTAL = 0;
  bool IsEnableVatTotal =true;
  @override
  void initState() {
    super.initState();
    setState(() {

      print("SECTION_ID : "+widget.SECTION_ID.toString());

      dropdownItemsProductUnit = widget.itemsMasProductUnit;
      dropdownItemsCapacityUnit = widget.itemsMasProductSize;
      dropdownItemsVolumeUnit = widget.itemsMasProductSize;

      dropdownItemsTaxUnit = widget.itemsMasProductUnit;

      dropdownItemsRemainingEvidenceCountUnit = widget.itemsMasProductUnit;
      dropdownItemsRemainingEvidenceVolumnUnit= widget.itemsMasProductSize;


      if(widget.IsCreate){
        ItemsMain = widget.itemsProduct;
        _setinitData();
      }

      if(widget.IsPreview){
        ItemsMain = widget.itemsProduct;
        _onSaved=true;
        _onFinish=true;


        try{
          print(ItemsMain.PROVE_ID);
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
        }catch(e){
          //
          _arrItemsImageFile=ItemsMain.itemsListDocument;
        }
      }
    });
  }

  _setinitData(){
    //******************tag1***************************
    editProductCount.text = ItemsMain.QUANTITY.toString();
    editProductCountUnit.text = ItemsMain.QUANTITY_UNIT.toString();

    /*dropdownItemsProductUnit.RESPONSE_DATA.forEach((item){
      if(item.UNIT_NAME_TH.endsWith(ItemsMain.QUANTITY_UNIT.toString())){
        dropdownValueProductUnit = item;
        editProductCountUnit.text = item.UNIT_NAME_TH;
      }
    });*/
    editProductCapacity.text = ItemsMain.SIZES.toString();
    editProductCapacityUnit.text = ItemsMain.SIZES_UNIT.toString();
    /*dropdownItemsCapacityUnit.RESPONSE_DATA.forEach((item){
      if(item.SIZE_ID==ItemsMain.SIZES_UNIT_ID){
        dropdownValueCapacityUnit = item;
      }
    });*/
    editProductVolume.text = ItemsMain.VOLUMN.toString();
    editProductVolumeUnit.text = ItemsMain.VOLUMN_UNIT.toString();
    /*dropdownItemsVolumeUnit.RESPONSE_DATA.forEach((item){
      if(item.SIZE_ID==ItemsMain.VOLUMN_UNIT_ID){
        dropdownValueVolumeUnit = item;
      }
    });*/
    //******************tag1***************************
    editTaxVolumnCo2.text = ItemsMain.CO2.toString();
    editTaxVolumnSugar.text = ItemsMain.SUGAR.toString();
    editTaxVolumnAlcohol.text = ItemsMain.DEGREE.toString();

    //******************tag2***************************
    editTaxValue.text = ItemsMain.TAX_VALUE.toString();
    editTaxVolumnBy.text = 1.toString();
    editProductTaxUnit.text = ItemsMain.TAX_VOLUMN_UNIT.toString();
    /*dropdownItemsTaxUnit.RESPONSE_DATA.forEach((item){
      if(item.UNIT_NAME_TH.endsWith(ItemsMain.TAX_VOLUMN_UNIT.toString())){
        dropdownValueTaxUnit = item;
      }
    });*/
    editTaxUnit.text = ItemsMain.TAX_VOLUMN==0?"":ItemsMain.TAX_VOLUMN.toString();
    //editTaxRetailPrice.text = ItemsMain.PRICE==0?"":ItemsMain.PRICE.toString();
    editTaxVolumnCo2.text = ItemsMain.CO2==0?"":ItemsMain.CO2.toString();
    editTaxVolumnSugar.text = ItemsMain.SUGAR==0?"":ItemsMain.SUGAR.toString();
    editTaxVolumnAlcohol.text = ItemsMain.DEGREE==0?"":ItemsMain.DEGREE.toString();

    //******************tag2***************************


    //******************tag3***************************
    editRemainingEvidenceCount.text = ItemsMain.QUANTITY.toString();
    dropdownItemsRemainingEvidenceCountUnit.RESPONSE_DATA.forEach((item){
      if(item.UNIT_NAME_TH.endsWith(ItemsMain.QUANTITY_UNIT.toString())){
        dropdownValueRemainingEvidenceCountUnit = item;
      }
    });
    editRemainingEvidenceVolumn.text = ItemsMain.VOLUMN.toString();
    dropdownItemsRemainingEvidenceVolumnUnit.RESPONSE_DATA.forEach((item){
      if(item.SIZE_NAME_TH.endsWith(ItemsMain.VOLUMN_UNIT.toString())){
        dropdownValueRemainingEvidenceVolumnUnit = item;
      }
    });
    editRemainingEvidenceComment.text = ItemsMain.REMARK==null||ItemsMain.REMARK.toString().endsWith("null")
        ?""
        :ItemsMain.REMARK.toString();

    //******************tag3***************************
    VAT_TOTAL=_onCalculateVat(
        ItemsMain.PRICE,
        ItemsMain.TAX_VALUE,
        ItemsMain.DEGREE,
        ItemsMain.VOLUMN,
        ItemsMain.TAX_VOLUMN,
        ItemsMain.QUANTITY
    );
    print("VAT_TOTAL : "+VAT_TOTAL.toString());

    editTaxProveValue.text = formatter.format(VAT_TOTAL).toString();

    if(ItemsMain.PRICE>0||ItemsMain.TAX_VALUE!=null){
      IsEnableVatTotal =false;
    }else{
      IsEnableVatTotal =true;
    }
    editProveDescription.text = ItemsMain.PRODUCT_RESULT==null?"":ItemsMain.PRODUCT_RESULT.toString();
    editLabResult.text = ItemsMain.SCIENCE_RESULT_DESC==null?"":ItemsMain.SCIENCE_RESULT_DESC.toString();
  }

  double _onCalculateVat(PRICE,TAX_VALUE,DEGREE,VOLUMN,TAX_VOLUMN,QUANTITY){
    double a = 0,b = 0,c = 0;
    double result =0;
    print("PRODUCT_GROUP_ID : "+ItemsMain.PRODUCT_GROUP_ID.toString());
    if(ItemsMain.PRODUCT_GROUP_ID==13){
      a= (PRICE*TAX_VALUE)/100;
      b= (DEGREE*VOLUMN*TAX_VOLUMN)/100;
      c= a+b;
      result = c*QUANTITY;
      print("a : "+a.toString());
      print("b : "+b.toString());
      print("c : "+c.toString());
      print("result : "+result.toString());
    }else if(ItemsMain.PRODUCT_GROUP_ID==14){
      a= (PRICE*TAX_VALUE)/107;
      if(a>60){
        b=(40/100)*a;
      }else{
        b=(20/100)*a;
      }
      c=VOLUMN*1.2;
      result = (b+c)*QUANTITY;
    }
    print(result.ceil());
    return double.parse(result.ceil().toString());
  }
  _onTextChangeDegree(text) {
    setState(() {
      VAT_TOTAL =_onCalculateVat(
        double.parse(editTaxRetailPrice.text.replaceAll(",","")),
        ItemsMain.TAX_VALUE,
        double.parse(text),
        double.parse(editProductVolume.text.replaceAll(",","")),
        double.parse(editTaxUnit.text.replaceAll(",","")),
        double.parse(editProductCount.text.replaceAll(",","")),
      );
      editTaxProveValue.text = VAT_TOTAL.toString();
    });
  }
  _onTextChangePrice(text) {
    setState(() {
      /*VAT_TOTAL =_onCalculateVat(
        double.parse(text),
        ItemsMain.TAX_VALUE,
        double.parse(editTaxVolumnAlcohol.text.replaceAll(",","")),
        double.parse(editProductVolume.text.replaceAll(",","")),
        double.parse(editTaxUnit.text.replaceAll(",","")),
        double.parse(editProductCount.text.replaceAll(",","")),
      );*/
      editTaxProveValue.text = VAT_TOTAL.toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    editProductCapacity.dispose();
    editProductCount.dispose();
    editProductVolume.dispose();

    editTaxValue.dispose();
    editTaxVolumnBy.dispose();
    editTaxVolumnAlcohol.dispose();
    editTaxVolumnSugar.dispose();
    editTaxVolumnCo2.dispose();
    editTaxUnit.dispose();
    editTaxRetailPrice.dispose();
    editTaxProveValue.dispose();

    editRemainingEvidenceCount.dispose();
    editRemainingEvidenceVolumn.dispose();
    editRemainingEvidenceComment.dispose();
    //editProveDescription.dispose();
    myExpandableController.dispose();

    editProveDescription.dispose();

    editLabResult.dispose();
  }

  ItemsMasterProductGroupResponse itemsProductGroup;
  Future<bool> onLoadActionProductGroupMaster() async {
    Map map= {
      "TEXT_SEARCH": "",
      "PRODUCT_GROUP_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
      itemsProductGroup = onValue;
    });
    setState(() {});
    return true;
  }
  _navigate(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if(itemsProductGroup!=null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Add(IsSearch:true, IsUpdate: true,ItemsProductGroup: itemsProductGroup,)),
      );
      if(result.toString()!="back"){
        if (_onEdited) {
          List items = result;
          items.forEach((item){
           /* _arrestMain.ArrestProduct.add(item);
            list_add_product.add(item);*/
          });

        } else {
          List items = result;
          items.forEach((item){
            ItemsMain = item;
          });
        }
      }
    }
    /*final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProveManageEvidenceSearchScreenFragment(
          )),
    );
    if (result.toString() != "Back") {
      ItemsMain = result;
    }*/
  }

  _navigate_price(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectPriceBookScreenFragment(
            IsUpdate: false,
            itemsEvidenceItem: [],)),
    );
  }


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

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;

    Widget _buildExpanded() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Container(
            padding: paddingLabel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        IsProve = !IsProve;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        color:
                        IsProve ? Color(0xff3b69f3) : Colors.white,
                        border: Border.all(
                            width: 1.5, color: Colors.black38),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IsProve
                              ? Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                              : Container(
                            height: 16.0,
                            width: 16.0,
                            color: Colors.transparent,
                          )),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ส่งพิสูจน์ทางเคมีและวิทยาศาสตร์",
                    style: textStyleLabel,
                  ),
                ),
              ],
            ),
          ),*/
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
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
                    "ตามมูลค่า", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text("มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Padding(
            padding: paddingData,
            child: TextField(
              enabled: false,
              focusNode: myFocusNodeTaxValue,
              controller: editTaxValue,
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
          Container(
            padding: paddingLabel,
            child: Text(
              "มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
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
                    "ตามปริมาณ", style: textStyleLabel,),
                ),
              ],
            ),
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
                      child: Text("ตามปริมาณต่อ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        enabled: false,
                        focusNode: myFocusNodeTaxVolumnBy,
                        controller: editTaxVolumnBy,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    //_buildLine(),
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
                    /*Container(
                      width: Width,
                      //padding: paddingInputBox,
                      child: DropdownButtonHideUnderline(
                        child: new IgnorePointer(
                          ignoring: true,
                          child:DropdownButton<ItemsListProductUnit>(
                            isExpanded: true,
                          value: dropdownValueTaxUnit,
                          onChanged: (ItemsListProductUnit newValue) {
                            setState(() {
                              dropdownValueTaxUnit = newValue;
                            });
                          },
                          items: dropdownItemsTaxUnit.RESPONSE_DATA
                              .map<DropdownMenuItem<ItemsListProductUnit>>((ItemsListProductUnit value) {
                            return DropdownMenuItem<ItemsListProductUnit>(
                              value: value,
                              child: Text(value.UNIT_NAME_TH.toString(),style: textStyleData,),
                            );
                          })
                              .toList(),
                        ),
                      ),
                      ),
                    ),
                    _buildLine(),*/
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        enabled: false,
                        focusNode: myFocusNodeProductTaxUnit,
                        controller: editProductTaxUnit,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
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
                      child: Text("หน่วยละ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: /*Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: <Widget>[
                            TextField(
                              focusNode: myFocusNodeTaxUnit,
                              controller: editTaxUnit,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            Text("บาท", style: textStyleData,),
                          ],
                        )*/
                      TextField(
                        enabled: false,
                        focusNode: myFocusNodeTaxUnit,
                        controller: editTaxUnit,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                      ),
                    ),
                    //_buildLine(),
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
                      child: Text(
                        "ปริมาณแอลกอฮอล์", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnAlcohol,
                        controller: editTaxVolumnAlcohol,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: _onTextChangeDegree,
                      ),
                    ),
                    _buildLine(),
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
                      child: Text("ปริมาณน้ำตาล", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnSugar,
                        controller: editTaxVolumnSugar,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
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
                      child: Text(
                        "อัตราการปล่อย CO2", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnCo2,
                        controller: editTaxVolumnCo2,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
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
                      child: Text("หมายเลขเครื่องยนต์", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeMotorNo1,
                        controller: editTaxMotorNo1,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
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
                      child: Text(
                        "หมายเลขตัวถัง", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeMotorNo2,
                        controller: editTaxMotorNo2,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ราคาขายปลีกเเนะนำ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeRetailPrice,
                        controller: editTaxRetailPrice,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                        onChanged: _onTextChangePrice,
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
              new Container(
                width: ((size.width * 90) / 100) / 2,
                child: new Card(
                    color: Color(0xff087de1),
                    shape: new RoundedRectangleBorder(
                        side: new BorderSide(
                            color: Color(0xff087de1), width: 1.5),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    elevation: 0.0,
                    child: Container(
                        width: 100.0,
                        //height: 40,
                        child: Center(
                          child: MaterialButton(
                            onPressed: () {
                              //
                              _navigate_price(context);
                            },
                            splashColor: Color(0xff087de1),
                            //highlightColor: Colors.blue,
                            child: Center(
                              child: Text("เลือกราคาขายปลีก",
                                style: textStyleButtonAccept,),),
                          ),
                        )
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        enabled: IsEnableVatTotal,
                        focusNode: myFocusNodeProveValue,
                        controller: editTaxProveValue,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                      ),
                    ),
                    //_buildLine(),
                  ],
                ),
              ),
            ],
          )
        ],
      );
    }
    Widget _buildCollapsed() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  formatter.format(VAT_TOTAL).toString()+" บาท", style: textStyleData,),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width,
          padding: EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อของกลาง", style: textStyleLabel,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: paddingData,
                    child: Text(
                      (ItemsMain.PRODUCT_GROUP_NAME != null
                          ? (ItemsMain.PRODUCT_GROUP_NAME
                          .toString() + ' ')
                          : '') +
                          (ItemsMain.PRODUCT_CATEGORY_NAME != null
                              ? (ItemsMain.PRODUCT_CATEGORY_NAME
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_TYPE_NAME != null
                              ? (ItemsMain.PRODUCT_TYPE_NAME
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_BRAND_NAME_TH != null
                              ? (ItemsMain.PRODUCT_BRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_BRAND_NAME_EN != null
                              ? (ItemsMain.PRODUCT_BRAND_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_SUBBRAND_NAME_TH != null
                              ? (ItemsMain.PRODUCT_SUBBRAND_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_SUBBRAND_NAME_EN != null
                              ? (ItemsMain.PRODUCT_SUBBRAND_NAME_EN
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_MODEL_NAME_TH != null
                              ? (ItemsMain.PRODUCT_MODEL_NAME_TH
                              .toString() + ' ')
                              : '') +
                          (ItemsMain.PRODUCT_MODEL_NAME_EN != null
                              ? (ItemsMain.PRODUCT_MODEL_NAME_EN
                              .toString() + ' ')
                              : ''),
                      style: textStyleData,),
                  ),
                  /*Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: InkWell(
                          onTap: () {
                            _navigate(context);
                          },
                          child: Text(
                            "แก้ไข", style: textLabelEditNonCheckStyle,)
                      )
                  ),*/
                ],
              ),
              new IgnorePointer(
                  ignoring: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductCount,
                                    controller: editProductCount,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                //_buildLine(),
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
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: /*DropdownButtonHideUnderline(
                                    child: DropdownButton<ItemsListProductUnit>(
                                      isExpanded: true,
                                      value: dropdownValueProductUnit,
                                      onChanged: (ItemsListProductUnit newValue) {
                                        setState(() {
                                          dropdownValueProductUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsProductUnit.RESPONSE_DATA
                                          .map<DropdownMenuItem<ItemsListProductUnit>>((
                                          ItemsListProductUnit value) {
                                        return DropdownMenuItem<ItemsListProductUnit>(
                                          value: value,
                                          child: Text(value.UNIT_NAME_TH.toString(),style: textStyleData,),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),*/
                                  Container(
                                    padding: paddingLabel,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: myFocusNodeProductCountUnit,
                                      controller: editProductCountUnit,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization
                                          .words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                //_buildLine(),
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
                                  child: Text(
                                    "ขนาดบรรจุ", style: textStyleLabel,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductCapacity,
                                    controller: editProductCapacity,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                //_buildLine(),
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
                                /*Container(
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<ItemsListProductSize>(
                                      isExpanded: true,
                                      value: dropdownValueCapacityUnit,
                                      onChanged: (ItemsListProductSize newValue) {
                                        setState(() {
                                          dropdownValueCapacityUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsCapacityUnit.RESPONSE_DATA
                                          .map<DropdownMenuItem<ItemsListProductSize>>((
                                          ItemsListProductSize value) {
                                        return DropdownMenuItem<ItemsListProductSize>(
                                          value: value,
                                          child: Text(value.SIZE_NAME_TH.toString(),style: textStyleData,),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                _buildLine(),*/
                                Container(
                                  padding: paddingLabel,
                                  child: TextField(
                                    enabled: false,
                                    focusNode: myFocusNodeProductCapacityUnit,
                                    controller: editProductCapacityUnit,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
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
                                  child: Text(
                                    "ปริมาณสุทธิ", style: textStyleLabel,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductVolume,
                                    controller: editProductVolume,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                //_buildLine(),
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
                                /*Container(
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<ItemsListProductSize>(
                                      isExpanded: true,
                                      value: dropdownValueVolumeUnit,
                                      onChanged: (ItemsListProductSize newValue) {
                                        setState(() {
                                          dropdownValueVolumeUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsVolumeUnit.RESPONSE_DATA
                                          .map<DropdownMenuItem<ItemsListProductSize>>((
                                          ItemsListProductSize value) {
                                        return DropdownMenuItem<ItemsListProductSize>(
                                          value: value,
                                          child: Text(value.SIZE_NAME_TH.toString(),style: textStyleData,),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                _buildLine(),*/
                                Container(
                                  padding: paddingLabel,
                                  child: TextField(
                                    enabled: false,
                                    focusNode: myFocusNodeProductVolumeUnit,
                                    controller: editProductVolumeUnit,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
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
                    ],
                  )
              ),
            ],
          ),
        ),
    widget.SECTION_ID==203||widget.SECTION_ID==204
        ?new Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ExpandableNotifier(
                controller: myExpandableController,
                child: Stack(
                  children: <Widget>[
                    _onEdited ? Expandable(
                        collapsed: _buildExpanded(),
                        expanded: _buildCollapsed()
                    ) :
                    Expandable(
                        collapsed: _buildCollapsed(),
                        expanded: _buildExpanded()
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Builder(

                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return IconButton(
                              icon: _onEdited?Icon(
                                exp.expanded ? Icons.keyboard_arrow_down : Icons
                                    .keyboard_arrow_up, size: 24.0,
                                color: Colors.grey,):Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons
                                    .keyboard_arrow_down, size: 24.0,
                                color: Colors.grey,),
                              onPressed: () {
                                exp.toggle();
                              },
                            );
                          }
                      ),
                    )
                  ],
                )
            ),
          ),
        ):Container(),

        new Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ของกลางคงเหลือพิสูจน์", style: textStyleLabel,),
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
                            child: Text(
                              "จำนวน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: myFocusRemainingEvidenceCount,
                              controller: editRemainingEvidenceCount,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine(),
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
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ItemsListProductUnit>(
                                isExpanded: true,
                                value: dropdownValueRemainingEvidenceCountUnit,
                                onChanged: (ItemsListProductUnit newValue) {
                                  setState(() {
                                    dropdownValueRemainingEvidenceCountUnit =
                                        newValue;
                                  });
                                },
                                items: dropdownItemsRemainingEvidenceCountUnit.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListProductUnit>>((
                                    ItemsListProductUnit value) {
                                  return DropdownMenuItem<ItemsListProductUnit>(
                                    value: value,
                                    child: Text(value.UNIT_NAME_TH.toString(),style: textStyleData,),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine(),
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
                            child: Text(
                              "ปริมาณสุทธิ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: myFocusRemainingEvidenceVolumn,
                              controller: editRemainingEvidenceVolumn,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine(),
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
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ItemsListProductSize>(
                                isExpanded: true,
                                value: dropdownValueRemainingEvidenceVolumnUnit,
                                onChanged: (ItemsListProductSize newValue) {
                                  setState(() {
                                    dropdownValueRemainingEvidenceVolumnUnit =
                                        newValue;
                                  });
                                },
                                items: dropdownItemsRemainingEvidenceVolumnUnit.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListProductSize>>((
                                    ItemsListProductSize value) {
                                  return DropdownMenuItem<ItemsListProductSize>(
                                    value: value,
                                    child: Text(value.SIZE_NAME_TH.toString(),style: textStyleData,),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine(),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("หมายเหตุ", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: TextField(
                    focusNode: myFocusRemainingEvidenceComment,
                    controller: editRemainingEvidenceComment,
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
        ),
        /*Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Row(
                      children: <Widget>[
                        Text("รายละเอียดการตวรจพิสูจน์ของกลาง",
                          style: textStyleLabel,),
                        Text("*", style: textStyleStar,),
                      ],
                    ),
                  ),
                  Padding(
                      padding: paddingData,
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: TextField(
                          maxLines: 10,
                          focusNode: myFocusProveDescription,
                          controller: editProveDescription,
                          style: textStyleData,
                          decoration: new InputDecoration(
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
                      )
                  ),
                ],
              )
          ),
        ),*/
        IsProve ? Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ผลทาง Lab", style: textStyleLabel,),
                  ),
                  Padding(
                      padding: paddingData,
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: TextField(
                          maxLines: 10,
                          focusNode: myFocusLabResult,
                          controller: editLabResult,
                          style: textStyleData,
                          decoration: new InputDecoration(
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
                      )
                  ),
                ],
              )
          ),
        ) : Container(),
        _onSaved
        ?Container()
        :Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 22.0),
          child: _buildButtonImgPicker(),
        ),
        _buildDataImage(context),
      ],
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
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
                width: size.width / 2,
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
                              Icons.file_upload, size: 32, color: uploadColor,),
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
                      child: Image.file(
                        _arrItemsImageFile[index].FILE_CONTENT, fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageFile[index].DOCUMENT_NAME,
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: !_onSaved?Icon(Icons.delete_outline, size: 32.0,color: Colors.grey[500],):Icon(null),
                        onPressed: () {
                          setState(() {
                            if(_onEdited){
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

  Widget _buildLine() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
  }


  Widget _buildContent_saved() {
    var size = MediaQuery
        .of(context)
        .size;
    Widget _buildExpanded() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ItemsMain.IS_SCIENCE==1
              ?Container(
        padding: paddingLabel,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
              child: InkWell(
                onTap: () {
                  /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff3b69f3),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xff3b69f3)),
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
                "ส่งพิสูจน์ทางเคมีและวิทยาศาสตร์", style: textStyleLabel,),
            ),
          ],
        ),
      )
              :Container(),
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
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
                    "ตามมูลค่า", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text("มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.TAX_VALUE.toString(),
              style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
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
                    "ตามปริมาณ", style: textStyleLabel,),
                ),
              ],
            ),
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
                      child: Text("ตามปริมาณต่อ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        1.toString(),
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
                      padding: paddingData,
                      child: Text(
                        ItemsMain.TAX_VOLUMN_UNIT.toString(),
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
                      child: Text("หน่วยละ", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.TAX_VOLUMN.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
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
                      child: Text(
                        "ปริมาณแอลกอฮอล์", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        double.parse(ItemsMain.DEGREE.toString())==0
                            ?""
                            : ItemsMain.DEGREE.toString(),
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
                      child: Text("ปริมาณน้ำตาล", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        double.parse(ItemsMain.SUGAR.toString())==0
                            ?""
                            : ItemsMain.SUGAR.toString(),
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
                      child: Text(
                        "อัตราการปล่อย CO2", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        double.parse(ItemsMain.CO2.toString())==0
                            ?""
                            : ItemsMain.CO2.toString(),
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
                      child: Text(
                        "ราคาขายปลีกเเนะนำ", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.PRICE.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
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
                      child: Text(
                        "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            formatter.format(ItemsMain.VAT).toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    Widget _buildCollapsed() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  formatter.format(ItemsMain.VAT).toString(),
                  style: textStyleData,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  "บาท", style: textStyleData,),
              ),
            ],
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width,
          padding: EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อของกลาง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  (ItemsMain.PRODUCT_GROUP_NAME != null
                      ? (ItemsMain.PRODUCT_GROUP_NAME
                      .toString() + ' ')
                      : '') +
                      (ItemsMain.PRODUCT_CATEGORY_NAME != null
                          ? (ItemsMain.PRODUCT_CATEGORY_NAME
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_TYPE_NAME != null
                          ? (ItemsMain.PRODUCT_TYPE_NAME
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_BRAND_NAME_TH != null
                          ? (ItemsMain.PRODUCT_BRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_BRAND_NAME_EN != null
                          ? (ItemsMain.PRODUCT_BRAND_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_SUBBRAND_NAME_TH != null
                          ? (ItemsMain.PRODUCT_SUBBRAND_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_SUBBRAND_NAME_EN != null
                          ? (ItemsMain.PRODUCT_SUBBRAND_NAME_EN
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_MODEL_NAME_TH != null
                          ? (ItemsMain.PRODUCT_MODEL_NAME_TH
                          .toString() + ' ')
                          : '') +
                      (ItemsMain.PRODUCT_MODEL_NAME_EN != null
                          ? (ItemsMain.PRODUCT_MODEL_NAME_EN
                          .toString() + ' ')
                          : ''),
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
                          child: Text(
                            "จำนวน", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.QUANTITY.toString(),
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
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.QUANTITY_UNIT.toString(),
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                ],
              ), Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ขนาดบรรจุ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.SIZES.toString(),
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
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.SIZES_UNIT.toString(),
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
                          child: Text(
                            "ปริมาณสุทธิ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.VOLUMN.toString(),
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
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.VOLUMN_UNIT.toString(),
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        //คำนวณอัตราภาษี
        widget.SECTION_ID==203||widget.SECTION_ID==204
            ?Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ExpandableNotifier(
                controller: myExpandableController,
                child: Stack(
                  children: <Widget>[
                    Expandable(
                        collapsed: _buildCollapsed(),
                        expanded: _buildExpanded()
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Builder(

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
                    )
                  ],
                )
            ),
          ),
        ):Container(),

        //ของกลางคงเหลือพิสูจน์
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ของกลางคงเหลือพิสูจน์", style: textStyleLabel,),
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
                            child: Text(
                              "จำนวน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.REMAIN_QUANTITY.toString(),
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
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.REMAIN_QUANTITY_UNIT.toString(),
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
                            child: Text(
                              "ปริมาณสุทธิ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.REMAIN_VOLUMN.toString(),
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
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.REMAIN_VOLUMN_UNIT.toString(),
                              style: textStyleData,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("หมายเหตุ", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    ItemsMain.REMARK.toString(),
                    style: textStyleData,),
                ),
              ],
            ),
          ),
        ),

        //รายละเอียดการตวรจพิสูจน์ของกลาง
        /*Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("รายละเอียดการตวรจพิสูจน์ของกลาง",
                      style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      ItemsMain.PRODUCT_RESULT.toString(),
                      style: textStyleData,),
                  ),
                ],
              )
          ),
        ),*/

        //ผลทาง Lab
        ItemsMain.IS_SCIENCE==1?Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ผลทาง Lab", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      ItemsMain.SCIENCE_RESULT_DESC.toString(),
                      style: textStyleData,),
                  ),
                ],
              )
          ),
        ):Container(),
        _onSaved
            ?Container()
            :Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 22.0),
          child: _buildButtonImgPicker(),
        ),
        _buildDataImage(context),
      ],
    );
  }

  void onSaved(BuildContext mContext) async {
    try{
      print("PROVE_ID : "+ItemsMain.PROVE_ID.toString());
      if(_onEdited){
        //set data
        ItemsMain.TAX_VALUE = editTaxValue.text.isEmpty
            ? 0.0
            : double.parse(editTaxValue.text.replaceAll(",", ""));
        ItemsMain.TAX_VOLUMN_UNIT = dropdownValueTaxUnit != null
            ? dropdownValueTaxUnit.UNIT_NAME_TH.toString()
            : "";
        ItemsMain.TAX_VOLUMN = editTaxUnit.text.isEmpty
            ? 0.0
            : double.parse(editTaxUnit.text.replaceAll(",", ""));
        ItemsMain.PRICE = editTaxRetailPrice.text.isEmpty
            ? ItemsMain.PRICE
            : double.parse(editTaxRetailPrice.text.replaceAll(",", ""));
        ItemsMain.CO2 = editTaxVolumnCo2.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnCo2.text.replaceAll(",", ""));
        ItemsMain.SUGAR = editTaxVolumnSugar.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnSugar.text.replaceAll(",", ""));
        ItemsMain.DEGREE = editTaxVolumnAlcohol.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnAlcohol.text.replaceAll(",", ""));

        ItemsMain.REMAIN_QUANTITY = editRemainingEvidenceCount.text.isEmpty
            ? 0.0
            : double.parse(editRemainingEvidenceCount.text.replaceAll(",", ""));
        ItemsMain.REMAIN_QUANTITY_UNIT =
        dropdownValueRemainingEvidenceCountUnit != null
            ? dropdownValueRemainingEvidenceCountUnit.UNIT_NAME_TH
            : "";
        ItemsMain.REMAIN_VOLUMN = editRemainingEvidenceVolumn.text.isEmpty
            ? 0.0
            : double.parse(editRemainingEvidenceVolumn.text.replaceAll(",", ""));
        ItemsMain.REMAIN_VOLUMN_UNIT =
        dropdownValueRemainingEvidenceVolumnUnit != null
            ? dropdownValueRemainingEvidenceVolumnUnit.SIZE_NAME_TH
            : "";
        ItemsMain.REMARK = editRemainingEvidenceComment.text;

        ItemsMain.VAT = VAT_TOTAL;
        ItemsMain.PRODUCT_RESULT = editProveDescription.text;
        ItemsMain.IS_SCIENCE = IsProve ? 1 : 0;
        ItemsMain.SCIENCE_RESULT_DESC =
        IsProve ? editLabResult.text : "";
        ItemsMain.IS_PROVE = true;


        //add to map
        List<Map> map = [
          {
            "PRODUCT_ID": ItemsMain.PRODUCT_ID,
            "PROVE_ID": ItemsMain.PROVE_ID,
            "SCIENCE_ID": ItemsMain.SCIENCE_ID,
            "PRODUCT_MAPPING_ID": ItemsMain.PRODUCT_MAPPING_ID,
            "PRODUCT_INDICTMENT_ID": ItemsMain.PRODUCT_INDICTMENT_ID,
            "PRODUCT_MAPPING_REF_ID": ItemsMain.PRODUCT_MAPPING_REF_ID,
            "PRODUCT_CODE": ItemsMain.PRODUCT_CODE,
            "PRODUCT_REF_CODE": ItemsMain.PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": ItemsMain.PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": ItemsMain.PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": ItemsMain.PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": ItemsMain.PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": ItemsMain.PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": ItemsMain.PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": ItemsMain.PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": ItemsMain.PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": ItemsMain.PRODUCT_TAXDETAIL_ID,
            "SIZES_UNIT_ID": ItemsMain.SIZES_UNIT_ID,
            "QUATITY_UNIT_ID": ItemsMain.QUATITY_UNIT_ID,
            "VOLUMN_UNIT_ID": ItemsMain.VOLUMN_UNIT_ID,
            "REMAIN_SIZES_UNIT_ID": ItemsMain.REMAIN_SIZES_UNIT_ID,
            "REMAIN_QUATITY_UNIT_ID": ItemsMain.REMAIN_QUATITY_UNIT_ID,
            "REMAIN_VOLUMN_UNIT_ID": ItemsMain.REMAIN_VOLUMN_UNIT_ID,
            "PRODUCT_GROUP_CODE": ItemsMain.PRODUCT_GROUP_CODE == null ? "" : ItemsMain
                .PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": ItemsMain.PRODUCT_GROUP_NAME == null ? "" : ItemsMain
                .PRODUCT_GROUP_NAME,
            "PRODUCT_CATEGORY_CODE": ItemsMain.PRODUCT_CATEGORY_CODE == null
                ? ""
                : ItemsMain.PRODUCT_CATEGORY_CODE,
            "PRODUCT_CATEGORY_NAME": ItemsMain.PRODUCT_CATEGORY_NAME == null
                ? ""
                : ItemsMain.PRODUCT_CATEGORY_NAME,
            "PRODUCT_TYPE_CODE": ItemsMain.PRODUCT_TYPE_CODE == null ? "" : ItemsMain
                .PRODUCT_TYPE_CODE,
            "PRODUCT_TYPE_NAME": ItemsMain.PRODUCT_TYPE_NAME == null ? "" : ItemsMain
                .PRODUCT_TYPE_NAME,
            "PRODUCT_SUBTYPE_CODE": ItemsMain.PRODUCT_SUBTYPE_CODE == null ? "" : ItemsMain
                .PRODUCT_SUBTYPE_CODE,
            "PRODUCT_SUBTYPE_NAME": ItemsMain.PRODUCT_SUBTYPE_NAME == null ? "" : ItemsMain
                .PRODUCT_SUBTYPE_NAME,
            "PRODUCT_SUBSETTYPE_CODE": ItemsMain.PRODUCT_SUBSETTYPE_CODE == null
                ? ""
                : ItemsMain.PRODUCT_SUBSETTYPE_CODE,
            "PRODUCT_SUBSETTYPE_NAME": ItemsMain.PRODUCT_SUBSETTYPE_NAME == null
                ? ""
                : ItemsMain.PRODUCT_SUBSETTYPE_NAME,
            "PRODUCT_BRAND_CODE": ItemsMain.PRODUCT_BRAND_CODE == null ? "" : ItemsMain
                .PRODUCT_BRAND_CODE,
            "PRODUCT_BRAND_NAME_TH": ItemsMain.PRODUCT_BRAND_NAME_TH == null
                ? ""
                : ItemsMain.PRODUCT_BRAND_NAME_TH,
            "PRODUCT_BRAND_NAME_EN": ItemsMain.PRODUCT_BRAND_NAME_EN == null
                ? ""
                : ItemsMain.PRODUCT_BRAND_NAME_EN,
            "PRODUCT_SUBBRAND_CODE": ItemsMain.PRODUCT_SUBBRAND_CODE == null
                ? ""
                : ItemsMain.PRODUCT_SUBBRAND_CODE,
            "PRODUCT_SUBBRAND_NAME_TH": ItemsMain.PRODUCT_SUBBRAND_NAME_TH == null
                ? ""
                : ItemsMain.PRODUCT_SUBBRAND_NAME_TH,
            "PRODUCT_SUBBRAND_NAME_EN": ItemsMain.PRODUCT_SUBBRAND_NAME_EN == null
                ? ""
                : ItemsMain.PRODUCT_SUBBRAND_NAME_EN,
            "PRODUCT_MODEL_CODE": ItemsMain.PRODUCT_MODEL_CODE == null ? "" : ItemsMain
                .PRODUCT_MODEL_CODE,
            "PRODUCT_MODEL_NAME_TH": ItemsMain.PRODUCT_MODEL_NAME_TH == null
                ? ""
                : ItemsMain.PRODUCT_MODEL_NAME_TH,
            "PRODUCT_MODEL_NAME_EN": ItemsMain.PRODUCT_MODEL_NAME_EN == null
                ? ""
                : ItemsMain.PRODUCT_MODEL_NAME_EN,
            "IS_TAX_VALUE": ItemsMain.IS_TAX_VALUE,
            "TAX_VALUE": ItemsMain.TAX_VALUE,
            "IS_TAX_VOLUMN": ItemsMain.IS_TAX_VOLUMN,
            "TAX_VOLUMN": ItemsMain.TAX_VOLUMN,
            "TAX_VOLUMN_UNIT": ItemsMain.TAX_VOLUMN_UNIT,
            "LICENSE_PLATE": ItemsMain.LICENSE_PLATE,
            "ENGINE_NO": ItemsMain.ENGINE_NO,
            "CHASSIS_NO": ItemsMain.CHASSIS_NO,
            "PRODUCT_DESC": ItemsMain.PRODUCT_DESC,
            "SUGAR": ItemsMain.SUGAR,
            "CO2": ItemsMain.CO2,
            "DEGREE": ItemsMain.DEGREE,
            "PRICE": ItemsMain.PRICE,
            "SIZES": ItemsMain.SIZES,
            "SIZES_UNIT": ItemsMain.SIZES_UNIT,
            "QUANTITY": ItemsMain.QUANTITY,
            "QUANTITY_UNIT": ItemsMain.QUANTITY_UNIT,
            "VOLUMN": ItemsMain.VOLUMN,
            "VOLUMN_UNIT": ItemsMain.VOLUMN_UNIT,
            "REMAIN_SIZES": ItemsMain.REMAIN_SIZES,
            "REMAIN_SIZES_UNIT": ItemsMain.REMAIN_SIZES_UNIT,
            "REMAIN_QUANTITY": ItemsMain.REMAIN_QUANTITY,
            "REMAIN_QUANTITY_UNIT": ItemsMain.REMAIN_QUANTITY_UNIT,
            "REMAIN_VOLUMN": ItemsMain.REMAIN_VOLUMN,
            "REMAIN_VOLUMN_UNIT": ItemsMain.REMAIN_VOLUMN_UNIT,
            "REMARK": ItemsMain.REMARK == null ? "" : ItemsMain.REMARK,
            "REMAIN_REMARK": ItemsMain.REMAIN_REMARK,
            "PRODUCT_RESULT": ItemsMain.PRODUCT_RESULT,
            "SCIENCE_RESULT_DESC": ItemsMain.SCIENCE_RESULT_DESC,
            "VAT": ItemsMain.VAT,
            "IS_DOMESTIC": ItemsMain.IS_DOMESTIC,
            "IS_ILLEGAL": ItemsMain.IS_ILLEGAL,
            "IS_SCIENCE": ItemsMain.IS_SCIENCE,
            "IS_PROVE": 1,
            "IS_ACTIVE": 1
          }
        ];
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
      }


    }catch(e){
      print("error : "+e.toString());

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
        ItemsMain.TAX_VALUE = editTaxValue.text.isEmpty
            ? 0.0
            : double.parse(editTaxValue.text.replaceAll(",", ""));
        ItemsMain.TAX_VOLUMN_UNIT = dropdownValueTaxUnit != null
            ? dropdownValueTaxUnit.UNIT_NAME_TH.toString()
            : "";
        ItemsMain.TAX_VOLUMN = editTaxUnit.text.isEmpty
            ? 0.0
            : double.parse(editTaxUnit.text.replaceAll(",", ""));
        ItemsMain.PRICE = editTaxRetailPrice.text.isEmpty
            ? ItemsMain.PRICE
            : double.parse(editTaxRetailPrice.text.replaceAll(",", ""));
        ItemsMain.CO2 = editTaxVolumnCo2.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnCo2.text.replaceAll(",", ""));
        ItemsMain.SUGAR = editTaxVolumnSugar.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnSugar.text.replaceAll(",", ""));
        ItemsMain.DEGREE = editTaxVolumnAlcohol.text.isEmpty
            ? 0.0
            : double.parse(editTaxVolumnAlcohol.text.replaceAll(",", ""));

        ItemsMain.REMAIN_QUANTITY = editRemainingEvidenceCount.text.isEmpty
            ? 0.0
            : double.parse(editRemainingEvidenceCount.text.replaceAll(",", ""));
        ItemsMain.REMAIN_QUANTITY_UNIT =
        dropdownValueRemainingEvidenceCountUnit != null
            ? dropdownValueRemainingEvidenceCountUnit.UNIT_NAME_TH
            : "";
        ItemsMain.REMAIN_VOLUMN = editRemainingEvidenceVolumn.text.isEmpty
            ? 0.0
            : double.parse(editRemainingEvidenceVolumn.text.replaceAll(",", ""));
        ItemsMain.REMAIN_VOLUMN_UNIT =
        dropdownValueRemainingEvidenceVolumnUnit != null
            ? dropdownValueRemainingEvidenceVolumnUnit.SIZE_NAME_TH
            : "";
        ItemsMain.REMARK = editRemainingEvidenceComment.text;

        ItemsMain.VAT = VAT_TOTAL;
        ItemsMain.PRODUCT_RESULT = editProveDescription.text;
        ItemsMain.IS_SCIENCE = IsProve ? 1 : 0;
        ItemsMain.SCIENCE_RESULT_DESC =
        IsProve ? editLabResult.text : "";
        ItemsMain.IS_PROVE = true;


        ItemsMain.itemsListDocument = _arrItemsImageFile;


        _onSaved = true;
        _onFinish = true;
      });
    }
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }
  Future<bool> onLoadActionUpdate(List<Map> map_pro) async {
    for(int i=0;i<map_pro.length;i++){
      await new ProveFuture().apiRequestProveProductupdByCon(map_pro[i]).then((onValue) {
        print("Update Product ["+i.toString()+"] : " + onValue.Msg);
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
        "DOCUMENT_NAME": ItemsMain.PRODUCT_MAPPING_ID.toString()+"_"+ItemsMain.PRODUCT_GROUP_ID.toString()+"_"+ItemsMain.PRODUCT_CATEGORY_ID.toString()+"_"+index.toString(),
        "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "5",
        "FILE_TYPE": "jpg",
        "FOLDER": "Person",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": ItemsMain.PRODUCT_ID,
        "CONTENT":base64Image
      });
    });
    for(int i=0;i<_arrJsonImg.length;i++){
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
        print("Update Add ["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
      });
    }

    for(int i=0;i<_arrItemsImageFileDelete.length;i++){
      Map map ={
        "DOCUMENT_ID":_arrItemsImageFileDelete[i]
      };
      await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
        print("Delete ["+i.toString()+"] : "+onValue.Msg.toString());
      });
    }

    Map map={
      "PRODUCT_ID": ItemsMain.PRODUCT_ID
    };
    await new ProveFuture()
        .apiRequestProveProductgetByProductId(map)
        .then((onValue) {
      ItemsMain = onValue;
    });

    map = {
      "DOCUMENT_TYPE": 5,
      "REFERENCE_CODE": ItemsMain.PRODUCT_ID
    };

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item){
        if(int.parse(item.IS_ACTIVE)==1){
          items.add(item);
        }
      });
      List<ItemsListDocument> itemsDoc = [];
      items.forEach((f){
        File _file = new File(f.DOCUMENT_OLD_NAME);
        itemsDoc.add(new ItemsListDocument(
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
      _arrItemsImageFile = itemsDoc;
    });


    _onSaved = true;
    _onFinish = true;

    _arrItemsImageFileAdd=[];
    _arrItemsImageFileDelete=[];

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
        _setinitData();
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

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: Text("รายละเอียดพิสูจน์ของกลาง",
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
        ),
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
                        'ILG60_B_03_00_06_00', style: textStylePageName,),
                    )
                  ],
                ),*/
                  ),
                  Expanded(
                    child: new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SingleChildScrollView(
                        child: _onSaved ? _buildContent_saved() : _buildContent(),
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
}

