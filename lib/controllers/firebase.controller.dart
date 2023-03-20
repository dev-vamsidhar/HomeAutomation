import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future saveData(
      {required String dbPath, required Map<String, dynamic> data}) async {
    DatabaseReference dbref = FirebaseDatabase.instance.ref("devices/$dbPath");
    await dbref.set(
      data,
    );
  }

  Future updateData(
      {required String dbPath, required Map<String, dynamic> data}) async {
    DatabaseReference dbref = FirebaseDatabase.instance.ref("$dbPath");
    await dbref.update(
      data,
    );
  }

  Future<DataSnapshot> getData({required String dbPath}) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref(dbPath).get();
    return snapshot;
  }

  Future deleteData() async {}
}
