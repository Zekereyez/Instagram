//
//  DetailsViewController.m
//  Instagram
//
//  Created by Zeke Reyes on 6/29/22.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // TODO: See below
    // Ask Rammi about the util methods and how to modularize this code
    // since we need to use the same code that's in postcell.m
    [self handlePostFormatting];
}

- (void)handlePostFormatting {
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.post.image.url]];
    self.detailsImage.image = [UIImage imageWithData:imageData];
    self.detailsCaption.text = self.post.caption;
    self.detailsCaption.text = [NSString stringWithFormat:@"%@ %@", self.post.author.username, self.post.caption];
    
    NSMutableAttributedString *postText = [[NSMutableAttributedString alloc] initWithString:self.detailsCaption.text];
//    NSRange boldRange = [self.detailsCaption.text rangeOfString:self.post.author.username];
//    [postText addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:boldRange];
    [self.detailsCaption setAttributedText: postText];
    
    [self postDate];
}


- (void)postDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Convert String to Date
    NSDate *date = self.post.createdAt;
    
    // Error handling for date
    if (date == nil) {
        date = [NSDate date];
    }
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;

    NSDate *currDate = [NSDate date];
    NSTimeInterval diff = [currDate timeIntervalSinceDate:date];

    // Format the string depending on how long ago post was created
    NSInteger interval = diff;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
    NSDateComponentsFormatter *formatter2 = [[NSDateComponentsFormatter alloc] init];
        formatter2.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        
    // If time is greater then 24 hrs, place date as days
    if (hours > 24) {
        formatter2.allowedUnits = NSCalendarUnitDay;
    }
    // If time is greater then a hour, place date as hours
    else if(hours > 1) {
        formatter2.allowedUnits = NSCalendarUnitHour;
        
    }
    // If time is greater then a minute, place date as minutes
    else if(minutes > 1) {
        formatter2.allowedUnits = NSCalendarUnitMinute;
    }
    // Place date as secs if smaller than all other time units
    else {
        formatter2.allowedUnits = NSCalendarUnitSecond;
    }
    NSString *elapsed = [formatter2 stringFromDate:date toDate:[NSDate date]];
    self.detailsPostDate.text = [NSString stringWithFormat:@"%@%@", elapsed, @" ago"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
