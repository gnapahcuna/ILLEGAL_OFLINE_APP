import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsLawsuitNotice {
  int NOTICE_ID;
  int ARREST_ID;

  ItemsLawsuitNotice({
    this.NOTICE_ID,
    this.ARREST_ID,
  });

  factory ItemsLawsuitNotice.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitNotice(
        NOTICE_ID: json['NOTICE_ID'],
        ARREST_ID: json['ARREST_ID'],
    );
  }
}