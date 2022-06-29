//
//  PostCell.m
//  Instagram
//
//  Created by Zeke Reyes on 6/29/22.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)handlePostFormatting {
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.post.image.url]];
    self.postImage.image = [UIImage imageWithData:imageData];
    self.postCaption.text = self.post.caption;
}

@end
