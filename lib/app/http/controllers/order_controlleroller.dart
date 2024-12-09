import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/order.dart';

class OrderController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'cust_id': 'required',
      'order_date': 'required|date',
    }, {
      'cust_id.required': 'Customer ID tidak boleh kosong',
      'order_date.required': 'Tanggal order tidak boleh kosong',
      'order_date.date': 'Format tanggal tidak valid',
    });

    final dataOrder = req.input();
    dataOrder['created_at'] = DateTime.now().toIso8601String();

    await Order().query().insert(dataOrder);

    return Response.json({
      'message': 'Order berhasil dibuat',
      'data': dataOrder,
    }, 200);
  }

  Future<Response> show() async {
    final dataOrder = await Order().query().get();
    return Response.json({
      'message': 'success',
      'data': dataOrder,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      'cust_id': 'required',
      'order_date': 'required|date',
    }, {
      'cust_id.required': 'Customer ID tidak boleh kosong',
      'order_date.required': 'Tanggal order tidak boleh kosong',
      'order_date.date': 'Format tanggal tidak valid',
    });

    final dataOrder = req.input();
    final existingOrder =
        await Order().query().where('order_num', '=', id).first();

    if (existingOrder == null) {
      return Response.json({'message': 'Order tidak ditemukan'}, 404);
    }

    await Order().query().where('order_num', '=', id).update(dataOrder);

    return Response.json({
      'message': 'Order berhasil diperbarui',
      'data': dataOrder,
    }, 200);
  }

  Future<Response> delete(String id) async {
    final existingOrder =
        await Order().query().where('order_num', '=', id).first();
    if (existingOrder == null) {
      return Response.json({'message': 'Order tidak ditemukan'}, 404);
    }

    await Order().query().where('order_num', '=', id).delete();

    return Response.json({
      'message': 'Order berhasil dihapus',
    }, 200);
  }
}

final OrderController orderController = OrderController();
