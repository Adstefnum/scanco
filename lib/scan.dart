import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanPage  extends StatefulWidget{

  ScanPageState createState() => ScanPageState();
 
}
 

class ScanPageState extends State<ScanPage> {
  String text = "Click the button to scan the code";
  bool visible = false;

  scan()async{
    String scanResult = await scanner.scan();
    setState((){
      text = scanResult;
      visible = true;
    }

    );
    
  }

Widget build(BuildContext context){
  final key = GlobalKey<ScaffoldState>();
  return Scaffold(
    key:key,
    backgroundColor:Colors.black,
    appBar: AppBar(
      title:Text("Scanco"),
    ),

    body:Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children:<Widget>[
        Visibility(
          visible:visible,
                  child: Center(child:Text("Hold down the text to copy", 
              style: TextStyle(color:Colors.white, fontSize:12.0)),),
        ),
            Divider(height:30.0),
        Center(
          child:GestureDetector(
                      child: Text(text, 
            style: TextStyle(color:Colors.white, fontSize:20.0)),
            onLongPress: () {
              Clipboard.setData(ClipboardData(text:text));
              key.currentState.showSnackBar(
                new SnackBar(content: Text("Copied to Clipboard"),)
              );
            },
          )
        )
      ]),
        floatingActionButton: FloatingActionButton(
        onPressed: scan,
        tooltip: 'Increment',
        child: Icon(Icons.camera),
      ),
    );}}