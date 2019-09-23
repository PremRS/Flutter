import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

const uploadImage = r"""
mutation($file: Upload!) {
  uploadFile(file:$file)
}
""";

String get host => Platform.isAndroid ? '10.0.2.2' : 'localhost';

class GraphQLUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpLink = HttpLink(uri: 'http://$host:4000/');

    var client = ValueNotifier(GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ));

    return GraphQLProvider(
      client: client,
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Image Upload'),
          ),
          body: ImageUpload(),
        ),
      ),
    );
  }
}

class ImageUpload extends StatefulWidget {
  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  File _image;
  bool _uploadInProgress = false;

  Future selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        if (_image != null)
          Flexible(
            flex: 9,
            child: Image.file(_image),
          )
        else
          Flexible(
            flex: 5,
            child: Center(
              child: Text('No Image Selected'),
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
                    Icon(Icons.photo_library),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Select File')
                  ],
                ),
                onPressed: () => selectImage(),
              ),
              if (_image != null)
                Mutation(
                  options: MutationOptions(
                    document: uploadImage,
                  ),
                  builder: (RunMutation runMutation, QueryResult result) {
                    return FlatButton(
                      child: _isLoadingInProgress(),
                      onPressed: () {
                        
                        setState(() {
                          _uploadInProgress = true;
                        });

                        var byteData = _image.readAsBytesSync();

                        
                        var multipartFile = MultipartFile.fromBytes(
                          'pic',
                          byteData,
                          filename: 'Pic@${DateTime.now().minute}.jpg',
                          contentType: MediaType("image", "jpg"),
                        );

                        runMutation(<String, dynamic>{
                          "file": multipartFile,
                        });
                      },
                    );
                  },
                  onCompleted: (d) {
                    print(d);
                    setState(() {
                      _uploadInProgress = false;
                    });
                  },
                  update: (cache, results) {
                    var message = results.hasErrors
                        ? '${results.errors.join(",")}'
                        : "Image Uploaded Successfully";

                    final snackBar = SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.blue,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                ),
            ],
          ),
        )
      ],
    ));
  }

Widget _isLoadingInProgress() {
  return _uploadInProgress
        ? CircularProgressIndicator(backgroundColor: Colors.blue,)
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
