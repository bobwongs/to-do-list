import React, { Component } from 'react'
import './App.css'
import { BrowserRouter, Route, Switch } from 'react-router-dom'
import { createStore } from 'redux'
import { Provider } from 'react-redux'

import ToDoList from './modules/to-do-list/ToDoList'
import ToDoItem from './modules/to-do-item/ToDoItem'
import About from './modules/about/About'

import todos from './reducers/todos'

const store = createStore(todos)

class App extends Component {
  render() {
    return (
      <div>
        <Provider store={store}>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={ToDoList} />
            <Route path='/to-do-item' component={ToDoItem} />
            <Route path='/about' component={About} />
          </Switch>
        </BrowserRouter>
        </Provider>
      </div>
    )
  }
}

export default App;
