import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myntra_project/pages/dressing_room.dart';
class VirtualTryOn extends StatefulWidget{
  @override
  State<VirtualTryOn> createState() => _VirtualTryOn();
}
 class _VirtualTryOn extends State<VirtualTryOn>{
  int _selectedIndex=-1;
  int  _selectedSizeIndex=-1;
  final List<String> images = [
    'assets/images/virtualtryon_images/vt1Tshirt.png',
    'assets/images/virtualtryon_images/vt2coat.png',
    'assets/images/virtualtryon_images/vt3gown.png',
    'assets/images/virtualtryon_images/vt4saree.png',
    'assets/images/virtualtryon_images/vt5pants.png',
  ];

  final List<String> sizeImages = [
    'assets/images/virtualtryon_images/vt6small.png',
    'assets/images/virtualtryon_images/vt7medium.png',
    'assets/images/virtualtryon_images/vt8large.png',
  ];
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

  Future<void> _chooseImageSource() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              child: Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  _uploadImage(File(pickedFile.path));
                }
              },
            ),
            TextButton(
              child: Text('Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _uploadImage(File(pickedFile.path));
                }
              },
            ),
          ],
        );
      },
    );
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

      // Optionally, show a message or perform additional actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded successfully!')));
    } catch (e) {
      print('Failed to upload image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image.')));
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(224, 152, 190, 1.0),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/virtualtryon_images/vt.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
         title: Center(child: Text('Try-On Magic',style: TextStyle(
             fontSize: 24,
             color: Colors.pink,
             fontWeight: FontWeight.bold),
         )),
         actions: [
           Padding(
             padding: const EdgeInsets.only(right: 9.0),
             child: Image.asset('assets/images/virtualtryon_images/dressingroom.png',
             ),
           ),
         ],
      ),
      body:
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:35, top: 65,),
              child: Text('Style Check',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
              ),
            ),

            Padding(
        padding: const EdgeInsets.only(left: 35 , top: 3, right: 15),
        child: Text('Swipe, Style, Slay! Dig through some clothes, hang em up, and then try em on in the Dressing Room!',
        style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        ),
        ),
            ),
          SizedBox(height: 18,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text('Category',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
          ),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    color: _selectedIndex == index ? Colors.pink : Color.fromRGBO(224, 152, 190, 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(images[index], width: 50, height: 50),
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text('Size',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,


              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSizeIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: _selectedSizeIndex == index ? Colors.pink : Color.fromRGBO(224, 152, 190, 1.0),
                      child: Center(
                        child: Image.asset(sizeImages[index], width: 50, height: 50),
                      ),
                    ),
                  ),
                );
              }),
            ),
              SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:20 ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 180,
                        child: Text('Time’s ticking-upload your image and shine bright!',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(width: 50,),
                        Container(
                          height: 60,
                          width: 60,
                          child: InkWell(
                            onTap:  _chooseImageSource,
                            child: Image.asset('assets/images/virtualtryon_images/upload.png',color: Colors.black, ),
                          ),
                          color: Color.fromRGBO(224, 152, 190, 1.0),
                        ),
                    ],
                  ),
                  InkWell(
                  onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>DressingRoom()));},
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.pink,
                      ),
                      child: Center(
                        child: Text(
                          'Try On',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



        ],

      ),


    );

  }
 }
