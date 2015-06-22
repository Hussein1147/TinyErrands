//
//  TinyUser.h
//  Jobos
//
//  Created by DJIBRIL KEITA on 6/8/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TinyUser : NSObject
@property (nonatomic,strong) NSMutableArray *friends;
@property (nonatomic,strong) NSMutableArray *post;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) NSInteger cardNumber;
@property (nonatomic) NSInteger expMonth;
@property (nonatomic) NSInteger expYear;



@property (nonatomic,strong) NSString *password;


-(NSMutableArray*)loadFriends:(NSString *)email;
-(NSMutableArray *)loadFollowedPosts:(NSString *)email;
-(void)follow:(NSString *)email completion:(void (^) (id responseObject, NSError *error))completionHandler;
-(void)getFollowers:(void (^) (id responseObject, NSError *))completionHandler;
-(void)addPost:(NSString *)currentUserEmail post:(NSString *)postBody;
-(NSDictionary *)likePost:(NSString *)currentUserEmail postId:(int)iD;
-(void)signUp:(void (^) (id responseObject, NSError *error))completionHandler;
-(void)getAllUsers:(void (^)(id responseObject, NSError *error))completionHandler;

@end

