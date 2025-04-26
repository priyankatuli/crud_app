import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/urls.dart';


class AddProductListScreen extends StatefulWidget{
  const AddProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddProductListScreenState();
  }

}

class _AddProductListScreenState extends State<AddProductListScreen>{

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewProductInProgress = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Product'),
        ),
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Product Name',
                          labelText: 'Name'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the Product Name';
                        }
                        return null;
                        },
                    ),

                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _productCodeTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Product Code',
                          labelText: 'Product Code'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the Product Code';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _unitPriceTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Unit Price',
                          labelText: 'Unit Price'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the unit Price of Product';
                        }
                        return null;

                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _quantityTEController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Quantity',
                          labelText: 'Quantity'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the Quantity of Product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _totalPriceTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Total Price',
                          labelText: 'Total Price'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the Total Price of Product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _imageTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Product Image',
                          labelText: 'Image'
                      ),
                      validator: (String ? value){
                        if(value == null || value.trim().isEmpty){
                          return 'Write the Path of Image';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16,),
                    Visibility(
                        visible: _addNewProductInProgress == false,
                        replacement:  const Center(
                          child: CircularProgressIndicator(
                          ),
                        ),
                        child:  ElevatedButton(
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                _addProduct();
                                Navigator.pop(context);
                              }
                            }, child: const Text("Add"))
                    )
                  ],
                )
            ),
          )
        ),
    );
  }

  Future <void> _addProduct() async{

    _addNewProductInProgress =true;
     if(mounted) {
       setState(() {});
     }

    //String addNewProductUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Map<String, dynamic> inputData=
    {
      "Img":_imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };

    Uri uri = Uri.parse(Urls.createProductListUrls);
    Response response = await post(uri,
        body: jsonEncode(inputData),
        headers: {'content-type': 'application/json'}
    );
    print(response.statusCode);
    print(response.headers);
    print(response.body);

    if(response.statusCode == 200){
     _clearTextFields();
     if(mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('New Product Added')),);
     }} else {
      if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add New Product Failed')),);
    }
  }
    _addNewProductInProgress = false;
    if(mounted){
      setState(() {

      });
    }

  }

  void _clearTextFields(){
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _productCodeTEController.clear();
      _unitPriceTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
      _quantityTEController.clear();
  }

  @override
  void dispose(){
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();

  }

}