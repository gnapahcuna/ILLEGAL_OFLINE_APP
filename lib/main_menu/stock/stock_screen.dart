import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_main.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_list_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';

import 'model/balance_type.dart';
import 'stock_history_list.dart';

class StockMainScreenFragment extends StatefulWidget {
  ItemsStockMain ItemsstockMain;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  String Title;
  StockMainScreenFragment({
    Key key,
    @required this.ItemsstockMain,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
    @required this.Title,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

const double _kPickerSheetHeight = 216.0;

class _FragmentState extends State<StockMainScreenFragment>
    with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ของกลางคงเหลือ'),
    Choice(title: 'รายงาน'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  List<ItemsDestroyEvidence> itemEvidence = [];

  //item หลักทั้งหมด
  ItemsStockMain itemMain;
  //ประเภททั้งหมด
  List<ItemsStockBalanceType> itemType = [];

  //item forms
  List<ItemsDestroyForms> itemsFormsTab = [
    new ItemsDestroyForms("จำนวนคงเหลือในคลัง"),
    new ItemsDestroyForms("ประวัติของกลาง")
  ];

  TextStyle textDataStyle = TextStyle(
      fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(
      fontSize: 14.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[400],
      fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(
    fontSize: 14.0,
    color: Color(0xff087de1),
  );
  TextStyle textLabelHeadStyle = TextStyle(
    fontSize: 16.0,
    color: Color(0xff087de1),
  );

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  int stockTotal = 0;
  List ItemsAll = [];
  List ItemsType = [];
  @override
  void initState() {
    super.initState();

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    itemMain = widget.ItemsstockMain;
    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;
    }
    if (widget.IsUpdate) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
    }

    stockTotal = 0;
    itemMain.Balance.BalanceType1.forEach((f) {
      itemType.add(f);
      stockTotal += f.BalanceDetails.length;
      f.BalanceDetails.forEach((item) {
        ItemsAll.add(item);
      });
    });
    //
    itemMain.Balance.BalanceType2.forEach((f) {
      itemType.add(f);
      stockTotal += f.BalanceDetails.length;
      f.BalanceDetails.forEach((item) {
        ItemsAll.add(item);
      });
    });
    itemMain.Balance.BalanceType3.forEach((f) {
      itemType.add(f);
      stockTotal += f.BalanceDetails.length;
      f.BalanceDetails.forEach((item) {
        ItemsAll.add(item);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(
        fontSize: 16.0,
        color: Colors.black54,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          if (_onSaved) {
            if (_onEdited) {
              _onEdited = false;
              _onSaved = false;
            } else {
              Navigator.pop(context);
              //Navigator.pop(context, itemMain);
            }
          } else {
            Navigator.pop(context);
            //Navigator.pop(context, itemMain);
          }
        });
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: new Text(
                widget.Title,
                style: appBarStyle,
              ),
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "Back");
                  }),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StockBookSearchScreenFragment(),
                          ));
                    }),
              ],
            ),
            SliverFillRemaining(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(140.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey[500],
                    labelStyle: tabStyle,
                    controller: tabController,
                    isScrollable: false,
                    tabs: choices.map((Choice choice) {
                      return Tab(
                        text: choice.title,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  //physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: <Widget>[
                    _buildContent_tab_1(),
                    _buildContent_tab_2(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      final double Width = (size.width * 90) / 100;
      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[700],
      );
      return Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StockListScreenFragment(
                        Items: ItemsAll,
                        Title: "ของกลางคงเหลือในคลัง",
                      ),
                    ));
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ของกลางคงเหลือในคลัง",
                                    style: textLabelHeadStyle,
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ของกลางทั้งหมด",
                                    style: textLabelStyle,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 22.0, bottom: 4.0),
                            child: Text(
                              stockTotal.toString(),
                              style: textDataStyle,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: paddingInputBox,
                            child: Text(
                              "รายการ",
                              style: textDataSubStyle,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StockHistoryFragment(
                                itemMain: itemType,
                                Title: "ประวัติการทำรายการ",
                              ),
                            ));
                      },
                      child: Text('ประวัติการทำรายการ', style: textLabelStyle),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Container(
              padding: EdgeInsets.only(top: 22.0, bottom: 10.0),
              child: _buildLine,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemMain.Balance.BalanceType1.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StockListScreenFragment(
                                  Items: itemMain.Balance
                                      .BalanceType1[index].BalanceDetails,
                                  Title: itemMain
                                      .Balance.BalanceType1[index].Name,
                                ),
                              ));
                        },
                        child: Container(
                            width: size.width / 2.8,
                            padding: EdgeInsets.only(
                                top: 4.0, bottom: 4.0, left: 22.0, right: 22.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.grey[500], width: 1.0),
                                  bottom: BorderSide(
                                      color: Colors.grey[500], width: 1.0),
                                  left: BorderSide(
                                      color: Colors.grey[500], width: 1.0),
                                  right: BorderSide(
                                      color: Colors.grey[500], width: 1.0),
                                )),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 4.0),
                                        child: Text(
                                          itemMain
                                              .Balance.BalanceType1[index].Name,
                                          style: textLabelStyle,
                                        )),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 4.0),
                                      child: Text(
                                        itemMain.Balance.BalanceType1[index]
                                            .BalanceDetails.length
                                            .toString(),
                                        style: textDataStyle,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 4.0),
                                      child: Text(
                                        "รายการ",
                                        style: textDataSubStyle,
                                      )),
                                ],
                              ),
                            )),
                      ),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ของกลางรอดำเนินการ",
                      style: textLabelHeadStyle,
                    ),
                  ),
                  Container(padding: paddingInputBox, child: _buildLine),
                ],
              ),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemMain.Balance.BalanceType2.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StockListScreenFragment(
                                Items: itemMain.Balance.BalanceType2[index]
                                    .BalanceDetails,
                                Title: itemMain
                                    .Balance.BalanceType2[index].Name,
                              ),
                            ));
                      },
                      child: Container(
                          width: size.width / 2.8,
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                    color: Colors.grey[500], width: 1.0),
                                bottom: BorderSide(
                                    color: Colors.grey[500], width: 1.0),
                                left: BorderSide(
                                    color: Colors.grey[500], width: 1.0),
                                right: BorderSide(
                                    color: Colors.grey[500], width: 1.0),
                              )),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 4.0),
                                      child: Text(
                                        itemMain
                                            .Balance.BalanceType2[index].Name,
                                        style: textLabelStyle,
                                      )),
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.only(top: 10.0, bottom: 4.0),
                                    child: Text(
                                      itemMain.Balance.BalanceType2[index]
                                          .BalanceDetails.length
                                          .toString(),
                                      style: textDataStyle,
                                    )),
                                Padding(
                                    padding:
                                    EdgeInsets.only(top: 8.0, bottom: 4.0),
                                    child: Text(
                                      "รายการ",
                                      style: textDataSubStyle,
                                    )),
                              ],
                            ),
                          )),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "หน่วยงานภายนอก",
                      style: textLabelHeadStyle,
                    ),
                  ),
                  Container(padding: paddingInputBox, child: _buildLine),
                ],
              ),
            ),
            Container(
                height: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemMain.Balance.BalanceType3.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StockListScreenFragment(
                                    Items: itemMain.Balance
                                        .BalanceType3[index].BalanceDetails,
                                    Title: itemMain
                                        .Balance.BalanceType3[index].Name,
                                  ),
                                ));
                          },
                          child: Container(
                              width: size.width / 2.8,
                              padding: EdgeInsets.only(
                                  top: 4.0,
                                  bottom: 12.0,
                                  left: 22.0,
                                  right: 22.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey[500], width: 1.0),
                                    bottom: BorderSide(
                                        color: Colors.grey[500], width: 1.0),
                                    left: BorderSide(
                                        color: Colors.grey[500], width: 1.0),
                                    right: BorderSide(
                                        color: Colors.grey[500], width: 1.0),
                                  )),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 4.0),
                                          child: Text(
                                            itemMain.Balance.BalanceType3[index]
                                                .Name,
                                            style: textLabelStyle,
                                          )),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 4.0),
                                        child: Text(
                                          itemMain.Balance.BalanceType3[index]
                                              .BalanceDetails.length
                                              .toString(),
                                          style: textDataStyle,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 4.0),
                                        child: Text(
                                          "รายการ",
                                          style: textDataSubStyle,
                                        )),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }))
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            //height: 34.0,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_12_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

  //************************start_tab_2*****************************
  Widget _buildContent_tab_2() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: ListTile(
                      leading: Padding(
                        padding: paddingLabel,
                        child: Text(
                          (index + 1).toString() + '. ',
                          style: textDataStyle,
                        ),
                      ),
                      title: Padding(
                        padding: paddingLabel,
                        child: Text(
                          itemsFormsTab[index].FormsName,
                          style: textDataStyle,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                        size: 18.0,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabScreenArrest8Dowload(
                                Title: itemsFormsTab[index].FormsName,
                              ),
                            ));
                      }),
                ),
              );
            }),
      );
    }

    //data result when search data
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //height: 34.0,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_12_00_04_00', style: textStylePageName,),
                  )
                ],
              ),*/
            ),
            Expanded(
              child: new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//************************end_tab_2*******************************

}
