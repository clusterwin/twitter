 //
//  TwitterClient.m
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"


NSString * const kTwitterConsumerKey = @"Vbjxb5nKbp4KLCG8mgfG381Qx";
NSString * const kTwitterConsumerSecret = @"KWhpXTPjmlHstxQkaFtQoGeRMz0fLBxNpCCh8yavYhf1sYdEnb";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@end

@implementation TwitterClient 

+ (TwitterClient *)sharedInstance {
	static TwitterClient *instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if(instance == nil){
			instance = [[TwitterClient alloc] initWithBaseURL:[NSURL
						URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey
											   consumerSecret:kTwitterConsumerSecret];
		}
	});

	return instance;
	
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion{
	self.loginCompletion = completion;
	
	[[TwitterClient sharedInstance].requestSerializer removeAccessToken];
	[[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
		NSLog(@"Got the request token");
		NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",requestToken.token]];
		[[UIApplication sharedApplication] openURL:authUrl];
	} failure:^(NSError *error) {
		NSLog(@"Failed to get the request token");
		self.loginCompletion(nil, error);
	}];
	
}

- (void)openURL:(NSURL *)url{
	[self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
		NSLog(@"got the access token!");
		[self.requestSerializer saveAccessToken:accessToken];
		[self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
			//NSLog(@"Current user: %@", responseObject);
			User *user = [[User alloc] initWithDictionary:responseObject];
			[User setCurrentUser:user];
			NSLog(@"currentUser: %@", user.name);
			self.loginCompletion(user, nil);
		} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
			NSLog(@"Failed getting current user");
			self.loginCompletion(nil, error);
		}];
	} failure:^(NSError *error) {
		NSLog(@"failed to get the access token!");
	}];

}

- (void)homeTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
	[self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){;
		NSArray *tweets = [Tweet tweetsWithArray:responseObject];
		//NSLog(@"Tweets: %@",responseObject);
		completion(tweets, nil);
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		completion(nil, error);
	}];
}

- (void)mentionsWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion {
	[self GET:@"/1.1/statuses/mentions_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){;
		NSArray *tweets = [Tweet tweetsWithArray:responseObject];
		//NSLog(@"Tweets: %@",responseObject);
		completion(tweets, nil);
	}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		completion(nil, error);
	}];
}

- (void)sendTweetWithParams:(NSDictionary *)params completion:(void (^)(NSArray *response, NSError *error))completion {
	[self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Did post: %@",responseObject);
		completion(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		completion(nil, error);
		NSLog(@"Error on post: %@",error);
	}];
}

- (void)favouriteTweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *response, NSError *))completion {
	[self POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Did fav: %@",responseObject);
		completion(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		completion(nil, error);
		NSLog(@"Error on post: %@",error);
	}];
}

- (void)retweetWithParams:(NSDictionary *)params completion:(void (^)(NSDictionary *response, NSError *))completion {
	NSString *postString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", params[@"id"]];
	NSLog(postString);
	[self POST:postString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Did retweet: %@",responseObject);
		completion(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		completion(nil, error);
		NSLog(@"Error on post: %@",error);
	}];
}

@end
