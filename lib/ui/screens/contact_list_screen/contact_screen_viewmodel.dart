import 'package:contact_app/utils/locator/locator.dart';
import 'package:contact_app/utils/models/contact.dart';
import 'package:contact_app/utils/services/contact_service.dart';
import 'package:stacked/stacked.dart';

class ContactsScreenViewModel extends BaseViewModel {
  final _contactsService = locator<ContactsService>();

  late final updateContactDetails = _contactsService.updateContactDetails;

  List<Contact> get contacts => _contactsService.contacts;

  final List<Contact> _filteredContacts = [];

  List<Contact> get filteredContacts => _filteredContacts;

  ContactsScreenViewModel() {
    _contactsService.addListener(_onContactsChanged);
    _filteredContacts.addAll(contacts);
  }

  @override
  void dispose() {
    _contactsService.removeListener(_onContactsChanged);
    super.dispose();
  }

  void _onContactsChanged() {
    _filteredContacts.clear();
    _filteredContacts.addAll(contacts);
    notifyListeners();
  }

  void filterContacts(String query) {
    if (query.isEmpty) {
      _filteredContacts.clear();
      _filteredContacts.addAll(contacts);
    } else {
      _filteredContacts.clear();
      _filteredContacts.addAll(contacts.where((contact) =>
          '${contact.firstName} ${contact.lastName}'
              .toLowerCase()
              .contains(query.toLowerCase())));
    }
    notifyListeners();
  }
}
