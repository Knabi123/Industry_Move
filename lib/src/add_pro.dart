import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_Pro extends StatefulWidget {
  const Add_Pro({super.key});

  @override
  State<Add_Pro> createState() => _Add_ProState();
}

class _Add_ProState extends State<Add_Pro> {
  final CollectionReference _Addtype = 
  FirebaseFirestore.instance.collection('Addtype');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      
      body: StreamBuilder(
        stream: _Addtype.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
        if(streamSnapshot.hasData){
          return ListView.builder(itemCount: streamSnapshot.data!.docs.length,
          itemBuilder: (Context, index){
            final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
            return Card(
              color: const Color.fromARGB(255,88,136,190),
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  // leading: CircleAvatar(
                  //   child: Text(documentSnapshot['Type'].toString(), 
                  //   style:TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black
                  //   ) ,),
                  //   radius: 17,
                  //   backgroundColor: Colors.white,),
                    title: Text(documentSnapshot['Type'],
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ) ,),
                ),
            );
          },
          );
        }
       return const Center();
      }),
    );
  }
}