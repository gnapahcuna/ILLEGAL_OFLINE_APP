import 'dart:convert';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class PersonNetFuture{
  PersonNetFuture() : super();

  Future<ItemsListPersonNetMain> apiRequestPersonDetailgetByPersonId(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv
          .Server()
          .IPAddressPersonNet + "/PersonDetailgetByPersonId",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      return ItemsListPersonNetMain.fromJson(json.decode(response.body));
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

}