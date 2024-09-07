const admin = require('firebase-admin');
const axios = require('axios');
const serviceAccount = require('./hotpro-3b874-firebase-adminsdk-9hatj-242974e7c8.json'); // Path from working-directory

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function getUserTeamPoints(userId, gw) {
    try {
        const response = await axios.get("https://fantasy.premierleague.com/api/entry/519066/event/3/live/");
        const userData = response.data;

        // Get the total points for the user's team
        const totalPoints = userData.summary.points;

        return totalPoints;
    } catch (error) {
        console.error('Error fetching user data:', error);
        return null;
    }
}

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

// Function to calculate the delivery amount based on factors
function calc(ownershipfactor, rankingfactor, pricefactor, points, playerbet) {
  if (playerbet / 10000 >= points) {
    const multfac = ownershipfactor.multiplier + rankingfactor.multiplier + pricefactor.multiplier + 1;
    return playerbet * multfac;
  } else {
    const divfac = ownershipfactor.divider + rankingfactor.divider + pricefactor.divider + 1;
    return playerbet / divfac;
  }
}

// Function to fetch player points from the FPL API
async function getPlayerPoints(playerId) {
  try {
    const response = await axios.get("https://fantasy.premierleague.com/api/event/3/live/");
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


// Example Firestore Document Update with API points fetching
async function updateSpecificDocument() {
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

    const player1points = await getPlayerPoints(player1Id);
    const player2points = await getPlayerPoints(player2Id);
    const player3points = await getPlayerPoints(player3Id);

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

    // Update Firestore document with calculated profit and budget
    await docRef.update({
      profit: Math.round(doc.get('profit') + player1profit + player2profit + player3profit),
      Budget: Math.round(doc.get('Budget') + player1delevary + player2delevary + player3delevary),
      player1points: player1points,
      player2points: player2points,
      player3points: player3points,
    });


    console.log('Document successfully updated!');
  } catch (error) {
    console.error('Error updating document:', error);
  }
}

// Call the function with a specific gameweek
//updateSpecificDocument();// Pass the gameweek number when calling the function

const userId = 123456; // Replace with the actual user ID
const gw = 3; // Replace with the actual Gameweek number
getUserTeamPoints(userId, gw).then(points => {
    console.log("User's total points for GW${gw}:", points);
});
