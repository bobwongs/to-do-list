//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    // array: [{
    //   title: 'first-title',
    //   content: 'one-content',
    //   time: 'time0'
    // }, {
    //     title: 'second-title',
    //     content: 'two-content',
    //     time: 'time1'
    // }, {
    //     title: 'third-title',
    //     content: 'three-content',
    //     time: 'time2'
    // }],
    array: [],
    toDoArray: [],
    searchResultArray: [],
    inputValue: ''
  },
  /** 生命周期函数--监听页面加载 */
  onLoad: function (options) {
    var that = this
    wx.getStorage({
      key: 'to-do-list',
      success: function(res) {
        if (res.data) {
          console.log('data: ' + res.data)
          that.setData({ array: res.data })
        }
      },
      fail: function (res) { 
        console.log('fail: ' + res)
      },
      complete: function (res) {
        console.log('complete')
       },
    })
  },
  search: function(e) {
    console.log('search')
    var inputValue = this.data.inputValue

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

    console.log('insert')

    var array = this.data.array
    array.push(item)
    wx.setStorage({
      key: 'to-do-list',
      data: array,
      success: function(res) { console.log('保存成功') },
      fail: function (res) {
        console.log('保存失败')
       },
      complete: function (res) { 
        console.log('保存完成')
      },
    })
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
