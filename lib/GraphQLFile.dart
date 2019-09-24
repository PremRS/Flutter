import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

String get host => Platform.isAndroid ? '10.0.2.2' : 'localhost';

const UploadFile = r""" 
mutation($file:Upload!) {
  uploadFile(file:$file)
  }
""";

const UploadMultipleFiles = r""" 
mutation($file:[Upload!]!) {
  uploadMultipleFiles(file:$file)
  }
""";

class GraphQLFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpLink = HttpLink(uri: 'http://$host:4000/');

    var client =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: httpLink));

    return GraphQLProvider(
        client: client,
        child: Material(
            child: Scaffold(
          appBar: AppBar(
            title: Text('GraphQL File Upload'),
          ),
          body: FileUpload(),
        )));
  }
}

class FileUpload extends StatefulWidget {
  @override
  FileUploadState createState() => FileUploadState();
}

class FileUploadState extends State<FileUpload> {
  File _file;
  List<File> _multipleFiles;
  String _filePath;
  // Map<String, String> _multipleFilesPath;
  bool _multipleFilesStatus = false;
  bool _uploadInProgress = false;

  selectFile() async {
    try {
      if (_multipleFilesStatus) {
        var multipleFiles = await FilePicker.getMultiFile(type: FileType.ANY);

        setState(() {
          _multipleFiles = multipleFiles;
        });
      } 
      else {
        var file = await FilePicker.getFile(type: FileType.ANY);
        var filePath = file.toString().replaceAll("'", "");

        setState(() {
          _file = file;
          _filePath = filePath;
        });
      }

    } on PlatformException catch (e) {
      print('UnSupported Operation' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        if (_file != null && _filePath != null)
          Flexible(
            flex: 5,
            child: ListTile(
              title: Text('Single File '),
              subtitle: Text(_filePath),
            ),
          ),

        
        if (_multipleFiles != null)
          Flexible(
              flex: 5,
              child: Scrollbar(
                child: ListView.separated(
                  itemCount: _multipleFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'File $index '),
                      subtitle: Text(_multipleFiles
                          .toList()[index]
                          .toString()
                          .replaceAll("'", "")),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              )),
        Align(
          alignment: Alignment.topRight,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 300.0),
            child: SwitchListTile.adaptive(
              title: Text('Multiple Files', textAlign: TextAlign.right),
              onChanged: (bool value) =>
                  setState(() => _multipleFilesStatus = value),
              value: _multipleFilesStatus,
            ),
          ),
        ),
        Flexible(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.folder_open),
                  SizedBox(
                    width: 5,
                  ),
                  _multipleFilesStatus
                      ? Text('Select Multiple Files')
                      : Text('Select File')
                ],
              ),
              onPressed: () => selectFile(),
            ),
            
            if (_file != null ) 
              Mutation(
                options: MutationOptions(
                  document: UploadFile,
                ),
                builder: (RunMutation runMutation, QueryResult result) {
                  return FlatButton(
                    child: _isLoadingInProgress(),
                    onPressed: () {
                      setState(() {
                        _uploadInProgress = true;
                      });

                        var byteData = _file.readAsBytesSync();

                        var multipartFile = MultipartFile.fromBytes(
                            'file', byteData,
                            filename: _filePath);

                        runMutation(<String, dynamic>{
                          "file": multipartFile,
                        });
                      
                    },
                  );
                },
                onCompleted: (result) {
                  print(result);

                  setState(() {
                    _uploadInProgress = false;
                  });
                },
                update: (cache, results) {
                  var message = results.hasErrors
                      ? '${results.errors.join(",")}'
                      : "File Uploaded Successfully";

                  final snackBar = SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.blue[700],
                  );
                  Scaffold.of(context).showSnackBar(snackBar);

                  _file = results.hasErrors ? _file : null;
                  

                },
              ),
              if(_multipleFiles != null)
              Mutation(
                options: MutationOptions(
                  document: UploadMultipleFiles,
                ),
                builder: (RunMutation runMutation, QueryResult result) {
                  return FlatButton(
                    child: _isLoadingInProgress(),
                    onPressed: () {
                      setState(() {
                        _uploadInProgress = true;
                      });

                        List<MultipartFile> multipleFilesInList = [];
                      
                        // int index = 0;
                        for(var files in _multipleFiles)
                        {
                          var byteData = files.readAsBytesSync();

                        var multipartFile = MultipartFile.fromBytes(
                            'file', byteData,
                            filename: files
                          .toString()
                          .replaceAll("'", ""));

                        // setState(() {
                        //   if(!result.hasErrors)
                        //   _multipleFiles.removeAt(index);
                        // });
                        // index++;
                        multipleFilesInList.add(multipartFile);
                        }
                        
                        runMutation(<String, dynamic>{
                          "file": multipleFilesInList,
                        });
                      
                    },
                  );
                },
                onCompleted: (result) {
                  print(result);

                  setState(() {
                    _uploadInProgress = false;
                  });
                },
                update: (cache, results) {
                  var message = results.hasErrors
                      ? '${results.errors.join(",")}'
                      : "Multiple Files Uploaded Successfully";

                  final snackBar = SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.blue[700],
                  );
                  Scaffold.of(context).showSnackBar(snackBar);

                  _multipleFiles = results.hasErrors ? _multipleFiles : null;

                },
              ),
          ],
        ))
      ],
    ));
  }

  Widget _isLoadingInProgress() {
    return _uploadInProgress
        ? CircularProgressIndicator(
            backgroundColor: Colors.blue,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.file_upload),
              SizedBox(
                width: 5,
              ),
              Text('Upload File'),
            ],
          );
  }
}


                      
                        
                      