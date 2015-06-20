//
//  SignUpViewController.h
//  Poke
//
//  Created by DJIBRIL KEITA on 2/22/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;

- (IBAction)signup:(id)sender;
@end
