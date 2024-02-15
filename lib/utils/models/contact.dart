class Contact {
  final String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String nickName;
  String email;
  List<String> groups;
  String notes;
  String relationship;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.nickName = '',
    this.email = '',
    this.groups = const [],
    this.notes = '',
    this.relationship = '',
  });
}
