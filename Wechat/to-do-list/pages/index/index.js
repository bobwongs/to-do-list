//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    array: [{
      message: 'foo'
    }, {
      message: 'bar'
    }]
  },
  search: function(e) {

  },
    reset: function(e) {
      
    }
  },
  reset: function(e) {

  },
  add: function(e) {
    console.log('Add item')
    wx.navigateTo({
      url: 'detail/detail',
    })
  },
})
