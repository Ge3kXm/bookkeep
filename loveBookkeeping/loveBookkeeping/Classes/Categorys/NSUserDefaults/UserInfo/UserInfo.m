/**
 * 用户信息
 * @author 郑业强 2018-11-20
 */

#import "UserInfo.h"

#define USerDefault [NSUserDefaults standardUserDefaults]

@implementation UserInfo


// 是否登录
+ (BOOL)isLogin {
    // 有缓存
//    if ([[PINCacheManager sharedManager] containsObjectForKey:kUser]) {
    if ([USerDefault objectForKey:kUser]) {
        return YES;
    }
    return NO;
}


// 保存个人信息
+ (void)saveUserInfo:(NSDictionary *)param {
    [NSUserDefaults setObject:param forKey:kUser];
}
// 保存个人信息
+ (void)saveUserModel:(UserModel *)model {
    NSDictionary *param = [model mj_keyValues];
    [USerDefault setObject:param forKey:kUser];
    [USerDefault synchronize];
}
// 读取个人信息
+ (UserModel *)loadUserInfo {
    NSDictionary *param = (NSDictionary *)[USerDefault objectForKey:kUser];
    UserModel *model = [UserModel mj_objectWithKeyValues:param];
    return model;
}


// 清除登录信息
+ (void)clearUserInfo {
//    NSUserDefaults *sharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.book.widget"];
//    [sharedData removeObjectForKey:kUser];
    [USerDefault removeObjectForKey:kUser];
    [USerDefault synchronize];

//    [[PINCacheManager sharedManager] removeObjectForKey:kUser];
}



@end
