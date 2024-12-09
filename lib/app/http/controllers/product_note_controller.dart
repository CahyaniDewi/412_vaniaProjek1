import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/models/product_note.dart';

class ProductNoteController extends Controller {
  Future<Response> create(Request req) async {
    req.validate({
      'prod_id': 'required',
      'note_text': 'required',
    }, {
      'prod_id.required': 'Product ID tidak boleh kosong',
      'note_text.required': 'Catatan produk tidak boleh kosong',
    });

    final dataProductNote = req.input();
    dataProductNote['created_at'] = DateTime.now().toIso8601String();

    await ProductNote().query().insert(dataProductNote);

    return Response.json({
      'message': 'Product note berhasil dibuat',
      'data': dataProductNote,
    }, 200);
  }

  Future<Response> show() async {
    final dataProductNote = await ProductNote().query().get();
    return Response.json({
      'message': 'success',
      'data': dataProductNote,
    }, 200);
  }

  Future<Response> update(Request req, String id) async {
    req.validate({
      'prod_id': 'required',
      'note_text': 'required',
    }, {
      'prod_id.required': 'Product ID tidak boleh kosong',
      'note_text.required': 'Catatan produk tidak boleh kosong',
    });

    final dataProductNote = req.input();
    final existingProductNote =
        await ProductNote().query().where('note_id', '=', id).first();

    if (existingProductNote == null) {
      return Response.json({'message': 'Product note tidak ditemukan'}, 404);
    }

    await ProductNote()
        .query()
        .where('note_id', '=', id)
        .update(dataProductNote);

    return Response.json({
      'message': 'Product note berhasil diperbarui',
      'data': dataProductNote,
    }, 200);
  }

  Future<Response> delete(String id) async {
    final existingProductNote =
        await ProductNote().query().where('note_id', '=', id).first();
    if (existingProductNote == null) {
      return Response.json({'message': 'Product note tidak ditemukan'}, 404);
    }

    await ProductNote().query().where('note_id', '=', id).delete();

    return Response.json({
      'message': 'Product note berhasil dihapus',
    }, 200);
  }
}

final ProductNoteController productNoteController = ProductNoteController();
