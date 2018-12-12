import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

class Third extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  String txtTitle, txtBody, txtId;

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
                  labelText: 'Id',
                ),
                onSaved: (input) => txtId = input,
                validator: (input) => input.length > 10 ? 'Max Length 2' : null,
              ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: delReq,
                      child: Text('Delete Data'),
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
      print(txtId);
      print(txtTitle);
      print(txtBody);


      var url = "http://harshmgor.pythonanywhere.com/api/data/"+txtId+"/";
      Map data = {
        'title': txtTitle.toString(),
        'body': txtBody.toString()
      };
      print(await apiRequest(url, data));

    }
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.putUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  void delReq() async{

    if(formkey.currentState.validate()){
      formkey.currentState.save();
      print(txtId);
      print(txtTitle);
      print(txtBody);


      var url = "http://harshmgor.pythonanywhere.com/api/data/"+txtId+"/";
      print(await apiDelRequest(url));

    }
  }

  Future<String> apiDelRequest(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

}