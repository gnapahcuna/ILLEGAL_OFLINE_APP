import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/evidence_search_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_get_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';

import 'model/compare_arrest_main.dart';
import 'model/compare_evidence_controller.dart';
import 'model/compare_guiltbase_fine.dart';
import 'model/compare_indicment_detail.dart';
import 'model/compare_map_fine_detail.dart';
import 'model/compare_prove_product.dart';

final formatterint = new NumberFormat("#,###");
final formatter = new NumberFormat("#,###.00");
final formattertax = new NumberFormat("#,###.0000");

final FocusNode myFocusPresidentCommittee = FocusNode();
TextEditingController editPresidentCommittee = new TextEditingController();

class CompareDetailFineScreenFragment extends StatefulWidget {
  ItemsCompareListIndicmentDetail indicmentDetail;
  ItemsCompareArrestMain itemsCompareArrestMain;
  ItemsCompareGuiltbaseFine itemsCompareGuiltbaseFine;
  CompareDetailFineScreenFragment({
    Key key,
    @required this.indicmentDetail,
    @required this.itemsCompareArrestMain,
    @required this.itemsCompareGuiltbaseFine,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CompareDetailFineScreenFragment>
    with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  bool Checkedboxna = false;

  List<ItemsListEvidenceGetStaff> itemsListEvidenceStaff = [];
  ItemsEvidenceMain itemMain;

  ItemsCompareArrestMain ItemsMain;

  //ยอดชำระสุทธิ
  double _totalPayment;

  TextStyle textStyleLabel = TextStyle(
      fontSize: 16,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = TextStyle(
      fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily,
      fontSize: 12.0);
  TextStyle styleTextAppbar =
      TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  TextStyle TitleStyle = TextStyle(
    fontSize: 16.0,
  );
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

  double fine_total = 0;
  @override
  void initState() {
    super.initState();

    _onSaved = widget.indicmentDetail.IsDetailFineComplete;
    _onFinish = widget.indicmentDetail.IsDetailFineComplete;

    setState(() {
      ItemsMain = widget.itemsCompareArrestMain;

      _totalPayment = 0.0;
      ItemsMain.CompareProveProduct.forEach((item) {
        //item.Controller.
        setInitDataTextField(item, widget.itemsCompareGuiltbaseFine.FINE_RATE);
        _totalPayment += fine_total;
      });
    });
  }

  setInitDataTextField(ItemsCompareListProveProduct item, double fine_rate) {
    //ค่าปรับสุทธิ
    //set text
    item.Controller.editTaxValue.text = item.VAT.toString();
    if (ItemsMain.FINE_TYPE == 0 ||
        ItemsMain.FINE_TYPE == 1 ||
        ItemsMain.FINE_TYPE == 2) {
      fine_total = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
    } else {
      fine_total = item.VAT * fine_rate;
    }
    item.Controller.editTaxValueDouble.text =
        formatterint.format(fine_rate).toString();
    item.Controller.editPayment.text = fine_total.toString();
    item.Controller.editFineValue.text =
        formatter.format(fine_total).toString();
  }

  @override
  void dispose() {
    super.dispose();

    /*ItemsMain.Evidenses.forEach((item){
      item.EvidenceTaxValues.expController.dispose();
      item.EvidenceTaxValues.editTaxValueDouble.dispose();
    });*/
  }

  void clearTextfield() {
    editPresidentCommittee.clear();
  }

  Widget _buildContent() {
    var size = MediaQuery.of(context).size;

    _totalPayment = 0;
    ItemsMain.CompareProveProduct.forEach((f) {
      _totalPayment += double.parse(f.Controller.editPayment.text);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: ItemsMain.CompareProveProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Stack(
                    children: <Widget>[
                      _buildExpandableContent(index),
                    ],
                  ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Column(
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
                                            Checkedboxna = !Checkedboxna;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            color: Checkedboxna
                                                ? Color(0xff3b69f3)
                                                : Colors.white,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black38),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Checkedboxna
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
                                        "ปรับผิดจากบัญชี",
                                        style: textStyleLabel,
                                      ),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Column(
                                  children: <Widget>[
                                    Checkedboxna
                                        ? Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "ผู้มีอำนาจ",
                                                  style: textStyleLabel,
                                                  textAlign: TextAlign.left,
                                                ),
                                                Container(
                                                  padding: paddingLabel,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      new Container(
                                                        //padding: paddingData,
                                                        child: TextField(
                                                          enableInteractiveSelection:
                                                              false,
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            _navigateSearchStaff(
                                                                context, 38);
                                                            //
                                                          },
                                                          focusNode:
                                                              myFocusPresidentCommittee,
                                                          controller:
                                                              editPresidentCommittee,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          style: textStyleData,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            //prefixIcon: Icon(Icons.search),
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
                                          )
                                        : Container(
                                            child: Text(""),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 44.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "รวมยอดชำระ",
                      style: textStyleLabel,
                    ),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      _totalPayment.toString() + "\t\t\t\t\tบาท",
                      style: textStyleData,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _buildExpandableContent(int index) {
    double fine_value = 0;
    if (ItemsMain.FINE_TYPE == 0 ||
        ItemsMain.FINE_TYPE == 1 ||
        ItemsMain.FINE_TYPE == 2) {
      fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
    } else {
      fine_value = ItemsMain.CompareProveProduct[index].VAT *
          widget.itemsCompareGuiltbaseFine.FINE_RATE;
    }

    var size = MediaQuery.of(context).size;
    Widget _buildExpanded(index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,
                ),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_BRAND_NAME_TH
                      .toString() +
                  " / " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_MODEL_NAME_TH
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "มาตรา",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.SUBSECTION_NAME.toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "อัตราโทษ",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.PENALTY_DESC.toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "จำนวครั้งกระทำผิด",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              /*ItemsMain.Offenses.length.toString()*/ "Unknow",
              style: textStyleData,
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
                      child: Text(
                        "มูลค่าภาษี",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.CompareProveProduct[index]
                              .Controller.editTaxValue,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                        "จำนวนค่าปรับเท่า",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: ItemsMain.CompareProveProduct[index]
                            .Controller.myFocusNodeTaxValueDouble,
                        controller: ItemsMain.CompareProveProduct[index]
                            .Controller.editTaxValueDouble,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (String text) {
                          double ble = double.parse(text);
                          if (text.isEmpty) {
                            setState(() {
                              ble = 0;
                              if (ItemsMain.FINE_TYPE == 0 ||
                                  ItemsMain.FINE_TYPE == 1 ||
                                  ItemsMain.FINE_TYPE == 2) {
                                fine_total = widget
                                    .itemsCompareGuiltbaseFine.FINE_AMOUNT;
                              } else {
                                fine_total =
                                    ItemsMain.CompareProveProduct[index].VAT *
                                        ble;
                              }

                              ItemsMain.CompareProveProduct[index].Controller
                                  .editFineValue.text = fine_total.toString();
                              ItemsMain.CompareProveProduct[index].Controller
                                  .editPayment.text = fine_total.toString();
                            });
                            return;
                          }
                          setState(() {
                            if (ItemsMain.FINE_TYPE == 0 ||
                                ItemsMain.FINE_TYPE == 1 ||
                                ItemsMain.FINE_TYPE == 2) {
                              fine_total =
                                  widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
                            } else {
                              fine_total =
                                  ItemsMain.CompareProveProduct[index].VAT *
                                      ble;
                            }

                            ItemsMain.CompareProveProduct[index].Controller
                                .editFineValue.text = fine_total.toString();
                            ItemsMain.CompareProveProduct[index].Controller
                                .editPayment.text = fine_total.toString();
                          });
                        },
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
                        "ค่าปรับสุทธิ",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.CompareProveProduct[index]
                              .Controller.editFineValue,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                        "ยอดชำระ",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.CompareProveProduct[index]
                              .Controller.editPayment,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget _buildCollapsed(int index) {
      double fine_value = 0;
      if (ItemsMain.FINE_TYPE == 0 ||
          ItemsMain.FINE_TYPE == 1 ||
          ItemsMain.FINE_TYPE == 2) {
        fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
      } else {
        fine_value = ItemsMain.CompareProveProduct[index].VAT *
            widget.itemsCompareGuiltbaseFine.FINE_RATE;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,
                ),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_BRAND_NAME_TH
                      .toString() +
                  " / " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_MODEL_NAME_TH
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ยอดชำระ",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              fine_value.toString(),
              style: textStyleData,
            ),
          ),
        ],
      );
    }

    return ExpandableNotifier(
      controller: ItemsMain.CompareProveProduct[index].Controller.expController,
      child: Stack(
        children: <Widget>[
          Expandable(
              collapsed: _buildCollapsed(index),
              expanded: _buildExpanded(index)),
          Align(
            alignment: Alignment.topRight,
            child: Builder(builder: (context) {
              var exp = ExpandableController.of(context);
              return IconButton(
                icon: Icon(
                  exp.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 32.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  exp.toggle();
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildLine() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 80) / 100;

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
  }

  Widget _buildExpandableContent_saved(int index) {
    double fine_value = 0;
    if (ItemsMain.FINE_TYPE == 0 ||
        ItemsMain.FINE_TYPE == 1 ||
        ItemsMain.FINE_TYPE == 2) {
      fine_value = widget.itemsCompareGuiltbaseFine.FINE_AMOUNT;
    } else {
      fine_value = ItemsMain.CompareProveProduct[index].VAT *
          widget.itemsCompareGuiltbaseFine.FINE_RATE;
    }

    var size = MediaQuery.of(context).size;
    Widget _buildExpanded(index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,
                ),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_BRAND_NAME_TH
                      .toString() +
                  " / " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_MODEL_NAME_TH
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ยอดชำระ",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.CompareProveProduct[index].Controller.Total.toString(),
              style: textStyleData,
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
                      child: Text(
                        "มูลค่าภาษี",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.CompareProveProduct[index].Controller.TaxValue
                            .toString(),
                        style: textStyleData,
                      ),
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
                        "จำนวนค่าปรับเท่า",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain
                            .CompareProveProduct[index].Controller.FineValue
                            .toString(),
                        style: textStyleData,
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
                        "ค่าปรับสุทธิ",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.CompareProveProduct[index].Controller.Payment
                            .toString(),
                        style: textStyleData,
                      ),
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
                        "ยอดชำระ",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.CompareProveProduct[index].Controller.Total
                            .toString(),
                        style: textStyleData,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget _buildCollapsed(int index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,
                ),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_GROUP_NAME
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_BRAND_NAME_TH
                      .toString() +
                  " / " +
                  ItemsMain.CompareProveProduct[index].PRODUCT_MODEL_NAME_TH
                      .toString(),
              style: textStyleData,
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ยอดชำระ",
              style: textStyleLabel,
            ),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.CompareProveProduct[index].Controller.Total.toString(),
              style: textStyleData,
            ),
          ),
        ],
      );
    }

    return ExpandableNotifier(
      controller: ItemsMain.CompareProveProduct[index].Controller.expController,
      child: Stack(
        children: <Widget>[
          Expandable(
              collapsed: _buildCollapsed(index),
              expanded: _buildExpanded(index)),
          Align(
            alignment: Alignment.topRight,
            child: Builder(builder: (context) {
              var exp = ExpandableController.of(context);
              return IconButton(
                icon: Icon(
                  exp.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 32.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  exp.toggle();
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildContent_saved() {
    var size = MediaQuery.of(context).size;

    _totalPayment = 0;
    ItemsMain.CompareProveProduct.forEach((f) {
      _totalPayment += f.Controller.Total;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: ItemsMain.CompareProveProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              /*return Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Stack(
                    children: <Widget>[

                      Align(
                        alignment: Alignment.topRight,
                        child: Builder(
                            builder: (context) {
                              return IconButton(
                                icon: Icon(Icons.keyboard_arrow_down, size: 32.0,
                                  color: Colors.grey,),
                              );
                            }
                        ),
                      )
                    ],
                  )
              );*/
              return Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Stack(
                    children: <Widget>[
                      _buildExpandableContent_saved(index),
                    ],
                  ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 44.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "รวมยอดชำระ",
                      style: textStyleLabel,
                    ),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      _totalPayment.toString() + "\t\t\t\t\tบาท",
                      style: textStyleData,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  void _showCheckedEmptyAlertDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context, text);
      },
    );
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext, text) {
    TextStyle TitleStyle =
        TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(
        color: Colors.blue,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            text,
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onSaved() async {
    bool hasChange = false;
    ItemsMain.CompareProveProduct.forEach((item) {
      if(double.parse(item.Controller.editTaxValueDouble.text)!=widget.itemsCompareGuiltbaseFine.FINE_RATE){
        hasChange=true;
      }
    });

    if (editPresidentCommittee.text.isEmpty && Checkedboxna == true&&hasChange) {
      _showCheckedEmptyAlertDialog(
          context, 'กรุณากรอกชื่อผู้มีอำนาจหากทำการเเก้ไขข้อมูล');
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          });
      await onLoadAction();
      Navigator.pop(context);

      setState(() {
        _onSaved = true;
        _onFinish = true;

        widget.indicmentDetail.IsDetailFineComplete = true;

        double sum_total = 0;
        ItemsMain.CompareProveProduct.forEach((item) {
          item.Controller.TaxValue = double.parse(
              item.Controller.editTaxValue.text.replaceAll(",", ""));
          item.Controller.FineValue = double.parse(
              item.Controller.editTaxValueDouble.text.replaceAll(",", ""));
          item.Controller.Payment = double.parse(
              item.Controller.editFineValue.text.replaceAll(",", ""));
          item.Controller.Total = double.parse(
              item.Controller.editPayment.text.replaceAll(",", ""));
          sum_total += item.Controller.Total;
        });
        widget.indicmentDetail.FINE_TOTAL = sum_total;

        ItemsCompareMapFineDetail itemsCompareMapFineDetail =
            new ItemsCompareMapFineDetail(
                itemsCompareListIndicmentDetail: widget.indicmentDetail,
                itemsListEvidenceGetStaff: itemsListEvidenceStaff.length > 0
                    ? itemsListEvidenceStaff[0]
                    : null);

        //Navigator.pop(context, widget.indicmentDetail);
        Navigator.pop(context, itemsCompareMapFineDetail);

        //เปลี่ยนสถานะเป็น active
        /*ItemsMain.IsActive=true;

      ItemsMain.Descriptions = new ItemsEvidenceDescription(
          30,
          1,
          3000,
          dropdownValueTaxUnit,
          0,
          0,
          0,
          1220.0000,
          149.0001,
          22,
          dropdownValueRemainingEvidenceCountUnit,
          500,
          dropdownValueRemainingEvidenceVolumnUnit,
          editRemainingEvidenceComment.text,
          editProveDescription.text,
          editLabResult.text,
          _arrItemsImageFile
      );*/
      });
    }
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }

  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการยกเลิกข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(mContext, "Back");
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
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
            title: Text(
              "รายละเอียดค่าปรับ",
              style: styleTextAppbar,
            ),
            actions: <Widget>[
              _onSaved
                  ? (_onSave
                      ? new FlatButton(
                          onPressed: () {
                            setState(() {
                              _onSaved = true;
                              _onSave = false;
                              _onEdited = false;
                            });
                            //TabScreenArrest1().createAcceptAlert(context);
                          },
                          child: Text('บันทึก', style: appBarStyle))
                      : PopupMenuButton<Constants>(
                          onSelected: choiceAction,
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (BuildContext context) {
                            return constants.map((Constants contants) {
                              return PopupMenuItem<Constants>(
                                value: contants,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        contants.icon,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(contants.text,
                                          style: TextStyle(
                                              fontFamily:
                                                  FontStyles().FontFamily)),
                                    )
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ))
                  : new FlatButton(
                      onPressed: () {
                        onSaved();
                      },
                      child: Text('บันทึก', style: appBarStyle)),
            ],
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  if (_onSaved) {
                    Navigator.pop(context, "Back");
                  } else {
                    _showCancelAlertDialog(context);
                  }
                }),
          ),
        ),
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
                    )),
                /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_04_00_06_00', style: textStylePageName,),
                    )
                  ],
                ),*/
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _onSaved ? _buildContent_saved() : _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateSearchStaff(BuildContext context, int CONTRIBUTOR_ID) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TabScreenSearchStaff(CONTRIBUTOR_ID: CONTRIBUTOR_ID)),
    );

    if (result.toString() != "back") {
      var Item = result;
      /*if (_onEdited) {
        if (itemMain.EvidenceInStaff.length > 0) {
          for(int i=0;i<itemMain.EvidenceInStaff.length;i++){
            if (Item.CONTRIBUTOR_ID == itemMain.EvidenceInStaff[i].CONTRIBUTOR_ID) {
              itemMain.EvidenceInStaff[i]=Item;
            }
          }
        }
        print(itemMain.EvidenceInStaff.length);
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
      }*/
      if (itemsListEvidenceStaff.length > 0) {
        if (itemsListEvidenceStaff
                .where((food) => food.CONTRIBUTOR_ID == (Item.CONTRIBUTOR_ID))
                .toList()
                .length >
            0) {
          for (int i = 0; i < itemsListEvidenceStaff.length; i++) {
            if (Item.CONTRIBUTOR_ID ==
                itemsListEvidenceStaff[i].CONTRIBUTOR_ID) {
              itemsListEvidenceStaff[i] = Item;
            }
          }
        } else {
          itemsListEvidenceStaff.add(Item);
        }
      } else {
        itemsListEvidenceStaff.add(Item);
      }

      print(itemsListEvidenceStaff.length);
      editPresidentCommittee.text = get_staff_name(itemsListEvidenceStaff, 38);
    }
  }

  String get_staff_name(var Items, int CONTRIBUTOR_ID) {
    String name;
    Items.forEach((item) {
      if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
        name =
            item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " + item.LAST_NAME;
      }
    });
    return name;
  }
}

class Constants {
  const Constants({this.text, this.icon});

  final String text;
  final IconData icon;
}

const List<Constants> constants = const <Constants>[
  const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
];
