//
//  PotierClient.m
//  HenriPotierShopper
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import "AFNetworking/AFNetworking.h"

#import "PotierClient.h"

#import "MTJSocketStore.h"

@interface PotierClient() {
    AFHTTPSessionManager *_sessionManager;
}

@end

@implementation PotierClient

+ (instancetype)clientWithAppID:(NSString *)appID {
    PotierClient *client = [PotierClient new];
    
    return client;
}

static NSString *const kBaseUrl = @"http://henri-potier.xebia.fr";

- (void)connectUser:(NSString *)userID completion:(void(^)(BOOL success, NSError *error))completion {
//    nothing to do as this is a unauthenticated API
}

- (void)GETCollectionAtEndpoint:(NSString *)endpoint completion:(void(^)(NSArray *collection, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"%@/%@", kBaseUrl, endpoint];
    
    [[self sessionManager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
       
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError *jsonParseError;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseError];
        
        if (!jsonParseError) {
            NSLog(@"GETCollectionAtEndpoint - Error : %@", response);
        } else {
            NSLog(@"GETCollectionAtEndpoint - Error : %@", jsonParseError);
        }
        
        completion(nil, error);
    }];
}

- (void)GETObjectAtEndpoint:(NSString *)endpoint withObjID:(NSString *)objID completion:(void(^)(NSDictionary *responseObj, NSError *error))completion {
    
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager) return _sessionManager;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:config];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //    i want to use charles for now.
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    _sessionManager.securityPolicy = policy;
    
    return _sessionManager;
}

@end
