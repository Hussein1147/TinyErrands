//
//  LogInViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/22/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@implementation LogInViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Poke"];
    
}
- (IBAction)signin:(id)sender {
        NSString *userName = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *passWord = [self.passWordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([passWord length]==0 || [userName length] ==0) {
        UIAlertView *allerView = [[UIAlertView alloc]initWithTitle:@"Bummer!"
                                                           message:@"try entering a username and password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [allerView show];
        
        
    }else{
        
        [PFUser logInWithUsernameInBackground:userName password:passWord block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [arlertView show];
                
            }else{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
        }];
        
    }
}
@end
