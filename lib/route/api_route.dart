import 'package:vania/vania.dart';
import 'package:projekcahya_vania/app/http/controllers/customer_controller.dart';
import 'package:projekcahya_vania/app/http/controllers/order_controlleroller.dart';
import 'package:projekcahya_vania/app/http/controllers/order_item_controlleroller.dart';
import 'package:projekcahya_vania/app/http/controllers/product_controller.dart';
import 'package:projekcahya_vania/app/http/controllers/product_note_controller.dart';
import 'package:projekcahya_vania/app/http/controllers/vendor_controlleroller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    // Customer Routes
    // Customer Routes
    Router.post('/create-customer', customerController.create);
    Router.get('/daftar-customer', customerController.show);
    Router.put('/update-customer/:id', customerController.update);
    Router.delete('/delete-customer/:id', customerController.delete);
    // Order Routes
    Router.post('/create-order', orderController.create);
    Router.get('/daftar-order', orderController.show);
    Router.put('/update-order/:id', orderController.update);
    Router.delete('/delete-order/:id', orderController.delete);

    // Vendor Routes
    Router.post('/create-vendor', vendorController.create);
    Router.get('/daftar-vendor', vendorController.show);
    Router.put('/update-vendor/:id', vendorController.update);
    Router.delete('/delete-vendor/:id', vendorController.delete);

    // Product Routes
    Router.post('/create-product', productController.create);
    Router.get('/daftar-product', productController.show);
    Router.put('/update-product/:id', productController.update);
    Router.delete('/delete-product/:id', productController.delete);

    // Product_ Routes
    Router.post('/create-product_', productNoteController.create);
    Router.get('/daftar-product_', productNoteController.show);
    Router.put('/update-product_/:id', productNoteController.update);
    Router.delete('/delete-product_/:id', productNoteController.delete);
 
    // OrderItem Routes
    Router.post('/create-order-item', orderItemController.create);
    Router.get('/daftar-order-item', orderItemController.show);
    Router.put('/update-order-item/:id', orderItemController.update);
    Router.delete('/delete-order-item/:id', orderItemController.delete);
  }
}

final ApiRoute apiRoute = ApiRoute();
