import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import ToDoItem from './modules/ToDoItem'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom'

class App extends Component {
  constructor() {
    super()
    let toDoList = localStorage.toDoList
    this.state = { list: toDoList ? JSON.parse(toDoList) : [], inputedText: '' }
  }

  onInputedTextChange = (e) => {
    let value = e.target.value
    this.setState({ inputedText: value })
  }

  addItem = () => {
    let inputedText = this.state.inputedText
    if (!inputedText.length) return

    let list = this.state.list, newItem = {title: inputedText, content: (new Date().toLocaleString()) }
    list.push(newItem)
    this.setState({ 'list': list, inputedText: '' })

    this.saveList(list)
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

  testAction = () => {
    console.log('test');
  }

  render() {
    let listItems = this.state.list.map((item, index) => {
      let listItem = (
      <li className='to-do-item'>
        <div className='item-left'>
          <div className='item-title'>{item.title} </div>
          <div className='item-content'>{item.content}</div>
        </div>
        <div className='item-delete' type='button' onClick={(e) => this.deleteItem(index)}>Delete</div>
      </li>
      )
      return listItem
    }  
  )

    return (
      <div>
        <Router>
          <Switch>
            <Route path='/to-do-item' component={ToDoItem}></Route>
            <div className='container'>
              <div className='header'>待办事项</div>
              <div className='input-view'>
                <input className='input-field' type='text' value={this.state.inputedText} onChange={this.onInputedTextChange} placeholder='Input to do item here' onKeyPress={this.pressEnterKey} />
                <button className='add-button' type='button' onClick={this.addItem}>Add</button>
                <div className='input-view-bg'></div>
              </div>
              <div className='to-do-list'>{listItems}</div>
              {/* <button className='test-button' onClick={this.testAction}>Test</button> */}
              <Link to='/to-do-item'>
                <button className='test-button'>Test</button>
              </Link>
            </div>
          </Switch>
        </Router>
      </div>
    )
  }
}

export default App;
