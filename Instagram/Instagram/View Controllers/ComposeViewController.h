//
//  ComposeViewController.h
//  Instagram
//
//  Created by Zeke Reyes on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *composeImage;
@property (weak, nonatomic) IBOutlet UITextField *caption;

@end

NS_ASSUME_NONNULL_END
