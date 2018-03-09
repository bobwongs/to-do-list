// pages/index/detail/detail.js
Page({
  /** 页面的初始数据 */
  data: {
    item: {},
    titleValue: '',
    contentValue: '',
    timeValue: ''
  },

  /** 生命周期函数--监听页面加载 */
  onLoad: function (options) {
    // console.log(options.item)
    var itemJSONString = options.itemJSONString
    if (itemJSONString === null || itemJSONString === undefined || itemJSONString ==='') return

    var item = JSON.parse(itemJSONString)
    if (item === null || item === undefined) return

    this.setData({
      item: item,
      titleValue: item.title,
      contentValue: item.content,
      timeValue: item.time
    })
  },
  
  done: function (e) {
    // if (this.data.item != {}) {
    //   wx.navigateBack()
    //   return
    // } 

    var titleValue = this.data.titleValue
    var contentValue = this.data.contentValue
    var timeValue = this.data.timeValue
    console.log('titleValue: ' + titleValue)
    console.log('contentValue: ' + contentValue)
    console.log('timeValue: ' + timeValue)

    let pages = getCurrentPages()  // 当前页
    let prevPage = pages[pages.length - 2]  // 上一页
    prevPage.insert({
      title: titleValue,
      content: contentValue,
      time: timeValue
    });

    wx.navigateBack()  // Back
  },
  bindTitleInput: function(e) {
    this.setData({
      titleValue: e.detail.value
    })
  },
  bindContentInput: function(e) {
    this.setData({
      contentValue: e.detail.value
    })
  },
  bindTimeInput: function(e) {
    this.setData({
      timeValue: e.detail.value
    })
  }
})
