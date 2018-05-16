export const TodoActionType = {
    ADD: 'ADD',
    EDIT: 'EDIT',
    DELETE: 'DELETE'
}

const addItem = (title) => ({
    type: TodoActionType.ADD,
    title
})

const editItem = (id, title, completed) => ({
    type: TodoActionType.EDIT,
    id,
    title,
    completed
})

const deleteItem = (id) => ({
    type: TodoActionType.DELETE,
    id,
})

export const TodoActions = {
    addItem,
    editItem,
    deleteItem
}