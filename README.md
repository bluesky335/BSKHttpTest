![httptest](AppIcon128x128.png)

# HttpTest  1.0

一个测试接口数据的小工具，将接口返回的json高亮显示，方便开发人员查看数据。

你可以在 [GitHub]()  clone 之后自己编译，也可以到这里（[HttpTest.liuwanlin.tk](http://httptest.liuwanlin.tk)）下载编译好的版本。



> 
>
> **编译环境**：Xcode 8.1
>
> **引用**：AFNetWorking
>
>  



## 使用注意事项

- 在进行网络请求时，会自动将主机地址和接口地址进行拼接，你可以将URL分开写，也可以写在一个输入框中。之所以拆开是为了看起来更有条理，因为接口有很多，主机地址基本不会变。

- 填写参数时请务必按照如下格式填写：

  > example=12
  >
  > key=theKey
  >
  > age=18

  一行只写一个参数，参数名和参数值之间用英文等号链接，请避免一行中出现多个等号


   

  ​



## Json 语法高亮

- 方便的填写网络请求参数，不在需要麻烦的链接符&和?
- Json语法高亮，数据更清晰
- 支持post和get
- 支持保存接口和返回的数据
- 双击列表项即可打开之前保存的数据

![json语法高亮](app1.jpg)



## Force Touch 预览链接

- 超链接高亮显示
- 单击超链接即可跳转
- 重按触控板使用Force Touch 预览超链接

![Force Touch](app2.jpg)