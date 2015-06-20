//
//  SignUpViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 2/22/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "SignUpViewController.h"
#import "TinyUser.h"
#import <Parse/Parse.h>

@implementation SignUpViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Poke"];

}
- (IBAction)signup:(id)sender {
    
    NSString *userName = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
      NSString *passWord = [self.passWordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
      NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([passWord length]<= 5 || [email length] ==0 || [userName length] ==0) {
        UIAlertView *allerView = [[UIAlertView alloc]initWithTitle:@"Bummer!"
                                                           message:@"Username, and email can not be empty, password must be greater than five characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [allerView show];
        
        
    }
    else{
        PFUser *newUser = [PFUser user];
        TinyUser *tinyUser = [[TinyUser alloc]init];
        tinyUser.name = userName;
        tinyUser.email = email;
        tinyUser.password = passWord;
        newUser.username = userName;
        newUser.password = passWord;
        newUser.email = email;
        
        [tinyUser signUp:^(id responseObject, NSError *error) {
            if (error) {
                UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [arlertView show];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
                [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                }];
                
            }
            
        }];

        
        
    
    }
}
@end
