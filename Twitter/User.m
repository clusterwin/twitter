//
//  User.m
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.name = dictionary[@"name"];
		self.screename = dictionary[@"screen_name"];
		self.profileImageUrl = dictionary[@"profile_image_url"];
		self.tagLine = dictionary[@"description"];
	}
	return self;
}

@end
