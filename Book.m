//
//  Book.m
//  
//
//  Created by Mathieu Tan on 10/21/15.
//
//

#import "Book.h"

@implementation Book

//{
//    "isbn": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
//    "title": "Henri Potier à l'école des sorciers",
//    "price": 35,
//    "cover": "http://henri-potier.xebia.fr/hp0.jpg"
//}
- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.isbn = dictionary[@"isbn"];
    self.price = [NSString stringWithFormat:@"%@", dictionary[@"price"]];
    self.cover = dictionary[@"cover"];
    self.title = dictionary[@"title"];
    
    self.createdAt = [NSDate date];
}


- (NSDictionary *)serializedCreateRequestDictionary {
//    nothing to see there this protocol should be optional
    return nil;
}


+ (id<MTJSyncedEntity>)findOrCreateEntity:(NSString *)objID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isbn = %@", objID];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        Book *book = [self insertNewObjectIntoContext:context];
        book.isbn = objID;
        return book;
    }
}

+ (id)entityName
{
    return NSStringFromClass(self);
}

+ (NSString *)sortKey {
    return @"createdAt";
}

- (void)addCollection:(NSSet<NSManagedObject *> *)values {
//    nothing to see there this protocol should be optional
    assert(0);
}

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext*)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

//name of the field to identify the object in core data
+ (NSString *)identifierString {
    return @"isbn";
}

- (NSString *)endpointURL {
//    nothing to see there this protocol should be optional
    assert(0);
    return nil;
}

+ (NSString *)collectionEndpointURL {
    return @"books";
}

- (NSString *)collectionWithRelationshipEndpointURL {
//    nothing to see there this protocol should be optional
    assert(0);
    return nil;
}


- (NSString *)description {
    return [NSString stringWithFormat:@" isbn: %@\n title: %@\n created_at:%@\n",
            self.isbn, self.title, self.createdAt];
}


@end
