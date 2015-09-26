//
//  InboxViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/21/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "InboxViewController.h"
#import <Parse/Parse.h>
#import "LogInViewController.h"

@implementation InboxViewController


-(void)viewDidLoad{

    [super viewDidLoad];
   


    PFUser *currentUser = [PFUser currentUser];
    if (currentUser){
        NSLog(@"Current user:%@",currentUser);
    }else{

    [self performSegueWithIdentifier:@"showlogin" sender:self];

    }

}

- (IBAction)Logout:(id)sender {
    [PFUser logOut];
    [[NSNotificationCenter defaultCenter]
postNotificationName:@"TestNotification"
object:self];
    [self performSegueWithIdentifier:@"showlogin" sender:self];
    
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 0;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showlogin"]) {
        UIViewController *lvc = segue.destinationViewController;
        [lvc setHidesBottomBarWhenPushed:YES];
        lvc.navigationItem.hidesBackButton = YES;
    }

}
@end
