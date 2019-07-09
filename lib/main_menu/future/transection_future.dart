import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/proof_case/accept_case/model/response/item_lawsuit_response.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;

import 'item_service_uat.dart';
import 'item_transection_item.dart';

class TransectionFuture{
  TransectionFuture() : super();

  Future<List<ItemsListTransection>> apiRequestTransactionRunninggetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterCompare + "/TransactionRunninggetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListTransection.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunninginsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterCompare + "/TransactionRunninginsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressMasterCompare + "/TransactionRunningupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  //Transection Item
  Future<List<ItemsListTransectionItem>> apiRequestTransactionRunningItemgetByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressEvidence + "/TransactionRunningItemgetByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListTransectionItem.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningIteminsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressEvidence + "/TransactionRunningIteminsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestTransactionRunningItemupdByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressEvidence + "/TransactionRunningItemupdByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<TestImageResponse> apiRequestDocumentinsAll(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressDocument+ "/DocumentinsAll",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return TestImageResponse.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<List<ItemsListDocument>> apiRequestGetDocumentByCon(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressDocument+ "/GetDocumentByCon",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsListDocument.fromJson(m))
          .toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<ItemsArrestResponseMessage> apiRequestDocumentupdDelete(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressDocument+ "/DocumentupdDelete",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsArrestResponseMessage.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<String> apiRequestArrestReport(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_03_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_03_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<String> apiRequestArrestReportTest(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_03_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_03_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  file.path;
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_04_001(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_04_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_04_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<String> apiRequestILG60_00_04_002(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_04_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_04_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<String> apiRequestILG60_00_06_004(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_06_004.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_004.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_06_001(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_06_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_06_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  Future<String> apiRequestILG60_00_05_001(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_05_001.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_001.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<String> apiRequestILG60_00_05_002(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_05_002.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_002.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }
  Future<String> apiRequestILG60_00_05_003(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressReport+"/ILG60_00_05_003.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var dir = await getApplicationDocumentsDirectory();
      String tempPath = dir.path;
      File file = new File('$tempPath/ILG60_00_05_003.pdf');
      await file.writeAsBytes(response.bodyBytes);

      return  response.statusCode.toString();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }


  Future<ItemsListServiceUATResponse> apiRequestEDRestServicesUAT(Map jsonMap) async {
    //encode Map to JSON
    var body =  utf8.encode(json.encode(jsonMap));
    final response = await http.post(
      serv
          .Server()
          .IPAddressServiceReg+"/EDRestServicesUAT/reg/Reg0200.aspx",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      //return ItemsListServiceUATResponse.fromJson(json.decode(response.body));
      return ItemsListServiceUATResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }



}
class TestImageResponse {
  bool success;
  String msg;
  int DOCUMENT_ID;

  TestImageResponse({
    this.success,
    this.msg,
    this.DOCUMENT_ID,
  });

  factory TestImageResponse.fromJson(Map<String, dynamic> js) {
    return TestImageResponse(
        success: js['success'],
        msg: js['imageFile'],
        DOCUMENT_ID: js['DOCUMENT_ID']
    );
  }
}