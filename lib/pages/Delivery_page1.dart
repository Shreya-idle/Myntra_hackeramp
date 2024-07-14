import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myntra_project/pages/PriorityDelivery_page.dart';
class DeliveryPage1 extends StatefulWidget {
  const DeliveryPage1({super.key, required this.title});
  final String title;


  @override
  State<DeliveryPage1> createState() => _DeliveryPage1State();
}
class _DeliveryPage1State extends State<DeliveryPage1>{
  String locationMessage ='Current Location of User';
  String deliveryStatusMessage = '';
  Future<Position> _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error(
        'Location permissions are permanently denied,we cannot request permission'
      );
    }
    }
    return await Geolocator.getCurrentPosition();
  }
  Future<void> _storeLocationInFirebase(Position position) async {
    await FirebaseFirestore.instance.collection('locations').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  Future<void> _fetchAndStoreLocation() async {
    try {
      Position position = await _getCurrentLocation();
      setState(() {
        locationMessage = 'Lat: ${position.latitude}, Long: ${position.longitude}';
      });
      await _storeLocationInFirebase(position);
      await _checkPriorityDelivery(position);
    } catch (e) {
      setState(() {
        locationMessage = 'Error fetching location: $e';
      });
    }
  }
  Future<void> _checkPriorityDelivery(Position userPosition) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('fixed_locations').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    const double priorityDistanceThreshold = 250000; // 50 km

    for (var doc in docs) {
      double latitude = double.tryParse(doc['latitude'].toString()) ?? 0.0;
      double longitude = double.tryParse(doc['longitude'].toString()) ?? 0.0;
      String locationName = doc['name'];

      double distanceInMeters = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        latitude,
        longitude,
      );

      if (distanceInMeters <= priorityDistanceThreshold) {
        setState(() {
          deliveryStatusMessage = 'Priority delivery available for $locationName';
        });
        return;
      }
    }

    setState(() {
      deliveryStatusMessage = 'Priority delivery not available for any location';
    });
  }



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(
       leadingWidth: 300,
       leading: Row(
         children: [
           IconButton(
             onPressed: () {
               Navigator.pop(context);
             },
             icon: Icon(
               Icons.arrow_back,
               size: 25,
               color: Colors.black,
             ),
           ),

           Image.asset(
             'assets/images/Homepage_images/Myntra_logo.png',
             width: 100,
             height: 250,
           ),
         ],
       ),
     ),
     body:
     SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(height: 24),
           Padding(
             padding: const EdgeInsets.only(left: 0),
             child: Text(
               'MYNTRA DELIVERY',
               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 45),
             child: Text(
               'Choose your Delivery Preference',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.black54,
               ),
             ),
           ),
           SizedBox(height: 18),
           Padding(
             padding: const EdgeInsets.only(left: 17.0),
             child: InkWell(
               onTap: _fetchAndStoreLocation,
               child: Container(
                 height: 45,
                 width: 360,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(50),
                   color: Color.fromRGBO(220, 217, 217, 1.0),
                 ),
                 child: Center(
                   child: Container(
                     height: 32,
                     child: Image.asset('assets/images/Homepage_images/delivery.png'),
                   ),
                 ),
               ),
             ),
           ),
           SizedBox(height: 15),
           Center(
             child: Text(
               'OR',
               style: TextStyle(
                 fontSize: 22,
                 color: Colors.black54,
               ),
             ),
           ),
           SizedBox(height: 15),
           Text(
             'Enter pincode to check delivery options',
             style: TextStyle(
               fontSize: 20,
               color: Colors.black54,
             ),
           ),
           SizedBox(height: 10),
           Container(
             height: 45,
             width: 360,
             decoration: BoxDecoration(
               border: Border.all(
                 color: Colors.black,
                 width: 1.5,
               ),
               borderRadius: BorderRadius.circular(15),
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: TextField(
                 decoration: InputDecoration(
                   hintText: 'Enter 6-digit Pincode',
                   hintStyle: TextStyle(
                     fontSize: 20,
                     color: Colors.black26,
                   ),
                   border: InputBorder.none,
                 ),
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.black,
                 ),
               ),
             ),
           ),
       
           SizedBox(height: 10),
           Row(
             children: [
               SizedBox(width: 15), // Adjust the width to align "State" text
               Text(
                 'State',
                 style: TextStyle(
                   fontSize: 18,
                   color: Colors.black38,
                 ),
               ),
             ],
           ),
           SizedBox(
             height: 5,
           ),
           Container(
             height: 45,
             width: 360,
             decoration: BoxDecoration(
               border: Border.all(
                 color: Colors.black,
                 width: 1.5,
               ),
               borderRadius: BorderRadius.circular(15),
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: TextField(
                 decoration: InputDecoration(
                   hintStyle: TextStyle(
                     fontSize: 20,
                     color: Colors.black26,
                   ),
                   border: InputBorder.none, // Remove the border around the input field
                 ),
                 style: TextStyle(
                   fontSize: 20,
                   color: Colors.black,
                 ),
               ),
             ),
           ),
           SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Row(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the cross axis (left side)
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 10), // Adjust the left padding for the whole column
                       child: Text(
                         'City',
                         style: TextStyle(
                           fontSize: 18,
                           color: Colors.black38,
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 10), // Adjust the left padding for the container
                       child: Container(
                         height: 45,
                         width: 150,
                         decoration: BoxDecoration(
                           border: Border.all(
                             color: Colors.black,
                             width: 1.5,
                           ),
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 15),
                           child: TextField(
                             decoration: InputDecoration(
                               hintStyle: TextStyle(
                                 fontSize: 20,
                                 color: Colors.black26,
                               ),
                               border: InputBorder.none, // Remove the border around the input field
                             ),
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.black,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(
                   width: 45,
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the cross axis (left side)
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 10), // Adjust the left padding for the whole column
                       child: Text(
                         'Country',
                         style: TextStyle(
                           fontSize: 18,
                           color: Colors.black38,
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 10), // Adjust the left padding for the container
                       child: Container(
                         height: 45,
                         width: 150,
                         decoration: BoxDecoration(
                           border: Border.all(
                             color: Colors.black,
                             width: 1.5,
                           ),
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: TextField(
                             decoration: InputDecoration(
                               hintStyle: TextStyle(
                                 fontSize: 20,
                                 color: Colors.black26,
                               ),
                               border: InputBorder.none, // Remove the border around the input field
                             ),
                             style: TextStyle(
                               fontSize: 20,
                               color: Colors.black,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
        SizedBox(
          height: 85,
        ),
       InkWell(
           // onTap:()async {
           //   try {
           //     Position userPosition = await _getCurrentLocation();
           //     await _checkPriorityDelivery(userPosition);
           //     Navigator.push(
           //       context,
           //       MaterialPageRoute(
           //         builder: (context) => PriorityDeliveryPage(
           //           deliveryStatusMessage: deliveryStatusMessage,
           //           title: 'Myntra',
           //         ),
           //       ),
           //     );
           //   } catch (e) {
           //     setState(() {
           //       deliveryStatusMessage = 'Error: $e';
           //     });
           //   }
           // },
         // onTap: () {
         //   Navigator.push(
         //     context,
         //     MaterialPageRoute(
         //       builder: (context) => PriorityDeliveryPage(
         //         title: 'Priority Delivery',
         //         deliveryStatusMessage: 'Testing Navigation',  // Temporary message
         //       ),
         //     ),
         //   );
         // },
         onTap: () async {
           print('Checking priority delivery...');
           Position userPosition = await _getCurrentLocation();
           await _checkPriorityDelivery(userPosition);
           print('Navigating to PriorityDeliveryPage');
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => PriorityDeliveryPage(
                 title: 'Priority Delivery',
                 deliveryStatusMessage: deliveryStatusMessage,
               ),
             ),
           );
         },
           child:Container(
               height: 45,
               width: 250,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                   'Check Delivery Date',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 20,
                   ),
                 ),
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                 color: Colors.pinkAccent,
               ),
             ),
           ),
       
         ],
       ),
     ),


   );
  }
}