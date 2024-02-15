import 'package:contact_app/utils/locator/locator.dart';
import 'package:contact_app/utils/models/contact.dart';
import 'package:contact_app/utils/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ContactDetailsViewModel extends BaseViewModel {
  final ContactsService _contactsService = locator<ContactsService>();
  final String? contactId;

  late Contact _contact;
  List<String> _groups = [];
  final groupController = TextEditingController();

  ContactDetailsViewModel({this.contactId}) {
    _contact = _contactsService.contacts.firstWhere(
      (contact) => contact.id == contactId,
      orElse: () => Contact(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
      ),
    );
    _groups = _contact.groups;
  }

  String get firstName => _contact.firstName;
  String get lastName => _contact.lastName;
  String get phoneNumber => _contact.phoneNumber;
  String get nickName => _contact.nickName;
  String get email => _contact.email;
  String get notes => _contact.notes;
  String get relationship => _contact.relationship;
  List<String> get groups => _contact.groups;

  void updateFirstName(String value) {
    _contact.firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    _contact.lastName = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _contact.phoneNumber = value;
    notifyListeners();
  }

  void updateNickName(String value) {
    _contact.nickName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _contact.email = value;
    notifyListeners();
  }

  void updateNotes(String value) {
    _contact.notes = value;
    notifyListeners();
  }

  void updateRelationship(String value) {
    _contact.relationship = value;
    notifyListeners();
  }

  void addGroup(String group) {
    if (!_groups.contains(group)) {
      _groups.add(group);
      notifyListeners();
    }
    groupController.clear();
  }

  void saveContact() {
    if (_contact.firstName.isNotEmpty &&
        _contact.lastName.isNotEmpty &&
        _contact.phoneNumber.isNotEmpty) {
      if (contactId != null) {
        _contactsService.updateContactDetails(contactId!, _contact);
      } else {
        _contactsService.newContact(
          firstName: _contact.firstName,
          lastName: _contact.lastName,
          phoneNumber: _contact.phoneNumber,
          nickName: _contact.nickName,
          email: _contact.email,
          notes: _contact.notes,
          relationship: _contact.relationship,
          groups: _groups,
        );
      }
    }
    _contactsService.getAllContacts();
  }

  void deleteContact() {
    if (contactId != null) {
      _contactsService.removeContact(contactId!);
    }
    _contactsService.getAllContacts();
  }
}
