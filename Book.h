//
//  Book.h
//  
//
//  Created by Mathieu Tan on 10/21/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "MTJSocketStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSManagedObject <MTJSyncedEntity>

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Book+CoreDataProperties.h"
