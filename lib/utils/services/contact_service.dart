import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/contact.dart';

class ContactsService with ListenableServiceMixin {
  var _contacts = ReactiveValue<List<Contact>>(
    Hive.box('contacts').get('contacts', defaultValue: []).cast<Contact>(),
  );
  final _random = Random();

  List<Contact> get contacts => _contacts.value;

  ContactsService() {
    listenToReactiveValues([_contacts]);
  }

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('contacts').put('contacts', _contacts.value);

  void getAllContacts() {
    _contacts = ReactiveValue<List<Contact>>(
      Hive.box('contacts').get('contacts', defaultValue: []).cast<Contact>(),
    );
    notifyListeners();
  }

  void newContact({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String nickName = '',
    String email = '',
    List<String> groups = const [],
    String notes = '',
    String relationship = '',
  }) {
    final newContact = Contact(
      id: _randomId(),
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      nickName: nickName,
      email: email,
      groups: groups,
      notes: notes,
      relationship: relationship,
    );
    _contacts.value.insert(0, newContact);
    _saveToHive();
    notifyListeners();
  }

  bool removeContact(String id) {
    final index = _contacts.value.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updateContactDetails(String id, Contact updatedContact) {
    final index = _contacts.value.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts.value[index] = updatedContact;
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
