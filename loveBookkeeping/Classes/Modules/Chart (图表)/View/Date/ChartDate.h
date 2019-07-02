/**
 * 图表
 * @author 郑业强 2018-12-17 创建文件
 */


#import "BaseView.h"
#import "XMYChartSubModel.h"
#import "BKModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - typedef
typedef void (^ChartDateComplete)(XMYChartSubModel *model);


#pragma mark - 声明
@interface ChartDate : BaseView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger segmentIndex;
@property (nonatomic, assign) NSInteger navigationIndex;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *selectIndexs;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<XMYChartSubModel *> *> *sModels;

@property (nonatomic, strong) BKModel *minModel;
@property (nonatomic, strong) BKModel *maxModel;
@property (nonatomic, strong) XMYChartSubModel *selectModel;

@property (nonatomic, copy  ) ChartDateComplete complete;

@end

NS_ASSUME_NONNULL_END
