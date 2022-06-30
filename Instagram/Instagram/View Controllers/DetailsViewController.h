//
//  DetailsViewController.h
//  Instagram
//
//  Created by Zeke Reyes on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailsImage;
@property (weak, nonatomic) IBOutlet UILabel *detailsCaption;
@property (weak, nonatomic) IBOutlet UILabel *detailsPostDate;

@property (weak, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
