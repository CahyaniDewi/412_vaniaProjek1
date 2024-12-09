import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/order_item.dart';

class OrderItemController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'order_num': 'required',
      'prod_id': 'required',
      'quantity': 'required|numeric',
    }, {
      'order_num.required': 'Order number tidak boleh kosong',
      'prod_id.required': 'Product ID tidak boleh kosong',
      'quantity.required': 'Quantity tidak boleh kosong',
      'quantity.numeric': 'Quantity harus berupa angka',
    });

    final dataOrderItem = req.input();
    dataOrderItem['created_at'] = DateTime.now().toIso8601String();

    await OrderItem().query().insert(dataOrderItem);

    return Response.json({
      'message': 'Order item berhasil dibuat',
      'data': dataOrderItem,
    }, 200);
  }

  Future<Response> show() async {
    final dataOrderItem = await OrderItem().query().get();
    return Response.json({
      'message': 'success',
      'data': dataOrderItem,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      'order_num': 'required',
      'prod_id': 'required',
      'quantity': 'required|numeric',
    }, {
      'order_num.required': 'Order number tidak boleh kosong',
      'prod_id.required': 'Product ID tidak boleh kosong',
      'quantity.required': 'Quantity tidak boleh kosong',
      'quantity.numeric': 'Quantity harus berupa angka',
    });

    final dataOrderItem = req.input();
    final existingOrderItem =
        await OrderItem().query().where('order_item', '=', id).first();

    if (existingOrderItem == null) {
      return Response.json({'message': 'Order item tidak ditemukan'}, 404);
    }

    await OrderItem()
        .query()
        .where('order_item', '=', id)
        .update(dataOrderItem);

    return Response.json({
      'message': 'Order item berhasil diperbarui',
      'data': dataOrderItem,
    }, 200);
  }

  Future<Response> delete(String id) async {
    final existingOrderItem =
        await OrderItem().query().where('order_item', '=', id).first();
    if (existingOrderItem == null) {
      return Response.json({'message': 'Order item tidak ditemukan'}, 404);
    }

    await OrderItem().query().where('order_item', '=', id).delete();

    return Response.json({
      'message': 'Order item berhasil dihapus',
    }, 200);
  }
}

final OrderItemController orderItemController = OrderItemController();
