//
//  TVDB API.h
//  VideoMatic
//
//  Created by James Reuss on 18/01/2012.
//  Copyright (c) 2012 James Reuss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVDBShow.h"

@interface TVDBShowSearch : NSObject {
    NSMutableArray *foundShows;
    TVDBShow *currentShow;
    NSMutableString *dataBuffer;
}

#pragma mark Initialisation
- (id)init;

#pragma mark Search Methods
- (void)searchForShowWithName:(NSString*)searchTerm;
- (NSMutableArray*)getFoundShows;
- (TVDBShow*)getShowElement:(NSUInteger)element;
- (TVDBShow*)firstShow;

#pragma mark Internal Methods
- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@end
