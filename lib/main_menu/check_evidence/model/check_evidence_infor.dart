import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence.dart';

class ItemsCheckEvidenceInformationChecked{
  String Number;
  String ReturnDate;
  String ReturnTime;
  String Person;
  String Stock;
  List<ItemsEvidence> Evidences;

  ItemsCheckEvidenceInformationChecked(
      this.Number,
      this.ReturnDate,
      this.ReturnTime,
      this.Person,
      this.Stock,
      this.Evidences
      );
}