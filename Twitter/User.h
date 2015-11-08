//
//  User.h
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screename;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
