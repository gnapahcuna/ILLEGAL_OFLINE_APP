import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main_menu/arrest/future/arrest_future.dart';
import 'main_menu/arrest/future/arrest_future_master.dart';
import 'main_menu/arrest/model/item_arrest_6_section.dart';
import 'main_menu/arrest/model/master/item_master_response.dart';
import 'main_menu/arrest/model/master/item_title.dart';
import 'offline_mode/Database.dart';

class OfflineSettingPage extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<OfflineSettingPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter SQLite"),
        actions: <Widget>[
          RaisedButton(
            child: Text('Del All'),
            onPressed: (){
              DBProvider.db.deleteAllMasTitle();
              DBProvider.db.deleteAllMasNationality();
              DBProvider.db.deleteAllMasRace();
              DBProvider.db.deleteAllMasDivisionRate();
            },
          )
        ],
      ),
      body: FutureBuilder<List<ItemsListTitle>>(
        future: DBProvider.db.getAllClientsMasTitle(),
        builder: (BuildContext context, AsyncSnapshot<List<ItemsListTitle>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ItemsListTitle item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteClientMasTitle(item.TITLE_ID);
                  },
                  child: ListTile(
                    title: Text(item.TITLE_NAME_TH),
                    leading: Text(item.TITLE_ID.toString()),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          /*Client rnd = testClients[math.Random().nextInt(testClients.length)];
          await DBProvider.db.newClient(rnd);
          setState(() {

          });*/
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CupertinoActivityIndicator(
                  ),
                );
              });
          Map map = {"TEXT_SEARCH": ""};
          await onLoadAction(map);
          Navigator.pop(context);
        },
      ),
    );
  }

  List<ItemsListArrest6Section> itemsMasterGuiltBase=[];
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsMasterProductGroupResponse itemsMasterProductGroup;

  ItemsMasterTitleResponse itemsMasTitle;
  ItemsMasNationalityResponse itemsMasNationality;
  ItemsMasRaceResponse itemsMasRace;
  ItemsMasterDivisionRateResponse itemsMasterDivisionRate;

  ItemsMasterCountryResponse itemsMasterCountry;
  ItemsMasterProvinceResponse itemsMasterProvince;
  ItemsMasterDistictResponse itemsMasterDistict;
  ItemsMasterSubDistictResponse itemsMasterSubDistict;

  Future<bool> onLoadAction(Map map) async {
    //**************>>Start Request Data From Server <<*****************************
    //get Guiltbase
    await new ArrestFuture().apiRequestArrestMasGuiltbasegetByKeyword(map).then((onValue) {
      itemsMasterGuiltBase  = onValue;
    });
    //get ProductUnit
    await ArrestFutureMaster().apiRequestMasProductUnitgetByKeyword(map).then((onValue) {
      itemsMasProductUnit  = onValue;
    });
    //get ProductGroup
    await ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
      itemsMasterProductGroup  = onValue;
    });
    //get Title
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map).then((onValue) {
      itemsMasTitle  = onValue;
    });
    //get National
    await ArrestFutureMaster().apiRequestMasNationalitygetByCon(map).then((onValue) {
      itemsMasNationality  = onValue;
    });
    //get Race
    await ArrestFutureMaster().apiRequestMasRacegetByCon(map).then((onValue) {
      print(onValue.RESPONSE_DATA.length);
      itemsMasRace  = onValue;
    });
    //get DivisionRate
    await ArrestFutureMaster().apiRequestMasDivisionRategetByCon(map).then((onValue) {
      itemsMasterDivisionRate  = onValue;
    });
    //get Country
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map).then((onValue) {
      itemsMasterCountry  = onValue;
    });
    //get Province
    await ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      itemsMasterProvince  = onValue;
    });
    //get District
    await ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      print(onValue.RESPONSE_DATA.length);
      itemsMasterDistict  = onValue;
    });
    //get SubDistrict
    await ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      itemsMasterSubDistict  = onValue;
    });
    //**************>>End Request Data From Server <<*****************************


    //**************>>Start Add to Local_Storage <<*****************************
    //add GuiltBase
    /*for(int i=0;i<itemsMasterGuiltBase.length;i++){
      await DBProvider.db.newClientMasGuiltBase(itemsMasterGuiltBase[i]);
    }*/
    //add ProductUnit
    for(int i=0;i<itemsMasProductUnit.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasProductUnit(itemsMasProductUnit.RESPONSE_DATA[i]);
    }
    //add ProductGroup
    for(int i=0;i<itemsMasterProductGroup.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasProductGroup(itemsMasterProductGroup.RESPONSE_DATA[i]);
    }
    //add Title
    for(int i=0;i<itemsMasTitle.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasTitle(itemsMasTitle.RESPONSE_DATA[i]);
    }
    //add Nationality
    for(int i=0;i<itemsMasNationality.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasNationality(itemsMasNationality.RESPONSE_DATA[i]);
    }
    //add Race
    for(int i=0;i<itemsMasRace.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasRace(itemsMasRace.RESPONSE_DATA[i]);
    }
    //add DivisionRate
    for(int i=0;i<itemsMasterDivisionRate.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasDivisionRate(itemsMasterDivisionRate.RESPONSE_DATA[i]);
    }
    //add Country
    for(int i=0;i<itemsMasterCountry.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasCountry(itemsMasterCountry.RESPONSE_DATA[i]);
    }
    //add Province
    for(int i=0;i<itemsMasterProvince.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasProvince(itemsMasterProvince.RESPONSE_DATA[i]);
    }
    //add Distict
    for(int i=0;i<itemsMasterDistict.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasDistrict(itemsMasterDistict.RESPONSE_DATA[i]);
    }
    //add SubDistict
    for(int i=0;i<itemsMasterSubDistict.RESPONSE_DATA.length;i++){
      await DBProvider.db.newClientMasSubDistrict(itemsMasterSubDistict.RESPONSE_DATA[i]);
    }
    //**************>>End Add to Local_Storage <<*****************************

    Navigator.pop(context);
    setState(() {});
    return true;
  }
}