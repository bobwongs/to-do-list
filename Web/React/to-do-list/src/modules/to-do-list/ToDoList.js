import React, { Component } from 'react'
// import { Link } from 'react-router-dom'
import './ToDoList.css'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'

import { TodoActions } from '../../actions'

/* 
-- v1.0.0 -- 
todo: {
  id: 0;
  title: go hiking;
  completed: false;
}

-- v1.0.1 -- 
todo: {
  id: 0;
  title: go hiking;
  content: call up Jenny;
  reminderTime: 0;
  completed: false;
}
*/

class ToDoList extends Component {
    constructor(props) {
        super(props)
        this.state = { inputedText: '', toDoList: props.list }

        // console.log('hi');
        // let str0 = 'hello'
        
        // if (str0.includes('ll')) {
        //   console.log('contain');
        // } else {
        //   console.log('not contain');
        // }
      }

      // 获取当前store的state
      static contextTypes = {
        store: PropTypes.object,
      }
      getStoreState = () => {
        let list = this.context.store.getState()
        return list
      }
    
      onInputedTextChange = (e) => {
        let value = e.target.value
        this.setState({ inputedText: value })

        if (!value.length) this.setState({toDoList: this.props.list})
      }

      addItem = () => {
        let path = {pathname: '/to-do-item', itemId: -1}
        this.props.history.push(path)
      }
    
      pressEnterKey = (e) => {
        if(e.key === 'Enter') {
          this.search()
        }
      }
    
      deleteItem = (e, index) => {
        e.stopPropagation()  // stop event bubbling
        this.props.deleteItem(index)
        this.setState({ toDoList: this.getStoreState() })
      }

      search = () => {
        let inputedText = this.state.inputedText
        if (!inputedText.length) return

        let resultList = this.props.list.filter((item) => {
          return item.title.includes(inputedText)
        })
        this.setState({toDoList: resultList})
      }
    
      testAction = () => {

      }

      clickListItem = (index) => {
        // const path = `/repos/${userName}/${repo}`
        let path = {pathname: '/to-do-item', itemId: index}
        this.props.history.push(path)
      }
    
      render() {
        let listItems = this.state.toDoList.map((item, index) => {
          let listItem = (
          <li className='to-do-item' onClick={(e) => this.clickListItem(item.id)} key={item.id}>
            <div className='item-left'>
              <div className='item-title'>{item.title} </div>
              <div className='item-content'>{item.completed ? '已完成' : '未完成'}</div>
            </div>
            <div className='item-delete' type='button' onClick={(e) => this.deleteItem(e, item.id)}>Delete</div>
          </li>
          )
          // return <Link to={{pathname: '/to-do-item', itemId: index}} key={index}>{listItem}</Link>
          return listItem
        }
      )

        return (
          <div>
            <div className='container'>
              <div className='header'>待办事项</div>
              <div className='input-view'>
                <input className='input-field' type='text' value={this.state.inputedText} onChange={this.onInputedTextChange} placeholder='Input text to search' onKeyPress={this.pressEnterKey} />
                {/* <button className='header-button' type='button' onClick={this.search}>Search</button> */}
                {/* <Link to='/to-do-item'> */}
                  <button className='header-button' type='button' onClick={this.addItem}>Add</button>
                {/* </Link> */}
                <div className='input-view-bg'></div>
              </div>
              <div className='to-do-list'>{listItems}</div>
            </div>

            {/* <Link to='/about'> */}
                {/* <button className='test-button' onClick={this.testAction}>Test</button> */}
            {/* </Link> */}

          </div>
        )
      }
}

const mapStateToProps = (state) => {
  localStorage.toDoListJSONString = JSON.stringify(state)
  return {list: state}
}
const mapDispatchToProps = dispatch => ({
  addItem: text => dispatch(TodoActions.addItem(text)),
  deleteItem: id => dispatch(TodoActions.deleteItem(id))
})

ToDoList = connect(mapStateToProps, mapDispatchToProps)(ToDoList)
export default ToDoList
