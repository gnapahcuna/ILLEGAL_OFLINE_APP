import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_payment.dart';

class ItemsListLawsuitDetail {
  int LAWSUIT_DETAIL_ID;
  int LAWSUIT_ID;
  int INDICTMENT_DETAIL_ID;
  int COURT_ID;
  int LAWSUIT_TYPE;
  int LAWSUIT_END;
  String COURT_NAME;
  int UNDECIDE_NO_1;
  String UNDECIDE_NO_YEAR_1;
  int DECIDE_NO_1;
  String DECIDE_NO_YEAR_1;
  int UNDECIDE_NO_2;
  String UNDECIDE_NO_YEAR_2;
  int DECIDE_NO_2;
  String DECIDE_NO_YEAR_2;
  int JUDGEMENT_NO;
  String JUDGEMENT_NO_YEAR;
  String JUDGEMENT_DATE;
  int IS_IMPRISON;
  double IMPRISON_TIME;
  int IMPRISON_TIME_UNIT;
  int IS_FINE;
  double FINE;
  int IS_PAYONCE;
  String FINE_DATE;
  int PAYMENT_PERIOD;
  int PAYMENT_PERIOD_DUE;
  int PAYMENT_PERIOD_DUE_UNIT;
  int IS_ACTIVE;
  List<ItemsListLawsuitPayment> LawsuitPayment;

  ItemsListLawsuitDetail({
    this.LAWSUIT_DETAIL_ID,
    this.LAWSUIT_ID,
    this.INDICTMENT_DETAIL_ID,
    this.COURT_ID,
    this.LAWSUIT_TYPE,
    this.LAWSUIT_END,
    this.COURT_NAME,
    this.UNDECIDE_NO_1,
    this.UNDECIDE_NO_YEAR_1,
    this.DECIDE_NO_1,
    this.DECIDE_NO_YEAR_1,
    this.UNDECIDE_NO_2,
    this.UNDECIDE_NO_YEAR_2,
    this.DECIDE_NO_2,
    this.DECIDE_NO_YEAR_2,
    this.JUDGEMENT_NO,
    this.JUDGEMENT_NO_YEAR,
    this.JUDGEMENT_DATE,
    this.IS_IMPRISON,
    this.IMPRISON_TIME,
    this.IMPRISON_TIME_UNIT,
    this.IS_FINE,
    this.FINE,
    this.IS_PAYONCE,
    this.FINE_DATE,
    this.PAYMENT_PERIOD,
    this.PAYMENT_PERIOD_DUE,
    this.PAYMENT_PERIOD_DUE_UNIT,
    this.IS_ACTIVE,
    this.LawsuitPayment,
  });

  factory ItemsListLawsuitDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListLawsuitDetail(
      LAWSUIT_DETAIL_ID: js['LAWSUIT_DETAIL_ID'],
      LAWSUIT_ID: js['LAWSUIT_ID'],
      INDICTMENT_DETAIL_ID: js['INDICTMENT_DETAIL_ID'],
      COURT_ID: js['COURT_ID'],
      LAWSUIT_TYPE: js['LAWSUIT_TYPE'],
      LAWSUIT_END: js['LAWSUIT_END'],
      COURT_NAME:js['COURT_NAME'],
      UNDECIDE_NO_1:js['UNDECIDE_NO_1'],
      UNDECIDE_NO_YEAR_1:js['UNDECIDE_NO_YEAR_1'],
      DECIDE_NO_1:js['DECIDE_NO_1'],
      DECIDE_NO_YEAR_1:js['DECIDE_NO_YEAR_1'],
      UNDECIDE_NO_2:js['UNDECIDE_NO_2'],
      UNDECIDE_NO_YEAR_2:js['UNDECIDE_NO_YEAR_2'],
      DECIDE_NO_2:js['DECIDE_NO_2'],
      DECIDE_NO_YEAR_2:js['DECIDE_NO_YEAR_2'],
      JUDGEMENT_NO:js['JUDGEMENT_NO'],
      JUDGEMENT_NO_YEAR:js['JUDGEMENT_NO_YEAR'],
      JUDGEMENT_DATE:js['JUDGEMENT_DATE'],
      IS_IMPRISON:js['IS_IMPRISON'],
      IMPRISON_TIME:js['IMPRISON_TIME'],
      IMPRISON_TIME_UNIT:js['IMPRISON_TIME_UNIT'],
      IS_FINE:js['IS_FINE'],
      FINE:js['FINE'],
      IS_PAYONCE:js['IS_PAYONCE'],
      FINE_DATE:js['FINE_DATE'],
      PAYMENT_PERIOD:js['PAYMENT_PERIOD'],
      PAYMENT_PERIOD_DUE:js['PAYMENT_PERIOD_DUE'],
      PAYMENT_PERIOD_DUE_UNIT:js['PAYMENT_PERIOD_DUE_UNIT'],
      IS_ACTIVE:js['IS_ACTIVE'],
      LawsuitPayment: List.from(js['LawsuitPayment'].map((m) => ItemsListLawsuitPayment.fromJson(m))),

    );
  }
}