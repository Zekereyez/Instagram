//
//  LoginViewController.h
//  Instagram
//
//  Created by Zeke Reyes on 6/28/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HomeFeedViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)didTapSignUp:(id)sender;
- (IBAction)didTapLogin:(id)sender;


@end

NS_ASSUME_NONNULL_END
