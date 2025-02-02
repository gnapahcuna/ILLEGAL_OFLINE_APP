
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';

import 'evidence_staff.dart';

class ItemsEvidenceArrest {
  final String ARREST_CODE;
  final int PROVE_ID;
  final String PROVE_NO;
  final int PROVE_IS_OUTSIDE;
  final String OCCURRENCE_DATE;
  final String OCCURRENCE_TIME;
  final int ARREST_STAFF_ID;
  final String ARREST_STAFF_TITLE_SHORT_NAME_TH;
  final String ARREST_STARFF_FIRST_NAME;
  final String ARREST_STARFF_LAST_NAME;
  final String ARREST_STARFF_OPREATION_POS_NAME;
  final String ARREST_STARFF_OPERATION_OFFICE_NAME;
  final String ARREST_STARFF_OPERATION_OFFICE_SHORT_NAME;
  final int SUB_DISTRICT_ID;
  final String SUB_DISTRICT_NAME_TH;
  final int DISTRICT_ID;
  final String DISTRICT_NAME_TH;
  final int PROVINCE_ID;
  final String PROVINCE_NAME_TH;
  final int LAWSUIT_ID;
  final String LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final int LAWSUIT_IS_OUTSIDE;
  final String LAWSUIT_DATE;
  final String LAWSUIT_TIME;
  final int INDICTMENT_ID;
  final int SUBSECTION_RULE_ID;
  final String SUBSECTION_ID;
  final String SUBSECTION_NO;
  final int GUILTBASE_ID;
  final String GUILTBASE_NAME;
  final String SECTION_ID;
  final String PENALTY_DESC;
  final String DELIVERY_DOC_NO_1;
  final String DELIVERY_DOC_NO_2;
  final String DELIVERY_DATE;
  final String DELIVERY_TIME;
  final String RECEIVER_TITLE_NAME;
  final String RECEIVER_FIRST_NAME;
  final String RECEIVER_LAST_NAME;
  final String RECEIVER_POSITION_NAME;
  final String RECEIVER_OFFICE_NAME;
  final String RECEIVER_OFFICE_SHORT_NAME;

  ItemsEvidenceArrest({
    this.ARREST_CODE,
    this.PROVE_ID,
    this.PROVE_NO,
    this.PROVE_IS_OUTSIDE,
    this.OCCURRENCE_DATE,
    this.OCCURRENCE_TIME,
    this.ARREST_STAFF_ID,
    this.ARREST_STAFF_TITLE_SHORT_NAME_TH,
    this.ARREST_STARFF_FIRST_NAME,
    this.ARREST_STARFF_LAST_NAME,
    this.ARREST_STARFF_OPREATION_POS_NAME,
    this.ARREST_STARFF_OPERATION_OFFICE_NAME,
    this.ARREST_STARFF_OPERATION_OFFICE_SHORT_NAME,
    this.SUB_DISTRICT_ID,
    this.SUB_DISTRICT_NAME_TH,
    this.DISTRICT_ID,
    this.DISTRICT_NAME_TH,
    this.PROVINCE_ID,
    this.PROVINCE_NAME_TH,
    this.LAWSUIT_ID,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_IS_OUTSIDE,
    this.LAWSUIT_DATE,
    this.LAWSUIT_TIME,
    this.INDICTMENT_ID,
    this.SUBSECTION_RULE_ID,
    this.SUBSECTION_ID,
    this.SUBSECTION_NO,
    this.GUILTBASE_ID,
    this.GUILTBASE_NAME,
    this.SECTION_ID,
    this.PENALTY_DESC,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.DELIVERY_DATE,
    this.DELIVERY_TIME,
    this.RECEIVER_TITLE_NAME,
    this.RECEIVER_FIRST_NAME,
    this.RECEIVER_LAST_NAME,
    this.RECEIVER_POSITION_NAME,
    this.RECEIVER_OFFICE_NAME,
    this.RECEIVER_OFFICE_SHORT_NAME,
  });

  factory ItemsEvidenceArrest.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceArrest(
      ARREST_CODE: json['ARREST_CODE'],
      PROVE_ID: json['PROVE_ID'],
      PROVE_NO: json['PROVE_NO'],
      PROVE_IS_OUTSIDE: json['PROVE_IS_OUTSIDE'],
      OCCURRENCE_DATE: json['OCCURRENCE_DATE'],
      OCCURRENCE_TIME: json['OCCURRENCE_TIME'],
      ARREST_STAFF_ID: json['ARREST_STAFF_ID'],
      ARREST_STAFF_TITLE_SHORT_NAME_TH: json['ARREST_STAFF_TITLE_SHORT_NAME_TH'],
      ARREST_STARFF_FIRST_NAME: json['ARREST_STARFF_FIRST_NAME'],
      ARREST_STARFF_LAST_NAME: json['ARREST_STARFF_LAST_NAME'],
      ARREST_STARFF_OPREATION_POS_NAME: json['ARREST_STARFF_OPREATION_POS_NAME'],
      ARREST_STARFF_OPERATION_OFFICE_NAME: json['ARREST_STARFF_OPERATION_OFFICE_NAME'],
      ARREST_STARFF_OPERATION_OFFICE_SHORT_NAME: json['ARREST_STARFF_OPERATION_OFFICE_SHORT_NAME'],
      SUB_DISTRICT_ID: json['SUB_DISTRICT_ID'],
      SUB_DISTRICT_NAME_TH: json['SUB_DISTRICT_NAME_TH'],
      DISTRICT_ID: json['DISTRICT_ID'],
      DISTRICT_NAME_TH: json['DISTRICT_NAME_TH'],
      PROVINCE_ID: json['PROVINCE_ID'],
      PROVINCE_NAME_TH: json['PROVINCE_NAME_TH'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_IS_OUTSIDE: json['LAWSUIT_IS_OUTSIDE'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      LAWSUIT_TIME: json['LAWSUIT_TIME'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SUBSECTION_NO: json['SUBSECTION_NO'],
      GUILTBASE_ID: json['GUILTBASE_ID'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      SECTION_ID: json['SECTION_ID'],
      PENALTY_DESC: json['PENALTY_DESC'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      DELIVERY_DATE: json['DELIVERY_DATE'],
      DELIVERY_TIME: json['DELIVERY_TIME'],
      RECEIVER_TITLE_NAME: json['RECEIVER_TITLE_NAME'],
      RECEIVER_FIRST_NAME: json['RECEIVER_FIRST_NAME'],
      RECEIVER_LAST_NAME: json['RECEIVER_LAST_NAME'],
      RECEIVER_POSITION_NAME: json['RECEIVER_POSITION_NAME'],
      RECEIVER_OFFICE_NAME: json['RECEIVER_OFFICE_NAME'],
      RECEIVER_OFFICE_SHORT_NAME: json['RECEIVER_OFFICE_SHORT_NAME'],
    );
  }
}