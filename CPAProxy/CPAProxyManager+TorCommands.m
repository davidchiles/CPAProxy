//  CPAProxyManager+TorControlAdditions.m
//
//  Copyright (c) 2013 Claudiu-Vlad Ursache.
//  See LICENCE for licensing information
//

#import "CPAProxyManager+TorCommands.h"
#import "CPAThread.h"
#import "CPAConfiguration.h"
#import "CPASocketManager.h"
#import "CPAProxyCommand.h"
#import "CPAProxyTorCommands.h"
#import "CPAProxyTorCommandConstants.h"

@implementation CPAProxyManager (TorControlAdditions)

- (void)cpa_sendAuthenticateWithCompletion:(CPAProxyCommandResponseBlock)completion completionQueue:(dispatch_queue_t)completionQueue;
{
    NSString *torCookieHex = [self.configuration torCookieDataAsHex];
    NSString *commandString = [CPAProxyTorCommands authenticateCommandWithCookieHexString:torCookieHex];
    CPAProxyCommand *command = [CPAProxyCommand commandWithCommandString:commandString tag:nil responseBlock:completion responseQueue:completionQueue];
    [self.socketManager sendCommand:command];
}

- (void)cpa_sendGetBootstrapInfoWithCompletion:(CPAProxyCommandResponseBlock)completion completionQueue:(dispatch_queue_t)completionQueue;
{
    NSString *commandString = [CPAProxyTorCommands getInfoCommandWithKeyword:kCPAProxyStatusBootstrapPhase];
    CPAProxyCommand *command = [CPAProxyCommand commandWithCommandString:commandString tag:nil responseBlock:completion responseQueue:completionQueue];
    [self.socketManager sendCommand:command];
}

- (void)cpa_setEvents:(NSArray *)eventsArray extended:(BOOL)extended completion:(CPAProxyCommandResponseBlock)completion completionQueue:(dispatch_queue_t)completionQueue
{
    NSString *commandString = [CPAProxyTorCommands setEventsCommandWithEventsArray:eventsArray extended:extended];
    CPAProxyCommand *command = [CPAProxyCommand commandWithCommandString:commandString tag:nil responseBlock:completion responseQueue:completionQueue];
    [self.socketManager sendCommand:command];
}


@end
