//
//  TVDBShow.m
//  Media Sorter
//
//  Created by James Reuss on 21/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TVDBShow.h"

@implementation TVDBShow
@synthesize seriesID, language, seriesName, overview;

//-------------------------------------------------------------------------------------
// Instance Methods
//-------------------------------------------------------------------------------------
- (void)setShowWithSeriesID:(NSString*)newSeriesID Language:(NSString*)newLanguage SeriesName:(NSString*)newSeries Overview:(NSString*)newOverview {
	[self setSeriesID:newSeriesID];
	[self setLanguage:newLanguage];
	[self setSeriesName:newSeries];
	[self setLanguage:newLanguage];
}

//-------------------------------------------------------------------------------------
// Class Methods
//-------------------------------------------------------------------------------------
+ (TVDBShow*)showWithSeriesID:(NSString*)newSeriesID Language:(NSString*)newLanguage SeriesName:(NSString*)newSeries Overview:(NSString*)newOverview {
    TVDBShow *returnableShow = [[TVDBShow alloc] init];
    [returnableShow setShowWithSeriesID:newSeriesID Language:newLanguage SeriesName:newSeries Overview:newOverview];
    return [returnableShow autorelease];
}

@end
