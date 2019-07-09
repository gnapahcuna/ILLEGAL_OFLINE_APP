import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_detail.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_product.dart';

class ItemsListArrestIndictment {
  int INDICTMENT_ID;
  int GUILTBASE_ID;
  String GUILTBASE_NAME;
  String FINE;
  int IS_PROVE;
  int IS_COMPARE;
  String SUBSECTION_NAME;
  String SUBSECTION_DESC;
  String SECTION_NAME;
  String PENALTY_DESC;
  List ArrestIndictmentProduct;
  List ArrestIndictmentDetail;
  ItemsListArrest6Controller Arrest6Controller;

  ItemsListArrestIndictment({
    this.INDICTMENT_ID,
    this.GUILTBASE_ID,
    this.GUILTBASE_NAME,
    this.FINE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.SUBSECTION_NAME,
    this.SUBSECTION_DESC,
    this.SECTION_NAME,
    this.PENALTY_DESC,
    this.ArrestIndictmentDetail,
    this.ArrestIndictmentProduct,
    this.Arrest6Controller,
  });

  factory ItemsListArrestIndictment.fromJson(Map<String, dynamic> json) {
    return ItemsListArrestIndictment(
        INDICTMENT_ID: json['INDICTMENT_ID'],
        GUILTBASE_ID: json['GUILTBASE_ID'],
        GUILTBASE_NAME: json['GUILTBASE_NAME'],
        FINE: json['FINE'],
        IS_PROVE: json['IS_PROVE'],
        IS_COMPARE: json['IS_COMPARE'],
        SUBSECTION_NAME: json['SUBSECTION_NAME'],
        SUBSECTION_DESC: json['SUBSECTION_DESC'],
        SECTION_NAME: json['SECTION_NAME'],
        PENALTY_DESC: json['PENALTY_DESC'],
        ArrestIndictmentDetail: List.from(
            json['ArrestIndictmentDetail'].map((m) =>
                ItemsListArrestIndictmentDetail.fromJson(m))),
        ArrestIndictmentProduct: List.from(
            json['ArrestIndictmentProduct'].map((m) =>
                ItemsListArrestIndictmentProduct.fromJson(m))),
    );
  }
}