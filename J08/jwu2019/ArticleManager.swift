import CoreData
import Foundation

public class ArticleManager
{
    public var managedObjectContext: NSManagedObjectContext

    public init(completion: @escaping () -> ())
    {
        let bundle = Bundle(for: ArticleManager.self)
        guard let dataModelURL = bundle.url(forResource: "article", withExtension: "momd") else {
            fatalError("Error initializing dataModelURL")
        }
        
        guard let m = NSManagedObjectModel(contentsOf: dataModelURL) else {
            fatalError("Error initializing m")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: m)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("Error initializing docURL")
            }
            let storeURL = docURL.appendingPathComponent("article.sqlite")
            do
            {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                DispatchQueue.main.sync(execute: completion)
            } catch {
                fatalError("Error migrating store \(error)")
            }
        }
    }

    public func newArticle() -> Articlee
    {
        print("new Article")
        //return nil!
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: self.managedObjectContext) as! Articlee
    }
    
    public func getAllArticles() -> [Articlee]
    {
        var allArticles: [Articlee] = []
        let request = NSFetchRequest<Articlee>(entityName: "Article")
        do
        {
            allArticles = try managedObjectContext.fetch(request)
        }
        catch { print("Couldnt load all articles") }
        return allArticles
    }
    
    public func getArticles(withLang lang : String) -> [Articlee]
    {
        let allArticles = self.getAllArticles()
        var allArticlesWithLang: [Articlee] = []
        for art in allArticles
        {
            if let artLang = art.langue
            {
                if artLang == lang
                {
                    allArticlesWithLang.append(art)
                }
            }
        }
        return allArticlesWithLang
    }
    
    public func getArticles(containString str : String) -> [Articlee]
    {
        let allArticles = self.getAllArticles()
        var allArticlesWithStr: [Articlee] = []
        for art in allArticles
        {
            if let artContent = art.content
            {
                if artContent.contains(str)
                {
                    allArticlesWithStr.append(art)
                    continue
                }
            }
            if let artTitle = art.title
            {
                if artTitle.contains(str)
                {
                    allArticlesWithStr.append(art)
                    continue
                }
            }
        }
        return allArticlesWithStr
    }
    
    public func removeArticle(article : Articlee)
    {
        self.managedObjectContext.delete(article)
    }
    
    public func save()
    {
        do
        {
            try self.managedObjectContext.save()
        }
        catch { print("Couldn't save context") }
    }
}
