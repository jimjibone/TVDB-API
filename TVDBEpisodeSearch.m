//
//  TVDBEpisodeSearch.m
//  VideoMatic
//
//  Created by James Reuss on 18/01/2012.
//  Copyright (c) 2012 James Reuss. All rights reserved.
//

#import "TVDBEpisodeSearch.h"

@implementation TVDBEpisodeSearch
@synthesize episodeID, seasonID, episodeNumber, seasonNumber, episodeName;
@synthesize firstAired, guestStars, director, writer;
@synthesize overview, coverPhotoURL, rating, language;

//-------------------------------------------------------------------------------------
// Initialisation Methods
//-------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    if (self) {
		//
    }
    return self;
}

//-------------------------------------------------------------------------------------
// Search Methods
//-------------------------------------------------------------------------------------
- (void)findEpisodeInfoForSeriesID:(NSString*)seriesID Season:(NSInteger)seasonNo Episode:(NSInteger)episodeNo {
	// Set up the url to get the episode info.
	NSURL *infoURL = [[NSURL alloc] initWithString:
						[NSString stringWithFormat:@"http://www.thetvdb.com/api/<your-api-key>/series/%@/default/%ld/%ld/en.xml", seriesID, seasonNo, episodeNo]];
	
	// Create a XML parser to search through the returned results for us.
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:infoURL];
	[parser setDelegate:self];
	[parser parse];
	
	// Clean up.
	[parser release];
	[infoURL release];
}

//-------------------------------------------------------------------------------------
// Internal NSXML Parser Methods
//-------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string {
	// This will be the same for all search types as it just collects the data we want.
	if (!dataBuffer) {
		dataBuffer = [[NSMutableString alloc] initWithString:@""];
	}
	[dataBuffer appendString:
	 [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	// So were doing a Series search. We must pick out all the information we want and put it into the relevant field of foundShow.
	if		  ([elementName isEqualToString:@"id"]) {
        episodeID = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"seasonid"]) {
		seasonID = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"EpisodeNumber"]) {
		episodeNumber = [dataBuffer integerValue];
	} else if ([elementName isEqualToString:@"SeasonNumber"]) {
		seasonNumber = [dataBuffer integerValue];
	} else if ([elementName isEqualToString:@"EpisodeName"]) {
		episodeName = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"FirstAired"]) {
		firstAired = [NSDate dateWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"GuestStars"]) {
		guestStars = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"Director"]) {
		director = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"Writer"]) {
		writer = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"Overview"]) {
		overview = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"filename"]) {
		coverPhotoURL = [NSString stringWithString:dataBuffer];
	} else if ([elementName isEqualToString:@"Rating"]) {
		rating = [NSNumber numberWithFloat:[dataBuffer floatValue]];
	} else if ([elementName isEqualToString:@"Language"]) {
		language = [NSString stringWithString:dataBuffer];
	}
    
	if ([elementName isEqualToString:@"Episode"]) {
		// This is the final element in this shows XML tree and because were not interested in this we can use it to close off the assignment of this shows details and add it to the foundShowArray.
		[dataBuffer release];
		dataBuffer = nil;
		
		// Check that all the fields are filled. If not then fill with blank.
		if (!episodeID)	episodeID = @"N/A";
		if (!seasonID)	seasonID = @"N/A";
        if (!episodeNumber)	episodeNumber = 0;
        if (!seasonNumber)	seasonNumber = 0;
        if (!firstAired)	firstAired = [NSDate dateWithString:@"1930-01-01 00:00:01 +0000"];
        if (!guestStars)	guestStars = @"N/A";
        if (!director)	director = @"N/A";
        if (!writer)	writer = @"N/A";
        if (!overview)	overview = @"N/A";
        if (!coverPhotoURL)	coverPhotoURL = @"N/A";
        if (!rating)	rating = [NSNumber numberWithInt:0];
        if (!language)	language = @"N/A";
	} else {
		[dataBuffer setString:@""];
	}
}

@end
