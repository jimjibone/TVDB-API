//
//  TVDBShow.h
//  Media Sorter
//
//  Created by James Reuss on 21/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVDBShow : NSObject
@property (retain) NSString *seriesID;
@property (retain) NSString *language;
@property (retain) NSString *seriesName;
@property (retain) NSString *overview;

// Instance Methods
- (void)setShowWithSeriesID:(NSString*)newSeriesID Language:(NSString*)newLanguage SeriesName:(NSString*)newSeries Overview:(NSString*)newOverview;

// Class Methods
+ (TVDBShow*)showWithSeriesID:(NSString*)newSeriesID Language:(NSString*)newLanguage SeriesName:(NSString*)newSeries Overview:(NSString*)newOverview;

@end
