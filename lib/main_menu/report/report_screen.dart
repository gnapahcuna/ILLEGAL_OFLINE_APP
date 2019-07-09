import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;

import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prototype_app_pang/main_menu/report/report_screen_map.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class ReportMainScreenFragment extends StatefulWidget {
  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("ภาค 1", 100),
      new LinearSales("ภาค 2", 75),
      new LinearSales("ภาค 3", 25),
      new LinearSales("ภาค 4", 5),
      new LinearSales("ภาค 5", 45),
      new LinearSales("ภาค 6", 30),
      new LinearSales("ภาค 7", 1),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.title,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        labelAccessorFn: (LinearSales row, _) => /*'${row.title} : ${row.sales}'*/'${row.sales}',
      )
    ];
  }

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData1() {
    final globalSalesData = [
      new OrdinalSales(new DateTime(2018, 1, 1), 45),
      new OrdinalSales(new DateTime.now(), 85),
    ];

    return [
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
        //colorFn: (OrdinalSales sales, _) => charts.Color.fromHex(code: '#5887f9'),
      ),
    ];

  }
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData2() {
    final globalSalesData = [
      new OrdinalSales(new DateTime(2018, 1, 1), 95),
      new OrdinalSales(new DateTime.now(), 80),
    ];

    return [
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
        //colorFn: (OrdinalSales sales, _) => charts.Color.fromHex(code: '#5887f9'),
      ),
    ];

  }
  _FragmentState createState() => new _FragmentState(_createSampleData(),_createSampleData1(),_createSampleData2(), animate: true,);
}
const double _kPickerSheetHeight = 216.0;
class _FragmentState extends State<ReportMainScreenFragment>  with TickerProviderStateMixin {
  List<charts.Series> seriesList;
  List<charts.Series> seriesList1;
  List<charts.Series> seriesList2;
  bool animate;
  _FragmentState(this.seriesList,this.seriesList1,this.seriesList2, {this.animate});


  TabController tabController;
  TabPageSelector _tabPageSelector;

  List<Choice> choices = <Choice>[
    Choice(title: 'จำนวนคดี'),
    Choice(title: 'รายงาน'),
  ];
  //item forms
  List<ItemsDestroyForms> itemsFormsTab = [];

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
      onWillPop: () {
      },
      child: Scaffold(
        body: CustomScrollView(
          //physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
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
                    ]
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
    var size = MediaQuery
        .of(context)
        .size;
    Widget _build_chart1() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: paddingInputBox,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: paddingInputBox,
                    child: Text('ระดับ ทั่วประเทศ',
                      style: textInputSubStyle,),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text('หมวดของกลาง สุรา',
                      style: textInputSubStyle,),
                  ),




               




















                ],
              ),
            ),
            SizedBox(
              width: /*(size.width*90)/100*/size.width,
              height: size.height / 2,
              child: Container(
                //color: Colors.green,
                child: new charts.PieChart(
                  seriesList,
                  animate: animate,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [
                        //new charts.ArcLabelDecorator(),
                        new charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.auto,
                        ),
                      ]
                  ),
                  behaviors: [
                    new charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      horizontalFirst: false,
                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      showMeasures: true,
                      measureFormatter: (num value) {
                        return value == null ? '-' : '${value}k';
                      },
                    ),
                  ],
                ),
                
              ),
              
              
            ),
            Container(
              alignment: Alignment.bottomRight,
                    child: FlatButton(
                   child: Text("ดูแบบแผนที่..",style: textLabelStyle,),    
                  onPressed: (){
                    Navigator.push(
                     context,
                    MaterialPageRoute(builder: (context) => ReportMapScreenFragment(
                    

          )),
        );
                  },
                    ),

                  ),
            
          ],
        ),
      );
    }
    Widget _build_chart2() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานจำนวนเงินค่าปรับ (1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: new charts.BarChart(
                    seriesList,
                    animate: animate,
                    vertical: false,
                  )
              ),
            )

          ],
        ),
      );
    }
    Widget _build_chart3() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานจำนวนคดีย้อนหลัง ( 1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: /*new charts.BarChart(
                    seriesList1,
                    animate: animate,
                    defaultRenderer: new charts.BarRendererConfig(
                        cornerStrategy: const charts.ConstCornerStrategy(30)),
                  )*/
                  new charts.TimeSeriesChart(
                      seriesList1,
                      animate: animate,
                      defaultRenderer: new charts.LineRendererConfig(
                          includePoints: true),
                      behaviors: [
                        new charts.RangeAnnotation([
                          new charts.RangeAnnotationSegment(
                              new DateTime(2018, 12, 31),
                              new DateTime(2019, 12, 31),
                              charts.RangeAnnotationAxisType.domain
                          ),
                        ]),
                      ])
              ),
            )

          ],
        ),
      );
    }

    Widget _build_chart4() {
      return Container(
        padding: EdgeInsets.all(22.0),
        decoration: BoxDecoration(
            //color: Colors.white,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingInputBox,
              child: Text('รายงานเงินค่าปรับย้อนหลัง (1 ม.ค. - 31 ธ.ค.)',
                style: textLabelStyle,),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Container(
                  child: /*new charts.OrdinalComboChart(
                  seriesList1,
                  animate: animate,
                  defaultRenderer: new charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(30),
                  ),
                ),*/
                  new charts.TimeSeriesChart(
                      seriesList2,
                      animate: animate,
                      defaultRenderer: new charts.LineRendererConfig(
                          includePoints: true),
                      behaviors: [
                        new charts.RangeAnnotation([
                          new charts.RangeAnnotationSegment(
                              new DateTime(2018, 12, 31),
                              new DateTime(2019, 12, 31),
                              charts.RangeAnnotationAxisType.domain
                          ),
                        ]),
                      ])
              ),
            )
          ],
        ),
      );
    }

    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            _build_chart1(),
            _build_chart2(),
            _build_chart3(),
            _build_chart4(),
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
        ),
      ],
    );
  }

//************************end_tab_1*******************************

//************************start_tab_3*****************************
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
                                  Title: itemsFormsTab[index].FormsName,),
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
//************************end_tab_3*******************************
}
class LinearSales {
  final String title;
  final int sales;

  LinearSales(this.title, this.sales);
}
/// Sample ordinal data type.
class OrdinalSales {
  final DateTime  year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
