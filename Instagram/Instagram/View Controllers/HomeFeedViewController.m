//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Zeke Reyes on 6/28/22.
//

#import "HomeFeedViewController.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrayOfPosts;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Source and delegate
     self.tableView.dataSource = self;
     self.tableView.dataSource = self;
    
    // Instantiating UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    // Binding action to the refresh control
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    // Adding UIRefreshControl to the table view
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    // check
    [self getPosts];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // Get timeline
    [self getPosts];
    [refreshControl endRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapCompose:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}


// TODO: Fix logout
- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Unable to log out of instagram");
        }
        
        if (!error) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    self.view.window.rootViewController = loginViewController;
        }
    }];
}

- (void) getPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // Handle fetched data
            self.arrayOfPosts = [NSMutableArray arrayWithArray:posts];
            [self.tableView reloadData];
            NSLog(@"%@", self.arrayOfPosts);
        }
        else {
            // Log error
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    [cell handlePostFormatting];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // this checks if the segue is the details segue when a segue is triggered
    // if it is, we need to do work before the details segue is completed to fill data
    if([segue.identifier isEqualToString:@"detailsSegue"]) {
        // We know that when triggered the sender will be a postcell
        PostCell *cell = sender;
        // each post tableview has an indexpath and we call this method on the
        // cell to extract the the index path from the tableview cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        // we create a post object that holds the number of which the cell
        // corresponds to in the array of posts which holds the posts
        Post *post = self.arrayOfPosts[indexPath.row];
        // we create a reference of details vc to prepare and fill data
        // since we have a post property within of details vc we can assign our
        // post to the details post to have that data when seguing
        DetailsViewController *detailsVC = segue.destinationViewController;
        detailsVC.post = post;
//        detailsVC.post =
    }
}

@end
