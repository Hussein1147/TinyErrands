//
//  EditFriendsViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "EditFriendsViewController.h"
@interface EditFriendsViewController()
@property (nonatomic,strong) NSMutableArray *allUsers;
@end

@implementation EditFriendsViewController

-(NSMutableArray *)allUsers{

    if (!_allUsers)_allUsers = [[NSMutableArray alloc]init];
    
    return _allUsers;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title =@"Edit Friends";
    
    self.currentUser = [PFUser currentUser];
    self.currentTinyUser = [[TinyUser alloc]init];
    self.currentTinyUser.email = self.currentUser.email;
    [self.currentTinyUser getAllUsers:^(id responseObject, NSError *error) {
        if (!responseObject) {
            NSLog(@"some error occured");
        }else{
    
            NSLog(@"%@", [[responseObject objectForKey:@"data"] firstObject]);
            
            self.allUsers = [responseObject valueForKey:@"data"];
            [self.tableView reloadData];
            NSLog(@"%lu",(unsigned long)[self.allUsers count]);
            NSLog(@"%@",[[self.allUsers firstObject] valueForKey:@"name"]);
        
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.allUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIndentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    NSDictionary *dict = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKey:@"name"];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSDictionary *user = [self.allUsers objectAtIndex:indexPath.row];
    [self.currentTinyUser follow:self.currentUser.email friend:[user valueForKey:@"email"] completion:^(id reponseObject, NSError *error) {
        if (!reponseObject) {
            UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [arlertView show];
        }else{
        
            NSLog(@"%@", reponseObject);
        }
    }] ;
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
