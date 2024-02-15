import 'package:contact_app/ui/screens/contact_details_screen/contact_details_view.dart';
import 'package:contact_app/ui/screens/contact_list_screen/contact_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class ContactsListScreenView extends StatelessWidget {
  const ContactsListScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactsScreenViewModel>.reactive(
      viewModelBuilder: () => ContactsScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: model.filterContacts,
                decoration: const InputDecoration(
                  hintText: 'Search by name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: model.filteredContacts.length,
          itemBuilder: (context, index) {
            final contact = model.filteredContacts[index];
            return GestureDetector(
              onTap: () => context.go('/details/', extra: contact.id),
              child: ListTile(
                title: Text('${contact.firstName} ${contact.lastName}'),
                subtitle: Text(contact.phoneNumber),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const ContactDetailsView();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
