import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
      firebaseStorage: FirebaseStorage.instance),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
//Now we upload and save files in a path
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
//Now when we upload to firebase storage, we get the download Url
//Then we save it to firestore
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
//Returning a string in an async function makes it a Future<String>
  }
}
