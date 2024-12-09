import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/vendor.dart';

class VendorController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'vend_name': 'required',
      'vend_address': 'required',
      'vend_country': 'required',
    }, {
      'vend_name.required': 'Nama vendor tidak boleh kosong',
      'vend_address.required': 'Alamat vendor tidak boleh kosong',
      'vend_country.required': 'Negara vendor tidak boleh kosong',
    });

    final dataVendor = req.input();
    dataVendor['created_at'] = DateTime.now().toIso8601String();

    final existingVendor = await Vendor()
        .query()
        .where('vend_name', '=', dataVendor['vend_name'])
        .first();
    if (existingVendor != null) {
      return Response.json({'message': 'Vendor sudah ada'}, 409);
    }

    await Vendor().query().insert(dataVendor);

    return Response.json({
      'message': 'Vendor berhasil dibuat',
      'data': dataVendor,
    }, 200);
  }

  Future<Response> show() async {
    final dataVendor = await Vendor().query().get();
    return Response.json({
      'message': 'success',
      'data': dataVendor,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      'vend_name': 'required',
      'vend_address': 'required',
      'vend_country': 'required',
    }, {
      'vend_name.required': 'Nama vendor tidak boleh kosong',
      'vend_address.required': 'Alamat vendor tidak boleh kosong',
      'vend_country.required': 'Negara vendor tidak boleh kosong',
    });

    final dataVendor = req.input();
    final existingVendor =
        await Vendor().query().where('vend_id', '=', id).first();

    if (existingVendor == null) {
      return Response.json({'message': 'Vendor tidak ditemukan'}, 404);
    }

    await Vendor().query().where('vend_id', '=', id).update(dataVendor);

    return Response.json({
      'message': 'Vendor berhasil diperbarui',
      'data': dataVendor,
    }, 200);
  }

  Future<Response> delete(String id) async {
    final existingVendor =
        await Vendor().query().where('vend_id', '=', id).first();
    if (existingVendor == null) {
      return Response.json({'message': 'Vendor tidak ditemukan'}, 404);
    }

    await Vendor().query().where('vend_id', '=', id).delete();

    return Response.json({
      'message': 'Vendor berhasil dihapus',
    }, 200);
  }
}

final VendorController vendorController = VendorController();
