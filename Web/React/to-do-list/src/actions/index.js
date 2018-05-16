export const TodoActionType = {
    UPDATE_LIST: 'UPDATE_LIST',
    ADD: 'ADD',
    EDIT: 'EDIT',
    DELETE: 'DELETE'
}

const updateList = (list) => ({
    type: TodoActionType.UPDATE_LIST,
    list
})

const addTodo = (title) => ({
    type: TodoActionType.ADD,
    title
})

const editTodo = (id, title, completed) => ({
    type: TodoActionType.EDIT,
    id,
    title,
    completed
})

const deleteTodo = (id) => ({
    type: TodoActionType.DELETE,
    id,
})

export const TodoActions = {
    updateList,
    addTodo,
    editTodo,
    deleteTodo
}