import Vue from 'vue'
import Router from 'vue-router'
import ToDoList from '@/components/ToDoList'
import ToDoItem from '@/components/ToDoItem'
import MyView from '@/components/MyView'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'ToDoList',
      component: ToDoList
    },
    {
      path: '/to-do-item',
      name: 'ToDoItem',
      component: ToDoItem
    },
    {
      path: '/my-view',
      name: 'MyView',
      component: MyView
    }
  ]
})
