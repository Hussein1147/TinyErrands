//
//  EditFriendsViewController.h
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TinyUser.h"


@interface EditFriendsViewController : UITableViewController
@property(nonatomic,strong) PFUser *currentUser;
@property(nonatomic,strong) TinyUser *currentTinyUser;
@end
