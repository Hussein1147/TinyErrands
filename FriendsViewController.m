//
//  FriendsViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "FriendsViewController.h"

@implementation FriendsViewController

-(void) viewWillAppear: (BOOL) animated
{

    [super viewWillAppear:animated];
    self.friendsRelation = [[PFUser currentUser] relationForKey:@"friendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    PFQuery *newQuery = [PFUser query];
    [newQuery whereKey:@"username" equalTo:@"karki"];
    
    [newQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
        
                NSLog(@"id: %@", objects);
            
        }else{
            
            NSLog(@"some error have occured");
        }
        
    
    }];
    
    

    [query orderByAscending:@"username"];
    
    //Dont forget to change this to intergrate NSNotificationCenter for efficiency
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.friends count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
}
@end
