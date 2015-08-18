//
//  TinyErrand.h
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 7/11/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TinyErrand : NSObject

@property (nonatomic,copy) NSString *errandDescription;
@property (nonatomic,assign) NSInteger dueIn;
@property (nonatomic,assign) NSInteger price;

@end
