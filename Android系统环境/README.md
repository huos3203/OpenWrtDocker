#  
init是Android中linux的第一个用户级进程，主要是解析init.rc脚本。
init.rc脚本包括了文件系统初始化、装载的许多过程。init.rc的工作主要是：
1）设置一些环境变量
2）创建system、sdcard、data、cache等目录（见案例1）
3）把一些文件系统mount到一些目录去，如，`mount tmpfs tmpfs /sqlite_stmt_journals`
4）设置一些文件的用户群组、权限
5）设置一些线程参数
6）设置TCP缓存大小
init脚本的关键字(如`mkdir`，`chmod`，`service`等等)可以参考init进程的**system/core/init/keyword.h**文件。
 我们可以通过修改init.rc脚本来修改启动过程。但是，一般情况下，我们不直接修改init.rc，而是在文件init.%PRODUCT%.rc(如init.qcom.rc)文件中添加或修改我们需要的额外的初始化配置。因为init.c中的main函数在解析完init.rc以后会继续解析init.%PRODUCT%.rc文件。要特别强调的是，init.rc文件和init.%PRODUCT%.rc文件都是用Android Init Language语言来编写的。
      
[](https://blog.csdn.net/zhangchiytu/article/details/7389057)
