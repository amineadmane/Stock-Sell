import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  //collection reference.
  // ignore: deprecated_member_use
  final CollectionReference ClientCollection = FirebaseFirestore.instance.collection('clients');

  void createRecord(String nom , String  email,int phone , String URL , String Secteur) async {
    DocumentReference ref = await ClientCollection
        .add({
      'nom': nom,
      'phone': phone,
      'email': email,
      'Secteur' : Secteur,
      'URL' : URL,
    });
    print(ref.id);
  }
}
