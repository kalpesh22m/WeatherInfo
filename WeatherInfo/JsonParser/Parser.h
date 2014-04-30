//
//  Parser.h
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol  ParserDelgate <NSObject>

@required
- (void)DidFail:(NSString *)errorstr;
- (void)DidFinish:(id)data;
@end


@interface Parser : NSObject
{
    id json;

}
@property (nonatomic, weak) id <ParserDelgate> delegate;
-(void)parseData:(NSString *)url;

@end
