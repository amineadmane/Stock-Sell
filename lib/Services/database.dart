import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  //collection reference.
  // ignore: deprecated_member_use
  final CollectionReference ClientCollection = FirebaseFirestore.instance.collection('clients');

  void ajouterclient(String nom , String  email,int phone , String URL , String Secteur) async {
    DocumentReference ref = await ClientCollection
        .add({
      'nom': nom,
      'phone': phone,
      'email': email,
      'Secteur' : Secteur,
      'URL' : URL,
    });
  }

  void updateclient(String docid,String nom , String  email,int phone , String URL , String Secteur) {
    try {
      ClientCollection.doc(docid)
          .update({'nom': nom,
        'phone': phone,
        'email': email,
        'Secteur' : Secteur,
        'URL' : URL,});
    } catch (e) {
      print(e.toString());
    }
  }
  void deleteclient(String docid) {
    try {
      ClientCollection.doc(docid).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
