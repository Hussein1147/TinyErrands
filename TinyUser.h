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


-(void)follow:(NSString *)email completion:(void (^) (id responseObject, NSError *error))completionHandler;
-(void)getFollowers:(void (^) (id responseObject, NSError *))completionHandler;
-(void)addPost:(NSString *)content dueIn:(NSInteger)dueIn startTime:(NSString *)startTime completion:(void(^) (id responseObject,NSError *error))completionHandler;
-(void)getFollowedPosts:(void (^) (id responseObject, NSError *error))completionHandler;
-(void)getMyPosts:(void (^) (id responseObject, NSError *error))completionHandler;

-(NSDictionary *)likePost:(NSString *)currentUserEmail postId:(int)iD;
-(void)signUp:(void (^) (id responseObject, NSError *error))completionHandler;
-(void)getAllUsers:(void (^)(id responseObject, NSError *error))completionHandler;

@end

