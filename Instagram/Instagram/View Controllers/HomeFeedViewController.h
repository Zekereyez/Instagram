//
//  HomeFeedViewController.h
//  Instagram
//
//  Created by Zeke Reyes on 6/28/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"
#import "PostCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedViewController : UIViewController
- (IBAction)didTapLogout:(id)sender;
- (IBAction)didTapCompose:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
