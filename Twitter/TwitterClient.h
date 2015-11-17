//
//  TwitterClient.h
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;
- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;
- (void)homeTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)mentionsWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)sendTweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary
	*response, NSError *error))completion;
- (void)favouriteTweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *response, NSError *))completion;
- (void)retweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *response, NSError *))completion;
@end
