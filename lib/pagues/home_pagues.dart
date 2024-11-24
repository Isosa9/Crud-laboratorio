import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/services/firestore.dart';


class HomePagues extends StatefulWidget{
  const HomePagues({super.key})

//open dialog

  @override
  State<HomePagues> createState() => _HomePaguesState();
  }


class HomePaguesState extends State<HomePagues> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController textController = TextEditingController();
//open dialog
void openNoteBox({String? docID}){
  showDialog
  (context: context, 
  builder: (context) => AlertDialog(
    content: TextField(
  controller: textController,
),
actions: [
  ElevatedButton(
    onPressed: () {
  if (docID == null){
    firestoreService.addNote (textController.text);
  }

  else{
    firestoreService.addNote(textController.text);
  }
    textController.clear(); // Limpia el contenido del controlador
    Navigator.pop(context); // Cierra la página o diálogo
  },
  child: Text('Add'), // Texto dentro del botón
)

  
  
]
  ),
  );
}
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBar(title: Text("Notes")),
    floatingActionButton: FloatingActionButton(
      onPressed: openNoteBox,
      child: const Icon(Icons.add),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStrem()),
      builder: (context, snapshot){
         
         if snapshot.hasData){
          List notesList=snapshot.data!.docs;

         return ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index){
 
            DocumentSnapshot document = notesList(index);
            string docID = document.id;

            Map<String, dynamic> data=
             document.data() as Map<String, dynamic>;
            String noteText = data('note');

            return ListTile(
              title: Text(noteText),
              trailing: Row(
              mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed:()=> openNoteBox(docID: docID),
                 icon: const(Icons.settings),
                  ),

   IconButton(
                    onPressed:() => firestoreService.deleteNotas(docID),
                 icon: const Icon(Icons.delete),
                  ),

          },
         );
         }
        else {
          return const Text("No notes..")
        } 
      },
      ),
      );
}


      
    
  