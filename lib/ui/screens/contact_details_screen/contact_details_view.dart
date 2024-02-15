import 'package:contact_app/ui/screens/contact_details_screen/contact_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class ContactDetailsView extends StatelessWidget {
  final String? contactId;

  const ContactDetailsView({Key? key, this.contactId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactDetailsViewModel>.reactive(
      viewModelBuilder: () => ContactDetailsViewModel(contactId: contactId),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text(contactId != null ? 'Edit Contact' : 'Add Contact'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: model.firstName,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onChanged: model.updateFirstName,
                ),
                TextFormField(
                  initialValue: model.lastName,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onChanged: model.updateLastName,
                ),
                TextFormField(
                  initialValue: model.phoneNumber,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  onChanged: model.updatePhoneNumber,
                ),
                TextFormField(
                  initialValue: model.nickName,
                  decoration: const InputDecoration(labelText: 'NickName'),
                  onChanged: model.updateNickName,
                ),
                TextFormField(
                  initialValue: model.email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: model.updateEmail,
                ),
                TextFormField(
                  initialValue: model.notes,
                  decoration: const InputDecoration(labelText: 'Notes'),
                  onChanged: model.updateNotes,
                ),
                TextFormField(
                  initialValue: model.relationship,
                  decoration: const InputDecoration(labelText: 'Relationship'),
                  onChanged: model.updateRelationship,
                ),
                const SizedBox(height: 16),
                const Text('Groups:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: model.groupController,
                        decoration:
                            const InputDecoration(labelText: 'Add a group'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () =>
                          model.addGroup(model.groupController.text),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(model.groups[index]);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    model.saveContact();
                    context.pop();
                  },
                  child:
                      Text(contactId != null ? 'Save Changes' : 'Add Contact'),
                ),
                const SizedBox(height: 16),
                if (contactId != null)
                  ElevatedButton(
                    onPressed: () {
                      model.deleteContact();
                      context.pop();
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    child: const Text('Delete Contact'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
