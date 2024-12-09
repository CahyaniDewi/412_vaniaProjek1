import 'package:vania/vania.dart';

class CreateVendorsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('vendors', () {
      char('vend_id', length: 5);
      string('vend_name', length: 50);
      text('vend_address'); 
      string('vend_kota', length: 50); 
      string('vend_state', length: 50); 
      string('vend_zip', length: 10); 
      string('vend_country', length: 25);
      timeStamps();
      primary('vend_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('vendors');
  }
}
