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
    console.log('search')
  },
  reset: function(e) {
    this.setData({ inputValue: '' })
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
  },
  insert: function(item) {
    if (item === null || item === undefined || item.title === null || item.title === undefined || item.title === '') return 

    var array = this.data.array
    array.push(item)
    this.setData({ array: array, inputValue: '' })
  },
  toDetail: function(e) {
    var index = e.currentTarget.dataset.index  // 获取对应index
    var item = this.data.array[index]
    var itemJSONString = JSON.stringify(item)
    wx.navigateTo({
      url: 'detail/detail?itemJSONString=' + itemJSONString
    })
  },

  test: function(n) {
    console.log('n: ' + n)
  }
})
