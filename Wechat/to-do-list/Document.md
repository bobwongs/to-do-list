
待开发
  搜索结果列表（Done）

Next
  月亮小屋Demo

常用代码
  globalData

网络请求
  .then(result => {
      let responseCode = result.responseCode
      if (responseCode === 2000) {  // 错误码返回2000时，代表用户信息不全，需要跳转信息补全页
        wx.navigateTo({ url: '/pages/login/fillInfo/index?sessionToken=' + result.sessionToken })
        return
      }
      if (responseCode !== 0) {  // 其他错误
        wx.showToast({ 
          title: result.responseMsg,
          icon: 'none'
        })
        return
      }
      // 登录成功
      app.toLogined(result.token)
    })

  ({ data: { '': value } })

// 小屋小程序请求代码
  wx.showLoading()
  api.module
    .requestName({ data: { '': value } })
    .then(result => {
      wx.hideLoading()
      let responseCode = result.responseCode
      if (responseCode !== 0) {
        wx.showToast({ 
          title: result.responseMsg,
          icon: 'none'
        })
        return
      }
      // success
    })

// 小屋常记代码
getApp().globalData.openid