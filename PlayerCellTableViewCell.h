//
//  PlayerCellTableViewCell.h
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 7/12/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *errandDescription;

@property (weak, nonatomic) IBOutlet UILabel *dueIn;
@end
