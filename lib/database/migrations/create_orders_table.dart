import 'package:vania/vania.dart';

class CreateOrdersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orders', () {
      integer('order_num');
      dateTime('order_date');
      string('cust_id', length: 5); // Tidak menggunakan references
      timeStamps();
      primary('order_num');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}
