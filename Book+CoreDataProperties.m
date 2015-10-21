//
//  Book+CoreDataProperties.m
//  
//
//  Created by Mathieu Tan on 10/21/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book+CoreDataProperties.h"

@implementation Book (CoreDataProperties)

@dynamic isbn;
@dynamic title;
@dynamic price;
@dynamic cover;
@dynamic createdAt;

@end
