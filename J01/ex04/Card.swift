import Foundation

class Card : NSObject {
	var color : Color
	var value : Value

	init (color:Color, value:Value) {
        self.color = color
        self.value = value
    }

    override var description : String {
    	return "color : \(self.color), value : \(self.value) \n"
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card {
            return (self.value == obj.value) && (self.color == obj.color)
        }
        return false
    }


}