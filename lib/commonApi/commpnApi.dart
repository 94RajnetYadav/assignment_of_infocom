import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

commonApiPostRequest(
  Map data,
  String url,
  BuildContext context,
) async {
  String body = json.encode(data);
  log(url);
  log(body);
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  } catch (e) {
    // loading = false;
  }
}

commonApigetRequest(
  String url,
  BuildContext context,
) async {
  var headers = {'Content-Type': 'text/plain'};
  var request = http.Request('GET', Uri.parse(url));
  request.body = ''' ''';
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  final req = await response.stream.bytesToString();
  log("${req}");
  return req;

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }
}
