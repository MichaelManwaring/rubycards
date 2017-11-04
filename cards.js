// womp
function womp() {
	alert("YOU'VE REALLY WOMPED IT NOW!")
	document.querySelector('.womp').remove();
}

//establish deck
const deck =[];
const suits = ['Hearts','Diamonds','Spades','Clubs'];
for (let i = suits.length - 1; i >= 0; i--) {
	for (let j = 1; j <= 13; j++) {
		deck.push({suit: suits[i], number: j}) 
	}
}


// showing a card
function nextCard() {
	deck.push(deck.shift());
	// header.innerText = deck[0].number + " of " +deck[0].suit;
	showBoard()
	// showDeck()
};
// shuffle
function shuffle() {
	for (let card of deck) {
		deck.sort(function(a, b){return 0.5 - Math.random()});
	};
	// showDeck()
	showBoard()
};
// make a list of cards
function showDeck() {
	let newDeck = ""
	for (let card of deck) {
		newDeck += card.number+deck[i].suit+", ";
	};
	deckDisplay.innerText = newDeck.slice(0,-2);
}
// display all cards
const cardBoard = document.querySelector('.card-board');
function showBoard() {	
	while ( cardBoard.firstChild ) cardBoard.removeChild( cardBoard.firstChild );
	for (let card of deck) {
		let cardData = document.createElement('div');
		cardData.innerText = card.number+" of "+card.suit;
		cardData.style.cssText = 'border-style: solid; width: 85px; display: inline-block; margin: 1px; padding: 5px; text-align: center';
		if (card.suit == "Spades" || card.suit == "Clubs") {
			cardData.style.cssText += 'background: grey';
		} else {
			cardData.style.cssText += 'background: red';
		}
		if (card.suit == "Hearts" || card.suit == "Clubs") {
			cardData.style.cssText += 'border-color: white';
		}
		cardBoard.appendChild(cardData)
	}
}
showBoard()
