import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Additems extends StatefulWidget {
  const Additems({super.key});

  @override
  _AdditemsState createState() => _AdditemsState();
}

class _AdditemsState extends State<Additems> {
  List<Map<String, String>> crops = [
    {"name": "Potato", "quantity": "50kg", "price": "10", "image": "assets/potato.jpeg"},
    {"name": "Wheat", "quantity": "50kg", "price": "10", "image": "assets/wheat2.jpeg"},
    {"name": "Tomato", "quantity": "50kg", "price": "10", "image": "assets/tomato.jpeg"},
    {"name": "Onion", "quantity": "50kg", "price": "10", "image": "assets/onion.jpeg"},
    
  ];

  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addCrop(String name, String quantity, String price, String imagePath) {
    setState(() {
      crops.add({"name": name, "quantity": quantity, "price": price, "image": imagePath});
    });
  }

  void _showAddCropDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Crop"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Crop Name'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantity Available'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(height: 10),
                _selectedImage == null
                    ? Text("No image selected")
                    : Image.file(_selectedImage!, height: 100, width: 100),
                TextButton.icon(
                  icon: Icon(Icons.image),
                  label: Text("Pick Image"),
                  onPressed: _pickImage,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addCrop(
                  nameController.text,
                  quantityController.text,
                  priceController.text,
                  _selectedImage?.path ?? "assets/vegfruits.jpeg",
                );
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bluebg = const Color.fromARGB(255, 76, 222, 230);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: bluebg,
        title: Text("Your Listed Items"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: crops.map((crop) {
                return Cropcard(
                  cropname: crop["name"]!,
                  cropquantity: crop["quantity"]!,
                  cropprice: crop["price"]!,
                  imagepath: crop["image"]!,
                );
              }).toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: bluebg,
        child: Icon(Icons.add, color: Colors.black, size: 35),
        onPressed: _showAddCropDialog,
      ),
    );
  }
}

class Cropcard extends StatelessWidget {
  final String cropname;
  final String cropquantity;
  final String cropprice;
  final String imagepath;

  const Cropcard({
    super.key,
    required this.cropname,
    required this.cropquantity,
    required this.cropprice,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextStyle cropdeets = TextStyle(
      color: const Color.fromARGB(255, 40, 39, 39),
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight * 0.15,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagepath,
                  fit: BoxFit.cover,
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.4,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cropname, style: cropdeets),
                    Text("Price: $cropprice", style: cropdeets),
                    Text("Available Quantity: $cropquantity", style: cropdeets),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
