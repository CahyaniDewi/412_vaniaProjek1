import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/customer.dart';

class CustomerController extends Controller {
  Future<Response> create(Request req) async {
    try {
      req.validate({
        'cust_name': 'required',
        'cust_address': 'required',
        'cust_city': 'required',
        'cust_country': 'required',
      });

      final dataCustomer = req.input();
      dataCustomer['created_at'] = DateTime.now().toIso8601String();

      final existingCustomer = await Customer()
          .query()
          .where('cust_name', '=', dataCustomer['cust_name'])
          .first();
      if (existingCustomer != null) {
        return Response.json({'message': 'Customer sudah ada'}, 409);
      }

      await Customer().query().insert(dataCustomer);

      final createdCustomer = await Customer()
          .query()
          .where('cust_name', '=', dataCustomer['cust_name'])
          .first();

      return Response.json({
        'message': 'Customer berhasil dibuat',
        'data': createdCustomer,
      }, 200);
    } catch (e) {
      return Response.json({'message': 'Terjadi kesalahan', 'error': e.toString()}, 500);
    }
  }

  Future<Response> show() async {
    try {
      final dataCustomer = await Customer().query().get();
      return Response.json({
        'message': 'success',
        'data': dataCustomer,
      }, 200);
    } catch (e) {
      return Response.json({'message': 'Terjadi kesalahan', 'error': e.toString()}, 500);
    }
  }

  Future<Response> update(Request req, String id) async {
    try {
      req.validate({
        'cust_name': 'required',
        'cust_address': 'required',
        'cust_city': 'required',
        'cust_country': 'required',
      });

      final dataCustomer = req.input();
      dataCustomer['updated_at'] = DateTime.now().toIso8601String();

      final existingCustomer =
          await Customer().query().where('id', '=', id).first();

      if (existingCustomer == null) {
        return Response.json({'message': 'Customer tidak ditemukan'}, 404);
      }

      await Customer().query().where('id', '=', id).update(dataCustomer);

      return Response.json({
        'message': 'Customer berhasil diperbarui',
        'data': dataCustomer,
      }, 200);
    } catch (e) {
      return Response.json({'message': 'Terjadi kesalahan', 'error': e.toString()}, 500);
    }
  }

  Future<Response> delete(String id) async {
    try {
      final existingCustomer =
          await Customer().query().where('id', '=', id).first();
      if (existingCustomer == null) {
        return Response.json({'message': 'Customer tidak ditemukan'}, 404);
      }

      await Customer().query().where('id', '=', id).delete();

      return Response.json({
        'message': 'Customer berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({'message': 'Terjadi kesalahan', 'error': e.toString()}, 500);
    }
  }
}

final CustomerController customerController = CustomerController();
