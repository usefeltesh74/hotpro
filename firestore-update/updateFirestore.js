const admin = require('firebase-admin');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json'); // Path from working-directory


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  // No need for databaseURL if you're using Firestore
});

const db = admin.firestore();

async function updateDocuments() {
  const collectionRef = db.collection('fantasy'); // Replace with your collection name
  const snapshot = await collectionRef.get();

  snapshot.forEach(async (doc) => {
    const data = doc.data();
    const newValue = (data.yourfield || 0) + 10;  // Replace with your field and operation
    await doc.ref.update({ yourField: newValue }); // Replace with your field name
  });

  console.log('Documents updated successfully');
}

updateDocuments().catch(console.error);
