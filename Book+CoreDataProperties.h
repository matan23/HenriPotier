//
//  Book+CoreDataProperties.h
//  
//
//  Created by Mathieu Tan on 10/21/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *isbn;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *cover;
@property (nullable, nonatomic, retain) NSDate *createdAt;

@end

NS_ASSUME_NONNULL_END
