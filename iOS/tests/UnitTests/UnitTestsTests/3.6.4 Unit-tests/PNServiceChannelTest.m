//
//  PNServiceChannelTest.m
//  UnitTestSample
//
//  Created by Vadim Osovets on 5/5/13.
//  Copyright (c) 2013 Micro-B. All rights reserved.
//
#import <XCTest/XCTest.h>

#import "PNServiceChannel.h"
#import "PNMessage.h"
#import "PNChannel.h"
#import "PNMessagePostRequest.h"

#import "NSData+PNAdditions.h"

#import <OCMock/OCMock.h>


@interface PNServiceChannelTest : XCTestCase

<
PNDelegate,
PNConnectionChannelDelegate
>

@end

@implementation PNServiceChannelTest {
    PNConfiguration *_configuration;
}

- (void)setUp
{
    [super setUp];
    
    _configuration = [PNConfiguration defaultConfiguration];
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

#pragma mark - States tests

- (void)testServiceChannelWithDelegate {
    /*
     Test scenario:
      - initService with some delegate object
      - check service is ready to work
     */
    
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithConfiguration:_configuration andDelegate:self];
    
    XCTAssertNotNil(channel, @"Channel is not available");
}

- (void)testInitWithTypeAndDelegate {
    /*
     Test scenario:
     - initService with type: service and some delegate object
     - check service is ready to work
     
     - initService with type: messaging and some delegate object
     - check service is ready to work
     */
    
    PNServiceChannel *channel = [[PNServiceChannel alloc] initWithConfiguration:_configuration type:PNConnectionChannelService andDelegate:self];
    
    XCTAssertNotNil(channel, @"Channel is not available");
    
    
    channel = [[PNServiceChannel alloc] initWithConfiguration:_configuration type:PNConnectionChannelMessaging andDelegate:self];
    XCTAssertNotNil(channel, @"Channel is not available");
}

#pragma mark - Interaction tests

- (void)testSendMessage {
    /*
     Test scenario:
     - initService with some delegate object
     - send a message
     - expect scheduleRequest method of channel ivoked
    */
    
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithConfiguration:_configuration andDelegate:self];
    
    id mock = [OCMockObject partialMockForObject:channel];
    
    [[[[mock expect] ignoringNonObjectArgs] andReturn:nil] sendMessage: [OCMArg any] toChannel:[OCMArg any] compressed:NO storeInHistory:NO];

    [mock sendMessage:[PNMessage new]];
    
    [mock verify];
}

- (void)testSendMessageToChannel {
    /*
     Test scenario:
     - initService with some delegate object
     - send a message to specific channel
     - expect scheduleRequest method of channel ivoked
     */
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithConfiguration:_configuration andDelegate:self];
    
    id mockChannel = [OCMockObject partialMockForObject:channel];
    
    [[[mockChannel expect] ignoringNonObjectArgs] sendMessage:[OCMArg any] toChannel:[OCMArg any]
                                                   compressed:NO storeInHistory:NO];
    
    [mockChannel sendMessage:[PNMessage new]
                   toChannel:mockChannel
                  compressed:NO
     storeInHistory:NO];
    [mockChannel verify];
}

#pragma mark - PNConnectionDelegates

- (void)connectionChannelConfigurationDidFail:(PNConnectionChannel *)channel{
}
- (void)connectionChannel:(PNConnectionChannel *)channel didConnectToHost:(NSString *)host{
}
- (void)connectionChannel:(PNConnectionChannel *)channel didReconnectToHost:(NSString *)host{
}
- (void)connectionChannel:(PNConnectionChannel *)channel connectionDidFailToOrigin:(NSString *)host
withError:(PNError *)error{
}
- (void)connectionChannelWillSuspend:(PNConnectionChannel *)channel{
}
- (void)connectionChannelDidSuspend:(PNConnectionChannel *)channel{
}
- (void)connectionChannelWillResume:(PNConnectionChannel *)channel{
}
- (void)connectionChannelDidResume:(PNConnectionChannel *)channel requireWarmUp:(BOOL)isWarmingUpRequired{
}
- (BOOL)connectionChannelCanConnect:(PNConnectionChannel *)channel{
    return YES;
}
- (BOOL)connectionChannelShouldRestoreConnection:(PNConnectionChannel *)channel{
    return YES;
}
- (void)connectionChannelConfigurationDidFail11:(PNConnectionChannel *)channel{
}
- (NSString *)clientIdentifier{
    return @"rr";
}
- (BOOL)isPubNubServiceAvailable:(BOOL)shouldUpdateInformation{
    return YES;
}
- (void)connectionChannel:(PNConnectionChannel *)channel didDisconnectFromOrigin:(NSString *)host{
}
- (void)connectionChannel:(PNConnectionChannel *)channel willDisconnectFromOrigin:(NSString *)host
               withError:(PNError *)error{
}

- (void)connectionChannel:(PNConnectionChannel *)channel checkCanConnect:(void (^)(BOOL))checkCompletionBlock {
    
}

@end
