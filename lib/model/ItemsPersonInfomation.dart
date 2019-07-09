class ItemsPersonInformation {
  int STAFF_ID;
  String PersonType;
  int STAFF_TYPE;
  String TITLE_SHORT_NAME_TH;
  String FIRST_NAME;
  String LAST_NAME;
  String PersonENTitle;
  String PersonENName;
  String PersonENSurName;
  String UnderOffCode;
  String UnderOffName;
  int UnderDeptCode;
  String UnderDeptName;
  String WorkOffCode;
  String OPERATION_OFFICE_NAME;
  String OPERATION_OFFICE_SHORT_NAME;
  int WorkDeptCode;
  String WorkDeptName;
  String LinePositionCode;
  String OPREATION_POS_LAVEL_NAME;
  String OPREATION_POS_NAME;
  String ExcPositionCode;
  String ExcPosition;
  String ActingExcPositionCode;
  String ActingExcPosition;
  String EmailAddress;
  String DeptPhoneNo;
  String PersonStatus;
  String ArrestType;
  int CONTRIBUTOR_ID;
  List<String> ArrestTypeItems;

  ItemsPersonInformation({
    this.STAFF_ID,
    this.PersonType,
    this.STAFF_TYPE,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.PersonENTitle,
    this.PersonENName,
    this.PersonENSurName,
    this.UnderOffCode,
    this.UnderOffName,
    this.UnderDeptCode,
    this.UnderDeptName,
    this.WorkOffCode,
    this.OPERATION_OFFICE_NAME,
    this.OPERATION_OFFICE_SHORT_NAME,
    this.WorkDeptCode,
    this.WorkDeptName,
    this.LinePositionCode,
    this.OPREATION_POS_LAVEL_NAME,
    this.OPREATION_POS_NAME,
    this.ExcPositionCode,
    this.ExcPosition,
    this.ActingExcPositionCode,
    this.ActingExcPosition,
    this.EmailAddress,
    this.DeptPhoneNo,
    this.PersonStatus,
    this.CONTRIBUTOR_ID,
    this.ArrestType,
      this.ArrestTypeItems
  });
  factory ItemsPersonInformation.fromJson(Map<String, dynamic> json) {
    return ItemsPersonInformation(
      STAFF_ID: json['PersonID'],
      PersonType: json['PersonType'],
      STAFF_TYPE: 0,
      TITLE_SHORT_NAME_TH: json['PersonTHTitle'],
      FIRST_NAME: json['PersonTHName'],
      LAST_NAME: json['PersonTHSurName'],
      PersonENTitle: json['PersonENTitle'],
      PersonENName: json['PersonENName'],
      PersonENSurName: json['PersonENSurName'],
      UnderOffCode: json['UnderOffCode'],
      UnderOffName: json['UnderOffName'],
      UnderDeptCode: json['UnderDeptCode'],
      UnderDeptName: json['UnderDeptName'],
      WorkOffCode: json['WorkOffCode'],
      OPERATION_OFFICE_NAME: json['WorkOffName'],
      OPERATION_OFFICE_SHORT_NAME: "",
      WorkDeptCode: json['WorkDeptCode'],
      WorkDeptName: json['WorkDeptName'],
      LinePositionCode: json['LinePositionCode'],
      OPREATION_POS_LAVEL_NAME: json['LinePositionLevel'],
      OPREATION_POS_NAME: json['LinePotistion'],
      ExcPositionCode: json['ExcPositionCode'],
      ExcPosition: json['ExcPosition'],
      ActingExcPositionCode: json['ActingExcPositionCode'],
      ActingExcPosition: json['ActingExcPosition'],
      EmailAddress: json['EmailAddress'],
      DeptPhoneNo: json['DeptPhoneNo'],
      PersonStatus: json['PersonStatus'],
      CONTRIBUTOR_ID: 14,
      ArrestType:"ผู้จับกุม",
      ArrestTypeItems:["ผู้จับกุม","ผู้ร่วมจับกุม"],
    );
  }
 /* ItemsPersonInformation(this.STAFF_ID,
      this.PersonType,
      this.STAFF_TYPE,
      this.TITLE_SHORT_NAME_TH,
      this.FIRST_NAME,
      this.LAST_NAME,
      this.PersonENTitle,
      this.PersonENName,
      this.PersonENSurName,
      this.UnderOffCode,
      this.UnderOffName,
      this.UnderDeptCode,
      this.UnderDeptName,
      this.WorkOffCode,
      this.OPERATION_OFFICE_NAME,
      this.OPERATION_OFFICE_SHORT_NAME,
      this.WorkDeptCode,
      this.WorkDeptName,
      this.LinePositionCode,
      this.OPREATION_POS_LAVEL_NAME,
      this.OPREATION_POS_NAME,
      this.ExcPositionCode,
      this.ExcPosition,
      this.ActingExcPositionCode,
      this.ActingExcPosition,
      this.EmailAddress,
      this.DeptPhoneNo,
      this.PersonStatus,
      this.CONTRIBUTOR_ID,
      this.ArrestType,
      this.ArrestTypeItems);*/
}
