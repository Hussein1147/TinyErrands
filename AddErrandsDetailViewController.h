//
//  AddErrandsDetailViewController.h
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 6/29/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddErrandsDetailViewController;
@class TinyErrand;

@protocol AddErrandsDetaillViewControllerDelegate <NSObject>

-(void)errandsDetailViewControllerDidCancel:(AddErrandsDetailViewController*)controller;
-(void)errandsDetailViewController:(AddErrandsDetailViewController*)controller;

@end

@interface AddErrandsDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ErrandsDescription;

@property (weak, nonatomic) IBOutlet UITextField *step1TextField;
@property (weak, nonatomic) IBOutlet UITextField *step2TextField;
@property (weak, nonatomic) IBOutlet UITextField *step3TextField;
@property (weak, nonatomic) IBOutlet UITextField *step4TextField;
@property (weak, nonatomic) IBOutlet UITextField *step5TextField;


@property (nonatomic, assign) BOOL dateOpen;

@property (nonatomic,assign)  BOOL secondDateOpen;

@property (nonatomic,weak) id <AddErrandsDetaillViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
