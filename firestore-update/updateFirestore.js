const admin = require('firebase-admin');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json'); // Path from working-directory

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// Ownership Multiplier and Divider List
const ownershipMultiplierDivider = [
  { ownership: 0, multiplier: 0.6, divider: 0.1 },
  { ownership: 2, multiplier: 0.58, divider: 0.12 },
  { ownership: 4, multiplier: 0.55, divider: 0.15 },
  { ownership: 6, multiplier: 0.52, divider: 0.18 },
  { ownership: 8, multiplier: 0.49, divider: 0.21 },
  { ownership: 10, multiplier: 0.46, divider: 0.24 },
  { ownership: 12, multiplier: 0.43, divider: 0.27 },
  { ownership: 14, multiplier: 0.4, divider: 0.3 },
  { ownership: 16, multiplier: 0.37, divider: 0.33 },
  { ownership: 18, multiplier: 0.34, divider: 0.36 },
  { ownership: 20, multiplier: 0.3, divider: 0.4 },
  { ownership: 22, multiplier: 0.27, divider: 0.43 },
  { ownership: 24, multiplier: 0.24, divider: 0.46 },
  { ownership: 26, multiplier: 0.21, divider: 0.49 },
  { ownership: 28, multiplier: 0.18, divider: 0.52 },
  { ownership: 30, multiplier: 0.15, divider: 0.55 },
  { ownership: 32, multiplier: 0.12, divider: 0.58 },
  { ownership: 34, multiplier: 0.1, divider: 0.61 },
  { ownership: 36, multiplier: 0.1, divider: 0.64 },
  { ownership: 38, multiplier: 0.1, divider: 0.67 },
  { ownership: 40, multiplier: 0.1, divider: 0.7 }
];

// Team Ranking Multiplier and Divider List
const teamRankingMultiplierDivider = [
  { teamRanking: 1, multiplier: 0.1, divider: 0.6 },
  { teamRanking: 2, multiplier: 0.13, divider: 0.57 },
  { teamRanking: 3, multiplier: 0.16, divider: 0.54 },
  { teamRanking: 4, multiplier: 0.19, divider: 0.51 },
  { teamRanking: 5, multiplier: 0.22, divider: 0.48 },
  { teamRanking: 6, multiplier: 0.25, divider: 0.45 },
  { teamRanking: 7, multiplier: 0.28, divider: 0.42 },
  { teamRanking: 8, multiplier: 0.31, divider: 0.39 },
  { teamRanking: 9, multiplier: 0.34, divider: 0.36 },
  { teamRanking: 10, multiplier: 0.37, divider: 0.33 },
  { teamRanking: 11, multiplier: 0.4, divider: 0.3 },
  { teamRanking: 12, multiplier: 0.43, divider: 0.27 },
  { teamRanking: 13, multiplier: 0.46, divider: 0.24 },
  { teamRanking: 14, multiplier: 0.49, divider: 0.21 },
  { teamRanking: 15, multiplier: 0.52, divider: 0.18 },
  { teamRanking: 16, multiplier: 0.55, divider: 0.15 },
  { teamRanking: 17, multiplier: 0.58, divider: 0.12 },
  { teamRanking: 18, multiplier: 0.61, divider: 0.1 },
  { teamRanking: 19, multiplier: 0.64, divider: 0.1 },
  { teamRanking: 20, multiplier: 0.67, divider: 0.1 }
];

const priceMultiplierDivider = [
  { price: 4.5, multiplier: 0.6, divider: 0.2 },
  { price: 5, multiplier: 0.55, divider: 0.25 },
  { price: 5.5, multiplier: 0.5, divider: 0.3 },
  { price: 6, multiplier: 0.45, divider: 0.35 },
  { price: 6.5, multiplier: 0.4, divider: 0.4 },
  { price: 7, multiplier: 0.35, divider: 0.45 },
  { price: 7.5, multiplier: 0.3, divider: 0.5 },
  { price: 8, multiplier: 0.25, divider: 0.55 },
  { price: 8.5, multiplier: 0.25, divider: 0.57 },
  { price: 9.5, multiplier: 0.2, divider: 0.6 },
  { price: 10, multiplier: 0.2, divider: 0.6 },
  { price: 10.5, multiplier: 0.2, divider: 0.6 },
  { price: 12.5, multiplier: 0.15, divider: 0.7 },
  { price: 15, multiplier: 0.1, divider: 0.75 }
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

// Function to find the multiplier and divider for a given price value
function findPriceMultiplierDivider(value) {
  for (let i = 0; i < priceMultiplierDivider.length - 1; i++) {
    const current = priceMultiplierDivider[i];
    const next = priceMultiplierDivider[i + 1];

    if (value >= current.price && value < next.price) {
      return { multiplier: current.multiplier, divider: current.divider };
    }
  }
  return priceMultiplierDivider[priceMultiplierDivider.length - 1];
}

function calc(ownershipfactor, rankingfactor, pricefactor, points, playerbet) {
  if (points >= playerbet / 10000) {
    const multfac = ownershipfactor.multiplier + rankingfactor.multiplier + pricefactor.multiplier + 1;
    return playerbet * multfac;
  } else {
    const divfac = ownershipfactor.divider + rankingfactor.divider + pricefactor.divider + 1;
    return playerbet / divfac;
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

    /// Calculate profit and budget with the 3 players
    //PLAYER 1
    const ownership1Value = doc.get('player1ows');  // Accessing with string
    const teamRanking1Value = doc.get('player1 team position');  // Accessing with string
    const player1Price = doc.get("player1price");  // Fetch player price
    const player1points = doc.get("player1points");
    const player1bet = doc.get("player1bid");

    const ownership1Data = findOwnershipMultiplierDivider(ownership1Value);
    const teamRanking1Data = findTeamRankingMultiplierDivider(teamRanking1Value);
    const price1Data = findPriceMultiplierDivider(player1Price);  // Get price data

    const player1delevary = calc(ownership1Data, teamRanking1Data, price1Data, player1points, player1bet);
    const player1profit = player1delevary - player1bet;

    //PLAYER 2
    const ownership2Value = doc.get('player2ows');  // Accessing with string
    const teamRanking2Value = doc.get('player2 team position');  // Accessing with string
    const player2Price = doc.get("player2price");  // Fetch player price
    const player2points = doc.get("player2points");
    const player2bet = doc.get("player2bid");

    const ownership2Data = findOwnershipMultiplierDivider(ownership2Value);
    const teamRanking2Data = findTeamRankingMultiplierDivider(teamRanking2Value);
    const price2Data = findPriceMultiplierDivider(player2Price);  // Get price data

    const player2delevary = calc(ownership2Data, teamRanking2Data, price2Data, player2points, player2bet);
    const player2profit = player2delevary - player2bet;

    //Player 3

    const ownership3Value = doc.get('player3ows');  // Accessing with string
    const teamRanking3Value = doc.get('player3 team position');  // Accessing with string
    const player3Price = doc.get("player3price");  // Fetch player price
    const player3points = doc.get("player3points");
    const player3bet = doc.get("player3bid");

    const ownership3Data = findOwnershipMultiplierDivider(ownership3Value);
    const teamRanking3Data = findTeamRankingMultiplierDivider(teamRanking3Value);
    const price3Data = findPriceMultiplierDivider(player3Price);  // Get price data

    const player3delevary = calc(ownership3Data, teamRanking3Data, price3Data, player3points, player3bet);
    const player3profit = player3delevary - player3bet;



    await docRef.update({
      profit: doc.get('profit') + player1profit + player2profit + player3profit ;
      Budget: doc.get('Budget') + player1delevary + player2delevary + player3delevary;
    });

    console.log('Document successfully updated!');
  } catch (error) {
    console.error('Error updating document:', error);
  }
}

updateSpecificDocument();
