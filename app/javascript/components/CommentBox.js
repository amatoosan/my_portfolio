import React from "react"
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"

class CommentBox extends React.Component {

  constructor (props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      data: []
    };
  }

  componentDidMount() {
    fetch(this.props.url)
    .then(res => res.json())
    .then(
      (result) => {
        this.setState({
          isLoaded: true,
          data: result.data
        });
      },
      (error) => {
        this.setState({
          isLoaded: true,
          error
        });
      }
    )
  }

  render () {
    const { error, isLoaded } = this.state;
    if (error) {
      return <div>Error</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
    return (
      <React.Fragment>
        <h1>Comments</h1>
        <br></br>
        <CommentList data={ this.state.data } />
        <br></br>
        <CommentForm />
      </React.Fragment>
    );
    }
  }
}

{/*子Componentの定義*/}
class CommentList extends React.Component {
  render() {
    const commentNodes = this.props.data.map((comment,i) => {
      return(
        <div key={i}>
          <h2>{comment.author}</h2>
          <p>{comment.text}</p>
        </div>
      );
    });
    return (
      <div>
        {commentNodes}
      </div>
    );
  }
}


function CommentForm() {
  return (
    <p>Hello, world! I am a CommentForm.</p>
  );
}

{/*
class Comment extends React.Component {
  render() {
    return (
      <div className="comment">
        <h2 className="commentAuthor">
          {this.props.author}
        </h2>
        {this.props.children}
      </div>
    );
  }
}

CommentBox.propTypes = {
  data: PropTypes.string
};
*/}

export default CommentBox
