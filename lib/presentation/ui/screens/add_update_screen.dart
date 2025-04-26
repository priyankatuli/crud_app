import 'dart:convert';
import 'package:crud_app/data/product_model.dart';
import 'package:crud_app/presentation/ui/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';



class AddUpdateScreen extends StatefulWidget{

  final ProductModel product;

  const AddUpdateScreen({super.key,required this.product});

  @override
  State<StatefulWidget> createState() {
    return _AddUpdateScreenState();
  }

}

class _AddUpdateScreenState extends State<AddUpdateScreen> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _getUpdateProductInProgress = false;

  @override
  void initState() {
    super.initState();

    _nameTEController.text = widget.product.productName ?? '';
    _productCodeTEController.text = widget.product.productCode ?? '';
    _unitPriceTEController.text = widget.product.unitPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.image ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Product'),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                      validator: (String ? value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Write the Product Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),

                    TextFormField(
                      controller: _productCodeTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'Product Code',
                          hintText: 'Product Code'
                      ),
                      validator: (String ? value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
                          return 'Write the Product code';
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
                      validator: (String ? value) {
                        if (value == null || value
                            .trim()
                            .isEmpty) {
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
                      validator: (String ? value) {
                        if (value == null || value.trim().isEmpty) {
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
                      validator: (String ? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Write the Total Price of Product';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: _imageTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          hintText: 'Product Image',
                          labelText: 'Image'
                      ),
                      validator: (String ? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter the path of Image';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16,),
                    Visibility(
                        visible: _getUpdateProductInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _updateProduct(widget.product.id!);
                              }
                            }, child: const Text("Update")))
                  ],
                )
            ),
          ),
        )
    );
  }

  Future<void> _updateProduct(String productId) async {

    _getUpdateProductInProgress = true;
    if(mounted) {
      setState(() {});
    }
    //String getUpdateProductUrl = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

    Map<String, String> inputData = {

      "Img": _imageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };

    Uri uri = Uri.parse(Urls.updateProductListUrls(productId));
    Response response = await post(
        uri, headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200 && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product has been Updated')),
      );
      Navigator.pop(context, true);
    }
    else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update Product Failed')),
        );
      }
    }

    _getUpdateProductInProgress = false;
    if(mounted) {
      setState(() {});
    }

  }

    @override
    void dispose() {
      _nameTEController.dispose();
      _unitPriceTEController.dispose();
      _quantityTEController.dispose();
      _totalPriceTEController.dispose();
      _imageTEController.dispose();
      _productCodeTEController.dispose();
      super.dispose();
    }

}