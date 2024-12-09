import 'package:vania/vania.dart';

class CreateProductNotesTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('productnotes', () {
      char('note_id', length: 5);
      string('prod_id', length: 10); // Tidak menggunakan references
      dateTime('note_date');
      text('note_text');
      timeStamps();
      primary('note_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('productnotes');
  }
}
