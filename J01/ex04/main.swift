var testDeck = Deck(sort: true)
var c: Card?

print(testDeck)
print("-------------Game Start--------------")

c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()
c = testDeck.draw()


c = nil

print("----------------- 10 cards outs --------------------")

for i in 0...(testDeck.outs.count-1){
	    print("outs[\(i)] = \(testDeck.outs[i])")
}

testDeck.fold(c: testDeck.outs[0])
testDeck.fold(c: testDeck.outs[1])
testDeck.fold(c: testDeck.outs[2])
testDeck.fold(c: testDeck.outs[3])
print("------------------- 4 cards elimite ----------------")
for i in 0...(testDeck.discards.count-1){
	    print("discards[\(i)] = \(testDeck.discards[i])")
}
print("----------------------------------------------------")
for i in 0...(testDeck.outs.count-1){
	    print("outs[\(i)] = \(testDeck.outs[i])")
}
print("----------------------- Final -----------------------------")
for i in testDeck.cards {
	  print(i)
}
