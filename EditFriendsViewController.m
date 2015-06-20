//
//  EditFriendsViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "EditFriendsViewController.h"
#import "TinyUser.h"
@interface EditFriendsViewController()
@property (nonatomic,strong) NSMutableArray *tUsers;
@end

@implementation EditFriendsViewController

-(NSMutableArray *)tUsers{

    if (!_tUsers)_tUsers = [[NSMutableArray alloc]init];
    
    return _tUsers;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title =@"Edit Friends";
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Sorry, some problem have occured: %@ %@", error, [error userInfo]);
        } else{
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];
    
    
    self.currentUser = [PFUser currentUser];
    TinyUser *tinyUser = [[TinyUser alloc]init];
    tinyUser.email = self.currentUser.email;
    [tinyUser getAllUsers:^(id responseObject, NSError *error) {
        if (!responseObject) {
            NSLog(@"some error occured");
        }else{
    
            NSLog(@"%@", [[responseObject objectForKey:@"data"] firstObject]);
            
            self.tUsers = [responseObject valueForKey:@"data"];
            [self.tableView reloadData];
            NSLog(@"%lu",(unsigned long)[self.tUsers count]);
            NSLog(@"%@",[[self.tUsers firstObject] valueForKey:@"name"]);
        
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.tUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIndentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    NSDictionary *dict = [self.tUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKey:@"name"];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
//    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
//    [friendsRelation addObject:user];
//    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if(error){
//            NSLog(@"Sorry, some problem have occured: %@ %@", error, [error userInfo]);
//        }
//    }];

}
@end
