import React, { Component } from 'react'
import { connect } from 'react-redux'

import './ToDoItem.css'
import { TodoActions } from '../../actions'

class ToDoItem extends Component {
  constructor(props) {
    super(props)
    console.log(props)
    this.state = { item: props.item }
  }

  onTitleChange = (e) => {
    let value = e.target.value
    let item = this.state.item
    item.title = value
    this.setState({item})
  }

  onCompletedChange = () => {
    let item = this.state.item
    item.completed = !item.completed
    this.setState({item})
  }

  confirm = () => {
    let item = this.state.item
    if (item.itemId !== -1) {
      this.props.editItem(item.itemId, item.title, item.completed)
    } else {
      this.props.addItem(item.title)
    }
    this.props.history.goBack()
  }

  render() {
    return (
      <div className='container'>
        <div className='header'>待办事项</div>
        <div className='main-view'>
          <div className='title'>标题</div>
          <input className='title-input' type='text' value={this.state.item ? this.state.item.title : ''} onChange={this.onTitleChange} placeholder='待办标题' />
          {/* <div className='content'>内容</div>
          <input className='content-input' type='text' value={item ? item.content : ''} onChange={this.onContentChange} placeholder='待办内容' /> */}
          <div className='completed-view'>
            是否完成<input type="checkbox" onChange={this.onCompletedChange} checked={this.state.item ? this.state.item.completed : false} />
          </div>
          <button className='confirm-button' type='button' onClick={this.confirm}>确  定</button>
        </div>
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => (
  ownProps.location.itemId === -1 ? {item: {itemId: -1}} : {item: state[ownProps.location.itemId]}
)
const mapDispatchToProps = dispatch => ({
  addItem: (title) => dispatch(TodoActions.addItem(title)),
  deleteItem: (id) => dispatch(TodoActions.deleteItem(id)),
  editItem: (id, title, completed) => dispatch(TodoActions.editItem(id, title, completed))
})
ToDoItem = connect(mapStateToProps, mapDispatchToProps)(ToDoItem)
export default ToDoItem
