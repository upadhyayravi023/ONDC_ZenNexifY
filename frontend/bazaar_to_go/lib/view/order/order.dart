import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orderview extends StatelessWidget {
  const Orderview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StoreListScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Configure ScreenUtil
        final mediaQueryData = MediaQuery.of(context);
        final designSize = mediaQueryData.size.width > mediaQueryData.size.height
            ? const Size(800, 300)
            : const Size(300, 800);

        ScreenUtil.init(
          context,
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
        );

        return child!;
      },
    );
  }
}

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final List<Map<String, dynamic>> stores = [];
  final TextEditingController storeNameController = TextEditingController();

  void _createStore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Store'),
        content: TextField(
          controller: storeNameController,
          decoration: InputDecoration(labelText: 'Store Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                stores.add({'name': storeNameController.text, 'products': []});
                storeNameController.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteStore(int index) {
    setState(() {
      stores.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(stores[index]['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStore(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductListScreen(store: stores[index]),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _createStore,
              child: Text('Create Store'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final Map<String, dynamic> store;

  const ProductListScreen({Key? key, required this.store}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController productNameController = TextEditingController();

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Product'),
        content: TextField(
          controller: productNameController,
          decoration: InputDecoration(labelText: 'Product Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.store['products'].add(productNameController.text);
                productNameController.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      widget.store['products'].removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products - ${widget.store['name']}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.store['products'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.store['products'][index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}
