import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

  //collection reference.
  // ignore: deprecated_member_use
  final CollectionReference ClientCollection = FirebaseFirestore.instance.collection('clients');
  final CollectionReference PlanningCollection = FirebaseFirestore.instance.collection('planification');

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

  void creerplanning(List<String> options , List<bool> selected,String jour)
  {
    List<String> selectedoptions = new List<String>();
    for (int i = 0; i < selected.length; i++) {
      if(selected[i]==true)
        {
          selectedoptions.add(options[i]);
        }
    }
    try {
      PlanningCollection.doc("5PAy3CuNNPPn4yJ4RG3r")
          .update({jour : selectedoptions});
    } catch (e) {
      print(e.toString());
    }
  }

  List<String> getdimanchesect()
  {
    List<String> Secteurs = new List<String>();
      PlanningCollection.doc("5PAy3CuNNPPn4yJ4RG3r").get().then((value) {
        return value.data()["dimanche"];
        });


  }

}
