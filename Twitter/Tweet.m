//
//  Tweet.m
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(self){
		self.text = dictionary[@"text"];
		self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
		NSString *createdAtString = dictionary[@"created_at"];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
		self.createdAt = [formatter dateFromString:createdAtString];
		NSNumber *ids = dictionary[@"id"];
		self.idNumber = [NSString stringWithFormat:@"%@",ids];
		NSLog(self.idNumber);

	}
	return self;
}

+ (NSArray *) tweetsWithArray:(NSArray *)array {
	NSMutableArray *tweets = [NSMutableArray array];
	
	for (NSDictionary *dictionary in array){
		[tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
	}
	return tweets;
}

@end
