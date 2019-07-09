import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_lawsuit_staff.dart';

class ItemsProveArrest {

  final int ARREST_ID;
  final String ARREST_CODE;
  final String ARREST_DATE;
  final String RECEIVE_OFFICE_NAME;
  final int INDICTMENT_ID;
  final String ARREST_STAFF_NAME;
  final String ARREST_STAFF_OPREATION_POS_NAME;
  final int GROUP_SECTION_SECTION_ID;
  final String GUILTBASE_NAME;
  final int PENALTY_SECTION_ID;
  final String PENALTY_DESC;
  final int LAWSUIT_ID;
  final String LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final String LAWSUIT_DATE;
  final String LAWSUIT_DATE_TIME;
  final String DELIVERY_DOC_NO_1;
  final String DELIVERY_DOC_NO_2;
  final List<ItemsProveLawsuitStaff> ProveLawsuitStaff;

  ItemsProveArrest({
    this.ARREST_ID,
    this.ARREST_CODE,
    this.ARREST_DATE,
    this.RECEIVE_OFFICE_NAME,
    this.INDICTMENT_ID,
    this.ARREST_STAFF_NAME,
    this.ARREST_STAFF_OPREATION_POS_NAME,
    this.GROUP_SECTION_SECTION_ID,
    this.GUILTBASE_NAME,
    this.PENALTY_SECTION_ID,
    this.PENALTY_DESC,
    this.LAWSUIT_ID,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,
    this.LAWSUIT_DATE_TIME,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.ProveLawsuitStaff,
  });

  factory ItemsProveArrest.fromJson(Map<String, dynamic> json) {
    return ItemsProveArrest(
      ARREST_ID: json['ARREST_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      ARREST_DATE: json['ARREST_DATE'],
      RECEIVE_OFFICE_NAME: json['RECEIVE_OFFICE_NAME'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      ARREST_STAFF_NAME: json['ARREST_STAFF_NAME'],
      ARREST_STAFF_OPREATION_POS_NAME: json['ARREST_STAFF_OPREATION_POS_NAME'],
      GROUP_SECTION_SECTION_ID: json['GROUP_SECTION_SECTION_ID'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      PENALTY_SECTION_ID: json['PENALTY_SECTION_ID'],
      PENALTY_DESC: json['PENALTY_DESC'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      LAWSUIT_DATE_TIME: json['LAWSUIT_DATE_TIME'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      ProveLawsuitStaff: List<ItemsProveLawsuitStaff>.from(json['ProveLawsuitStaff'].map((m) => ItemsProveLawsuitStaff.fromJson(m))),
    );
  }
}