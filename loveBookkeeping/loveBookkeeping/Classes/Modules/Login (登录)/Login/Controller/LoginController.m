/**
 * 登录
 * @author 郑业强 2018-12-17 创建文件
 */


#import "LoginController.h"
#import "RE1Controller.h"
#import "PhoneController.h"
#import "BaseViewController+Extension.h"
#import "LOGIN_NOTIFICATION.h"
#import "JGProgressHUD.h"


#pragma mark - 声明
@interface LoginController()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *nameIcn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreBtnConstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxConstraintH;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end


#pragma mark - 实现
@implementation LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    
    [self.wxLoginBtn.layer setCornerRadius:3];
    [self.wxLoginBtn.layer setMasksToBounds:YES];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [self.wxLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.moreBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
    
    [self.moreBtnConstraintB setConstant:countcoordinatesX(20) + SafeAreaBottomHeight];
    [self.wxConstraintH setConstant:countcoordinatesX(45)];
    
    [self rac_notification_register];
}

// 监听通知
- (void)rac_notification_register {
    @weakify(self)
    // 忘记密码完成
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOPGIN_FORGET_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"忘记密码完成");
    }];
    // 注册完成
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOPGIN_REGISTER_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        // 回调
        if (self.complete) {
            self.complete();
        }
        // 关闭
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }];
    // 登录完成
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOPGIN_LOGIN_COMPLETE object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        // 回调
        if (self.complete) {
            self.complete();
        }
        // 关闭
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }];
    
    
}


#pragma mark - 请求
// QQ登录
- (void)getQQLoginRequest:(UMSocialUserInfoResponse *)resp {
//    @weakify(self)
//    // 下载图片
//    NSURL *url = [NSURL URLWithString:resp.iconurl];
//    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        @strongify(self)
//        // 失败
//        if (error) {
//            [self showTextHUD:@"图片获取失败" delay:1.5f];
//            return;
//        }
//        // 成功
//        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                               resp.openid, @"openid",
//                               resp.name, @"nickname",
//                               [resp.gender isEqualToString:@"男"] ? @(1) : @(0), @"sex", nil];
//        NSArray *images = @[image];
//        [self showProgressHUD];
//        @weakify(self)
//        [AFNManager POST:QQLoginRequest params:param andImages:images progress:nil complete:^(APPResult *result) {
//            @strongify(self)
//            [self hideHUD];
//            if (result.status == ServiceCodeSuccess) {
//                // 保存信息
//                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
//                                       [result.data valueForKey:@"icon"], @"icon",
//                                       [result.data valueForKey:@"token"], @"token",
//                                       [resp name], @"nickname",
//                                       [resp openid], @"openid",
//                                       [resp.gender isEqualToString:@"男"] ? @(1) : @(0), @"sex", nil];
//                [UserInfo saveUserInfo:data];
//                // 关闭
//                [self.navigationController dismissViewControllerAnimated:true completion:nil];
//                // 回调
//                if (self.complete) {
//                    self.complete();
//                }
//            } else {
//                [self showTextHUD:result.message delay:1.5f];
//            }
//        }];
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_pwd resignFirstResponder];
    [_account resignFirstResponder];
}

#pragma mark - 点击
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 微信
- (IBAction)wxBtnClick:(UIButton *)sender {
    if(_account.text.length < 11) {
        [self showErrorHUD:@"账号不合法"];
        [self hideHUD:1];
        return;
    }

    if(_pwd.text.length < 3) {
        [self showErrorHUD:@"密码错误"];
        [self hideHUD:1];
        return;
    }

    if ([_account.text isEqualToString:@"18888888888"] && [_pwd.text isEqualToString:@"123"]) {

        [self showSuccessHUD:@"登录成功"];
        [self hideHUD:1];

        UserModel *model = [[UserModel alloc] init];
        model.icon = @"http://img.qqzhi.com/uploads/2019-04-03/213319521.jpg";
        model.nickname = @"前海吴彦祖";
        [UserInfo saveUserModel:model];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.complete();
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
    } else {
        [self showErrorHUD:@"账号或密码错误"];
        [self hideHUD:1];
    }

//    [self startQQLogin:^{
//        [self.navigationController dismissViewControllerAnimated:true completion:nil];
//    }];
//
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            [self showTextHUD:@"登录失败" delay:1.5f];
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            [self getQQLoginRequest:resp];
//        }
//    }];
}
// 更多登录方式
- (IBAction)moreBtnClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"注册", @"手机登录", nil];
    [sheet showInView:self.view];
    [[sheet rac_buttonClickedSignal] subscribeNext:^(NSNumber *number) {
        NSInteger index = [number integerValue];
        // 注册
        if (index == 0) {
            RE1Controller *vc = [[RE1Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 手机登录
        else if (index == 1) {
            PhoneController *vc = [[PhoneController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}


@end
