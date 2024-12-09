import 'package:vania/vania.dart';

class CreateOrderItemsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      integer('order_item');
      integer('order_num');
      string('prod_id', length: 10); // Tidak menggunakan references
      integer('quantity');
      integer('size');
      timeStamps();
      primary('order_item');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}
