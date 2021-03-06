//
//  Message.m
//  
//
//  Created by sintaiyuan on 10/19/15.
//
//

#import "Message.h"
#import "Conversation.h"

@implementation Message

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.objId = dictionary[[Message identifierString]];
    self.url = dictionary[@"url"];
    self.receiptsUrl = dictionary[@"receipts_url"];
    self.messageText = [dictionary[@"parts"] firstObject][@"body"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *date = [dateFormat dateFromString:dictionary[@"sent_at"]];
    self.sentAt = date;
//    CHANGE
//    self.conversation = [Conversation findOrCreateEntity:dictionary[@"conversation"][@"id"] inContext:nil];
}


//{
//    "parts": [
//              {
//                  "body": "Hello, World!",
//                  "mime_type": "text/plain"
//              },
//              {
//                  "body": "YW55IGNhcm5hbCBwbGVhc3VyZQ==",
//                  "mime_type": "image/jpeg",
//                  "encoding": "base64"
//              }
//              ],
//    "notification": {
//        "text": "This is the alert text to include with the Push Notification.",
//        "sound": "chime.aiff"
//    }
//}
- (NSDictionary *)serializedCreateRequestDictionary {
    NSDictionary *data = @{@"parts":@[@{@"body":self.messageText,
                                        @"mime_type":@"text/plain"}]
                           };
    NSDictionary *body = @{ @"method": @"Message.create",
                            @"request_id": [NSString stringWithFormat:@"message.create.%@", [NSDate date]],
                            @"object_id": self.conversation.objId,
                            @"data": data};
    NSDictionary *parameters = @{ @"type": @"request", @"body": body};
    return parameters;
    return nil;
}

- (void)deserializedCreateRequestDictionary:(NSDictionary *)dictionary {
    
}

+ (id<MTJSyncedEntity>)findOrCreateEntity:(NSString *)objID inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"objId = %@", objID];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        Message *msg = [self insertNewObjectIntoContext:context];
        msg.objId = objID;
        return msg;
    }
}

+ (id)entityName
{
    return NSStringFromClass(self);
}

+ (NSString *)sortKey {
    return @"sentAt";
}

- (void)addCollection:(NSSet<NSManagedObject *> *)values {
//    nothing here yet
    abort();
}


+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext*)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

//name of the field to identify the object in core data
+ (NSString *)identifierString {
    return @"id";
}

- (NSString *)endpointURL {
    return @"messages";
}

+ (NSString *)collectionEndpointURL {
//    messages are associated with a conversation
    abort();
    return @"";
}

- (NSString *)collectionWithRelationshipEndpointURL {
    //    nothing yet
    abort();
    return @"";
    
}



- (NSString *)description {
    return [NSString stringWithFormat:@" id: %@\n url: %@\n messageText:%@\n",
            self.objId, self.url, self.messageText];
}
@end

