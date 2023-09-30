import 'package:danny_chats/common/widgets2/error.dart';
import 'package:danny_chats/common/widgets2/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
//Now we register the  Screen
  static const String routeName = '/select-contact';
  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
//cause it is a one time thing we use Read
    ref.read(selectContactControllerProvider).selectContact(
          selectedContact,
          context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select contact'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: ref.watch(getContactsProvider).when(
              data: (contactList) => ListView.builder(
                itemCount: contactList.length,
                itemBuilder: ((context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30,
                              ),
                      ),
                    ),
                  );
                }),
              ),
              error: (err, trace) => ErrorScreen(error: err.toString()),
              loading: () => Loader(),
            ));
  }
}
