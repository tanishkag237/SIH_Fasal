import 'package:flutter/material.dart';

class Cropcard extends StatelessWidget {
  final String cropname;
  final String cropquantity;
  final String cropprice;
  final String imagepath;

  const Cropcard({super.key,
  required this.cropname,
  required this.cropquantity,
  required this.cropprice,
  required this.imagepath});
  


  @override
  Widget build(BuildContext context) {

    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenText = screenWidth * 0.05;
    TextStyle cropdeets=TextStyle(color: const Color.fromARGB(255, 40, 39, 39), fontSize: 17, fontWeight: FontWeight.bold);

    return  Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight*0.15,
                    child: Row(
                      
                      children: [
                        ClipRRect
                        (
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(imagepath, fit: BoxFit.cover,
                          height: screenHeight*0.15,
                          width: screenWidth*0.4,
                          )),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cropname, style: cropdeets,),
                                Text("Price: ${cropprice}",style: cropdeets,),
                                Text("Available Quantity :${cropquantity}",style: cropdeets,)
                              ],
                            ),
                          )
                      ]
                      
                    ),
                    
                  ),
                ),
              );
  }
}