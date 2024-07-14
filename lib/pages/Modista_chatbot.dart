import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myntra_project/pages/Pair_finder.dart';

class ModistaChatbot extends StatefulWidget {
  @override
  _ModistaChatbotState createState() => _ModistaChatbotState();
}

class _ModistaChatbotState extends State<ModistaChatbot> {
  File? _imageFile;
  String? _imageUrl;
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Initialize Firebase
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Upload the picked image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('ModistaImages');
      Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

      await referenceImageToUpload.putFile(_imageFile!);
      _imageUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        _messages.add({'type': 'image', 'content': _imageUrl!});
        _imageFile = null; // Clear the selected image
      });
    } catch (error) {
      print("Error uploading image: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image')),
      );
    }
  }

  // Handle sending messages or uploading images
  void _handleSend() {
    if (_imageFile != null) {
      _uploadImage();
    } else if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add({'type': 'text', 'content': _textController.text});
        _textController.clear();
      });
    }
  }

  // Show options for picking an image
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(224, 152, 190, 1.0),
        title: Text(
          'Modista-AI Styler',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap:  (){Navigator.push(context,MaterialPageRoute(builder:(context)=>Pairfinder()));
              },
              child: Image.asset(
                'assets/images/Homepage_images/pairfinder.png',
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: _messages.map((message) {
                        if (message['type'] == 'text') {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(message['content']!),
                              ),
                            ),
                          );
                        } else if (message['type'] == 'image') {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(message['content']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              color: Color.fromRGBO(224, 152, 190, 1.0),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _handleSend,
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: _showImageSourceOptions,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
