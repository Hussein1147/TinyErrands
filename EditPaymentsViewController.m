//
//  EditPaymentsViewController.m
//  Poke
//
//  Created by DJIBRIL KEITA on 3/1/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "EditPaymentsViewController.h"
#import "Stripe.h"

#import  "AFHTTPRequestOperationManager.h"
#define STRIPE_TEST_PUBLIC_KEY @"pk_test_mjZsJALdxDNEccGPBzX73"
#define STRIPE_TEST_POST_URL @"https://jobostest-jobos.rhcloud.com"

@interface EditPaymentsViewController ()

@property(nonatomic,strong) STPCard *stripeCard;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvcNumberTextField;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) NSDate *myDate;
@property (weak, nonatomic) IBOutlet UIButton *addCard;
@property (nonatomic,strong) PFUser *currentUser;

@end
@implementation EditPaymentsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self createDatePicker];
    /*For now make a parse call to get a current user but used 
     delegation to get current user from editfriends view controller
     */
    self.currentUser = [PFUser currentUser];
    
}

-(void)createDatePicker{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle   = UIBarButtonItemStylePlain;
    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.expDateTextField action:@selector(resignFirstResponder)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[itemSpace,itemDone];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    datePicker.date          = [NSDate date];
    datePicker.datePickerMode =UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    self.expDateTextField.inputAccessoryView = toolbar;
    self.expDateTextField.inputView          = datePicker;


}



-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.expDateTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    self.myDate =[NSDate date];
    self.myDate =picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.expDateTextField.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void)Result
{
    NSDateFormatter *formDay = [[NSDateFormatter alloc] init];
    formDay.dateFormat=@"MM-dd-yyyy";
    NSString *day = [formDay stringFromDate:[_datePicker date]];
    self.expDateTextField.text = day;
}

#pragma mark - Strip setup & call

- (IBAction)AddCard:(id)sender {
 
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.myDate];
    self.stripeCard = [[STPCard alloc]init];
    self.stripeCard.name = self.nameTextField.text;
    self.stripeCard.number = self.cardNumberTextField.text;
    self.stripeCard.expMonth = [components month];
    self.stripeCard.expYear = [components year];
    self.stripeCard.cvc = self.cvcNumberTextField.text;
    
    if ([self validateCustomerInfo]) {
        [self performStripeOperation];
    }

}

-(void)performStripeOperation{
//    self.addCard.enabled =NO;
    NSLog(@"striipe operatio perforded");
    
    [[STPAPIClient sharedClient] createTokenWithCard:self.stripeCard

completion:^(STPToken *token, NSError *error) {
    if (error) {
        NSLog(@"Sorry, some problem have occured: %@ %@", error, [error userInfo]);
    
    }else{
        NSLog(@"%@",token.tokenId);
       // [self createBackendChargeWithToken:token];
        NSLog(@"calling backend");
    }
}];
}

- (void)createBackendChargeWithToken:(STPToken *)token{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];;
   // manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONReadingAllowFragments];
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    NSInteger totalCents = 100;
    postRequestDictionary[@"stripeAmount"] = [NSString stringWithFormat:@"%ld", (long)totalCents];
    postRequestDictionary[@"stripeCurrency"] = @"usd";
    postRequestDictionary[@"stripeToken"] = token.tokenId;
    postRequestDictionary[@"stripeDescription"] = @"Purchase from jobos iOS app!";
    NSLog(@"dictionary: %@", postRequestDictionary);
    
    [manager POST:STRIPE_TEST_POST_URL parameters:postRequestDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
    }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", [operation responseString]);
     }];
    
    self.addCard.enabled =YES;
}
#pragma mark - Helper methods
- (BOOL)validateCustomerInfo {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                     message:@"Please enter all required information"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    //1. Validate name & email
    
    /*
     
     was testing this part make sure payment server is running
     */
    
    
    if (self.nameTextField.text.length == 0 ||
        [self NSStringIsValidEmail:self.emailTextField.text] == NO) {
        
        [alert show];
        return NO;
    }
    
    //2. Validate card number, CVC, expMonth, expYear
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    //3
    if (error) {
        alert.message = [error localizedDescription];
        [alert show];
        return NO;
    }
    
    return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end
