
class ItemsListPersonNetLawbreakerDetail {
  final int ARREST_ID;
  final String ARREST_CODE;
  final int LAWSUIT_NO;
  final String OCCURRENCE_DATE;
  final int SECTION_ID;
  final String GUILTBASE_NAME;
  final String LOCALE_ADDRESS;
  final String PRODUCT_GROUP_NAME;
  final String ARREST_STAFF_NAME;
  final String ARREST_STAFF_OFFICE_NAME;
  final String LAWSUIT_STAFF_NAME;
  final String LAWSUIT_STAFF_OFFICE_NAME;
  final int PAYMENT_FINE;

  ItemsListPersonNetLawbreakerDetail({
    this.ARREST_ID,
    this.ARREST_CODE,
    this.LAWSUIT_NO,
    this.OCCURRENCE_DATE,
    this.SECTION_ID,
    this.GUILTBASE_NAME,
    this.LOCALE_ADDRESS,
    this.PRODUCT_GROUP_NAME,
    this.ARREST_STAFF_NAME,
    this.ARREST_STAFF_OFFICE_NAME,
    this.LAWSUIT_STAFF_NAME,
    this.LAWSUIT_STAFF_OFFICE_NAME,
    this.PAYMENT_FINE,
  });

  factory ItemsListPersonNetLawbreakerDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetLawbreakerDetail(
      ARREST_ID: js['ARREST_ID'],
      ARREST_CODE: js['ARREST_CODE'],
      LAWSUIT_NO: js['LAWSUIT_NO'],
      OCCURRENCE_DATE: js['OCCURRENCE_DATE'],
      SECTION_ID: js['SECTION_ID'],
      GUILTBASE_NAME: js['GUILTBASE_NAME'],
      LOCALE_ADDRESS: js['LOCALE_ADDRESS'],
      PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
      ARREST_STAFF_NAME: js['ARREST_STAFF_NAME'],
      ARREST_STAFF_OFFICE_NAME: js['ARREST_STAFF_OFFICE_NAME'],
      LAWSUIT_STAFF_NAME: js['LAWSUIT_STAFF_NAME'],
      LAWSUIT_STAFF_OFFICE_NAME: js['LAWSUIT_STAFF_OFFICE_NAME'],
      PAYMENT_FINE: js['PAYMENT_FINE'],
    );
  }
}