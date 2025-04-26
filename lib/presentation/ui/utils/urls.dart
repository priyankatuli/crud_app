class Urls{

     static const String _baseUrl = 'https://crud.teamrabbil.com/api/v1';
     static const String getProductListUrls = '$_baseUrl/ReadProduct';
     static String deleteProductListUrls (String productId) => '$_baseUrl/DeleteProduct/$productId';
     static String updateProductListUrls (String productId) => '$_baseUrl/UpdateProduct/$productId';
     static const String createProductListUrls = '$_baseUrl/CreateProduct';




}