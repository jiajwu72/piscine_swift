

var card1 = Card(color: Color.Carreau, value: Value.As)
print (card1.description)

var card2 = Card(color: Color.Pique, value: Value.Valet)
print (card2.description)

var card3 = Card(color: Color.Pique, value: Value.Valet)
print (card3.description)

print (card1 == card2)
print (card2 == card3)
