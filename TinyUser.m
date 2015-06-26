//
//  TinyUser.m
//  Jobos
//
//  Created by DJIBRIL KEITA on 6/8/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "TinyUser.h"
#import "AFHTTPRequestOperationManager.h"
#define TINY_CREATE_POST_URL @"https://tinyerrands-jobos.rhcloud.com/createUser"
#define TINY_ALL_USER_POST_URL @"https://tinyerrands-jobos.rhcloud.com/get_All_Users"
#define TINY_FOLOW_POST_URL @"https://tinyerrands-jobos.rhcloud.com/follow"
#define TINY_GET_FOLLOWERS_POST_URL @"https://tinyerrands-jobos.rhcloud.com/get_followers"
#define TINY_ADD_ERRANDS_POST_URL @"https://tinyerrands-jobos.rhcloud.com/add_post"
#define TINY_GET_ERRANDS_POST_URL @"https://tinyerrands-jobos.rhcloud.com/get_followed_post"

@interface TinyUser()
@property (nonatomic,strong) NSMutableArray *arrayOfUsers;
@end

@implementation TinyUser

-(NSString *)email{
    
    if(!_email)_email = [[NSString alloc]init];
    return _email;
}

-(NSString *)name{
    
    if(!_name)_name = [[NSString alloc]init];
    return _name;
}

-(NSString *)password{

    if (!_password)_password = [[NSString alloc]init];
    return _password;
}

-(NSMutableArray *)post {

    if(!_post)_post = [[NSMutableArray alloc]init];
    return _post;

}

-(NSMutableArray *)friends{

    if (!_friends)_friends =[[NSMutableArray alloc]init];
    
    return _friends;
        
}

// write sign up with completion handler
-(void)signUp:(void (^)(id, NSError *))completionHandler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    // manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONReadingAllowFragments];
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"userName"] = self.name;
    postRequestDictionary[@"userEmail"] = self.email;
    postRequestDictionary[@"userPassword"] = self.password;
    
    [manager POST:TINY_CREATE_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (completionHandler) {
             completionHandler(responseObject,nil);

         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler(nil, error);
         }
         NSLog(@"Error: %@", [operation responseString]);
     }];
    
    
}
-(void)getAllUsers:(void (^)(id, NSError *))completionHandler{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"userEmail"] = self.email;
    [manager POST:TINY_ALL_USER_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil);
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler(error,nil);
         }
     }];
    
}

-(void)follow:(NSString *)email completion:(void (^) (id, NSError *error))completionHandler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"currentUserEmail"] = self.email;
    postRequestDictionary[@"userFollowedEmail"]=email;
    [manager POST:TINY_FOLOW_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil);
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler([operation responseString],nil);
         }
     }];
    


}

-(void)getFollowers:(void (^)(id, NSError *))completionHandler{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"currentUserEmail"] = self.email;
    [manager POST:TINY_GET_FOLLOWERS_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil);
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler(error,nil);
         }
     }];
}
-(void)addPost:(NSString *)content completion:(void (^)(id responseObject, NSError *error))completionHandler{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"currentUserEmail"] = self.email;
    postRequestDictionary[@"myPost"] = content;

    [manager POST:TINY_ADD_ERRANDS_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil);
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler(error,nil);
         }
     }];

    
}
-(void)getposts:(void (^) (id responseObject, NSError *error))completionHandler{

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"currentUserEmail"] = self.email;
    
    [manager POST:TINY_GET_ERRANDS_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil);
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         if (completionHandler) {
             completionHandler(error,nil);
         }
     }];

}
 @end
