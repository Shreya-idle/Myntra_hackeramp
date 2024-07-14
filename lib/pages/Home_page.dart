import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myntra_project/pages/Modista_chatbot.dart';
import 'package:myntra_project/pages/productdescription_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading:
        Container(
          height: 120,
          child: Image.asset("assets/images/Homepage_images/Myntra_logo.png",
          fit: BoxFit.contain,
          ),
        ),
          actions: [
                 IconButton(
                     icon: SizedBox(
                          height:25,
                          width:30,
                          child: Image.asset("assets/images/Homepage_images/notifications.png")),
                          onPressed: (){},
                   ),
                IconButton(
                    icon: SizedBox(
                        height:30,
                        width:30,
                        child: Image.asset("assets/images/Homepage_images/like.png")),
                        onPressed: (){},
            ),
            IconButton(
              icon: SizedBox(
                  height:25,
                  width:30,
                  child: Image.asset("assets/images/Homepage_images/cart.png")),
              onPressed: (){},
            ),
        ]
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 40,
              width: 382,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 15),
                child: Text(
                  'Search for brands and Products',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 17),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Fashion',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Beauty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Accessories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Jewellery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/Homepage_images/choices.png',
          ),
          SizedBox(height: 10),
          Image.asset(
            'assets/images/Homepage_images/mstar.png',
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left:6),
            child: Container(
              height: 240,
              width: 380,
              child: Image.asset(
                'assets/images/Homepage_images/myntra_seasonsale.png',
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/Homepage_images/circles.png',
            ),
          ),
          Text(
            'Continue Browsing...',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.orange
            ),
          ),
          Row(
          children: [
           Container(
               height: 250,
               width: 170,
               child: InkWell(
                   child: Image.asset('assets/images/Homepage_images/pic1.png'),
               onTap:(){
                     Navigator.push(context,MaterialPageRoute(builder:(context)=> ProductDescription(title: 'Myntra',)));
               }
               )
           ),

            Container(
                height: 250,
                width: 170,
                child: InkWell(
                    child: Image.asset('assets/images/Homepage_images/pic2.png'),
                    onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder:(context)=> ProductDescription(title: 'Myntra',)));
                    }
                )),
          ],
          )
        ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ Navigator.push(context,MaterialPageRoute(builder:(context)=> ModistaChatbot()));},
        child: Image.asset('assets/images/Homepage_images/chatbot.png', height:38,color: Colors.pink,),
      ),

    );
  }
}

