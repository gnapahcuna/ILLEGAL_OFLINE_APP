import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/lawsuit_sentence.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/not_accept_case/model/lawsuit_case_information.dart';

class ItemsLawsuitList {
  /*String LawsuitNumber;
  String LawsuitYear;
  String LawsuitDate;
  String LawsuitTime;
  String LawsuitPersonName;
  ItemsLawsuitCaseInformation Informations;
  String LawsuitPlace;
  String LawsuitTestimony;
  String LawsuitCompare;
  bool IsCompare;
  //กรณี
  //bool IsProof;

  ItemsLawsuitMainAcceptCase(
      this.LawsuitNumber,
      this.LawsuitYear,
      this.LawsuitDate,
      this.LawsuitTime,
      this.LawsuitPersonName,
      this.Informations,
      this.LawsuitPlace,
      this.LawsuitTestimony,
      this.LawsuitCompare,
      this.IsCompare,
      //this.IsProof,
      );*/
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  String ARREST_CODE;
  String SECTION_NAME;
  String SUBSECTION_NAME;
  int LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  int INDICTMENT_IS_LAWSUIT_COMPLETE;
  List<ItemsLawsuitListIndicmentDetail> IndicmentDetail;

  ItemsLawsuitList({
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.ARREST_CODE,
    this.SECTION_NAME,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.SUBSECTION_NAME,

    this.INDICTMENT_IS_LAWSUIT_COMPLETE,
    this.IndicmentDetail,
  });

  factory ItemsLawsuitList.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitList(
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      SECTION_NAME: json['SECTION_NAME'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      IndicmentDetail: List.from(
          json['LawsuitArrestIndictmentDetail'].map((m) =>
              ItemsLawsuitListIndicmentDetail.fromJson(m))),
      INDICTMENT_IS_LAWSUIT_COMPLETE: json['INDICTMENT_IS_LAWSUIT_COMPLETE'],
    );
  }
}