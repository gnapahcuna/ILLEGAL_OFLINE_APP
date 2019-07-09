import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/item_lawsuit_payment.dart';

class ItemsListServiceUATResponse {
  final String ResponseCode;
  final String ResponseMessage;
  final ItemsListFactoryInfo ResponseData;

  ItemsListServiceUATResponse({
    this.ResponseCode,
    this.ResponseMessage,
    this.ResponseData,
  });
  factory ItemsListServiceUATResponse.fromJson(Map<String, dynamic> js) {
    return ItemsListServiceUATResponse(
      ResponseCode: js['ResponseCode'],
      ResponseMessage: js['ResponseMessage'],
      ResponseData: ItemsListFactoryInfo.fromJson(js['ResponseData']),
    );
  }
}
class ItemsListFactoryInfo {
  final String NewregId;
  final FirstName;
  final String Name;
  final String Pin;
  final List<ItemsListAddress> Address;

  ItemsListFactoryInfo({
    this.NewregId,
    this.FirstName,
    this.Name,
    this.Pin,
    this.Address,
  });
  factory ItemsListFactoryInfo.fromJson(Map<String, dynamic> js) {
    return ItemsListFactoryInfo(
      NewregId: js['NewregId'],
      FirstName: js['FirstName'],
      Name: js['Name'],
      Pin: js['Pin'],
      Address: List<ItemsListAddress>.from(js['Address'].map((m) => ItemsListAddress.fromJson(m))),
    );
  }
}

class ItemsListAddress {
  final String BuildingName;
  final String RoomIdentifier;
  final String FloorIdentifier;
  final String VillageName;
  final String MooIdentifier;
  final String SoiName;
  final String StreetName;
  final String SubDistrictCode;

  ItemsListAddress({
    this.BuildingName,
    this.RoomIdentifier,
    this.FloorIdentifier,
    this.VillageName,
    this.MooIdentifier,
    this.SoiName,
    this.StreetName,
    this.SubDistrictCode,
  });

  factory ItemsListAddress.fromJson(Map<String, dynamic> js) {
    return ItemsListAddress(
      BuildingName: js['BuildingName'],
      RoomIdentifier: js['RoomIdentifier'],
      FloorIdentifier: js['FloorIdentifier'],
      VillageName: js['VillageName'],
      MooIdentifier: js['MooIdentifier'],
      SoiName: js['SoiName'],
      StreetName: js['StreetName'],
      SubDistrictCode: js['SubDistrictCode'],
    );
  }
}