const admin = require('firebase-admin');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json'); // Path from working-directory

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// Ownership Multiplier and Divider List
const ownershipMultiplierDivider = [
  { ownership: 0, multiplier: 1.6, divider: 1.1 },
  { ownership: 2, multiplier: 1.58, divider: 1.12 },
  { ownership: 4, multiplier: 1.55, divider: 1.15 },
  { ownership: 6, multiplier: 1.52, divider: 1.18 },
  { ownership: 8, multiplier: 1.49, divider: 1.21 },
  { ownership: 10, multiplier: 1.46, divider: 1.24 },
  { ownership: 12, multiplier: 1.43, divider: 1.27 },
  { ownership: 14, multiplier: 1.4, divider: 1.3 },
  { ownership: 16, multiplier: 1.37, divider: 1.33 },
  { ownership: 18, multiplier: 1.34, divider: 1.36 },
  { ownership: 20, multiplier: 1.3, divider: 1.4 },
  { ownership: 22, multiplier: 1.27, divider: 1.43 },
  { ownership: 24, multiplier: 1.24, divider: 1.46 },
  { ownership: 26, multiplier: 1.21, divider: 1.49 },
  { ownership: 28, multiplier: 1.18, divider: 1.52 },
  { ownership: 30, multiplier: 1.15, divider: 1.55 },
  { ownership: 32, multiplier: 1.12, divider: 1.58 },
  { ownership: 34, multiplier: 1.1, divider: 1.61 },
  { ownership: 36, multiplier: 1.1, divider: 1.64 },
  { ownership: 38, multiplier: 1.1, divider: 1.67 },
  { ownership: 40, multiplier: 1.1, divider: 1.7 }
];

// Team Ranking Multiplier and Divider List
const teamRankingMultiplierDivider = [
  { teamRanking: 1, multiplier: 1.1, divider: 1.6 },
  { teamRanking: 2, multiplier: 1.13, divider: 1.57 },
  { teamRanking: 3, multiplier: 1.16, divider: 1.54 },
  { teamRanking: 4, multiplier: 1.19, divider: 1.51 },
  { teamRanking: 5, multiplier: 1.22, divider: 1.48 },
  { teamRanking: 6, multiplier: 1.25, divider: 1.45 },
  { teamRanking: 7, multiplier: 1.28, divider: 1.42 },
  { teamRanking: 8, multiplier: 1.31, divider: 1.39 },
  { teamRanking: 9, multiplier: 1.34, divider: 1.36 },
  { teamRanking: 10, multiplier: 1.37, divider: 1.33 },
  { teamRanking: 11, multiplier: 1.4, divider: 1.3 },
  { teamRanking: 12, multiplier: 1.43, divider: 1.27 },
  { teamRanking: 13, multiplier: 1.46, divider: 1.24 },
  { teamRanking: 14, multiplier: 1.49, divider: 1.21 },
  { teamRanking: 15, multiplier: 1.52, divider: 1.18 },
  { teamRanking: 16, multiplier: 1.55, divider: 1.15 },
  { teamRanking: 17, multiplier: 1.58, divider: 1.12 },
  { teamRanking: 18, multiplier: 1.61, divider: 1.1 },
  { teamRanking: 19, multiplier: 1.64, divider: 1.1 },
  { teamRanking: 20, multiplier: 1.67, divider: 1.1 }
];

// Function to find the multiplier and divider for a given ownership value
function findOwnershipMultiplierDivider(value) {
  for (let i = 0; i < ownershipMultiplierDivider.length - 1; i++) {
    const current = ownershipMultiplierDivider[i];
    const next = ownershipMultiplierDivider[i + 1];

    if (value >= current.ownership && value < next.ownership) {
      return { multiplier: current.multiplier, divider: current.divider };
    }
  }
  return ownershipMultiplierDivider[ownershipMultiplierDivider.length - 1];
}

// Function to find the multiplier and divider for a given team ranking value
function findTeamRankingMultiplierDivider(value) {
  for (let i = 0; i < teamRankingMultiplierDivider.length - 1; i++) {
    const current = teamRankingMultiplierDivider[i];
    const next = teamRankingMultiplierDivider[i + 1];

    if (value >= current.teamRanking && value < next.teamRanking) {
      return { multiplier: current.multiplier, divider: current.divider };
    }
  }
  return teamRankingMultiplierDivider[teamRankingMultiplierDivider.length - 1];
}

function calc(ownershipfactor,rankingfactor,points,playerbet)
{
  if(points >= playerbet/10000)
  {
    const multfac = ownershipfactor.multiplier + rankingfactor.multiplier - 1;
    return playerbet*multfac;
  }
}

// Example Firestore Document Update
async function updateSpecificDocument() {
  try {
    const docRef = db.collection('fantasy').doc('0q82LrYr9tU8o95uKgT8RnRArng1');

    const doc = await docRef.get();
    if (!doc.exists) {
      console.log('No such document!');
      return;
    }

    // Example: Accessing data by string field names
    const ownershipValue = doc.get('player1ows');  // Accessing with string
    const teamRankingValue = doc.get('player1 team position');  // Accessing with string
    const player1points = doc.get("player1points");
    const player1bet = doc.get("player1bid");

    const ownershipData = findOwnershipMultiplierDivider(ownershipValue);
    const teamRankingData = findTeamRankingMultiplierDivider(teamRankingValue);

    const playerprofit = calc(ownershipData,teamRankingData,player1points,player1bet);


    console.log(`Ownership Multiplier: ${ownershipData.multiplier}, Divider: ${ownershipData.divider}`);
    console.log(`Team Ranking Multiplier: ${teamRankingData.multiplier}, Divider: ${teamRankingData.divider}`);

    // Update Firestore document with the new multiplier and divider values
    await docRef.update({
      profit : playerprofit
    });

    console.log('Document updated successfully');
  } catch (error) {
    console.error('Error updating document: ', error);
  }
}

updateSpecificDocument().catch(console.error);
