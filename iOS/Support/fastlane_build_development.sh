# 蓝月亮iOS组打包脚本
# 打测试包

# 技术设计
#   Shell全流程
#   fastlane中的Ruby
#   ssh做传输

# 工具
#   包管理：cocoapods
#   自动构建和部署工具：fastlane

# 流程
#   Shell命令输入
#   读取输入参数，参数设计：接口环境、签名类型
#       接口环境 -env|--environment 0/1，直接用文件覆写，0：正式；1：测试
#       签名类型 -sign development/ad-hoc/app-store/enterprise
#   备份旧包+清理
#   修改接口环境，默认为0
#   CocoaPods依赖构建
#   打包
#   * 签名，根据输入类型，默认为development，指定统一的授权文件所在目录，从中检索
#   * 更名（取*.ipa的文件名存在变量中 -> 重命名）
#   传输

# 问题解决
#   fastlane：
#       获取项目名、App名，版本号、时间
#       git修改数设为build号
#       获取build号
#   脚本修改：签名证书（用fastlane gym/appstore/enterprise做区分）
#
#   fastlane配置脱离项目，全项目共用同一份构建配置；解决方案，私有仓库放一套打包文件，供所有项目使用；
#   签名类型：app-store, ad-hoc, package, enterprise, development, developer-id

# 初始配置
build_dir="./build"
package_format='.ipa'
backup_dir=${build_dir}/Backup

# 获取参数
script_directory_path=$(dirname $0)

# 获取传入参数
environment=0
sign=development

echo "env: $environment"
echo "sign: $sign"

# 移动原来的.ipa文件到备份文件夹build/Backup/
if [ ! -d $backup_dir ];then
mkdir $backup_dir;
else echo ${backup_dir}"：备份文件夹已经存在";
fi
mv ${build_dir}/*.* $backup_dir

# ------------ 修改接口环境 -----------
environment_config_file_path=`find . | grep BMNetworkingConfiguration`
environment_source_file="BMNetworkingConfiguration_TEST.h"
if [ $environment == 0 ]
then
    environment_source_file="BMNetworkingConfiguration.h"
fi
cp $script_directory_path/$environment_source_file $environment_config_file_path
# ------------ 修改接口环境 -----------

# CocoaPods依赖构建
pod install

# 构建，根据自定义命令做脚本构建，在Fastfile中自定义actions，bm_为前缀
# fastlane bm_$sign
fastlane gym

# 重命名和移动文件
cd $build_dir  # 切换“build/”目录

# 查找.ipa文件，获取文件名
# 重命名文件
# 示例命名：月亮小屋_20170914_170649_开发环境_内部测试_4.0.0(436).ipa
# 待解决：获得环境、签名类型、版本号、build号
ipa_file_full_name=`ls | grep $package_format`  # 获取.ipa文件的全名
ipa_origin_name=${ipa_file_full_name%${package_format}*}  # 获取.ipa文件名

time=$(date "+%Y%m%d_%H%M%S")
ipa_name=${ipa_origin_name}_${time}
mv ${ipa_origin_name}.ipa ${ipa_name}.ipa
mv ${ipa_origin_name}.app.dSYM.zip ${ipa_name}.app.dSYM.zip

cd ..  # 切换回项目根目录