import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_payment.dart';

class ItemsListCompareID {
  final int COMPARE_ID;
  final int LAWSUIT_ID;

  ItemsListCompareID({
    this.COMPARE_ID,
    this.LAWSUIT_ID,
  });

  factory ItemsListCompareID.fromJson(Map<String, dynamic> js) {
    return ItemsListCompareID(
      COMPARE_ID: js['COMPARE_ID'],
      LAWSUIT_ID: js['LAWSUIT_ID'],
    );
  }
}