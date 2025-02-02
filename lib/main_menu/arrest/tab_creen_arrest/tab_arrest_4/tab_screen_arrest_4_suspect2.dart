import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2_detail.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

class TabScreenArrest4Suspect2 extends StatefulWidget {
  ItemsListPersonNetMain itemsListPersonNetMain;
  TabScreenArrest4Suspect2({
    Key key,
    @required this.itemsListPersonNetMain,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<TabScreenArrest4Suspect2>  with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;

  List<Choice> choices = <Choice>[
    Choice(title: 'ประวัติผู้ต้องหา'),
    Choice(title: 'การกระทำผิด'),
  ];
  //item forms
  List<ItemsDestroyForms> itemsFormsTab = [];


  TextStyle textInputStyle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputSubStyle = TextStyle(
      fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0,
      color: Color(0xff087de1),
      fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(
      fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  String sTitle;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    itemsFormsTab.add(new ItemsDestroyForms("รายงานจำนวนคดี"));
    itemsFormsTab.add(new ItemsDestroyForms("ผลปราบปรามผู้กระทำผิดกฎหมายสรรพสามิต"));
    itemsFormsTab.add(new ItemsDestroyForms("รายงานรายละเอียดค่าปรับ"));
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0,
        color: Colors.black54,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;


    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              centerTitle: true,
              title: Text((widget.itemsListPersonNetMain.PERSON_INFO.TITLE_NAME_TH.toString()+
                  widget.itemsListPersonNetMain.PERSON_INFO.FIRST_NAME+" "
                  +widget.itemsListPersonNetMain.PERSON_INFO.LAST_NAME),style: appBarStyle,),
              leading: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(10.0),
                child: new Icon(Icons.arrow_back_ios, color: Colors.white,),
              ),
              automaticallyImplyLeading: false,
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
                  body: Stack(
                    children: <Widget>[
                      BackgroundContent(),
                      TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: <Widget>[
                            _buildContent_tab_1(),
                            _buildContent_tab_2(),
                          ]
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  //************************start_tab_1*****************************
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasterCountryResponse itemsCountry;
  //on show dialog
  Future<bool> onLoadActionCountryMaster() async {
    Map map_title = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    Map map_country = {
      "TEXT_SEARCH" : ""
    };
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    setState(() {});
    return true;
  }

  Widget _buildContent_tab_1() {
    var size = MediaQuery
        .of(context)
        .size;
    Widget _buildContent(BuildContext context) {
      TextStyle textStyleLabel = TextStyle(
          fontSize: 16, color: Color(0xff087de1),fontFamily: FontStyles().FontFamily);
      TextStyle textStyleData = TextStyle(fontSize: 16, color: Colors.black,fontFamily: FontStyles().FontFamily);
      TextStyle textLabelEditStyle = TextStyle(
          fontSize: 16.0, color: Colors.red,fontFamily: FontStyles().FontFamily);
      EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

      String address="";
      widget.itemsListPersonNetMain.PERSON_ADDRESSES.forEach((item){
        address = (item.ADDRESS_NO!=null?item.ADDRESS_NO:""+"")+
            item.ADDRESS.toString();

      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: paddingLabel,
                        child: Text("ชื่อผู้ต้องหา", style: textStyleLabel,),
                      ),
                    ),
                   
                  ],
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    (widget.itemsListPersonNetMain.PERSON_INFO.TITLE_NAME_TH.toString()+
                        widget.itemsListPersonNetMain.PERSON_INFO.FIRST_NAME+" "
                        +widget.itemsListPersonNetMain.PERSON_INFO.LAST_NAME),
                    style: textStyleData,),
                ),
                Padding(
                  padding: paddingData,
                  child: Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("ประเภทผู้ต้องหา", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    widget.itemsListPersonNetMain.PERSON_INFO.PERSON_TYPE==0?"คนไทย":"ต่างชาติ",
                    style: textStyleData,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("ประเภทบุคคล", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    widget.itemsListPersonNetMain.PERSON_INFO.ENTITY_TYPE==0?"บุคคลธรรมดา":"นิติบุคคล",
                    style: textStyleData,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("เลขที่บัตรประชาชน", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    widget.itemsListPersonNetMain.PERSON_INFO.ID_CARD==null
                        ?""
                        :widget.itemsListPersonNetMain.PERSON_INFO.ID_CARD,
                    style: textStyleData,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("ที่อยู่", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    widget.itemsListPersonNetMain.PERSON_ADDRESSES.length==0
                        ?""
                        :address,
                    style: textStyleData,),
                ),
              ],
            ),
          ),
        ],
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
              //color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_10_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _buildContent(
                    context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_2() {
    Widget _buildContent() {
      return widget.itemsListPersonNetMain.ARREST_LAWBREAKER_DETAILS.length>0
          ?Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: widget.itemsListPersonNetMain.ARREST_LAWBREAKER_DETAILS.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: ListTile(
                      leading: Padding(padding: paddingLabel,
                        child: Text((index + 1).toString() + '. ',
                          style: textInputStyleTitle,),),
                      title: Padding(padding: paddingLabel,
                        child: Text("เลขรับคำกล่าวโทษ "
                            +widget.itemsListPersonNetMain.ARREST_LAWBREAKER_DETAILS[index].LAWSUIT_NO.toString(),
                          style: textInputStyleTitle,),),
                      subtitle: Padding(padding: paddingLabel,
                        child: Text("ฐานความผิดมาตรา "
                            +widget.itemsListPersonNetMain.ARREST_LAWBREAKER_DETAILS[index].SECTION_ID.toString(),
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[400],
                        size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest4Suspect2Detail(
                                  lawbreakerDetail: widget.itemsListPersonNetMain.ARREST_LAWBREAKER_DETAILS[index],
                                ),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      )
          :Center(
        child: Padding(
          padding: paddingInputBox,
          child: Text(
            "ยังไม่เคยกระทำผิด",
            style: TextStyle(fontSize: 20.0,fontFamily: FontStyles().FontFamily),),
        ),
      );
    }
    //data result when search data
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: 34.0,
            decoration: BoxDecoration(
              //color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_10_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
          ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child:/* _onSaved
                  ? _buildContent_saved(context)
                  : */_buildContent(),
            ),
          ),
        ],
      ),
    );
  }
//************************end_tab_3*******************************
}