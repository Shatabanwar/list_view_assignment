import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
 Future<List<User>> _getUsers() async {

  var data =  await http.get("http://www.json-generator.com/api/json/get/cgsMDTVpWq?indent=2");
  var jsonData = json.decode(data.body);

  List<User> users = [];
  for(var u in jsonData){
    User user = User(u["index"],u["email"],u["company"],u["name"],u["picture"],u["address"]);
    users.add(user);
  }

  print(users.length);
  return users;

 }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        

        child:FutureBuilder(
          
          future: _getUsers(),
          builder: (BuildContext context,AsyncSnapshot snapshot)
          
          {

            if(snapshot.data == null){
              return Container(
                child:Center(child: Text("Loading..."),
                )
              );
            } else{
              return ListView.builder(

                itemCount:snapshot.data.length ,

                itemBuilder: (BuildContext context, int index){

              return Container(

              child:Column(
              children: <Widget>[
                Card(
          elevation: 5,
          child: ListTile(

          leading: CircleAvatar(
          backgroundImage: NetworkImage(
          snapshot.data[index].picture
          ),
          ),
            title: Text(snapshot.data[index].name + "\n" + snapshot.data[index].company + "\n"),
            subtitle: Text("Email:" + snapshot.data[index].email + "\n"  +"Address: " + snapshot.data[index].address),
            dense:true,
            isThreeLine: true,

            contentPadding: EdgeInsets.all(25.0),
          ),
          )
          ],
              )

              );

              },

            );
          }
          },
          ), 

      ),
    );
  }
}

class User{
   final int index;
   final String email;
   final String company;
   final String name;
   final String picture;
   final String address;

   

   User(this.index,this.email,this.company,this.name,this.picture,this.address);

}
