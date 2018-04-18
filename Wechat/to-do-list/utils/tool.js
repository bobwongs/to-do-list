
const sum = function (...values) {
  let sum = 0
  for (let v of values) {
    sum += v
  }
  return sum
}

module.exports = {
  sum
}