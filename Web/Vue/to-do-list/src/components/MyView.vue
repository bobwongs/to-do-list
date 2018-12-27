<template>
  <div>
    MyView
    <div>{{titleToChange}}</div>
    <button v-on:click="$emit('tapAction')">Invoke Parent Method</button>

    <div class="list">
      <div></div>
      <img class="icon" src="">
      <div class="count">X100</div>
    </div>

    <div class="myclass0">
      <div class="mysubclass0">1</div>
      <div class="mysubclass1">2</div>
      <div class="mysubclass2">3</div>
    </div>

    <MyComp0 />

    <div>Animation Testing0</div>

    <div class="div0">内容</div>

    <div class="my-div1">
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
      <div class="div1-0"><div class="div1-0-0">1</div>
      </div>
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
      <div class="div1-0">
        <div class="div1-0-0">1</div>
      </div>
    </div>

    <div class="div2"></div>
  </div>
</template>

<script>
import MyComp0 from './MyComponent0'

export default {
  name: 'MyView',
  components: {
    MyComp0
  },
  props: {
    titleToChange: {
      type: String,
      default: 'title to change'
    }
  },
  data () {
    return {}
  },
  methods: {
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.list {
  background: rgba(205, 176, 164, 0.845);
}

.myclass0 {
  display: flex;
  background: lightgray;
}

.mysubclass0 {
  order: -2;
}

.mysubclass1 {
  order: 1;
}

.mysubclass2 {
  order: -1;
}

.div0 {
  background: orange;
  width: 100px;
  height: 100px;
  border: 10px solid purple;
  margin-left: 30px;
  margin-right: 30px;
  box-sizing: border-box;
  /* box-sizing: content-box; */
}

.my-div1 {
  display: flex;
  height: 100px;
  align-items: center;
  /* width: 500px; */
  overflow-x: scroll;
  background: orange;
  padding-left: 20px;
}

.div1-0 {
  
  height: 80px;
  background: lightgray;
  /* margin-left: 20px; */
  margin-right: 20px;
}

.div1-0-0 {
  background: purple;
  width: 400px;
}

.div2 {
  width: 100px;
  height: 100px;
  background: darkcyan;
}
</style>
