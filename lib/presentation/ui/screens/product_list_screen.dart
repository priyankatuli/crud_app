
import 'package:crud_app/data/product_model.dart';
import 'package:crud_app/presentation/ui/screens/add_product_list_screen.dart';
import 'package:crud_app/presentation/ui/screens/add_update_screen.dart';
import 'package:crud_app/presentation/ui/utils/urls.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget{
  const ProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductListScreenState();
  }

}

class  _ProductListScreenState extends State<ProductListScreen>{

  bool _getProductInProgress = false;
  List<ProductModel> productList = [];

  @override
  void initState(){
    super.initState();
    _getProductList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getProductList();
        },
        child: Visibility(
          visible: _getProductInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(

            ),
          ),
          child : ListView.separated(
            itemCount: productList.length,
            itemBuilder: (BuildContext context,int index){

              return _buildProductList(productList[index]);
            },
            separatorBuilder: (_, index) => const Divider(),
          ),
        ),),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductListScreen()),
          );
        },
        child: const Icon(Icons.add),

      ),

    );
  }

  Future<void> _getProductList() async{

    _getProductInProgress = true;
    if(mounted) {
      setState(() {});
    }

    productList.clear();
    //const String getProductListUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri =Uri.parse(Urls.getProductListUrls);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);
      final jsonProductList =decodedData['data'];

      // loop over the list
      for(Map<String,dynamic> json in jsonProductList){
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }

    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Get product list failed')),);
      }
    }

    _getProductInProgress =false;
    if(mounted) {
      setState(() {});
    }

  }

  Widget _buildProductList(ProductModel product) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        height: 60,
        child: product.image != null && product.image!.startsWith('http') ?
        Image.network(product.image!,
          fit: BoxFit.cover,
          errorBuilder: (context,error,stackTrace) => Icon(Icons.broken_image) )
            : Icon(Icons.image_not_supported)
        ),
      title:  Text(product.productName ?? 'Unknown'),
      subtitle:  Wrap(
        spacing: 16,
        children: [
          Text('Unit Price: ${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: ${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: () async{
            final result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUpdateScreen(product: product)),);
            if(result == true){
              _getProductList();
            }
          },
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: (){
            _showDeleteConfirmationDialog(product.id!);
          }, icon: const Icon(Icons.delete_outline_sharp)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String productId){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete'),
        content:const Text('Are you sure that you want to delete this product'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Cancel')),
          TextButton(onPressed: (){
            _deleteProduct(productId);
            Navigator.pop(context);
          }, child: const Text('Yes, delete')),
        ],
      );
    });
  }

  Future<void> _deleteProduct(String productId) async{

    _getProductInProgress = true;
    if(mounted) {
      setState(() {});
    }
    //String getDeleteProductUrl = 'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(Urls.deleteProductListUrls(productId));

    Response response = await get(uri);
   // print(response.statusCode);
   // print(response.body);

    if(response.statusCode == 200 && mounted){
      _getProductList();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleted')));
    }
    else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delete product failed !! Try Again')));
      }
    }
    _getProductInProgress = false;
    if(mounted) {
      setState(() {});
    }
  }
}

