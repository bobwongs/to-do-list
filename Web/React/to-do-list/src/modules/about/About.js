import React, { Component } from 'react'

class About extends Component {
  constructor(props) {
    super(props)
    this.myName = props.myName
    this.myJob = props.location.myJob
    
    console.log('props: \n' + JSON.stringify(props))
  }
  
  render() {
    let html = (
        <div>
            About:
            MyName: {this.myName}
            MyJob: {this.myJob}
        </div>
    )
    return html
  }
}

export default About