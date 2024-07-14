import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Pairfinder extends StatefulWidget {
  @override
  State<Pairfinder> createState() => _PairfinderState();
}

class _PairfinderState extends State<Pairfinder> {
  final ImagePicker _picker = ImagePicker();
  late FirebaseStorage _storage;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp().then((_) {
      _storage = FirebaseStorage.instance;
    });
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      _uploading = true;
    });

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString() + "_" + imageFile.uri.pathSegments.last;
      final storageRef = _storage.ref().child('uploads/$fileName');
      await storageRef.putFile(imageFile);

      final downloadURL = await storageRef.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      print('Failed to upload image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image.')),
      );
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _uploadImage(File(pickedFile.path));
    }
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pair Finder',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        backgroundColor:  Color.fromRGBO(224, 152, 190, 1.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Homepage_images/img.png',),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:  Color.fromRGBO(250, 94, 144, 0.596078431372549),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.pink,
                  ),
                  onPressed: _showImageSourceDialog,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Find the right pair',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
