class ItemsListArrestIndictmentDetail {
  final int INDICTMENT_DETAIL_ID;
  final int INDICTMENT_ID;
  final int LAWBREAKER_ID;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;

  ItemsListArrestIndictmentDetail({
    this.INDICTMENT_DETAIL_ID,
    this.INDICTMENT_ID,
    this.LAWBREAKER_ID,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
  });

  factory ItemsListArrestIndictmentDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestIndictmentDetail(
      INDICTMENT_DETAIL_ID: js['INDICTMENT_DETAIL_ID'],
      INDICTMENT_ID: js['INDICTMENT_ID'],
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      TITLE_SHORT_NAME_TH: js['TITLE_SHORT_NAME_TH']==null?"":js['TITLE_SHORT_NAME_TH'],
      FIRST_NAME: js['FIRST_NAME']==null?"":js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME']==null?"":js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
    );
  }
}