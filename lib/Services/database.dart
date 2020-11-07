import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference.
  // ignore: deprecated_member_use
  final CollectionReference ClientCollection =
      FirebaseFirestore.instance.collection('clients');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('produit');

  void ajouterclient(
      String nom, String email, int phone, String URL, String Secteur) async {
    DocumentReference ref = await ClientCollection.add({
      'nom': nom,
      'phone': phone,
      'email': email,
      'Secteur': Secteur,
      'URL': URL,
    });
  }

  void updateclient(String docid, String nom, String email, int phone,
      String URL, String Secteur) {
    try {
      ClientCollection.doc(docid).update({
        'nom': nom,
        'phone': phone,
        'email': email,
        'Secteur': Secteur,
        'URL': URL,
      });
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

  void addproductstock(String reference, String marque, int baseprice,
      int nbunitstock, int promprice) async {
    await productCollection.add({
      'reference': reference,
      'marque': marque,
      'baseprice': baseprice,
      'nbunitstock': nbunitstock,
      'promprice': promprice,
      'nbunitfourgon': 0,
      'nbvente': 0,
    });
  }

  void updateproduct(String prodid, String reference, String marque,
      int baseprice, int nbunitstock, int promprice, int nbunitfourgon) {
    try {
      productCollection.doc(prodid).update({
        'reference': reference,
        'marque': marque,
        'baseprice': baseprice,
        'nbunitstock': nbunitstock,
        'promprice': promprice,
        'nbunitfourgon': nbunitfourgon,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteproduct(String prodid) {
    try {
      productCollection.doc(prodid).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
