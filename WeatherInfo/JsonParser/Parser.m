//
//  Parser.m
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import "Parser.h"

@implementation Parser
@synthesize delegate;
-(void)parseData:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             id dict = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             [self succesfullyParseData:dict];
         }
         else
         {
             [delegate DidFail:connectionError.localizedDescription];
         }
         
     }];
}
-(void)succesfullyParseData:(id)data
{
    if ([[data valueForKey:@"cod"] integerValue]==200) {
        [delegate DidFinish:data];
    }
    else
    {
        [delegate DidFail:@"City Not Found"];
    }
}
@end
