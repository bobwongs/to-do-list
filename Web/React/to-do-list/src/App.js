import React, { Component } from 'react'
import './App.css'
import { BrowserRouter, Route, Link, Switch } from 'react-router-dom'
import { createStore } from 'redux'
import { Provider } from 'react-redux'

import ToDoList from './modules/to-do-list/ToDoList'
import ToDoItem from './modules/to-do-item/ToDoItem'
import About from './modules/about/About'

import todos from './reducers/todos'

const myStore = createStore(todos)

class App extends Component {
  render() {    
    return (
      // <div>
        <BrowserRouter>
          <Switch>
            <Provider store={myStore}>
              <Route exact path="/" component={ToDoList} />
              {/* <Route exact path="/" component={ToDoItem} /> */}
              <Route path='/to-do-item' component={ToDoItem} />
              <Route path='/about' component={About} />
            </Provider>
          </Switch>
        </BrowserRouter>
      // </div>
    )
  }
}

export default App;
