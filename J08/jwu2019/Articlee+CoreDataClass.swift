//
//  Article.swift
//  jwu2019
//
//  Created by jiajun wu on 23/10/2019.
//

import Foundation
import CoreData

public class Articlee: NSManagedObject
{
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: NSData?
    @NSManaged public var langue: String?
    @NSManaged public var dateModification: NSDate?
    @NSManaged public var dateCreation: NSDate?
    
    override public var description: String
    {
        return "Article :\nLanguage : \(self.langue)\nTitle : \(self.title)\nContent : \(self.content)\nImage : \(self.image)\nCreation Date : \(self.dateCreation)\nModification Date : \(self.dateModification)\n------------------------------\n"
    }
}

extension Articlee {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    
}
