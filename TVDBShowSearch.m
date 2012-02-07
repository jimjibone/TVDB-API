//
//  TVDB API.m
//  VideoMatic
//
//  Created by James Reuss on 18/01/2012.
//  Copyright (c) 2012 James Reuss. All rights reserved.
//

#import "TVDBShowSearch.h"

#define GETSERIESURL @"http://www.thetvdb.com/api/GetSeries.php?seriesname="

@implementation TVDBShowSearch

//-------------------------------------------------------------------------------------
// Initialisation Methods
//-------------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    if (self) {
		foundShows = [[NSMutableArray alloc] init];
    }
    return self;
}

//-------------------------------------------------------------------------------------
// Search Methods
//-------------------------------------------------------------------------------------
- (void)searchForShowWithName:(NSString*)searchTerm {
	// Set up the url to search for the show 'showName'.
	searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSURL *searchURL = [[NSURL alloc] initWithString:
							[NSString stringWithFormat:@"%@%@", GETSERIESURL, searchTerm]];
	
	[foundShows removeAllObjects];
	
	// Create a XML parser to search through the returned results for us.
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:searchURL];
	[parser setDelegate:self];
	[parser parse];
	
	// Clean up.
	[parser release];
	[searchURL release];
}
- (NSMutableArray*)getFoundShows {
	return foundShows;
}
- (TVDBShow*)getShowElement:(NSUInteger)element {
	return [foundShows objectAtIndex:element];
}
- (TVDBShow*)firstShow {
    return [foundShows objectAtIndex:0];
}

//-------------------------------------------------------------------------------------
// Internal NSXML Parser Methods
//-------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	// If we are doing a Series search then we want to create a new TVDBShow object to work with for each show we encounter in the search.
	if ([elementName isEqualToString:@"seriesid"]) {
		currentShow = [[TVDBShow alloc] init];
	}
}

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
	if		  ([elementName isEqualToString:@"seriesid"]) {
		[currentShow setSeriesID:[NSString stringWithString:dataBuffer]];
	} else if ([elementName isEqualToString:@"language"]) {
		[currentShow setLanguage:[NSString stringWithString:dataBuffer]];
	} else if ([elementName isEqualToString:@"SeriesName"]) {
		[currentShow setSeriesName:[NSString stringWithString:dataBuffer]];
	} else if ([elementName isEqualToString:@"Overview"]) {
		[currentShow setOverview:[NSString stringWithString:dataBuffer]];
	}
	if ([elementName isEqualToString:@"id"]) {
		// This is the final element in this shows XML tree and because were not interested in this we can use it to close off the assignment of this shows details and add it to the foundShowArray.
		[dataBuffer release];
		dataBuffer = nil;
		
		// Check that all the fields are filled. If not then fill with blank.
		if (![currentShow seriesID])	[currentShow setSeriesID:@"N/A"];
		if (![currentShow language])	[currentShow setLanguage:@"N/A"];
		if (![currentShow seriesName])	[currentShow setOverview:@"N/A"];
		if (![currentShow overview])	[currentShow setOverview:@"N/A"];
		
		[foundShows addObject:currentShow];
		[currentShow release];
	} else {
		[dataBuffer setString:@""];
	}
}

@end
