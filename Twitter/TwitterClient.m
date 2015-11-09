 //
//  TwitterClient.m
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "TwitterClient.h"

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

@end
