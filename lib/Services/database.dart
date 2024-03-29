import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  //collection reference.
  // ignore: deprecated_member_use
  final CollectionReference ClientCollection =
      FirebaseFirestore.instance.collection('clients');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('produit');
  final CollectionReference PlanningCollection =
      FirebaseFirestore.instance.collection('planification');
  final CollectionReference VenteCollection =
      FirebaseFirestore.instance.collection('vente');
  final CollectionReference ProductCollection =
      FirebaseFirestore.instance.collection('produit');

  void ajouterclient(
      String nom, String email, int phone, String URL, String Secteur) async {
    await ClientCollection.add({
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

  void addproductstock(String reference, String marque, double baseprice,
      int nbunitstock, double promprice, double buyprice) async {
    await productCollection.add({
      'reference': reference,
      'marque': marque,
      'baseprice': baseprice,
      'nbunitstock': nbunitstock,
      'promprice': promprice,
      'nbunitfourgon': 0,
      'nbvente': 0,
      'buyprice': buyprice
    });
  }

  void updateproduct(
      String prodid,
      String reference,
      String marque,
      double baseprice,
      int nbunitstock,
      double promprice,
      int nbunitfourgon,
      double buyprice) {
    try {
      productCollection.doc(prodid).update({
        'reference': reference,
        'marque': marque,
        'baseprice': baseprice,
        'nbunitstock': nbunitstock,
        'promprice': promprice,
        'nbunitfourgon': nbunitfourgon,
        'buyprice': buyprice
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void creerplanning(List<String> options, List<bool> selected, String jour) {
    List<String> selectedoptions = new List<String>();
    for (int i = 0; i < selected.length; i++) {
      if (selected[i] == true) {
        selectedoptions.add(options[i]);
      }
    }
    try {
      PlanningCollection.doc("5PAy3CuNNPPn4yJ4RG3r")
          .update({jour: selectedoptions});
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

  Future<void> deletevente(
      String clientId, String productId, String date) async {
    var product = await ProductCollection.doc(productId).get();
    int nbproduitfourgon = product.get('nbunitfourgon');
    int nbvente = product.get('nbvente');

    var a = await FirebaseFirestore.instance
        .collection('vente')
        .where("client_id", isEqualTo: clientId)
        .where("date", isEqualTo: date)
        .where("product_id", isEqualTo: productId)
        .get();
    if (a.size != 0) {
      String docid = a.docs.first.id;
      int nb_product = a.docs.first.get('nb_product');
      try {
        ProductCollection.doc(productId).update({
          'nbunitfourgon': nbproduitfourgon + nb_product,
          'nbvente': nbvente - nb_product,
        });
        VenteCollection.doc(docid).delete();
      } catch (e) {
        print(e.toString());
      }
    } else {

    }
  }

  void savevente(
      String clientId,
      String client_name,
      String date,
      String productId,
      String marque,
      double unitprice,
      double prixpromotionel,
      double _couttotale,
      int nbProducts,
      String proddocid,
      double prix_achat,
      int restant) async {
    var product = await ProductCollection.doc(proddocid).get();
    int nbventeadd = product.get('nbvente');
    ProductCollection.doc(proddocid)
        .update({'nbunitfourgon': restant, 'nbvente': nbventeadd + nbProducts});

    var a = await FirebaseFirestore.instance
        .collection('vente')
        .where("client_id", isEqualTo: clientId)
        .where("date", isEqualTo: date)
        .where("product_id", isEqualTo: productId)
        .get();

    if (a.size != 0) {
      String docid = a.docs.first.id;
      int nb_product = a.docs.first.get('nb_product');
      double couttotale = a.docs.first.get('couttotale');
      try {
        VenteCollection.doc(docid).update({
          'nb_product': nb_product + nbProducts,
          'couttotale': couttotale + _couttotale,
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      await VenteCollection.add({
        'client_id': clientId,
        'client_name': client_name,
        'date': date,
        'product_id': productId,
        'nb_product': nbProducts,
        'marque': marque,
        'baseprice': unitprice,
        'prixpromo': prixpromotionel,
        'couttotale': _couttotale,
        'prix_achat':prix_achat,
      });
    }
  }

  todaystransaction(String client_id) {
    String currentdate =
        DateFormat('dd-MM-yyy').format(DateTime.now()).toString();
    return FirebaseFirestore.instance
        .collection('vente')
        .where("client_id", isEqualTo: client_id)
        .where("date", isEqualTo: currentdate)
        .get();
  }

  getProduct(String product_id) {
    return FirebaseFirestore.instance
        .collection('produit')
        .doc(product_id)
        .get();
  }

  getTotaltoday() {
    String currentdate =
        DateFormat('dd-MM-yyy').format(DateTime.now()).toString();
    return FirebaseFirestore.instance
        .collection('vente')
        .where("date", isEqualTo: currentdate)
        .get();
  }

  getnbproduitrestantfourgon() {
    return FirebaseFirestore.instance
        .collection('produit')
        .where("nbunitfourgon", isGreaterThan: 0)
        .get();
  }

  getnbarticlesachetesclient(String Clientid) {
    return FirebaseFirestore.instance
        .collection('vente')
        .where("client_id", isEqualTo: Clientid)
        .get();
  }

  getmostselledproducts() {
    return FirebaseFirestore.instance
        .collection('produit')
        .orderBy("nbvente", descending: true)
        .limit(3)
        .get();
  }
}
