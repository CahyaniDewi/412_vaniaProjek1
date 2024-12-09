import 'package:vania/vania.dart';

class CreateProductsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      string('prod_id', length: 10);
      char('vend_id', length: 5); // Tidak menggunakan references
      string('prod_name', length: 25);
      float('prod_price', precision: 10, scale: 2);
      text('prod_desc');
      timeStamps();
      primary('prod_id');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
