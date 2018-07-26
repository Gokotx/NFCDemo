//
//  ViewController.m
//  NFCDemo
//
//  Created by Goko on 14/08/2017.
//  Copyright © 2017 Goko. All rights reserved.
//

#import <CoreNFC/CoreNFC.h>
#import "ViewController.h"

@interface ViewController ()<NFCNDEFReaderSessionDelegate>

@property(nonatomic,strong)NFCNDEFReaderSession * nfcSession;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nfcSession = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:NO];
    [self.nfcSession beginSession];
    
}
-(void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages{
    [messages enumerateObjectsUsingBlock:^(NFCNDEFMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.records enumerateObjectsUsingBlock:^(NFCNDEFPayload * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"typeNameFormat:%d",obj.typeNameFormat);
            NSLog(@"payload:%@",obj.payload);
            NSLog(@"type:%@",obj.type);
            NSLog(@"identifier:%@",obj.identifier);
        }];
    }];
}
-(void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(nonnull NSError *)error{
    NSLog(@"error:%@",error.localizedDescription);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.nfcSession = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:YES];
    [self.nfcSession beginSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
