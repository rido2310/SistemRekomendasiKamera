import 'package:camera_market_app/pages/detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CameraItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  final double? q;

  const CameraItem({
    super.key,
    required this.documentSnapshot,
    this.q,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(documentSnapshot: documentSnapshot),
        ),
      ),
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              documentSnapshot['gambar'],
              fit: BoxFit.cover,
              width: size.width * 0.24,
              loadingBuilder: (context, child, event) => event == null
                  ? child
                  : SizedBox(
                      width: size.width * 0.24,
                      height: size.width * 0.24,
                      child: Center(
                        child: SizedBox(
                          width: size.width * 0.24,
                          height: size.width * 0.24,
                          child: CircularProgressIndicator(
                            value: event.cumulativeBytesLoaded /
                                (event.expectedTotalBytes ?? 1),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
              errorBuilder: (context, url, error) => Icon(
                Icons.broken_image_outlined,
                color: Colors.grey,
                size: size.width * 0.24,
              ),
            ),
            Text(
              documentSnapshot['namaProduk'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 14,
                  ),
            ),
            if (q != null)
              Text(
                "Q: $q",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
              ),
            Text(
              "Rp. ${documentSnapshot['harga']}",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
