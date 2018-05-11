import React, { Component } from 'react'
import './ToDoItem.css'

class ToDoItem extends Component {
  constructor(props) {
    super(props)

    let item = props.location.item
    this.state = {'item': item ? item : {} }
  }

  onTitleChange = (e) => {
    let value = e.target.value
    let item = this.state.item
    item.title = value
    this.setState({ 'item': item })
  }

  onContentChange = (e) => {
    let value = e.target.value
    let item = this.state.item
    item.content = value
    this.setState({ 'item': item })
  }

  confirm = () => {
    let item = this.state.item
    console.log('item: ' + item.title + '  ' + item.content)
    this.props.history.goBack();
  }

  render() {
    let item = this.state.item
    return (
      <div className='container'>
        <div className='header'>待办事项</div>
        <div className='main-view'>
          <div className='title'>标题</div>
          <input className='title-input' type='text' value={item ? item.title : ''} onChange={this.onTitleChange} placeholder='待办标题' />
          <div className='content'>内容</div>
          <input className='content-input' type='text' value={item ? item.content : ''} onChange={this.onContentChange} placeholder='待办内容' />
          <button className='confirm-button' type='button' onClick={this.confirm}>确  定</button>
        </div>
      </div>
    )
  }
}

export default ToDoItem