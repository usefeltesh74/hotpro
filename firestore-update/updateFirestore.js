const admin = require('firebase-admin');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json'); // Path from working-directory

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  // No need for databaseURL if you're using Firestore
});

const db = admin.firestore();

async function updateSpecificDocument() {
  try {
    // Replace with your collection name and document ID
    const docRef = db.collection('fantasy').doc('0q82LrYr9tU8o95uKgT8RnRArng1'); // Update with your specific document ID

    const doc = await docRef.get();
    if (!doc.exists) {
      console.log('No such document!');
      return;
    }

    const data = doc.data();
    const newValue = (data.profit || 3) + 10; // Replace with your field and operation

    await docRef.update({ yourField: newValue }); // Replace with your field name

    console.log('Document updated successfully');
  } catch (error) {
    console.error('Error updating document: ', error);
  }
}

updateSpecificDocument().catch(console.error);
