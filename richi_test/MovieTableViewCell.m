//
//  MovieTableViewCell.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

-(void)prepareForReuse
{
    self.posterImageView.image = nil;
    self.yearLabel.text = nil;
    self.titleLabel.text = nil;
    self.ratingLabel.text = nil;
}

- (void)awakeFromNib {
    // Initialization code
    self.posterImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
