//
//  MyCustomTableViewCell.m
//  Tiny Errands
//
//  Created by DJIBRIL KEITA on 7/3/15.
//  Copyright (c) 2015 DJIBRILKEITA. All rights reserved.
//

#import "MyCustomTableViewCell.h"


@implementation MyCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // initialize cell and add observers
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self)
        return self;
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // configure up some interesting display properties inside the cell
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 9, 147, 26)];
//    label.font = [UIFont fontWithName:@"task" size:17];
//    label.textColor = [UIColor colorWithWhite:0.2 alpha:1];
//    [self.contentView addSubview:label];
//    
    return self;
}
@end
