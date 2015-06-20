//
//  EditFriendsViewController.h
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface EditFriendsViewController : UITableViewController
@property(nonatomic,strong) NSArray *allUsers;
@property(nonatomic,strong) PFUser *currentUser;
@end
