import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/customer.dart';

class CustomerController extends Controller {
  // Create a new customer
  Future<Response> create(Request req) async {
    try {
      req.validate({
        'cust_name': 'required',
        'cust_address': 'required',
        'cust_city': 'required',
        'cust_country': 'required',
        'cust_telp': 'required',
      });

      final dataCustomer = req.input();
      dataCustomer['created_at'] = DateTime.now().toIso8601String();

      final existingCustomer = await Customer()
          .query()
          .where('cust_name', '=', dataCustomer['cust_name'])
          .where('cust_city', '=', dataCustomer['cust_city'])
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
      return Response.json({
        'message': 'Terjadi kesalahan pada server',
        'error': e.toString(),
      }, 500);
    }
  }

  // Retrieve all customers
  Future<Response> show() async {
    try {
      final dataCustomer = await Customer().query().get();
      return Response.json({
        'message': 'success',
        'data': dataCustomer,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan pada server',
        'error': e.toString(),
      }, 500);
    }
  }
  Future<Response> update(Request req, String id) async {
    try {
      req.validate({
        'cust_name': 'required',
        'cust_address': 'required',
        'cust_city': 'required',
        'cust_country': 'required',
        'cust_telp': 'required',
      });

      final dataCustomer = req.input();
      dataCustomer['updated_at'] = DateTime.now().toIso8601String();

      print("Updating customer with id: $id");
      print("Input data: $dataCustomer");

      // Ensure `id` is parsed correctly as an integer
      final existingCustomer = await Customer()
          .query()
          .where('cust_id', '=', int.parse(id)) // Parse id to int
          .first();

      print("Existing customer: $existingCustomer");

      if (existingCustomer == null) {
        return Response.json({'message': 'Customer tidak ditemukan'}, 404);
      }

      await Customer().query().where('cust_id', '=', int.parse(id)).update(dataCustomer);

      final updatedCustomer = await Customer()
          .query()
          .where('cust_id', '=', int.parse(id))
          .first();

      return Response.json({
        'message': 'Customer berhasil diperbarui',
        'data': updatedCustomer,
      }, 200);
    } catch (e) {
      print("Error: ${e.toString()}");
      return Response.json({
        'message': 'Terjadi kesalahan pada server',
        'error': e.toString(),
      }, 500);
    }
  }

  // Delete a customer by ID
  Future<Response> delete(String id) async {
    try {
      final existingCustomer =
          await Customer().query().where('cust_id', '=', int.parse(id)).first();
      if (existingCustomer == null) {
        return Response.json({'message': 'Customer tidak ditemukan'}, 404);
      }

      await Customer().query().where('cust_id', '=', int.parse(id)).delete();

      return Response.json({
        'message': 'Customer berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan pada server',
        'error': e.toString(),
      }, 500);
    }
  }
}

// Instance of CustomerController
final CustomerController customerController = CustomerController();
