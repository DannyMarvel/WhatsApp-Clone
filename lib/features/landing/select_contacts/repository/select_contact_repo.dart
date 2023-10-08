import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danny_chats/common/widgets2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/user_model.dart';
import '../../auth/chats/screens/mobile_chat_screen.dart';

final selectContactRepositoryProvider =
    Provider((ref) => SelectContactRepository(
          firestore: FirebaseFirestore.instance,
        ));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll('', '');
        print(selectedContact.phones[0].number);
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(
            context,
            MobileChatScreen.routeName,
          arguments: {
          'name': userData.name, 
          'uid' : userData.uid,
          }
          );
        }
      }
      if (!isFound) {
        showSnackBar(
          context: context,
          content: 'This Number does not exist on this App!',
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
