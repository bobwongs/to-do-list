//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    array: [{
      title: 'first-title',
      content: 'one-content',
      time: 'time0'
    }, {
        title: 'second-title',
        content: 'two-content',
        time: 'time1'
    }, {
        title: 'third-title',
        content: 'three-content',
        time: 'time2'
    }],
    inputValue: ''
  },
  search: function(e) {

  },
  reset: function(e) {
    var inputValue = this.data.inputValue
    if (inputValue === null || inputValue === undefined || inputValue === '') return

    var array = this.data.array
    array.push({msg: inputValue})
    this.setData({array: array, inputValue: ''})
  },
  add: function(e) {
    console.log('Add item')
    wx.navigateTo({
      url: 'detail/detail',
    })
  },
  bindSearchInput: function(e) {
    this.setData({
      inputValue: e.detail.value
    })
  }
})
