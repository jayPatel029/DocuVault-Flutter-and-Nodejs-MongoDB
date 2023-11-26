import 'dart:convert';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:responsivedashboard/model/doc_model.dart';

class Api {
  static const baseUrl = "http://localhost:3000";
  List<int>? _selectedFile;
  Uint8List? _bytesData;

  // static Future<void> addDoc(Map pData) async {
  //   print(pData);
  //
  //   var url = Uri.parse("$baseUrl/products");
  //
  //   try {
  //     final res = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(pData),
  //     );
  //
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       var data = jsonDecode(res.body.toString());
  //       print('API Response: $data');
  //     } else {
  //       print("Failed to add document. Status Code: ${res.statusCode}");
  //       throw Exception('Failed to add document');
  //     }
  //   } catch (err) {
  //     print('Error in addDoc: $err');
  //     throw err;
  //   }
  // }

  static Future<void> addDoc(Map pData, Uint8List imageBytes) async {
    var url = Uri.parse("$baseUrl/products");

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add form fields
    for (var entry in pData.entries) {
      request.fields[entry.key] = entry.value.toString();
    }

    // Add image as a file
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    try {
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(await response.stream.bytesToString());
        print('API Response: $data');
      } else {
        print("Failed to add document. Status Code: ${response.statusCode}");
        throw Exception('Failed to add document');
      }
    } catch (err) {
      print('Error in addDoc: $err');
      throw err;
    }
  }



  static Future<List<Docs>> getDoc() async {
    var url = Uri.parse("$baseUrl/products");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);

        // Updated code here
        List<Docs> docsList = data.map((json) => Docs.fromJson(json)).toList();
        return docsList;
            } else {
        print("Failed to get documents. Status Code: ${res.statusCode}");
        throw Exception('Failed to get documents');
      }
    } catch (err) {
      print('Error in getDocs: $err');
      throw err;
    }
  }



  // static Future<List<Docs>> getDoc() async {
  //   var url = Uri.parse("$baseUrl/products");
  //
  //   try {
  //     final res = await http.get(url);
  //
  //     if (res.statusCode == 200) {
  //       List<dynamic> data = jsonDecode(res.body);
  //       List<Docs> docsList = data.map((json) => Docs.fromJson(json)).toList();
  //       return docsList;
  //     } else {
  //       print("Failed to get documents. Status Code: ${res.statusCode}");
  //       throw Exception('Failed to get documents');
  //     }
  //   } catch (err) {
  //     print('Error in getDocs: $err');
  //     throw err;
  //   }
  // }

  // Function to extract name, description, and regNo from Docs list
  static List<Map<String, dynamic>> extractDocDetails(List<Docs> docsList) {
    return docsList.map((doc) {
      return {
        'name': doc.name,
        'description': doc.description,
        'regNo': doc.regNo,
        'image': doc.image,
      };
    }).toList();
  }

  static deleteDoc(id) async {
    var url = Uri.parse("${baseUrl}/products/$id");
    final res = await http.delete(url);
    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("Failed to delete data");
    }
  }

}
