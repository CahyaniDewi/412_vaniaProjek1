import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/product.dart';

class ProductController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'prod_name': 'required',
      'prod_price': 'required|numeric',
    }, {
      'prod_name.required': 'Nama produk tidak boleh kosong',
      'prod_price.required': 'Harga produk tidak boleh kosong',
      'prod_price.numeric': 'Harga produk harus berupa angka',
    });

    final dataProduct = req.input();
    dataProduct['created_at'] = DateTime.now().toIso8601String();

    final existingProduct = await Product()
        .query()
        .where('prod_name', '=', dataProduct['prod_name'])
        .first();
    if (existingProduct != null) {
      return Response.json({'message': 'Produk sudah ada'}, 409);
    }

    await Product().query().insert(dataProduct);

    return Response.json({
      'message': 'Produk berhasil dibuat',
      'data': dataProduct,
    }, 200);
  }

  Future<Response> show() async {
    final dataProduct = await Product().query().get();
    return Response.json({
      'message': 'success',
      'data': dataProduct,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      'prod_name': 'required',
      'prod_price': 'required|numeric',
    }, {
      'prod_name.required': 'Nama produk tidak boleh kosong',
      'prod_price.required': 'Harga produk tidak boleh kosong',
      'prod_price.numeric': 'Harga produk harus berupa angka',
    });

    final dataProduct = req.input();
    final existingProduct =
        await Product().query().where('prod_id', '=', id).first();

    if (existingProduct == null) {
      return Response.json({'message': 'Produk tidak ditemukan'}, 404);
    }

    await Product().query().where('prod_id', '=', id).update(dataProduct);

    return Response.json({
      'message': 'Produk berhasil diperbarui',
      'data': dataProduct,
    }, 200);
  }

  Future<Response> delete(String id) async {
    final existingProduct =
        await Product().query().where('prod_id', '=', id).first();
    if (existingProduct == null) {
      return Response.json({'message': 'Produk tidak ditemukan'}, 404);
    }

    await Product().query().where('prod_id', '=', id).delete();

    return Response.json({
      'message': 'Produk berhasil dihapus',
    }, 200);
  }
}

final ProductController productController = ProductController();
