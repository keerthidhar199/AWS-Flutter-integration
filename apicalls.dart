import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:testing_app/main.dart';
import 'package:tuple/tuple.dart';

Future<dynamic> getS3image(String filename) async {
  Dio dio = new Dio();
  var s3image = {};
  //name of the file that you need to get from s3
  //get presigned url for uploading the file
  var response = await dio.get(
      //API GATEWAY link for presigned url
      "your api gateway link",
      queryParameters: {'file': filename, 'method': 'gets3'});

  // print(response.data.toString().length);

  return response.data;
}

Future<Tuple2<dynamic, List<Widget>>> getDynamoDbData() async {
  Dio dio = new Dio();
  var response = await dio.get("your_api_link/stage/your_resource_name");
  List<Widget> imagedata = [];
  print(response.data);
  return response.data;
}

getDynamoDbData() async {
  Dio dio = new Dio();
  var params = {
    "id": i[8]
        .toString()
        .trim(), //you wish to store the file in dynamodb with this name
    "info": i, //this is the data
  };
  await dio.put("your api gateway link", data: params);
}

putS3image() async {
  //get presigned url for uploading the file
  var response = await dio.get("your api gateway link",
      queryParameters: {'file': fileName, 'method': 'puts3'});

  //API GATEWAY link for presigned url
  //parse the response got from the above to form data.
  var parsed = jsonDecode(response.data);
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(f.path),
    "key": parsed['URL']['fields']['key'],
    "AWSAccessKeyId": parsed['URL']['fields']['AWSAccessKeyId'],
    "x-amz-security-token": parsed['URL']['fields']['x-amz-security-token'],
    "policy": parsed['URL']['fields']['policy'],
    "signature": parsed['URL']['fields']['signature'],
  });
  //parsing url that came from the same response
  var posturl = parsed['URL']['url'];
  //using post method send formdata to the above url.And the file will be uploaded to s3.
  var uploadedmessage = await dio.post(posturl, data: formData);
  print(uploadedmessage.statusCode);
}


//   Response response = await dio.put(
//       'https://ank2z4dbn1.execute-api.ap-southeast-1.amazonaws.com/s1/poleclimberhistory',
//       data: Stream.fromIterable(image.map((e) => [e])),
//       options: options);
//   return response.statusMessage;
// }
