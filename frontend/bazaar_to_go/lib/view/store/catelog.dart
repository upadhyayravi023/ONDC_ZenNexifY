import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: ProductCatalogScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProductCatalogScreen extends StatefulWidget {
  @override
  _ProductCatalogScreenState createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final List<Map<String, dynamic>> products = [];
  final Map<String, List<String>> categoryTemplates = {
    'Electronics': ['Brand', 'Model', 'Price', 'Warranty'],
    'Clothing': ['Brand', 'Size', 'Material', 'Price'],
    'Books': ['Author', 'Genre', 'Price', 'Publisher'],
  };

  String? selectedCategory;
  Map<String, TextEditingController> fieldControllers = {};
  File? selectedImage;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () async {
                  final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      selectedImage = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      selectedImage = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _addProduct() {
    if (selectedCategory != null && selectedImage != null) {
      final productDetails = {
        'category': selectedCategory,
        'image': selectedImage,
        'details': fieldControllers.map((key, controller) =>
            MapEntry(key, controller.text)),
      };

      setState(() {
        products.add(productDetails);
        selectedCategory = null;
        selectedImage = null;
        fieldControllers.clear();
      });

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please complete all fields and select an image."),
        ),
      );
    }
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedCategory,
                    hint: Text('Select Category'),
                    items: categoryTemplates.keys.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        fieldControllers.clear();
                        for (var field in categoryTemplates[value!]!) {
                          fieldControllers[field] = TextEditingController();
                        }
                      });
                    },
                  ),
                  if (selectedCategory != null)
                    Column(
                      children: [
                        ...categoryTemplates[selectedCategory!]!.map((field) {
                          return TextField(
                            controller: fieldControllers[field],
                            decoration: InputDecoration(labelText: field),
                          );
                        }).toList(),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: Text('Pick Image'),
                        ),
                        if (selectedImage != null)
                          Image.file(selectedImage!, height: 100, width: 100),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showProductDetails(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${product['details']['Brand'] ?? product['details']['Author']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (product['image'] != null)
                Image.file(product['image'], height: 150, width: 150),
              SizedBox(height: 10),
              ...product['details'].entries.map((entry) {
                return Text('${entry.key}: ${entry.value}');
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
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
        title: Text('Product Catalog'),
      ),
      body: products.isEmpty
          ? Center(child: Text('No products added yet.'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: product['image'] != null
                  ? Image.file(product['image'], width: 50, height: 50)
                  : null,
              title: Text(product['details']['Brand'] ?? product['details']['Author'] ?? 'Unknown'),
              subtitle: Text(product['category']),
              onTap: () => _showProductDetails(product),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
