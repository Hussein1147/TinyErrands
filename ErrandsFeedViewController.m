//
//  ErrandsFeedViewController.m
//  Jobos
//
//  Created by DJIBRIL KEITA on 6/22/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "ErrandsFeedViewController.h"
#import "TinyUser.h"
#import "FBGTimelineCell.h"
#import <Parse/Parse.h>

@interface ErrandsFeedViewController ()
@property (nonatomic,strong) NSMutableArray *posts;
@property (nonatomic,strong) TinyUser *tinyUser;
@property (nonatomic,strong) PFUser *currentUser;


@end

@implementation ErrandsFeedViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tinyUser = [[TinyUser alloc]init] ;
    self.currentUser = [PFUser currentUser];
    self.tinyUser.email =self.currentUser.email;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.tinyUser getFollowedPosts:^(id responseObject, NSError *error) {
        if (error) {
            UIAlertView *arlertView = [[UIAlertView alloc]initWithTitle:@"Yaiks!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [arlertView show];
        }else{
            self.posts = [[NSMutableArray alloc]init];
            self.posts = [responseObject valueForKey:@"data"];
            
        }
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"timelineCell";
    FBGTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (![cell configured])
    {
        [cell initTimelineCell];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}






#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
