import React, { Component } from 'react'
import './App.css'
import { BrowserRouter, Route, Link, Switch } from 'react-router-dom'

import ToDoList from './modules/to-do-list/ToDoList'
import ToDoItem from './modules/to-do-item/ToDoItem'
import About from './modules/about/About'

class App extends Component {
  render() {    
    return (
      <div>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={ToDoList} />
            {/* <Route exact path="/" component={ToDoItem} /> */}
            <Route path='/to-do-item' component={ToDoItem} />
            <Route path='/about' component={About} />
          </Switch>
        </BrowserRouter>
      </div>
    )
  }
}

export default App;
