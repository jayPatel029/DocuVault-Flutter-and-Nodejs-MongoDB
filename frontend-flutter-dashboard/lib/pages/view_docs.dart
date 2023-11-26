import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/model/doc_model.dart';
import 'package:intl/intl.dart';

import '../services/nodejs_api.dart';

class ViewDocs extends StatefulWidget {
  const ViewDocs({super.key});

  @override
  State<ViewDocs> createState() => _ViewDocsState();
}

class _ViewDocsState extends State<ViewDocs> {
  String? deletedDocName;
  Widget _buildDocumentList(List<Docs> docsData) {

    if(docsData.isEmpty) {
      return Center(child: Text("No Documents to show"),);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: docsData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(CupertinoIcons.doc_checkmark_fill),
            title: Text("${docsData[index].name}",
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
            subtitle: Text(
              "Tap to view",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey[500]),
            ),
            trailing: IconButton(
              onPressed: () async {
                deletedDocName = docsData[index].name;
                await Api.deleteDoc(docsData[index].id);
                docsData.remove(index);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Document $deletedDocName is deleted"),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.delete),
            ),
            onTap: () async{
              await _showDetailsAlertBox(context, docsData[index]);
              setState(() {
              });
            },
          );
        },
      ),
    );
  }

 Future<void> _showDetailsAlertBox(BuildContext context, Docs selectedDoc) async {
    final date = DateFormat.yMMMMd().format(selectedDoc.createdAt!);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Document Details"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${selectedDoc.name}"),
                const SizedBox(height: 8),
                const Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${selectedDoc.description}"),
                const SizedBox(height: 8),
                const Text(
                  "RegNo:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${selectedDoc.regNo}"),
                const SizedBox(height: 8),
                const Text(
                  "Created At:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("$date"),

                Image.memory(selectedDoc.image as Uint8List,width: 200, height: 200)
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(onPressed: () async {
                deletedDocName = selectedDoc.name;
                await Api.deleteDoc(selectedDoc.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Document $deletedDocName is deleted"),
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigator.of(context).pop();

              }, child: const Text("Delete"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        body: FutureBuilder(
          future: Api.getDoc(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(child: Text('No documents available.'));
            } else {
              List<Docs> docsData = snapshot.data;

              return Row(
                children: [
                  // open drawer
                  myDrawer,

                  // Main content area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('data'),

                          // List of documents
                          _buildDocumentList(docsData),
                          //   Expanded(
                          //   child: ListView.builder(
                          //   itemCount: docsData
                          //     .length, // Replace with the actual number of documents
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return ListTile(
                          //         leading:
                          //         Icon(CupertinoIcons.doc_checkmark_fill),
                          //         title: Text("${docsData[index].name}", style: TextStyle(color: Colors.black54),),
                          //         subtitle: Text("${docsData[index].description}"),
                          //         trailing: Text('$index'),
                          //         // Add any other properties you want for each document
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
