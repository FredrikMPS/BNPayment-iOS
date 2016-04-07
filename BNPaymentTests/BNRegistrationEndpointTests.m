//
//  BNRegistrationEndpointTests.m
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "BNPayment.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"

@import XCTest;
@import UIKit;

@interface BNRegistrationEndpointTests : XCTestCase

@property NSString *fileName;
@property int statusCode;

@end

@implementation BNRegistrationEndpointTests

- (void)setUp {
    [super setUp];
    
    [OHHTTPStubs setEnabled:YES];
    
    NSError *error;
    [BNPaymentHandler setupWithApiToken:@"T000000000" baseUrl:nil debug:YES error:&error];
    
    XCTAssertNil(error, "Error is nil after setup");
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *filePath = OHPathForFile(self.fileName, self.class);
        OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithFileAtPath:filePath
                                                                         statusCode:self.statusCode
                                                                            headers:@{@"Content-Type":@"application/json"}];
        return response;
    }];
}

- (void)testSuccessfulResponse {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];

    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNotNil(authenticator, "Authenticator not nil");
        XCTAssertNil(error, "Error is nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)testSuccessfulResponseExtraParams {
    self.fileName = @"registerResponseSuccessExtraParams.json";
    self.statusCode = 200;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNotNil(authenticator, "Authenticator not nil");
        XCTAssertNil(error, "Error is nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)test400Response {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 400;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNil(authenticator, "Authenticator nil");
        XCTAssertNotNil(error, "Error not nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

- (void)test500Response {
    self.fileName = @"registerResponseSuccess.json";
    self.statusCode = 500;
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Register user"];
    
    NSURLSessionDataTask *task =[BNRegistrationEndpoint registerWithUser:nil completion:^(BNAuthenticator *authenticator,
                                                                                          NSError *error) {
        XCTAssertNil(authenticator, "Authenticator nil");
        XCTAssertNotNil(error, "Error not nil");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

@end
