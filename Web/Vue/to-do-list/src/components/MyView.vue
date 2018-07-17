<template>
  <div>
    MyView
    <div>{{titleToChange}}</div>
    <button v-on:click="$emit('tapAction')">Invoke Parent Method</button>
  </div>
</template>

<script>
export default {
  name: 'MyView',
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

</style>
