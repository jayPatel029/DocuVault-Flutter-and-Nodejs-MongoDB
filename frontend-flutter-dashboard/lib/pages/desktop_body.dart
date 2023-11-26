import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../constants.dart';
import '../services/nodejs_api.dart';



class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  String imagePath = '';
  bool isLoading = false;

  List<int>? _selectedFile;
  Uint8List? _bytesData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectedFile = _bytesData;
        });
      });
      reader.readAsDataUrl(file);
    });
  }



  // Future<void> uploadImage() async {
  //   if (_selectedFile == null) {
  //     // No file selected
  //     return;
  //   }
  //
  //   var url = Uri.parse("http://localhost:3000/products");
  //   var request = http.MultipartRequest("POST", url);
  //
  //   // Extract file name from the html.File object
  //
  //   request.files.add(
  //     http.MultipartFile.fromBytes(
  //       'file',
  //       _selectedFile!,
  //       contentType: MediaType('application', 'json'), // Update with the correct content type
  //       filename: ('image.png'),
  //     ),
  //   );
  //
  //   try {
  //     var response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print("File uploaded successfully");
  //     } else {
  //       print('File upload failed with status ${response.statusCode}');
  //       // Handle the error, throw an exception, or show an error message
  //     }
  //   } catch (error) {
  //     print('Error uploading file: $error');
  //     // Handle the error, throw an exception, or show an error message
  //   }
  // }
  //


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: regNoController,
            decoration: const InputDecoration(labelText: 'Official RegNo.'),
          ),

          Divider(
            color: Colors.grey,
          ),
          ElevatedButton(
            onPressed: startWebFilePicker,
            child: Text('Pick Image'),
          ),

          Divider(
            color: Colors.teal,
          ),
          _bytesData != null
              ? Image.memory(_bytesData!, width: 200, height: 200)
              : Container(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            var data = {
              "name": nameController.text,
              "description": descriptionController.text,
              "regNo": regNoController.text,
            };

            try {
              // await uploadImage();
              // Simulate an API call (replace with your actual API call)
              await Future.delayed(const Duration(seconds: 2));
              Api.addDoc(data, _bytesData!);


              // Clear text fields
              nameController.clear();
              descriptionController.clear();
              regNoController.clear();

              // Close the dialog
              Navigator.pop(context);

              // Show a success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data submitted successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } catch (error) {
              // Handle errors (e.g., show an error message)
              print('Error submitting data: $error');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error submitting data. Please try again.'),
                  duration: Duration(seconds: 2),
                ),
              );
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.blue,
                ) // Show a loading indicator
              : const Text('Submit'),
        ),

      ],
    );
  }
}

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,

            // first half of page
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 59,
                    ),
                    Text(
                      "Secure and simple document storage",
                      style: GoogleFonts.neuton(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          height: 400,
                          width: 400,
                          child: Column(
                            children: [
                              Text(
                                'Click to add a document',
                                style: GoogleFonts.neuton(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddProductDialog();
                                        });
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.grey,
                                    size: 140,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    //

                    SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(),
                      ),
                      height: 400,
                      width: 700,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Online document storage",
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Storing, organizing, and accessing your digital files, photos, and videos in a central and secure storage space can be challenging. It’s often difficult to store documents efficiently without taking up vast amounts of physical space for records storage or using valuable resources for records management.",
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // second half of page
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[400],
                      ),
                      // child: Image.network(
                      //   "https://i.postimg.cc/g0VYNP4H/IMG-20231125-115243.jpg",
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
