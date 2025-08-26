class Meeting {
  Meeting(this.eventName, this.from, this.to,
      {this.nomContremaitre, this.nomApprenti, this.description, this.docId});

  String eventName;
  DateTime from;
  DateTime to;
  String? nomContremaitre;
  String? nomApprenti;
  String? description;
  String? docId; // ID du document Firestore
}
