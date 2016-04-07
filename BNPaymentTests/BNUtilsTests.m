//
//  BNUtilsTests.m
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

#import <BNPayment/BNPayment.h>

@import XCTest;

@interface BNUtilsTests : XCTestCase

@end

@implementation BNUtilsTests

- (void)testGenerateSHA256HMAC {
    NSString *data = @"The quick brown fox jumps over the lazy dog";
    NSString *key = @"key";
    
    NSString *hmac = [BNUtils sha256HMAC:data key:key];
    NSString *correctHmac = @"f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8";
    
    XCTAssertEqualObjects(correctHmac, hmac, "Correct SHA256 HCMAC generated");
}

@end