//
//  TVDBEpisodeSearch.h
//  VideoMatic
//
//  Created by James Reuss on 18/01/2012.
//  Copyright (c) 2012 James Reuss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TVDBEpisodeSearch : NSObject {
    NSMutableString *dataBuffer;
}
@property (assign) NSString *episodeID, *seasonID;
@property (assign) NSInteger episodeNumber, seasonNumber;
@property (assign) NSString *episodeName;
@property (assign) NSDate *firstAired;
@property (assign) NSString *guestStars, *director, *writer;
@property (assign) NSString *overview;
@property (assign) NSString *coverPhotoURL;
@property (assign) NSNumber *rating;
@property (assign) NSString *language;

#pragma mark Initialisation
- (id)init;

#pragma mark Search Methods
- (void)findEpisodeInfoForSeriesID:(NSString*)show Season:(NSInteger)seasonNo Episode:(NSInteger)episodeNo;

#pragma mark Internal Methods
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@end
