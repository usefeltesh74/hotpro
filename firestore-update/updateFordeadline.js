const admin = require('firebase-admin');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function updateAllDocuments(GW) {
  try {
    // Fetch all documents in the 'fantasy' collection
    const querySnapshot = await db.collection('fantasy').get();

    // Loop through each document in the collection
    querySnapshot.forEach(async (docSnapshot) => {
      const docRef = db.collection('fantasy').doc(docSnapshot.id);
      const doc = docSnapshot.data();  // Correct way to retrieve document data

      if (!doc) {
        console.log(`No such document: ${docSnapshot.id}`);
        return;
      }

      if (doc['play'] === true) {
        await docRef.update({
          playedthisGW: true,
          stand_player1: doc['player1'],
          stand_player1bet: doc['player1bid'],
          player1profit: 0,
          stand_player2: doc['player2'],
          stand_player2bet: doc['player2bid'],
          player2profit: 0,
          stand_player3: doc['player3'],
          stand_player3bet: doc['player3bid'],
          player3profit: 0,
          GWprofit: 0,
          stand_GW: GW,
        });
      } else {
        await docRef.update({
          play: true,
          playedthisGW: false,
          stand_GW: GW,
          GWprofit: 0,
          stand_player1: '',
          stand_player1bet: 0,
          player1profit: 0,
          stand_player2: '',
          stand_player2bet: 0,
          player2profit: 0,
          stand_player3: '',
          stand_player3bet: 0,
          player3profit: 0,
          'player1 team position': 0,
          player1id: 0,
          player1ows: 0.1,
          player1points: 0,
          player1price: 0.1,
          'player2 team position': 0,
          player2id: 0,
          player2ows: 0.1,
          player2points: 0,
          player2price: 0.1,
          'player3 team position': 0,
          player3id: 0,
          player3ows: 0.1,
          player3points: 0,
          player3price: 0.1,
          teamProfit: 0,
          teamPoints: 0,
        });
      }
    });
  } catch (error) {
    console.error('Error updating documents:', error);
  }
}

updateAllDocuments(5);
