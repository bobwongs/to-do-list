import { TodoActionType } from '../actions'

const INITIAL_LIST = localStorage.toDoListJSONString ? JSON.parse(localStorage.toDoListJSONString) : []

const todos = (state = INITIAL_LIST, action) => {
    switch (action.type) {
        case TodoActionType.ADD:
            return [...state, {id: state.length, title: action.title, completed: false}]
        case TodoActionType.EDIT:
            return state.map((todo => {
                if (todo.id === action.id) {
                    return {...todo, title: action.title, completed: action.completed}
                }
                return todo
            }))
        case TodoActionType.DELETE:
            return state.slice(0, state.length - 1)
            return state.filter((item) => (item.id !== action.id))
        default: return state;
    }
}

export default todos