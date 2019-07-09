
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';

import 'evidence_staff.dart';

class ItemsEvidenceList {
  final int EVIDENCE_IN_ID;
  final int PROVE_ID;
  final String EVIDENCE_IN_CODE;
  final String EVIDENCE_IN_DATE;
  final String RETURN_DATE;
  final int IS_RECEIVE;
  final String DELIVERY_NO;
  final String DELIVERY_DATE;
  final int EVIDENCE_IN_TYPE;
  final String REMARK;
  final int IS_ACTIVE;
  final int IS_EDIT;
  final List<ItemsEvidenceStaff> EvidenceInStaff;

  ItemsEvidenceList({
    this.EVIDENCE_IN_ID,
    this.PROVE_ID,
    this.EVIDENCE_IN_CODE,
    this.EVIDENCE_IN_DATE,
    this.RETURN_DATE,
    this.IS_RECEIVE,
    this.DELIVERY_NO,
    this.DELIVERY_DATE,
    this.EVIDENCE_IN_TYPE,
    this.REMARK,
    this.IS_ACTIVE,
    this.IS_EDIT,
    this.EvidenceInStaff,
  });

  factory ItemsEvidenceList.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceList(
      EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],
      PROVE_ID: json['PROVE_ID'],
      EVIDENCE_IN_CODE: json['EVIDENCE_IN_CODE'],
      EVIDENCE_IN_DATE: json['EVIDENCE_IN_DATE'],
      RETURN_DATE: json['RETURN_DATE'],
      IS_RECEIVE: json['IS_RECEIVE'],
      DELIVERY_NO: json['DELIVERY_NO'],
      DELIVERY_DATE: json['DELIVERY_DATE'],
      EVIDENCE_IN_TYPE: json['EVIDENCE_IN_TYPE'],
      REMARK: json['REMARK'],
      IS_ACTIVE: json['IS_ACTIVE'],
      IS_EDIT: json['IS_EDIT'],
      EvidenceInStaff: List.from(
          json['EvidenceInStaff'].map((m) =>
              ItemsEvidenceStaff.fromJson(m))),
    );
  }
}