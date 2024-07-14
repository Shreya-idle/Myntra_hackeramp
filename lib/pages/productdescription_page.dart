import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myntra_project/pages/Delivery_page1.dart';
import 'package:myntra_project/pages/virtualtryon_page.dart';

class ProductDescription  extends StatefulWidget {
  const ProductDescription({super.key, required this.title});
  final String title;
  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lorem ipsum dolor'),
          actions: [
            Icon(Icons.favorite_border),
            Icon(Icons.shopping_cart),
            SizedBox(width: 16),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/Homepage_images/productdescription.png', height: 600, fit: BoxFit.cover),
                        Container(
                          height: 600,
                          width: 180,
                          padding: EdgeInsets.all(8),
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 85),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Carbon Emission',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '39%',
                                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Fabric:\nPolyester\nCarbon rating:\n6.4KG CO₂',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                          Positioned(
                            left: 290,
                            child: Container(
                              height:100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54
                              ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder:(context)=> VirtualTryOn()));
                                        },
                                        child: Image.asset('assets/images/Homepage_images/camera.png',
                                            height: 45,
                                            width: 45,
                                           color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    Center(
                                      child: Text('Virtual Try on',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                       fontSize: 13,
                                          color: Colors.white
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          )

                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor Women Floral Printed Casual Shirt',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'MRP: ₹499',
                          style: TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '₹279 (72% OFF)',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hurry only 4 left!',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>DeliveryPage1(title: 'Myntra',)));
                      },
                      child: Text('Check earliest delivery'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Offers'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Myntra Bonus: Get upto 50 Myntra Coins'),
                          SizedBox(height: 8),
                          Text('Bank Offers: 10% Discount on RBL Credit Card. Max Discount Upto Rs. 1000 on every spend.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('More Offers'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}