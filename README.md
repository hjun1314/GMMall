该项目主要仿照国美商城，是本人有空时仿照别人Demo敲的，如有问题可issue我

4.9
创建项目，设置相关框架，项目通过sourcetree托管到github，完成了添加tabbar子控制器(美信，商城，美店，美眉榜，我的)，利用枚举类，字符串添加tabbar子控制器，具体做法：
创建数组字典，将所需要字符串添加到该数组字典,然后遍历该数组，设置相关信息(比如图片，title等)；
tabbar点击动画效果；
添加新特性引导页。

4.10
"我的"控制器里登录页面完成(封装思想多练习)
具体做法:控制器xib，账号密码登录xib，手机注册登陆xib三部分组成，账号密码和手机注册用scrollView相互滚动
手机注册登录验证码利用gcd创建定时器功能
个人信息暂时还没写

4.11
自定义"我的"控制器界面顶部导航栏完成
自定义"我的"控制器headView为tableView的headview完成
headview下拉图片(9张随机背景图)滚动变大(scrollViewDidScroll)，并且下拉时导航栏隐藏显示逻辑的实现

4.12
主要就是四组cell的完成，具体实现方法如下:
"我的"控制器主要是继承自UIviewcontroller，然后添加tableview，设置相关headView和代理数据源方法。
自定义4组tableViewcell，其中在第一组cell和第二组cell里面再添加collectionviewCell，并且在这两组cell里设置collectionviewCell的代理数据源方法，获取数据和collectionviewcell的高度等，接着回到主控制器即"我的"控制器里面加载第一组和第二组cell的数据(plist文件)；
第三四组cell就是普通的自定义cell
四组cell都是xib创建的(emmmmm.....)

4.16
"我的"控制器导航栏右边item点击控制器GMMySettingrVC和，实现方法：
头部自定义headview为GMMySettingrVC的headView，自定义cell，添加退出登录按钮
"我的"控制器headView头像点击跳转控制器"账号管理控制器"GMManagerVC完成，实现方法：
自定义cell，和点击导航栏右边item是同一个cell，其实两个控制器就是相差了退出登录按钮
完成点击退出按钮回到登录界面逻辑

4.17
"账号管理控制器"点击跳转至添加收货地址(GMReceivedAddressController)然后GMReceivedAddressController导航栏右边点击跳转至新增收货人地址或是编辑收货人地址控制器GMNewAddressController基本界面完成，实现方法：
自定义addressView，添加了地区的第三方ChooseLocation和点击出现的阴影背景层(要多理解)
利用FMDB写了个地址的工具类(新增地址，删除地址，更新地址，获取所有数据)，FMDB蛋疼...

5.2
处理添加地址的相关逻辑，具体实现:
枚举类判断当前是添加收货地址还是编辑收货地址(title)
导航栏右边item点击保存完成，主要利用NSuserdefault存储数组信息
底部保存按钮点击完成，保存后跳转回添加收货地址控制器，并且清空添加地址栏信息，没做相同地址的判断

5.3
完成删除地址编辑地址和默认选择按钮功能。具体逻辑看demo
