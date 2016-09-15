//
//  ViewController.m
//  searchID
//
//  Created by again on 16/4/12.
//  Copyright © 2016年 again. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#define IDUrl @"http://api.k780.com:88/?app=idcard.get&idcard=110101199001011114&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;
- (IBAction)search:(id)sender;
@property (strong,nonatomic) NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UILabel *born;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *att;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    
}


- (IBAction)search:(id)sender {
    [self.text resignFirstResponder];
    __block NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *str = @"http://api.k780.com:88/?app=idcard.get&idcard=";
    NSString *str2 = [str stringByAppendingString:[NSString stringWithFormat:@"%@", _text.text]];
    NSString *str3 = @"&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json";
    NSString *str4 = [str2 stringByAppendingString:[NSString stringWithFormat:@"%@", str3]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"idcard", @"att", @"sex", @"born", @"msg", @"success", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:str4 parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@-----------", dic);
        NSDictionary *diction = [dic objectForKey:@"result"];
        
        NSString *att = [diction objectForKey:@"att"];
        NSString *sex = [diction objectForKey:@"sex"];
        NSString *born = [diction objectForKey:@"born"];
        
        

        _att.text = [NSString stringWithFormat:@"%@",att];
        _sex.text = [NSString stringWithFormat:@"%@",sex];
        _born.text = [NSString stringWithFormat:@"%@",born];
        
            [_array addObject:att];
            [_array addObject:sex];
            [_array addObject:born];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
//    NSLog(@"%@", _array);
    
    
}











@end
