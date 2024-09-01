import 'package:flutter/material.dart';

class ItemsListed extends StatefulWidget {
  ItemsListed({super.key});

  @override
  State<ItemsListed> createState() => _ItemsListedState();
}

class _ItemsListedState extends State<ItemsListed> {
  List<String> cropNames = ["Tomato", "Onions", "Wheat"];
  List<String> cropQuantities = ["50kg", "60kg", "40kg"];
  List<String> cropPrices = ["100", "200", "300"];
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Color bluebg = const Color.fromARGB(255, 76, 222, 230);

    TextStyle cropDeets = const TextStyle(
      color: Color.fromARGB(255, 40, 39, 39),
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Listed Items'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: cropNames.length,
              itemBuilder: (BuildContext context, int index) {
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
                              "assets/wheat2.jpeg",
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
                                Text(
                                  cropNames[index],
                                  style: cropDeets,
                                ),
                                Text(
                                  "Price: ${cropPrices[index]}",
                                  style: cropDeets,
                                ),
                                Text(
                                  "Quantity: ${cropQuantities[index]}",
                                  style: cropDeets,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Color.fromARGB(255, 217, 32, 32)),
                            onPressed: () {
                              // Remove crop and update the state
                              setState(() {
                                cropNames.removeAt(index);
                                cropPrices.removeAt(index);
                                cropQuantities.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          FloatingActionButton(
            backgroundColor: bluebg,
            child: const Icon(Icons.add, color: Colors.black, size: 35),
            onPressed: () {
              showAddCropDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void showAddCropDialog(BuildContext context) {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Crop"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Crop Name"),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                final name = _nameController.text.trim();
                final price = _priceController.text.trim();
                final quantity = _quantityController.text.trim();

                if (name.isNotEmpty && price.isNotEmpty && quantity.isNotEmpty) {
                  setState(() {
                    cropNames.add(name);
                    cropPrices.add(price);
                    cropQuantities.add(quantity);
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
