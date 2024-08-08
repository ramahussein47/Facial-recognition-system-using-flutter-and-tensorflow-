import 'package:cloud_firestore/cloud_firestore.dart';

void storeEmbeddingsInFirebase(String name, List<double> embeddings) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a map to store in Firestore
    Map<String, dynamic> data = {
      'name': name,
      'embeddings': embeddings,
    };

    // Store data in Firestore
    await firestore.collection('face_embeddings').add(data);

    print("Embeddings stored successfully");
  } catch (e) {
    print("Error storing embeddings: $e");
  }
}
