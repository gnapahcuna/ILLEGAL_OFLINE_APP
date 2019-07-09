import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/guy/chat.dart';
import 'package:prototype_app_pang/guy/search.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('hh:mm : EEE d MMM yyyy').format(now);
final police = [
  "จ่าก้อง",
];
final recentPolice = [
  "",

];
String chat = 'ประวิตร วงทองคำ';

class ChatFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle textLabelStyle =
    TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle1 =
    TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);

    return Scaffold(
      /*appBar: AppBar(
        title: Text('ห้องสนทนา',style: textLabelStyle1, ),
        centerTitle: true,
        backgroundColor: Color(0xff5887f9),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new Search1()),
              );
            },
          )
        ],
      ),*/
      drawer: Drawer(
        child: ListView(
          children: <Widget>[],
        ),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          ListView(
            children: <Widget>[
              Divider(),
              //คืือการเคาะลงมา

              ListTile(
                leading: /*Icon(
                  Icons.person_pin,
                  size: 50,
                ),*/
                Container(
                  width: 50.0,
                  height: 50.0,
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
                            'assets/images/avatar_chat.jpeg')),
                  ),
                ),
                title: Text('จ่าตุ่น',style: textLabelStyle1,),
                subtitle: Text('บิ้ก สำนวนคดีอย่าลืมส่งมานะ',style: textLabelStyle,),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new MyApp()),
                  );
                },
              ),
              Divider(),
            ],
          ),
        ],
      )
    );
  }
}







class Searchchat extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: MyApp(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? null
        : police
        .where((p) => p.startsWith(query))
        .toList();
    if (query == police) {
      return buildResults(context);
    } else {
      print("ไม่พบ");
    } //เช็คพยัญชนะที่ค้นหา

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.person),
        title: RichText(
          text: TextSpan(
              text: suggestionlist[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionlist[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionlist.length,
    );
  }
}



