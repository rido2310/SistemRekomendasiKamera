import 'package:camera_market_app/widgets/camera_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.waspasResult});
  static const routeName = '/resultPageRoute';

  final List<List> waspasResult;

  @override
  Widget build(BuildContext context) {
    final CollectionReference camera = FirebaseFirestore.instance.collection('camera');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 50,
          width: 90,
          child: Image.asset(
            'assets/icons/Logo.png',
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(18.0),
              child: const Text(
                'Rating Terbaik',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),

            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: waspasResult.length,
                itemBuilder: (context, index) {
                  final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                      waspasResult[index][2][0];
                  return CameraItem(documentSnapshot: documentSnapshot);
                },
              ),
            ),

            // StreamBuilder(
            //   stream: camera.snapshots(),
            //   builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            //     if (streamSnapshot.hasData) {
            //       return Flexible(
            //         child: GridView.builder(
            //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //           ),
            //           itemCount: streamSnapshot.data?.docs.length,
            //           itemBuilder: (context, index) {
            //             final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
            //             return CameraItem(documentSnapshot: documentSnapshot);
            //           },
            //         ),
            //       );
            //     } else {
            //       return const Center();
            //     }
            //   }
            // ),
          ],
        ),
      ),
    );
  }
}
