import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Second extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String txtTitle, txtBody;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSaved: (input) => txtTitle = input,
                validator: (input) => input.length > 10 ? 'Max Length 10' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Body',
                ),
                onSaved: (input) => txtBody = input,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: submit,
                      child: Text('Send Data'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() async{

    if(formkey.currentState.validate()){
      formkey.currentState.save();
      print(txtTitle);
      print(txtBody);


      var url = "http://harshmgor.pythonanywhere.com/api/data/";
      Map data = {
        'title': txtTitle.toString(),
        'body': txtBody.toString()
      };
      print(await apiRequest(url, data));

    }
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

}

