
import 'package:flutter/material.dart';

class DressingRoom extends StatefulWidget {
  @override
  _DressingRoomState createState() => _DressingRoomState();
}

class _DressingRoomState extends State<DressingRoom> {
  @override
  void initState() {
    super.initState();
    // Show the image views dialog as soon as the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showImageViews(context);
    });
  }

  void _showImageViews(BuildContext context) {
    // List of image paths for different angles
    final List<String> images = [
      'assets/images/virtualtryon_images/droom3.png',  // Front view
      'assets/images/virtualtryon_images/droom4.png',   // Back view
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 600, // Set width as needed
            height: 600, // Set height as needed
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover, // Adjust fit as needed
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Dressing Room',
          style: TextStyle(
            fontSize: 24, // Customize font size
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromRGBO(224, 152, 190, 1.0), // Customize the background color
      ),
      body: Center(
        child: Text(
          'Loading views...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

