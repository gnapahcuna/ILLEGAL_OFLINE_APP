import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prototype_app_pang/model/test/Background.dart';

import 'model/person_net_main.dart';

class AnalysisMainScreenFragment extends StatefulWidget {
  final ItemsListPersonNetMain itemsListPersonNetMain;
  final int PERSON_ID;
  AnalysisMainScreenFragment({
    Key key,
    @required this.itemsListPersonNetMain,
    @required this.PERSON_ID,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<AnalysisMainScreenFragment>  with TickerProviderStateMixin {

  TabController tabController;
  TabPageSelector _tabPageSelector;

  List<Choice> choices = <Choice>[
    Choice(title: 'ผู้ต้องหา'),
    Choice(title: 'รายงาน'),
  ];

  //item forms
  List<ItemsListArrest8> itemsFormsTab = [];

  TextStyle textAppbarStyle = TextStyle(
      fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
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


  ItemsListPersonNetMain itemsListPersonNetMain;
  @override
  void initState() {
    super.initState();
    itemsListPersonNetMain=widget.itemsListPersonNetMain;

    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);


    itemsFormsTab.add(new ItemsListArrest8("ทะเบียนประวัติผู้กระทำผิด",""));
    itemsFormsTab.add(new ItemsListArrest8("รายละเอียดการกระทำผิดของผู้กระทำผิด",""));
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
              title: Text("วิเคราะห์ข้อมุลผู้ต้องหา",style: appBarStyle,),
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
  _navigatePreviewIndicmentDetail(BuildContext context,Map map) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenArrest4Suspect2(
        itemsListPersonNetMain: itemsListPersonNetMain,)),
    );
  }

  Widget _buildBlock1(){
    return Container(
      padding: EdgeInsets.all(22.0),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                width: 70.0,
                height: 70.0,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30),
                ),
                //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                padding: const EdgeInsets.all(3.0),
                child: ClipOval(
                  child: new Image(
                      fit: BoxFit.cover,
                      image: new AssetImage(
                          'assets/images/avatar.png')),
                ),
              ),
            ),
            Container(
              padding: paddingInputBox,
              child: Text(itemsListPersonNetMain.PERSON_INFO.TITLE_NAME_TH.toString()+" "
                  +itemsListPersonNetMain.PERSON_INFO.FIRST_NAME.toString()+" "
                  +itemsListPersonNetMain.PERSON_INFO.LAST_NAME.toString(),style: textInputStyle,),
            )
          ],
        ),
        onTap: (){
          Map map={
            "TEXT_SEARCH" : "",
            "PERSON_ID" : widget.PERSON_ID
          };
          _navigatePreviewIndicmentDetail(context, map);
        },
      )
    );
  }

  Widget _buildBlock2(){
    return Container(
      padding: EdgeInsets.only(left:22.0,right: 22.0,bottom: 22.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text('ใบงานจับกุมเดียวกัน',style: textLabelStyle,),
              ),
            ],
          ),

          /*Column(
            children: <Widget>[
              Container(
                child: Container(
                  width: 70.0,
                  height: 70.0,

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30),
                  ),
                  //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: new Image(
                        fit: BoxFit.cover,
                        image: new AssetImage(
                            'assets/images/avatar.png')),
                  ),
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: Text('Person 1',style: textInputStyle,),
              )
            ],
          ),*/
        ],
      )
    );
  }
  Widget _buildBlock3() {
    return Container(
        padding: EdgeInsets.only(left:22.0,right: 22.0,bottom: 22.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text('บิดา-มารดา ', style: textLabelStyle,),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 12.0),
              child: itemsListPersonNetMain.PERSON_RELATIONSHIPS
                  .length>0
                  ?GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: itemsListPersonNetMain.PERSON_RELATIONSHIPS
                      .length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String name = itemsListPersonNetMain
                        .PERSON_RELATIONSHIPS[index].TITLE_NAME_TH.toString() +
                        " " +
                        itemsListPersonNetMain
                            .PERSON_RELATIONSHIPS[index].FIRST_NAME.toString() +
                        " " +
                        itemsListPersonNetMain
                            .PERSON_RELATIONSHIPS[index].LAST_NAME.toString();

                    return Container(
                      padding: paddingLabel,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Container(
                              width: 70.0,
                              height: 70.0,

                              decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white30),
                              ),
                              //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                              padding: const EdgeInsets.all(3.0),
                              child: ClipOval(
                                child: new Image(
                                    fit: BoxFit.cover,
                                    image: new AssetImage(
                                        'assets/images/avatar.png')),
                              ),
                            ),
                          ),
                          Container(
                            padding: paddingInputBox,
                            child: Text(name, style: textInputStyle,),
                          )
                        ],
                      ),
                    );
                  }
              )
                  :Container(),
            )
          ],
        )
    );
  }

  Widget _buildBlock4() {
    return Container(
        padding: EdgeInsets.only(left:22.0,right: 22.0,bottom: 22.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text('ที่อยู่ เดียวกัน', style: textLabelStyle,),
                ),
              ],
            ),
            /*Container(
                padding: EdgeInsets.only(top: 12.0),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: itemsListPersonNetMain.PERSON_ADDRESSES
                        .length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      String name = itemsListPersonNetMain
                          .PERSON_ADDRESSES[index].TITLE_NAME_TH
                          .toString() +
                          " " +
                          itemsListPersonNetMain
                              .PERSON_ADDRESSES[index].FIRST_NAME
                              .toString() +
                          " " +
                          itemsListPersonNetMain
                              .PERSON_ADDRESSES[index].LAST_NAME.toString();

                      return Container(
                        padding: paddingLabel,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Container(
                                width: 70.0,
                                height: 70.0,

                                decoration: BoxDecoration(

                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white30),
                                ),
                                //margin: const EdgeInsets.only(top: 22.0,bottom: 22.0),
                                padding: const EdgeInsets.all(3.0),
                                child: ClipOval(
                                  child: new Image(
                                      fit: BoxFit.cover,
                                      image: new AssetImage(
                                          'assets/images/avatar.png')),
                                ),
                              ),
                            ),
                            Container(
                              padding: paddingInputBox,
                              child: Text('Person 1', style: textInputStyle,),
                            )
                          ],
                        ),
                      );
                    }
                )
            ),*/
          ],
        )
    );
  }


  Widget _buildContent_tab_1() {
    var size = MediaQuery
        .of(context)
        .size;

    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildBlock1(),
            _buildBlock2(),
            _buildBlock3(),
            _buildBlock4()
          ],
        ),
      );
    }

    return Stack(
      children: <Widget>[
        BackgroundContent(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
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
        ),
      ],
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
                        child: Text(itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,),),
                      trailing: Icon(
                        Icons.arrow_forward_ios, color: Colors.grey[400],
                        size: 18.0,),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TabScreenArrest8Dowload(
                                  Title: itemsFormsTab[index].FormsName,
                                  FILE_NAME: "",
                                ),
                            ));
                      }
                  ),
                ),
              );
            }
        ),
      );
    }
    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //height: 34.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                    ),
                  ),
                  SingleChildScrollView(
                    child: _buildContent(),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
//************************end_tab_2*******************************
