import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsProveLawsuitStaff {
  final String LAWSUIT_STAFF_NAME;
  final String LAWSUIT_STAFF_OPREATION_POS_NAME;
  final String LAWSUIT_STAFF_OPERATION_OFFICE_NAME;
  final int CONTRIBUTOR_ID;

  ItemsProveLawsuitStaff({
    this.LAWSUIT_STAFF_NAME,
    this.LAWSUIT_STAFF_OPREATION_POS_NAME,
    this.LAWSUIT_STAFF_OPERATION_OFFICE_NAME,
    this.CONTRIBUTOR_ID,
  });

  factory ItemsProveLawsuitStaff.fromJson(Map<String, dynamic> json) {
    return ItemsProveLawsuitStaff(
      LAWSUIT_STAFF_NAME: json['LAWSUIT_STAFF_NAME'],
      LAWSUIT_STAFF_OPREATION_POS_NAME: json['LAWSUIT_STAFF_OPREATION_POS_NAME'],
      LAWSUIT_STAFF_OPERATION_OFFICE_NAME: json['LAWSUIT_STAFF_OPERATION_OFFICE_NAME'],
      CONTRIBUTOR_ID: json['CONTRIBUTOR_ID'],
    );
  }
}