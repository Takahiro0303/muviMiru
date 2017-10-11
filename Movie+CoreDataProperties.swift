//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by takahiro tshuchida on 2017/10/11.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var artworkUrl: String?
    @NSManaged public var longDescription: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var saveDate: NSDate?
    @NSManaged public var trackName: String?
    @NSManaged public var trackViewUrl: String?

}
