import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();

// ReactDOM.render((
//         <Router>
//         <div>
//             <ul>
//                 <li><Link to='/to-do-item'>First</Link></li>
//                 <li>Second</li>
//             </ul>
//             {/* <Route path="/" component={App}/> */}
//             <Route path="/to-do-item" component={ToDoItem}/>
//             </div>
//         </Router>
// ), document.getElementById('root'))
// registerServiceWorker();