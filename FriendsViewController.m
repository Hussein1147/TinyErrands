//
//  FriendsViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/24/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "FriendsViewController.h"
#import "TinyUser.h"
@interface FriendsViewController()
@property (nonatomic,strong) TinyUser *tinyCurrentUser;
@property (nonatomic,strong) NSMutableArray *tinyFriends;
@end
@implementation FriendsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init] ;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearFriendsData:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    PFUser *currentUser = [PFUser currentUser];
    self.tinyCurrentUser = [[TinyUser alloc]init];
    self.tinyFriends = [[NSMutableArray alloc]init];
    self.tinyCurrentUser.email = currentUser.email;

}
-(void)viewWillAppear: (BOOL) animated
{

    [super viewWillAppear:animated];
   
    [self.tinyCurrentUser getFollowers:^(id responseObject, NSError *error) {
        if (error) {
            UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [arlertView show];
            
        }else{
            self.tinyFriends = [responseObject valueForKey:@"data"];
            [self.tableView reloadData];
                
        }
        
    }];

}
-(void)clearFriendsData:(NSNotification *)notification{
    self.tinyFriends=nil;
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.tinyFriends count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *user = [self.tinyFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = [user valueForKey:@"name"];
    return cell;
}
@end
