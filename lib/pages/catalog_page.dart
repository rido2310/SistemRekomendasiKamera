import 'package:camera_market_app/widgets/camera_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);
  static const routeName = '/catalogPageRoute';

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final cameraCollection = FirebaseFirestore.instance.collection('camera');
  final TextEditingController searchInputController = TextEditingController();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraTempList = [];
  bool isLoading = true;

  Future<void> getCamera() async {
    isLoading = true;
    final result = await cameraCollection.get();

    setState(() {
      cameraList = result.docs;
      cameraList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
      cameraTempList = result.docs;
      cameraTempList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
      isLoading = false;
    });
  }

  void _onTapFilterCamera(String merek) {
    setState(() {
      if (searchInputController.text.isNotEmpty) {
        cameraList = cameraTempList
            .where((item) =>
                item.data()['merek'] == merek &&
                (item.data()['namaProduk'] as String)
                    .contains(searchInputController.text))
            .toList();
      } else {
        cameraList = cameraTempList
            .where((item) => item.data()['merek'] == merek)
            .toList();
      }

      cameraTempList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCamera();
    });

    super.initState();
  }

  @override
  void dispose() {
    searchInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        padding: const EdgeInsets.all(18.0),
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
            TextFormField(
              controller: searchInputController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Search camera",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchInputController.clear();
                      cameraList = cameraTempList;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  cameraList = cameraTempList
                      .where((item) =>
                          (item.data()['namaProduk'] as String).contains(value))
                      .toList();
                });
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Pilih Merek',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width,
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onTapFilterCamera("SONY");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      height: 40,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Text('SONY'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onTapFilterCamera("CANON");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      height: 40,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Text('CANON'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onTapFilterCamera("NIKON");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      height: 40,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Text('NIKON'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              // margin: const EdgeInsets.all(12.0),
              child: const Text(
                'Produk Kamera',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (!isLoading)
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: cameraList.length,
                  itemBuilder: (context, index) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        documentSnapshot = cameraList[index];

                    return CameraItem(documentSnapshot: documentSnapshot);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
