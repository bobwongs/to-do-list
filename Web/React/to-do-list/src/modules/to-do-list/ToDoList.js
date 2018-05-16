import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import './ToDoList.css'
import { connect } from 'react-redux'

import { TodoActions } from '../../actions'

/* 
todo: {
  id: 0;
  title: go hiking;
  completed: false;
}

-- next:
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
        let toDoList = localStorage.toDoList
        props.updateList(toDoList && toDoList.length ? toDoList : [])
        this.state = { inputedText: '' }
      }
    
      onInputedTextChange = (e) => {
        let value = e.target.value
        this.setState({ inputedText: value })
      }
    
      addItem = () => {
        let inputedText = this.state.inputedText
        if (!inputedText.length) return
    
        // let list = this.props.list
        // let newItem = {title: inputedText, content: (new Date().toLocaleString()) }
        // list.push(newItem)

        this.props.addTodo(inputedText)
        this.setState({ inputedText: '' })
    
        let newList = this.props.list
        console.log('newList: ' + newList);
        
        // this.saveList(this.props.list)
      }
    
      pressEnterKey = (e) => {
        if(e.key == 'Enter') {
          this.addItem()
        }
      }
    
      deleteItem = (index) => {
        let list = this.state.list
        list.splice(index, 1)
        this.setState({ 'list': list })
    
        this.saveList(list)
      }
    
      saveList = (list) => {
        localStorage.toDoList = JSON.stringify(list)
      }

      search = () => {

      }
    
      testAction = () => {

      }
    
      render() {
        let listItems = this.props.list.map((item, index) => {
          let listItem = (
          <li className='to-do-item'>
            <div className='item-left'>
              <div className='item-title'>{item.title} </div>
              <div className='item-content'>{item.completed}</div>
            </div>
            <div className='item-delete' type='button' onClick={(e) => this.deleteItem(index)}>Delete</div>
          </li>
          )
          return <Link to={{pathname: '/to-do-item', 'item': item}}>{listItem}</Link>
        } 
      )

        return (
          <div>
            <div className='container'>
              <div className='header'>待办事项</div>
              <div className='input-view'>
                <input className='input-field' type='text' value={this.state.inputedText} onChange={this.onInputedTextChange} placeholder='Input text to search' onKeyPress={this.pressEnterKey} />
                <button className='header-button' type='button' onClick={this.search}>Search</button>
                {/* <Link to='/to-do-item'> */}
                  <button className='header-button' type='button' onClick={this.addItem}>Add</button>
                {/* </Link> */}
                <div className='input-view-bg'></div>
              </div>
              <div className='to-do-list'>{listItems}</div>
            </div>

            {/* <Link to='/about'> */}
                <button className='test-button' onClick={this.testAction}>Test</button>
            {/* </Link> */}

          </div>
        )
      }
}

const mapStateToProps = (state) => ({list: state})
const mapDispatchToProps = dispatch => ({
  updateList: list => dispatch(TodoActions.updateList(list)),
  addTodo: text => dispatch(TodoActions.addTodo(text))
})

ToDoList = connect(mapStateToProps, mapDispatchToProps)(ToDoList)
export default ToDoList
