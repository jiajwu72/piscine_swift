import Foundation

class Deck : NSObject {
	static let allSpades : [Card] = Value.allValues.map{
		Card(color : Color.Pique, value : $0)
	}
	static let allDiamonds : [Card] = Value.allValues.map{
		Card(color : Color.Carreau, value : $0)
	}
	static let allHearts : [Card] = Value.allValues.map{
		Card(color : Color.Coeur, value : $0)
	}
	static let allClubs : [Card] = Value.allValues.map{
		Card(color : Color.Trefle, value : $0)
	}

	static let allCards : [Card] = allSpades + allDiamonds + allHearts + allClubs

	var cards: [Card] = allCards
	var discards: [Card] = []
	var outs: [Card] = []

	init(sort : Bool){
		if sort {
			cards.shuffle()
		}

	}

	//toString
	override public var description: String {
		return (self.cards.description)
	}

	func draw() -> Card? {
        let first = self.cards.first
        self.outs.append(first!)
        self.cards.remove(at:0)
        return first
    }
    
    func fold(c: Card) {
        var index = 0
        for elem in self.outs {
            if c == elem {
                self.discards.append(elem)
                self.outs.remove(at:index)
            }
            index += 1
        }
    }

}

extension Array {
	mutating func shuffle(){
		var index = 0
		for i in  0..<self.count {
			index = Int(arc4random_uniform(UInt32(self.count)))
			if i != index {
				//self.swapAt(i, index)
				let tmp = self[index]
            	self[index] = self[i]
            	self[i] = tmp
			}
		}
	}
}
