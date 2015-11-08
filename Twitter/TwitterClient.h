//
//  TwitterClient.h
//  Twitter
//
//  Created by Alex Lester on 11/7/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

@end
