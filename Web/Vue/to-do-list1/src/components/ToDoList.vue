<template>
  <div class="container">
    <div class="header">To Do List</div>
    <div class="middle">
      <input class="input-search" placeholder="To Add Title" v-model="toAddTitle" v-on:keyup.enter="add" />
      <router-link to="/to-do-item">
        <button class="button-add">Add</button>
      </router-link>
    </div>
    <div class="to-do-list">
      <div class="list-item" v-for="(item, index) in items" :key="index">
        <div class="list-item-title">{{item.title}}</div>
        <div class="list-item-content">{{item.content}}</div>
        <div class="list-item-finished">{{item.finished}}</div>
      </div>
      <h1>{{testTitle}}</h1>
      <MyView :titleToChange="testTitle" v-on:tapAction="tapAction" />
    </div>
    <button class="test-button" v-on:click="test">Test</button>
  </div>
</template>

<script>
import MyView from './MyView.vue'

let initialItems = [
  {
    title: 'go home',
    content: 'as quickly as possible',
    finished: false
  },
  {
    title: 'go to work',
    content: 'to earn money',
    finished: false
  }
]
var testTitle = 1
export default {
  name: 'ToDoList',
  components: {
    MyView
  },
  data () {
    return {
      'items': initialItems,
      'toAddTitle': 'Initial To Add Title',
      testTitle
    }
  },
  methods: {
    test: function (event) {
      console.log('test')
      this.testTitle += 1
    },
    add: function (event) {
      console.log('add')
      let todo = {title: this.toAddTitle, content: 'new added', finished: false}
      this.items = [...this.items, todo]
      console.log(this.items)

      this.toAddTitle = ''
    },
    tapAction: function (event) {
      console.log('tap act')
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.container{
  background-color: white;
}

.header {
  background: #2A282E;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 64px;
  color: white;
  font-weight: bold;
}

.middle {
  padding: 0 12px 0 12px;
  height: 60px;
  background-color: rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
}

.input-search {
  flex-grow: 1;
  height: 30px;
  color: black;
  font-size: 12px;
  background: darkkhaki;
}

.button-add {
  margin-left: 12px;
  background-color: #996633;
  color: white;
  font-size: 15px;
}

.to-do-list {
  position: absolute;
  left: 0;
  right: 0;
  top: 124px;
  bottom: 0;
}

.list-item {
  margin-bottom: 12px;
  background: lightgray;
}

.test-button {
  background: #996633;
  position: fixed;
  left: 0;
  width: 100%;
  bottom: 0;
  height: 50px;
}

</style>
