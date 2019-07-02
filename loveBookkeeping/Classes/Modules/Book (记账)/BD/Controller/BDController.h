/**
 * 记账详情页
 * @author 郑业强 2019-01-05 创建
 */

#import "XMBaseViewController.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typedef
typedef void (^BDComplete)(void);


#pragma mark - 声明
@interface BDController : XMBaseViewController

@property (nonatomic, strong) BKModel *model;
@property (nonatomic, copy  ) BDComplete complete;

@end

NS_ASSUME_NONNULL_END
