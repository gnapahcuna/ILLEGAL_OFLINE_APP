import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_type.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_creating.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest5Add extends StatefulWidget {
  bool IsSearch;
  bool IsUpdate;
  ItemsMasterProductGroupResponse ItemsProductGroup;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  TabScreenArrest5Add({
    Key key,
    @required this.IsSearch,
    @required this.IsUpdate,
    @required this.ItemsProductGroup,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _TabScreenArrest5AddState createState() => new _TabScreenArrest5AddState();
}
class _TabScreenArrest5AddState extends State<TabScreenArrest5Add> {
  List _itemsData = [];

  final FocusNode myFocusNodeMainBrand = FocusNode();
  final FocusNode myFocusNodeSecondaryBrand = FocusNode();
  final FocusNode myFocusNodeProductModel = FocusNode();
  //final FocusNode myFocusNodeCapacity = FocusNode();

  TextEditingController editMainBrand = new TextEditingController();
  TextEditingController editSecondaryBrand = new TextEditingController();
  TextEditingController editProductModel = new TextEditingController();
  //TextEditingController editCapacity = new TextEditingController();

  /*List<String> dropdownItemsUnit = ["ขวด", 'ลัง'];
  List<String> dropdownItemsSubProductType = [];
  List<String> dropdownItemsSubSetProductType = [];*/

  ItemsMasterProductCategoryResponse ItemsProductCategory;
  ItemsMasterProductTypeResponse ItemsProductType;
  //ItemsMasterProductSubTypeResponse ItemsProductSubType;
  //ItemsMasterProductSubSetTypeResponse ItemsProductSubSetType;

  ItemsListProductGroup sProductGroup;
  ItemsListProductCategory sProductCategory;
  ItemsListProductType sProductType;
  //ItemsListProductSubType sProductSubType;
  //ItemsListProductSubSetType sProductSubSetType;


  String dropdownValueUnit = "ขวด";
  String dropdownValueSubProductType;
  String dropdownValueSubSetProductType;

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white,fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color:  Color(0xff087de1),fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0, color: Colors.grey[400],fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  @override
  void initState() {
    super.initState();
    if(widget.ItemsProductGroup.RESPONSE_DATA.length>0) {
      //sProductGroup = widget.ItemsProductGroup.RESPONSE_DATA[0];
    }
    //this.onLoadActionProuductCategoryMaster(widget.ItemsProductGroup.RESPONSE_DATA[0].PRODUCT_GROUP_ID);
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 85) / 100;
    return Container(
      height: size.height,
        decoration: BoxDecoration(
            //color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
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
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                Map map = {
                                  "TEXT_SEARCH" : editMainBrand.text
                                };
                                _navigateSearch(context,map);
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

  Widget _buildInput() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมวดหมู่สินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ItemsListProductGroup>(
              isExpanded: true, //
              value: sProductGroup,
              onChanged: (ItemsListProductGroup newValue) {
                setState(() {
                  sProductGroup = newValue;
                  _onSelectProductGroup(sProductGroup.PRODUCT_GROUP_ID);

                  sProductType=null;
                  sProductCategory=null;
                });
              },
              items: widget.ItemsProductGroup.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListProductGroup>>((
                  ItemsListProductGroup value) {
                return DropdownMenuItem<ItemsListProductGroup>(
                  value: value,
                  child: Text(value.PRODUCT_GROUP_NAME, style: textInputStyle,),
                );
              })
                  .toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "กลุ่มสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: ItemsProductCategory != null ? DropdownButton<ItemsListProductCategory>(
              isExpanded: true, //
              value: sProductCategory,
              onChanged: (ItemsListProductCategory newValue) {
                setState(() {
                  sProductCategory = newValue;
                  _onSelectProductCategory(sProductCategory.PRODUCT_CATEGORY_ID);
                });
              },
              items: ItemsProductCategory.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListProductCategory>>((
                  ItemsListProductCategory value) {
                return DropdownMenuItem<ItemsListProductCategory>(
                  value: value,
                  child: Text(value.PRODUCT_CATEGORY_NAME, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel,
              child: Container(),),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ประเภทสินค้า", style: textLabelStyle,),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: ItemsProductType != null ? DropdownButton<ItemsListProductType>(
              isExpanded: true, //
              value: sProductType,
              onChanged: (ItemsListProductType newValue) {
                setState(() {
                  sProductType = newValue;
                  //_onSelectProductType(sProductType.PRODUCT_TYPE_ID);
                });
              },
              items: ItemsProductType.RESPONSE_DATA
                  .map<DropdownMenuItem<ItemsListProductType>>((
                  ItemsListProductType value) {
                return DropdownMenuItem<ItemsListProductType>(
                  value: value,
                  child: Text(value.PRODUCT_TYPE_NAME, style: textInputStyle,),
                );
              })
                  .toList(),
            ) : Container(
              padding: paddingLabel,
              child: Container(),),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ยี่ห้อหลักสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup==null?false:true,
            focusNode: myFocusNodeMainBrand,
            controller: editMainBrand,
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
          child: Text("ยี่ห้อรองสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup==null?false:true,
            focusNode: myFocusNodeSecondaryBrand,
            controller: editSecondaryBrand,
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
          child: Text("รุ่นสินค้า", style: textLabelStyle,),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            enabled: sProductGroup==null?false:true,
            focusNode: myFocusNodeProductModel,
            controller: editProductModel,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
      ],
    );
  }

  _navigateSearch(BuildContext context,Map map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadActionProuductProductMappingMaster(map);
    Navigator.pop(context);

    if(_itemsData.length>0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabScreenArrest5Search(
          IsSearch: widget.IsSearch,
          IsUpdate: widget.IsUpdate,
          itemProductMapping: _itemsData,
          itemsMasProductSize: widget.itemsMasProductSize,
          itemsMasProductUnit: widget.itemsMasProductUnit,
        )),
      );
      if(result.toString()!="back"){
        _itemsData = result;
        Navigator.pop(context,result);
      }
    }else{
      new EmptyDialog(context,"ไม่พบข้อมูลของกลาง");
    }
  }

  _navigateCreate(BuildContext mContext)async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(builder: (context) =>
          TabScreenArrest5Creating(
            ItemsProductGroup: widget.ItemsProductGroup,
          )),
    );
    if (result.toString() != "back") {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //
      }, child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text("ค้นหาของกลาง",
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
          /*actions: <Widget>[
            widget.IsSearch? new FlatButton(
              onPressed: () {
                _navigateCreate(context);
              },
              child: Text("สร้าง",
                style: styleTextAppbar,
              ),
            ):Container(),
          ],*/
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
                      //color: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_20_00',
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
                      )
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

  void _onSelectProductGroup(int PRODUCT_GROUP_ID)async{
    await onLoadActionProuductCategoryMaster(PRODUCT_GROUP_ID);
  }
  void _onSelectProductCategory(int PRODUCT_CATEGORY_ID)async{
    await onLoadActionProuductTypeMaster(PRODUCT_CATEGORY_ID);
  }
  /*void _onSelectProductType(int PRODUCT_TYPE_ID)async{
    await onLoadActionProuductSubTypeMaster(PRODUCT_TYPE_ID);
  }
  void _onSelectProductSubType(int PRODUCT_SUBTYPE_ID)async{
    await onLoadActionProuductSubSetTypeMaster(PRODUCT_SUBTYPE_ID);
  }*/

  Future<bool> onLoadActionProuductCategoryMaster(int PRODUCT_GROUP_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_GROUP_ID": PRODUCT_GROUP_ID,
      "PRODUCT_CATEGORY_ID": ""
    };

    await new ArrestFutureMaster().apiRequestMasProductCategorygetByCon(map).then((onValue) {
      ItemsProductCategory = onValue;
      print(ItemsProductCategory.RESPONSE_DATA[0].PRODUCT_CATEGORY_ID);
      this.onLoadActionProuductTypeMaster(onValue.RESPONSE_DATA[0].PRODUCT_CATEGORY_ID);
    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionProuductTypeMaster(int PRODUCT_CATEGORY_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_CATEGORY_ID": PRODUCT_CATEGORY_ID,
      "PRODUCT_TYPE_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductTypegetByCon(map).then((onValue) {
      ItemsProductType = onValue;
      //this.onLoadActionProuductSubTypeMaster(onValue.RESPONSE_DATA[0].PRODUCT_TYPE_ID);
    });
    setState(() {});
    return true;
  }
  /*Future<bool> onLoadActionProuductSubTypeMaster(int PRODUCT_TYPE_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_TYPE_ID": PRODUCT_TYPE_ID,
      "PRODUCT_SUBTYPE_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductSubTypegetByCon(map).then((onValue) {
      ItemsProductSubType = onValue;
      this.onLoadActionProuductSubSetTypeMaster(onValue.RESPONSE_DATA[0].PRODUCT_SUBTYPE_ID);
    });
    setState(() {});
    return true;
  }
  Future<bool> onLoadActionProuductSubSetTypeMaster(int PRODUCT_SUBTYPE_ID) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PRODUCT_SUBTYPE_ID": PRODUCT_SUBTYPE_ID,
      "PRODUCT_SUBSETTYPE_ID": ""
    };
    await new ArrestFutureMaster().apiRequestMasProductSubSetTypegetByCon(map).then((onValue) {
      ItemsProductSubSetType = onValue;
      //this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID);
    });
    setState(() {});
    return true;
  }*/

  Future<bool> onLoadActionProuductProductMappingMaster(Map map) async {
    /*Map map = {
      "PRODUCT_GROUP_NAME": sProductGroup==null?"":sProductGroup.PRODUCT_GROUP_NAME,
      "PRODUCT_CATEGORY_NAME": sProductCategory==null?"":sProductCategory.PRODUCT_CATEGORY_NAME,
      "PRODUCT_TYPE_NAME": sProductType==null?"":sProductType.PRODUCT_TYPE_NAME,
      "PRODUCT_BRAND_NAME": editMainBrand.text,
      "PRODUCT_SUBBRAND_NAME": editSecondaryBrand.text,
      "PRODUCT_MODEL_NAME_TH": editProductModel.text,
    };*/
    await new ArrestFutureMaster().apiRequestMasProductMappinggetByKeyword(map).then((onValue) {
      _itemsData = onValue.RESPONSE_DATA;
      //this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID);
    });
    setState(() {});
    return true;
  }
}