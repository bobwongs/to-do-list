export const TodoActionType = {
    ADD: 'ADD',
    EDIT: 'EDIT',
    DELETE: 'DELETE'
}

export const addTodo = (title) => ({
    type: TodoActionType.ADD,
    title
})

export const editTodo = (id, title, completed) => ({
    type: TodoActionType.EDIT,
    id,
    title,
    completed
})

export const deleteTodo = (id) => ({
    type: TodoActionType.DELETE,
    id,
})