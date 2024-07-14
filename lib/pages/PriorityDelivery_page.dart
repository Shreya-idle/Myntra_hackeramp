
import 'package:flutter/material.dart';

class PriorityDeliveryPage extends StatelessWidget {
  final String title;
  final String deliveryStatusMessage;

  const PriorityDeliveryPage({
    Key? key,
    required this.title,
    required this.deliveryStatusMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            deliveryStatusMessage,
            style: TextStyle(fontSize: 24, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
