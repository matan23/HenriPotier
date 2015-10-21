//
//  PotierClient.h
//  HenriPotierShopper
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTJSocketStore.h"

@interface PotierClient : NSObject <MTJClientProtocol>

@property (nonatomic, readonly) NSString *sessionToken;

@end
