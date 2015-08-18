//
//  AddErrandsDetailViewController.m
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 6/29/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "AddErrandsDetailViewController.h"
#import "MyCustomTableViewCell.h"
#import "TinyErrand.h"
#import "TinyUser.h"
#import <Parse/Parse.h>


@interface AddErrandsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondDetailLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *secondDatePicker;
@property (strong,nonatomic) NSMutableArray *individualTasks;
@property (strong,nonatomic) NSString *iso8601String;
@property (strong,nonatomic) TinyUser *tinyUser;

@end

@implementation AddErrandsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    self.tinyUser = [[TinyUser alloc]init];
    self.tinyUser.email =currentUser.email;
    
    self.dateOpen = true;
    self.secondDateOpen =true;
    self.individualTasks = [[NSMutableArray alloc]init];
    [self.individualTasks addObject:@"default"];

    [self datePickerChanged:self.detailsLabel picker:self.datePicker];
    [self datePickerChanged:self.secondDetailLabel picker:self.secondDatePicker];
    self.ErrandsDescription.delegate = self.step1TextField.delegate = self.step2TextField.delegate =
    self.step3TextField.delegate =self.step4TextField.delegate = self.step5TextField.delegate= self;
    [self.ErrandsDescription setReturnKeyType:UIReturnKeyDone];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)datePickerChanged:(UILabel *)label picker:(UIDatePicker*)picker{
    label.text = [NSDateFormatter localizedStringFromDate:picker.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    

}
#pragma mark - Table view data source



-(void)addCharity:(id)sender{
    [self.individualTasks addObject:@"task"];
}
-(void)toggleDatepicker{
    self.dateOpen =!self.dateOpen;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}
-(void)toggleSecondDatePicker{
    self.secondDateOpen =!self.secondDateOpen;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];


}
- (IBAction)dateValueChanged:(UIDatePicker *)sender {
    [self datePickerChanged:self.detailsLabel picker:self.datePicker];
}

- (IBAction)secondDatePickerValue:(UIDatePicker *)sender {
    [self datePickerChanged:self.secondDetailLabel picker:self.secondDatePicker];
}



- (IBAction)cancel:(id)sender {
    [self.delegate errandsDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    NSMutableDictionary *errand = [[NSMutableDictionary alloc]init];
    errand[@"myPost"] = self.ErrandsDescription.text;
    NSNumber *dueInValue =[NSNumber numberWithInteger:[self dueInCalculator]];
    errand[@"dueDate"] = dueInValue;
    
    [self.tinyUser addPost:errand[@"myPost"] dueIn:[dueInValue integerValue] startTime:self.iso8601String completion:^(id responseObject, NSError *error)
     {
         NSLog(@"called");
         if (error) {
         UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [arlertView show];
         
    }
     }
     ];
    [self.delegate errandsDetailViewController:self];
}

-(NSInteger)dueInCalculator {
    
    NSDateComponents *components;
    NSInteger minutes;
    components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self.datePicker.date toDate:self.secondDatePicker.date options:0];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateformatter setLocale:locale];
    [dateformatter setTimeZone:timeZone];
    [dateformatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateformatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss Z"];
    self.iso8601String = [[NSString alloc]init];
    self.iso8601String = [dateformatter stringFromDate:self.datePicker.date];
    
    NSLog(@"%@, %@",self.datePicker.date, self.iso8601String) ;
    minutes =  [components minute];
    return minutes;

}
#pragma mark - delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // This is the index path of the date picker cell in the static table
    
    if ((self.dateOpen && indexPath.section == 1 && indexPath.row == 1 ) || (self.secondDateOpen && indexPath.section== 1 && indexPath.row == 3)){
        return 0;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        
    }
}




-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section ==1 && indexPath.row == 0)
        
    {
        [self toggleDatepicker];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self toggleSecondDatePicker];
    }
    
    //    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [super tableView:tableView numberOfRowsInSection:section];
    
}
@end
