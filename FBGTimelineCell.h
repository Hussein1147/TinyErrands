//
//  FBGTimelineCell.h
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 9/25/15.
//  Copyright © 2015 DJIBRILKEITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBGTimelineCell : UITableViewCell
{
    bool configured;
}

@property (nonatomic,strong) IBOutlet UIView *cellContentView;

- (void) initTimelineCell;
- (bool) configured;

@end


