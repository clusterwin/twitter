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

@end
