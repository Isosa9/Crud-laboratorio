
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

//get notes
final CollectionReference notas = FirebaseFirestore.instance.collection("NOTAS ")

// Crate
Future<void> addNote(String note){
 return notas.add({
  'note': notas,
  'timestamp':Timestamp.now()
 });

}
Stream<QuerySnapshot> getNotesStrem(){
  final notesStream=
  notas.orderBy('tomestamp', descending: true).snapshots();

  return notesStream;
}

Future<void>updataNotas(String docID, String newNote){
  return notas.doc(docID).update('notas': newNote, 
  'timestamp' : Timestamp.now(),
  
});
}

Future<void> deleteNotas (String docID){
  return notas.doc(docID). delete();
}

}
