//
//  AddErrandsViewController.m
//  
//
//  Created by DJIBRIL KEITA on 6/28/15.
//
//

#import "AddErrandsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "TinyErrands-Swift.h"
#import "PlayerCellTableViewCell.h"
#import "TinyUser.h"

@interface AddErrandsViewController ()

@property(nonatomic,strong) NSMutableArray *errands;
@property(nonatomic,strong) UIRefreshControl *refreshCtrl;
@property(nonatomic,strong) TinyUser *tinyUser;
@end

@implementation AddErrandsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *current = [PFUser currentUser];
    self.tinyUser = [[TinyUser alloc]init];
    self.tinyUser.email = current.email;
    
    
    /* creating the refrsh control*/
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshCtrl =self.refreshControl;
    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tinyUser getMyPosts:^(id responseObject, NSError *error) {
        if (!responseObject) {
            NSLog(@"some error occured");
        }else{
            self.errands = [responseObject valueForKey:@"data"];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            
        }
    }];



}

-(NSMutableArray *)errands {
    
    if(!_errands)_errands = [[NSMutableArray alloc]init];
    return _errands;
    
}

-(void)handleRefresh{
        int64_t delayInSeconds = 1.0f;
   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
    
      [self.tinyUser getMyPosts:^(id responseObject, NSError *error) {
          if (!responseObject) {
              NSLog(@"some error occured");
          }else{
                  self.errands = [responseObject valueForKey:@"data"];
                  [self.refreshControl endRefreshing];
              [self.tableView reloadData];
             
          }
      }];

    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.errands count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
        NSMutableDictionary *errand =(self.errands)[indexPath.row];
        cell.errandDescription.text = [errand valueForKey:@"myPost"];
        cell.dueIn.text = [NSString stringWithString:[errand valueForKey:@"postedDate"]];
   
    return cell;

}
#pragma mark - Delegate methods

-(void)errandsDetailViewController:(AddErrandsDetailViewController *)controller{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)errandsDetailViewControllerDidCancel:(AddErrandsDetailViewController *)controller{


    [self dismissViewControllerAnimated:YES completion:nil];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddTask"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        AddErrandsDetailViewController *addDetailViewController = [navigationController viewControllers][0];
        addDetailViewController.delegate =self;
    
    }
}

@end
