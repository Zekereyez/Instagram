//
//  LoginViewController.m
//  Instagram
//
//  Created by Zeke Reyes on 6/28/22.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// User registration function
- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    // newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;

    if([self fieldsAreInvalid]) {
        [self alert];
        return;
    }
    
    
    // call sign up function on the object
    // signs up the user asynchronously, will
    // enforce that the username isn't already taken
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//            HomeFeedViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeFeedViewController"];
//            self.view.window.rootViewController = feedVC;
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

-(BOOL)fieldsAreInvalid {
    return ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]);
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if([self fieldsAreInvalid]) {
        [self alert];
        return;
    }
    
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // Display view controller that needs to shown after successful login
            // Manual segue is better since we are able to use the pull refresh
            // rather than having to run the app again once logged in
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeFeedViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeFeedViewController"];
            self.view.window.rootViewController = feedVC;
            // Another way to segue: use with a segue identifier
            // [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

// Alert method which handles the cases of incomplete user login/sign up credentials
- (void)alert {
    if ([self.usernameField.text isEqual:@""] && [self.passwordField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Username and Password Required"
                                                                                   message:@"Please Enter Your Credentials"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    else if ([self.passwordField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password Required"
                                                                                   message:@"Please Enter Your Password"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{}];
    }
    
    else if ([self.usernameField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Username Required"
                                                                                   message:@"Please Enter Your Username"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{}];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}
@end
