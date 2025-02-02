import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class EvidenceInventoryList {
  final String REPRESENT_OFFICE_CODE;
  final String REPRESENT_OFFICE_NAME;
  final String EVIDENCE_IN_ITEM_CODE;
  final String PRODUCT_DESC;
  final double BALANCE_QTY;
  final String BALANCE_QTY_UNIT;
  final int EVIDENCE_IN_TYPE;
  final String DELIVERY_NO;
  final String TITLE_NAME_TH;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String REPRESENT_POS_NAME;
  final int CONTRIBUTOR_ID;
  ItemsCheckEvidenceDetailController ItemsController;
  bool IsCkecked;

  EvidenceInventoryList({
    this.REPRESENT_OFFICE_CODE,
    this.REPRESENT_OFFICE_NAME,
    this.EVIDENCE_IN_ITEM_CODE,
    this.PRODUCT_DESC,
    this.BALANCE_QTY,
    this.BALANCE_QTY_UNIT,
    this.EVIDENCE_IN_TYPE,
    this.DELIVERY_NO,
    this.TITLE_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.REPRESENT_POS_NAME,
    this.CONTRIBUTOR_ID,
    this.ItemsController,
    this.IsCkecked
  });

  factory EvidenceInventoryList.fromJson(Map<String, dynamic> json) {
    return EvidenceInventoryList(
      REPRESENT_OFFICE_CODE: json['REPRESENT_OFFICE_CODE'],
      REPRESENT_OFFICE_NAME: json['REPRESENT_OFFICE_NAME'],
      EVIDENCE_IN_ITEM_CODE: json['EVIDENCE_IN_ITEM_CODE'],
      PRODUCT_DESC: json['PRODUCT_DESC'],
      BALANCE_QTY: json['BALANCE_QTY'],
      BALANCE_QTY_UNIT: json['BALANCE_QTY_UNIT'],
      EVIDENCE_IN_TYPE: json['EVIDENCE_IN_TYPE'],
      DELIVERY_NO: json['DELIVERY_NO'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      FIRST_NAME: json['FIRST_NAME'],
      LAST_NAME: json['LAST_NAME'],
      REPRESENT_POS_NAME: json['REPRESENT_POS_NAME'],
      CONTRIBUTOR_ID: json['CONTRIBUTOR_ID'],
        ItemsController: new ItemsCheckEvidenceDetailController(
          new ExpandableController(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          null,
          null,
          null,
          null,),
        IsCkecked: false
    );
  }
}