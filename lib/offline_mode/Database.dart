import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_country.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_nationality.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_race.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_title.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "exciseLocal.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          //ARREST_MAS_GUILTBASE
          await db.execute("CREATE TABLE ARREST_MAS_GUILTBASE ("
              "GUILTBASE_ID INTEGER PRIMARY KEY,"
              "GUILTBASE_NAME TEXT,"
              "FINE TEXT,"
              "IS_PROVE INTEGER,"
              "IS_COMPARE INTEGER,"
              "SUBSECTION_NAME TEXT,"
              "SUBSECTION_DESC TEXT,"
              "SECTION_NAME TEXT,"
              "PENALTY_DESC TEXT"
              ")");

          //MAS_PRODUCT_UNIT
          await db.execute("CREATE TABLE MAS_PRODUCT_UNIT ("
              "UNIT_ID INTEGER PRIMARY KEY,"
              "UNIT_NAME_TH TEXT,"
              "UNIT_NAME_EN TEXT,"
              "UNIT_SHORT_NAME TEXT"
              ")");

          //MAS_PRODUCT_GROUP
          await db.execute("CREATE TABLE MAS_PRODUCT_GROUP ("
              "PRODUCT_GROUP_ID INTEGER PRIMARY KEY,"
              "PRODUCT_GROUP_CODE TEXT,"
              "PRODUCT_GROUP_NAME TEXT,"
              "IS_ACTIVE INTEGER"
              ")");

          //MAS_TITLE
          await db.execute("CREATE TABLE MAS_TITLE ("
              "TITLE_ID INTEGER PRIMARY KEY,"
              "TITLE_NAME_TH TEXT,"
              "TITLE_NAME_EN TEXT,"
              "TITLE_SHORT_NAME_TH TEXT,"
              "TITLE_SHORT_NAME_EN TEXT,"
              "TITLE_TYPE INTEGER"
              ")");

          //MAS_NATIONALITY
          await db.execute("CREATE TABLE MAS_NATIONALITY ("
              "NATIONALITY_ID INTEGER PRIMARY KEY,"
              "NATIONALITY_NAME_TH TEXT,"
              "NATIONALITY_NAME_EN TEXT,"
              "IS_ACTIVE INTEGER"
              ")");

          //MAS_RACE
          await db.execute("CREATE TABLE MAS_RACE ("
              "RACE_ID INTEGER PRIMARY KEY,"
              "RACE_NAME_TH TEXT,"
              "RACE_NAME_EN TEXT,"
              "IS_ACTIVE INTEGER"
              ")");

          //MAS_DIVISIONRATE
          await db.execute("CREATE TABLE MAS_DIVISIONRATE ("
              "DIVISIONRATE_ID INTEGER PRIMARY KEY,"
              "TREASURY_RATE REAL,"
              "BRIBE_RATE REAL,"
              "REWARD_RATE REAL,"
              "BRIBE_MAX_MONEY TEXT,"
              "REWARD_MAX_MONEY TEXT,"
              "EFFECTIVE_DATE TEXT,"
              "EXPIRE_DATE TEXT,"
              "IS_ACTIVE INTEGER"
              ")");


          //MAS_COUNTRY
          await db.execute("CREATE TABLE MAS_COUNTRY ("
              "COUNTRY_ID INTEGER PRIMARY KEY,"
              "COUNTRY_CODE TEXT,"
              "COUNTRY_NAME_TH TEXT,"
              "COUNTRY_NAME_EN TEXT,"
              "COUNTRY_SHORT_NAME TEXT,"
              "IS_ACTIVE INTEGER"
              ")");

          //MAS_PROVINCE
          await db.execute("CREATE TABLE MAS_PROVINCE ("
              "PROVINCE_ID INTEGER PRIMARY KEY,"
              "COUNTRY_ID INTEGER,"
              "PROVINCE_CODE TEXT,"
              "PROVINCE_NAME_TH TEXT,"
              "PROVINCE_NAME_EN TEXT,"
              "IS_ACTIVE INTEGER,"
              "COUNTRY_NAME_TH TEXT,"
              "COUNTRY_NAME_EN TEXT"
              ")");

          //MAS_DISTRICT
          await db.execute("CREATE TABLE MAS_DISTRICT ("
              "DISTRICT_ID INTEGER PRIMARY KEY,"
              "PROVINCE_ID INTEGER,"
              "DISTRICT_CODE TEXT,"
              "DISTRICT_NAME_TH TEXT,"
              "DISTRICT_NAME_EN TEXT,"
              "IS_ACTIVE INTEGER,"
              "PROVINCE_NAME_TH TEXT,"
              "PROVINCE_NAME_EN TEXT"
              ")");

          //MAS_SUB_DISTRICT
          await db.execute("CREATE TABLE MAS_SUB_DISTRICT ("
              "SUB_DISTRICT_ID INTEGER PRIMARY KEY,"
              "DISTRICT_ID INTEGER,"
              "OFFICE_CODE TEXT,"
              "SUB_DISTRICT_CODE TEXT,"
              "SUB_DISTRICT_NAME_TH TEXT,"
              "SUB_DISTRICT_NAME_EN TEXT,"
              "ZIP_CODE TEXT,"
              "IS_ACTIVE INTEGER,"
              "DISTRICT_NAME_TH TEXT,"
              "DISTRICT_NAME_EN TEXT,"
              "PROVINCE_ID INTEGER,"
              "PROVINCE_NAME_TH TEXT,"
              "PROVINCE_NAME_EN TEXT"
              ")");


        });
  }

  //*******************************************>> START TITLE NAME <<**********************************************************

  newClientMasTitle(ItemsListTitle newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_TITLE (TITLE_ID,TITLE_NAME_TH,TITLE_NAME_EN,TITLE_SHORT_NAME_TH,TITLE_SHORT_NAME_EN,TITLE_TYPE)"
            " VALUES (?,?,?,?,?,?)",
        [newClient.TITLE_ID,
          newClient.TITLE_NAME_TH,
          newClient.TITLE_NAME_EN,
          newClient.TITLE_SHORT_NAME_TH,
          newClient.TITLE_SHORT_NAME_EN,
          newClient.TITLE_TYPE
        ]);
    return raw;
  }
  Future<List<ItemsListTitle>> getAllClientsMasTitle() async {
    final db = await database;
    var res = await db.query("MAS_TITLE");
    List<ItemsListTitle> list =
    res.isNotEmpty ? res.map((c) => ItemsListTitle.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientMasTitle(int id) async {
    final db = await database;
    return db.delete("MAS_TITLE", where: "TITLE_ID = ?", whereArgs: [id]);
  }

  deleteAllMasTitle() async {
    final db = await database;
    db.rawDelete("Delete from MAS_TITLE");
  }

//*******************************************>> END TITLE NAME <<**********************************************************

//*******************************************>> START MAS_NATIONAL <<**********************************************************

  newClientMasNationality(ItemsListNational newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_NATIONALITY (NATIONALITY_ID,NATIONALITY_NAME_TH,NATIONALITY_NAME_EN,IS_ACTIVE)"
            " VALUES (?,?,?,?)",
        [newClient.NATIONALITY_ID,
          newClient.NATIONALITY_NAME_TH,
          newClient.NATIONALITY_NAME_EN,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListNational>> getAllClientsMasNationality() async {
    final db = await database;
    var res = await db.query("MAS_NATIONALITY");
    List<ItemsListNational> list =
    res.isNotEmpty ? res.map((c) => ItemsListNational.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientMasNationality(int id) async {
    final db = await database;
    return db.delete("MAS_NATIONALITY", where: "NATIONALITY_ID = ?", whereArgs: [id]);
  }

  deleteAllMasNationality() async {
    final db = await database;
    db.rawDelete("Delete from MAS_NATIONALITY");
  }

//*******************************************>> END MAS_NATIONAL <<****************************************************

//*******************************************>> START MAS_RACE <<****************************************************
  newClientMasRace(ItemsListRace newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_RACE (RACE_ID,RACE_NAME_TH,RACE_NAME_EN,IS_ACTIVE)"
            " VALUES (?,?,?,?)",
        [newClient.RACE_ID,
          newClient.RACE_NAME_TH,
          newClient.RACE_NAME_EN,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListRace>> getAllClientsMasRace() async {
    final db = await database;
    var res = await db.query("MAS_RACE");
    List<ItemsListRace> list =
    res.isNotEmpty ? res.map((c) => ItemsListRace.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientRace(int id) async {
    final db = await database;
    return db.delete("MAS_RACE", where: "RACE_ID = ?", whereArgs: [id]);
  }

  deleteAllMasRace() async {
    final db = await database;
    db.rawDelete("Delete from MAS_RACE");
  }
//*******************************************>> END MAS_RACE <<**************************************************

//*******************************************>> START MAS_RACE <<****************************************************
  newClientMasDivisionRate(ItemsListDivisionRate newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_DIVISIONRATE ("
            "DIVISIONRATE_ID,"
            "TREASURY_RATE,"
            "BRIBE_RATE,"
            "REWARD_RATE,"
            "BRIBE_MAX_MONEY,"
            "REWARD_MAX_MONEY,"
            "EFFECTIVE_DATE,"
            "EXPIRE_DATE,"
            "IS_ACTIVE)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [newClient.DIVISIONRATE_ID,
          newClient.TREASURY_RATE,
          newClient.BRIBE_RATE,
          newClient.REWARD_RATE,
          newClient.BRIBE_MAX_MONEY,
          newClient.REWARD_MAX_MONEY,
          newClient.EFFECTIVE_DATE,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListDivisionRate>> getAllClientsMasDivisionRate() async {
    final db = await database;
    var res = await db.query("MAS_DIVISIONRATE");
    List<ItemsListDivisionRate> list =
    res.isNotEmpty ? res.map((c) => ItemsListDivisionRate.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientDivisionRate(int id) async {
    final db = await database;
    return db.delete("MAS_DIVISIONRATE", where: "DIVISIONRATE_ID = ?", whereArgs: [id]);
  }

  deleteAllMasDivisionRate() async {
    final db = await database;
    db.rawDelete("Delete from MAS_DIVISIONRATE");
  }
//*******************************************>> END MAS_RACE <<**************************************************


//*******************************************>> START MAS_COUNTRY <<****************************************************
  newClientMasCountry(ItemsListCountry newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_COUNTRY (COUNTRY_ID,COUNTRY_CODE,COUNTRY_NAME_TH,COUNTRY_NAME_EN,COUNTRY_SHORT_NAME,IS_ACTIVE)"
            " VALUES (?,?,?,?,?,?)",
        [newClient.COUNTRY_ID,
          newClient.COUNTRY_CODE,
          newClient.COUNTRY_NAME_TH,
          newClient.COUNTRY_NAME_EN,
          newClient.COUNTRY_SHORT_NAME,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListCountry>> getAllClientsMasCountry() async {
    final db = await database;
    var res = await db.query("MAS_COUNTRY");
    List<ItemsListCountry> list =
    res.isNotEmpty ? res.map((c) => ItemsListCountry.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientCountry(int id) async {
    final db = await database;
    return db.delete("MAS_COUNTRY", where: "COUNTRY_ID = ?", whereArgs: [id]);
  }

  deleteAllMasCountry() async {
    final db = await database;
    db.rawDelete("Delete from MAS_COUNTRY");
  }
//*******************************************>> END MAS_COUNTRY <<**************************************************


//*******************************************>> START MAS_PROVINCE <<****************************************************
  newClientMasProvince(ItemsListProvince newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_PROVINCE ("
            "PROVINCE_ID,"
            "COUNTRY_ID,"
            "PROVINCE_CODE,"
            "PROVINCE_NAME_TH,"
            "PROVINCE_NAME_EN,"
            "IS_ACTIVE)"
            " VALUES (?,?,?,?,?,?)",
        [newClient.PROVINCE_ID,
          newClient.COUNTRY_ID,
          newClient.PROVINCE_CODE,
          newClient.PROVINCE_NAME_TH,
          newClient.PROVINCE_NAME_EN,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListProvince>> getAllClientsMasProvince() async {
    final db = await database;
    var res = await db.query("MAS_PROVINCE");
    List<ItemsListProvince> list =
    res.isNotEmpty ? res.map((c) => ItemsListProvince.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientProvince(int id) async {
    final db = await database;
    return db.delete("MAS_PROVINCE", where: "PROVINCE_ID = ?", whereArgs: [id]);
  }

  deleteAllMasProvince() async {
    final db = await database;
    db.rawDelete("Delete from MAS_PROVINCE");
  }
//*******************************************>> END MAS_DISTRICT <<**************************************************

//*******************************************>> START MAS_DISTRICT <<****************************************************
  newClientMasDistrict(ItemsListDistict newClient) async {
    final db = await database;
    //insert to the table using the new id

    var raw = await db.rawInsert(
        "INSERT Into MAS_DISTRICT ("
            "DISTRICT_ID,"
            "PROVINCE_ID,"
            "DISTRICT_CODE,"
            "DISTRICT_NAME_TH,"
            "DISTRICT_NAME_EN,"
            "IS_ACTIVE)"
            " VALUES (?,?,?,?,?,?)",
        [newClient.DISTRICT_ID,
          newClient.PROVINCE_ID,
          newClient.DISTRICT_CODE,
          newClient.DISTRICT_NAME_TH,
          newClient.DISTRICT_NAME_EN,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListDistict>> getAllClientsMasDistrict() async {
    final db = await database;
    var res = await db.query("MAS_DISTRICT");
    List<ItemsListDistict> list =
    res.isNotEmpty ? res.map((c) => ItemsListDistict.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientDistrict(int id) async {
    final db = await database;
    return db.delete("MAS_DISTRICT", where: "DISTRICT_ID = ?", whereArgs: [id]);
  }

  deleteAllMasDistrict() async {
    final db = await database;
    db.rawDelete("Delete from MAS_DISTRICT");
  }
//*******************************************>> END MAS_DISTRICT <<**************************************************


//*******************************************>> START MAS_SUB_DISTRICT <<****************************************************
  newClientMasSubDistrict(ItemsListSubDistict newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_SUB_DISTRICT ("
            "SUB_DISTRICT_ID,"
            "DISTRICT_ID,"
            "OFFICE_CODE,"
            "SUB_DISTRICT_CODE,"
            "SUB_DISTRICT_NAME_TH,"
            "SUB_DISTRICT_NAME_EN,"
            "ZIP_CODE,"
            "IS_ACTIVE)"
            " VALUES (?,?,?,?,?,?,?,?)",
        [newClient.SUB_DISTRICT_ID,
          newClient.DISTRICT_ID,
          newClient.OFFICE_CODE,
          newClient.SUB_DISTRICT_CODE,
          newClient.SUB_DISTRICT_NAME_TH,
          newClient.SUB_DISTRICT_NAME_EN,
          newClient.ZIP_CODE,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListSubDistict>> getAllClientsMasSubDistrict() async {
    final db = await database;
    var res = await db.query("MAS_SUB_DISTRICT");
    List<ItemsListSubDistict> list =
    res.isNotEmpty ? res.map((c) => ItemsListSubDistict.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientSubDistrict(int id) async {
    final db = await database;
    return db.delete("MAS_SUB_DISTRICT", where: "SUB_DISTRICT_ID = ?", whereArgs: [id]);
  }

  deleteAllMasSubDistrict() async {
    final db = await database;
    db.rawDelete("Delete from MAS_SUB_DISTRICT");
  }
//*******************************************>> END MAS_SUB_DISTRICT <<**************************************************


//*******************************************>> START ARREST_MAS_GUILTBASE <<****************************************************
  newClientMasGuiltBase(ItemsListArrest6Section newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into ARREST_MAS_GUILTBASE ("
            "GUILTBASE_ID,"
            "GUILTBASE_NAME,"
            "FINE,"
            "IS_PROVE,"
            "IS_COMPARE,"
            "SUBSECTION_NAME,"
            "SUBSECTION_DESC,"
            "SECTION_NAME,"
            "PENALTY_DESC)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [newClient.GUILTBASE_NAME,
          newClient.GUILTBASE_NAME,
          newClient.FINE,
          newClient.IS_PROVE,
          newClient.IS_COMPARE,
          newClient.SUBSECTION_NAME,
          newClient.SUBSECTION_DESC,
          newClient.SECTION_NAME,
          newClient.PENALTY_DESC,
        ]);
    return raw;
  }
  Future<List<ItemsListArrest6Section>> getAllClientsMasGuiltBase() async {
    final db = await database;
    var res = await db.query("ARREST_MAS_GUILTBASE");
    List<ItemsListArrest6Section> list =
    res.isNotEmpty ? res.map((c) => ItemsListArrest6Section.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientGuiltBase(int id) async {
    final db = await database;
    return db.delete("ARREST_MAS_GUILTBASE", where: "GUILTBASE_ID = ?", whereArgs: [id]);
  }

  deleteAllMasGuiltBase() async {
    final db = await database;
    db.rawDelete("Delete from ARREST_MAS_GUILTBASE");
  }
//*******************************************>> END ARREST_MAS_GUILTBASE <<**************************************************


//*******************************************>> START MAS_PRODUCT_UNIT <<****************************************************
  newClientMasProductUnit(ItemsListProductUnit newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_PRODUCT_UNIT ("
            "UNIT_ID,"
            "UNIT_NAME_TH,"
            "UNIT_NAME_EN,"
            "UNIT_SHORT_NAME)"
            " VALUES (?,?,?,?)",
        [newClient.UNIT_ID,
          newClient.UNIT_NAME_TH,
          newClient.UNIT_NAME_EN,
          newClient.UNIT_SHORT_NAME,
        ]);
    return raw;
  }
  Future<List<ItemsListProductUnit>> getAllClientsMasProductUnit() async {
    final db = await database;
    var res = await db.query("MAS_PRODUCT_UNIT");
    List<ItemsListProductUnit> list =
    res.isNotEmpty ? res.map((c) => ItemsListProductUnit.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientProductUnit(int id) async {
    final db = await database;
    return db.delete("MAS_PRODUCT_UNIT", where: "UNIT_ID = ?", whereArgs: [id]);
  }

  deleteAllMasProductUnit() async {
    final db = await database;
    db.rawDelete("Delete from MAS_PRODUCT_UNIT");
  }
//*******************************************>> END MAS_PRODUCT_UNIT <<**************************************************

//*******************************************>> START MAS_PRODUCT_GROUP <<****************************************************
  newClientMasProductGroup(ItemsListProductGroup newClient) async {
    final db = await database;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into MAS_PRODUCT_GROUP ("
            "PRODUCT_GROUP_ID,"
            "PRODUCT_GROUP_CODE,"
            "PRODUCT_GROUP_NAME,"
            "IS_ACTIVE)"
            " VALUES (?,?,?,?)",
        [newClient.PRODUCT_GROUP_ID,
          newClient.PRODUCT_GROUP_CODE,
          newClient.PRODUCT_GROUP_NAME,
          newClient.IS_ACTIVE,
        ]);
    return raw;
  }
  Future<List<ItemsListProductUnit>> getAllClientsMasProductGroup() async {
    final db = await database;
    var res = await db.query("MAS_PRODUCT_GROUP");
    List<ItemsListProductUnit> list =
    res.isNotEmpty ? res.map((c) => ItemsListProductUnit.fromJson(c)).toList() : [];
    return list;
  }

  deleteClientProductGroup(int id) async {
    final db = await database;
    return db.delete("MAS_PRODUCT_GROUP", where: "PRODUCT_GROUP_ID = ?", whereArgs: [id]);
  }

  deleteAllMasProductGroup() async {
    final db = await database;
    db.rawDelete("Delete from MAS_PRODUCT_GROUP");
  }
//*******************************************>> END MAS_PRODUCT_GROUP <<**************************************************

}