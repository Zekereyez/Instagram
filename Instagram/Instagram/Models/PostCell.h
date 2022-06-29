//
//  PostCell.h
//  Instagram
//
//  Created by Zeke Reyes on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;

@property (weak, nonatomic) Post *post;

- (void) handlePostFormatting;

@end

NS_ASSUME_NONNULL_END
