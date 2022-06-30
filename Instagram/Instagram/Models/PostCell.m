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
    self.postUsername.text = self.post.author.username;
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
    self.postDate.text = [NSString stringWithFormat:@"%@%@", elapsed, @" ago"];
}

@end
