import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './src/pages/call.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nanda Calling Nanda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Nanda Calling Nanda'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final TextEditingController number = new TextEditingController();
  final TextEditingController message = new TextEditingController();
  
  Future callservice() async {
    String url =
        "https://smsapi.engineeringtgr.com/send/?Mobile=MOBILE_NUMBER&Password=PASSWORD&Message=" +
            message.text +
            "&To=" +
            number.text +
            "&Key=API_KEY";
    http.Response res = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"Application/json"}
    );
    print(json.decode(res.body));
  }

    final _channelController = TextEditingController();

  /// if channel textfield is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
         title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Image.asset('assets/images/logo.png')
           ],
         ),
        ),
        
          body:Container(
            child:Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.person_pin,size: 40.0),
                        Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Dad',style:TextStyle(fontSize: 20.0,color: Colors.black,fontWeight:FontWeight.bold)),
                  ),
                      ],
                    ),
                
                   Row(
                    children: <Widget>[
                      GestureDetector(
                                              child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Icon(Icons.message,color: Colors.grey[400],size: 25.0,),
                          
                        ),
                        onTap:(){ BottomCallSheet(context);},
                      ),
                      GestureDetector(child: Icon(Icons.video_call,color: Colors.grey[400],size: 30.0,),
                      onTap: (){BottomVideoSheet(context);},),
                    ],
                  ),
                  
                  
                ],),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(Icons.person_pin,size: 40.0),
                        Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Mom',style:TextStyle(fontSize: 20.0,color: Colors.black,fontWeight:FontWeight.bold)),
                  ),
                      ],
                    ),
                
                  Row(
                    children: <Widget>[
                      GestureDetector(
                                              child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Icon(Icons.message,color: Colors.grey[400],size: 25.0,),
                          
                        ),
                        onTap:(){ BottomCallSheet(context);},
                      ),
                      GestureDetector(child: Icon(Icons.video_call,color: Colors.grey[400],size: 30.0,),
                      onTap: (){BottomVideoSheet(context);},),
                    ],
                  ),
                  
                  
                ],),
              ),
              Divider(),
            ],),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 15.0),
                child: FloatingActionButton(
                  onPressed: (){BottomCallSheet(context);},
                  child: Icon(Icons.message,color: Colors.white,),
                  backgroundColor: Colors.black87,
                  elevation: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 15.0),
                child: FloatingActionButton(
                  onPressed: (){
                    BottomVideoSheet(context);
                  },
                  child: Icon(Icons.video_call,color: Colors.white,size: 30.0,),
                  backgroundColor: Colors.black87,
                  elevation: 5.0,
                ),
              ),
            ],
          ),
        
        );
  }

  Widget BottomCallSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          height: 250.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Let\'s have a chat',style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  controller: number,
                  decoration: InputDecoration(hintText: "Enter mobile number",contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 5.0),
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  
                  controller: message,
                  decoration: InputDecoration(hintText: "Write message",contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 5.0),
                  )),
                ),
              ),
              new RaisedButton(
                onPressed: callservice,
                color: Colors.black,
                child: Text("Send",style: TextStyle(color: Colors.white,fontSize: 16.0),),
              )
            ],
          )
      
        );}
    );

  }
  Widget BottomVideoSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return  Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 12.0),
                    child: Text('Facetime with Nanda',style:TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold)),
                  ),
                   Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                            errorText: _validateError
                                ? "Channel name is mandatory"
                                : null,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                            border: OutlineInputBorder(

                                borderSide: BorderSide(width: 1)),
                            hintText: 'Channel name'),
                    ),
                        
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              
                              onPressed: () => onJoin(),
                              child: Text("Join",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ))
                ],
              )
        );
      }
    );
}
onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new CallPage(
                    channelName: _channelController.text,
                  )));
    }
  }

  _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}