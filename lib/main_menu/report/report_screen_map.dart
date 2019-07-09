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

class ReportMapScreenFragment extends StatefulWidget {
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
class _FragmentState extends State<ReportMapScreenFragment>  with TickerProviderStateMixin {
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
TextStyle textTableStyle = TextStyle(
      fontSize: 12.0, color: Colors.black,fontFamily: FontStyles().FontFamily);
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


    return Scaffold(
      
    
        appBar: AppBar(
          leading: new IconButton(
  icon: new Icon(Icons.arrow_back_ios,),
  onPressed: () => Navigator.of(context).pop(),
), 
          
          title: Text("รายงานสถิติ",style: textAppbarStyle,),centerTitle: true,),
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
            
//*********************************************************************/ไทยทั้งแผ่น 

           Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/map2.png',
                            width: 500.0, height: 500.0),
                        

                 ),

                 Container(
                   //เหนือบน
                   padding: EdgeInsets.all(75),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){
        //              Navigator.push(
        //              context,
        //             MaterialPageRoute(builder: (context) => _buildmapS5()),
        // );
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //เหนือล่าง
                   padding: EdgeInsets.only(left: 90,right: 20,bottom: 50,top: 110),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //อีสานบน
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 90),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //อีสานล่าง
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 150),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //กลาง
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _buildmapS1()),
         );


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //ตะวันออก
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 230),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //ตะวันตก
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //กทม
                   padding: EdgeInsets.only(left: 140,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //ใต้บน
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 340),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 138,right: 20,bottom: 80,top: 447),
                child:  SizedBox(
                  width: 80,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("100คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),)
                 
       
                
            
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
                    child:  _build_chart1(),
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


//***********************************************ภาค1********************************************************************** */

Widget _buildmapS1(){
  
  return Scaffold(
    
    appBar: AppBar(
       leading: new IconButton(
  icon: new Icon(Icons.arrow_back_ios,),
  onPressed: () => Navigator.of(context).pop(),
), 
      title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(style: prefix1.BorderStyle.solid),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                 Center (child: Text("เงินส่งคลัง",style: textTableStyle,),),
                    Center (child: Text("",style: textTableStyle,),),
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                    
                    
                  ]),

                  TableRow(children: [
                    
                        Center (child: Text("ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                        Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      

                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("60,000.00",style: textTableStyle,),),
                      Center (child: Text("",style: textTableStyle,),),
                      
                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}



















//***********************************************ภาค2********************************************************************** */

Widget _buildmapS2(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}




















//***********************************************ภาค3********************************************************************** */

Widget _buildmapS3(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}



































//***********************************************ภาค4********************************************************************** */

Widget _buildmapS4(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}

































//***********************************************ภาค5********************************************************************** */

Widget _buildmapS5(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}










































//***********************************************ภาค6********************************************************************** */

Widget _buildmapS6(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}


































//***********************************************ภาค7********************************************************************** */

Widget _buildmapS7(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}















//***********************************************ภาค8********************************************************************** */

Widget _buildmapS8(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}



































//***********************************************ภาค9********************************************************************** */

Widget _buildmapS9(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
    )
  
  );
}




































//***********************************************ภาค10********************************************************************** */

Widget _buildmapS10(){
  
  return Scaffold(
    
    appBar: AppBar(title: Text("รายงานสถิติคดี",style: textAppbarStyle,),centerTitle: true,),
    

    body: SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       
          children: <Widget>[
            
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,top: 30),
              
              child: Text('รายงานจำนวนคดี (1 ม.ค. - 31 ธ.ค. 61)',
                style: textLabelStyle,),
            ),
            Container(
              padding: prefix0.EdgeInsets.only(left: 20,right: 20,bottom: 60,),
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
               Container(
              child: Stack(
               children: <Widget>[
                 Container(
                        child: Image.asset('assets/images/map/S1.jpg',
                            width: 800.0, height: 500.0),
                        

                 ),
                  //ชัยนาท
                 Container(
                   
                   padding: EdgeInsets.only(left: 25,right: 20,top: 120),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
       
                  },

                ),
                  )
                    )
                 ),


                  Container(
                    //ปทุมธานี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 50,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                   Container(
                    //ลพบุรี
                   padding: EdgeInsets.only(left: 200,right: 20,bottom: 80,top: 130),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
              child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                  
                   Container(
                    //สระบุรี
                   padding: EdgeInsets.only(left: 240,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                  child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),

                
                  
                   Container(
                    //สิงบุรี
                   padding: EdgeInsets.only(left: 110,right: 20,bottom: 80,top: 180),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){
                     
         


                  },

                ),
                  )
                    )
                 ),


                 Container(
                    //อ่างทอง
                   padding: EdgeInsets.only(left: 70,right: 20,bottom: 80,top: 220),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
             
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),


                    Container(
                    //
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 258),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),





                    Container(
                    //อยุธยา
                   padding: EdgeInsets.only(left: 100,right: 20,bottom: 80,top: 280),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),



                    Container(
                    //สุพรรณ
                   padding: EdgeInsets.only(left: 60,right: 20,bottom: 80,top: 350),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




                 Container(
                    //ใต้ล่าง
                   padding: EdgeInsets.only(left: 180,right: 20,bottom: 80,top: 380),
                child:  SizedBox(
                  width: 70,
                  height: 20,
                  child: Align( 
                  
                 child : RaisedButton(
                   color: Colors.white,
                   shape: RoundedRectangleBorder(
                      side: new BorderSide(
                                    color: Color(0xff087de1), width: 1.5),
                                borderRadius: BorderRadius.circular(12.0)
                   ),
                  child:Text("10คดี",),
                  onPressed: (){},

                ),
                  )
                    )
                 ),




               ],
                //color: Colors.green,
                
                
                





              ),
              ),
              Container(
                child: SingleChildScrollView(
                child:  Table(
                  
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                  Center (child: Text("สรรพสามิต",style: textTableStyle,),),
                  Center (child: Text("จำนวนคดี",style: textTableStyle,),),
                    Center (child: Text("ค่าปรับ",style: textTableStyle,),),
                      Center (child: Text("เงินสินบน",style: textTableStyle,),),
                        Center (child: Text("เงินรางวัล",style: textTableStyle,),),
                  
                    
               
            
                  ],),
                   TableRow(children: [
                       Center (child: Text("สสพ.นนทบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                 
                    
                  ]),
                    TableRow(children: [

                      Center (child: Text("สสพ.ชัยนาท",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                    
                    
                  ]),

                  TableRow(children: [

                        Center (child: Text("สสพ.ปทุมธานี1",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ปทุมธานี2",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                     Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.อยุธยา",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                       Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),


                  
                    
                  ]),
                  TableRow(children: [
                          Center (child: Text("สสพ.ลพบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                      Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
               
                    
                  ]),
                  TableRow(children: [
                        Center (child: Text("สสพ.สระบุรี",style: textTableStyle,),),
                      Center (child: Text("10",style: textTableStyle,),),
                    Center (child: Text("100,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),
                      Center (child: Text("20,000.00",style: textTableStyle,),),

                    
                  ]),



                ],
              ),
              )
              )
              

          ]
        )
  
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
