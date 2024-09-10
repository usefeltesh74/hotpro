const admin = require('firebase-admin');
const axios = require('axios');
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

// Price Multiplier and Divider List
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

const teambetMultiplierDivider = [
  { points: 10, multiplier: 1.1, divider: 1.1 },
  { points: 20, multiplier: 1.2, divider: 1.2 },
  { points: 30, multiplier: 1.3, divider: 1.3 },
  { points: 40, multiplier: 1.4, divider: 1.4 },
  { points: 50, multiplier: 1.5, divider: 1.5 },
  { points: 60, multiplier: 1.6, divider: 1.6 },
  { points: 70, multiplier: 1.7, divider: 1.7 },
  { points: 80, multiplier: 1.8, divider: 1.8 },
  { points: 90, multiplier: 1.9, divider: 1.9 },
  { points: 100, multiplier: 2.0, divider: 2.0 }
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

function findTeambetMultiplierDivider(points) {
  for (let i = 0; i < teambetMultiplierDivider.length - 1; i++) {
    const current = teambetMultiplierDivider[i];
    const next = teambetMultiplierDivider[i + 1];

    if ( points == current.points  ) {
      return { multiplier: current.multiplier, divider: current.divider };
    }
  }
  return teambetMultiplierDivider[teambetMultiplierDivider.length - 1];
}

// Function to calculate the delivery amount based on factors
function calc(ownershipfactor, rankingfactor, pricefactor, points, playerbet) {
  if (playerbet / 10000 <= points ) {
    const multfac = ownershipfactor.multiplier + rankingfactor.multiplier + pricefactor.multiplier + 1;
    return playerbet * multfac;
  } else {
    const divfac = ownershipfactor.divider + rankingfactor.divider + pricefactor.divider + 1;
    return playerbet / divfac;
  }
}

function calcTeambet(teamMultiplierDivider, teambet, teamPoints) {
  const teamMultiplier = teamMultiplierDivider.multiplier;
  const teamDivider = teamMultiplierDivider.divider;

  if (teambet / 10000 <= teamPoints ) {
    return teambet * teamMultiplier;
  } else {
    return teambet / teamDivider;
  }
}

// Function to fetch player points from the FPL API
async function getPlayerPoints(playerId,GW) {
  try {
    const response = await axios.get(`https://fantasy.premierleague.com/api/event/${GW}/live/`);
    const players = response.data.elements;

    // Find the player by ID
    const playerData = players.find(player => player.id === playerId);
    if (playerData) {
      return playerData.stats.total_points; // Return the player's total points
    } else {
      console.log(`Player with ID ${playerId} not found`);
      return 0;
    }
  } catch (error) {
    console.error('Error fetching player points:', error);
    return 0;
  }
}

async function getUserGWPoints(userId, gwId) {
  const url = `https://fantasy.premierleague.com/api/entry/${userId}/event/${gwId}/picks/`;

  try {
    const response = await axios.get(url);
    const data = response.data;
    const totalPoints = data.entry_history.points;
    console.log("total points for GW 3 :" + totalPoints);  // Contains player picks, captain, and points

    return totalPoints;
    // You can then extract points and player details from this data
  } catch (error) {
    console.error('Error fetching user data:', error.message);
    return null;
  }

}


// Example Firestore Document Update with API points fetching
async function updateSpecificDocument(GW) {
  try {
    const docRef = db.collection('fantasy').doc('0q82LrYr9tU8o95uKgT8RnRArng1');
    const doc = await docRef.get();
    if (!doc.exists) {
      console.log('No such document!');
      return;
    }

    // Fetch points for each player from FPL API
    const player1Id = doc.get('player1id');
    const player2Id = doc.get('player2id');
    const player3Id = doc.get('player3id');

    const player1points = await getPlayerPoints(player1Id,GW);
    const player2points = await getPlayerPoints(player2Id,GW);
    const player3points = await getPlayerPoints(player3Id,GW);

    // PLAYER 1 calculations
    const ownership1Value = doc.get('player1ows');
    const teamRanking1Value = doc.get('player1 team position');
    const player1Price = doc.get('player1price');
    const player1bet = doc.get('player1bid');

    const ownership1Data = findOwnershipMultiplierDivider(ownership1Value);
    const teamRanking1Data = findTeamRankingMultiplierDivider(teamRanking1Value);
    const price1Data = findPriceMultiplierDivider(player1Price);

    const player1delevary = calc(ownership1Data, teamRanking1Data, price1Data, player1points, player1bet);
    const player1profit = player1delevary - player1bet;

    // PLAYER 2 calculations
    const ownership2Value = doc.get('player2ows');
    const teamRanking2Value = doc.get('player2 team position');
    const player2Price = doc.get('player2price');
    const player2bet = doc.get('player2bid');

    const ownership2Data = findOwnershipMultiplierDivider(ownership2Value);
    const teamRanking2Data = findTeamRankingMultiplierDivider(teamRanking2Value);
    const price2Data = findPriceMultiplierDivider(player2Price);

    const player2delevary = calc(ownership2Data, teamRanking2Data, price2Data, player2points, player2bet);
    const player2profit = player2delevary - player2bet;

    // PLAYER 3 calculations
    const ownership3Value = doc.get('player3ows');
    const teamRanking3Value = doc.get('player3 team position');
    const player3Price = doc.get('player3price');
    const player3bet = doc.get('player3bid');

    const ownership3Data = findOwnershipMultiplierDivider(ownership3Value);
    const teamRanking3Data = findTeamRankingMultiplierDivider(teamRanking3Value);
    const price3Data = findPriceMultiplierDivider(player3Price);

    const player3delevary = calc(ownership3Data, teamRanking3Data, price3Data, player3points, player3bet);
    const player3profit = player3delevary - player3bet;

    //Teambet calculations
    const teambet = doc.get('teambid');
    const teamid = doc.get('teamid');
    const teambetpoints = teambet / 10000;

    const teampoints = parseInt(await getUserGWPoints(teamid, GW), 10);


    const teamMultdiv = findTeambetMultiplierDivider(teambetpoints);
    console.log('mult factor :'+teamMultdiv.multiplier);
    const teamDelivery = calcTeambet(teamMultdiv, teambet, teampoints);
    console.log('deliv :'+ teamDelivery);
    const teamProfit = teamDelivery - teambet;
    console.log('team profit :' + teamProfit);





    // Update Firestore document with calculated profit and budget
    await docRef.update({
      profit: Math.round(doc.get('profit') + player1profit + player2profit + player3profit + teamProfit),
      Budget: Math.round(doc.get('Budget') + player1delevary + player2delevary + player3delevary + teamDelivery),
      player1profit: player1profit,
      player2profit: player2profit,
      player3profit: player3profit,
      player1points:player1points,
      player2points:player2points,
      player3points:player3points,
      teamPoints: teampoints + 1,
      teamProfit: teamProfit,
    });


    console.log('Document successfully updated!');
  } catch (error) {
    console.error('Error updating document:', error);
  }
}

// Call the function with a specific gameweek
updateSpecificDocument(3);

//async function UpdateMissingFields() {
//  const collectionRef = db.collection('fantasy');
//  const snapshot = await collectionRef.get();
//
//  if (snapshot.empty) {
//    console.log('No matching documents.');
//    return;
//  }
//
//  snapshot.forEach(async (doc) => {
//    try {
//      // Create an object dynamically with string keys
//      const updateData = {
//        [`player1 team position`]: 0,
//        [`player1id`]: 0,
//        [`player1ows`]: 0,
//        [`player1points`]: 0,
//        [`player1price`]: 0,
//        [`player1profit`]: 0,
//        [`player2 team position`]: 0,
//        [`player2id`]: 0,
//        [`player2ows`]: 0,
//        [`player2points`]: 0,
//        [`player2price`]: 0,
//        [`player2profit`]: 0,
//        [`player3 team position`]: 0,
//        [`player3id`]: 0,
//        [`player3ows`]: 0,
//        [`player3points`]: 0,
//        [`player3price`]: 0,
//        [`player3profit`]: 0,
//        [`teamProfit`]: 0,
//        [`teamid`]: 0,
//        [`teamPoints`]: 0,
//
//      };
//
//      // Update the document with dynamically created fields
//      await doc.ref.update(updateData);
//
//      console.log(`Document ${doc.id} updated successfully`);
//    } catch (error) {
//      console.error(`Error updating document ${doc.id}:`, error);
//    }
//  });
//}
//
//UpdateMissingFields();






