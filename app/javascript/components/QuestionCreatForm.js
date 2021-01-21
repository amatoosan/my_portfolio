import React from 'react'
import axios from 'axios'
class QuestionCreatForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      content: '',
      picture: ''
    };
    this.handleInputValue = this.handleInputValue.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleInputValue = (event) => {
    this.setState({
      [event.target.title]: event.target.value,
      [event.target.content]: event.target.value
    });
  }

  handleSubmit = (event) => {
    //post処理
    axios.post("http://localhost:3000/signup",
      {
        question: {
          title: this.state.title,
          content: this.state.content,
          picture: this.state.picture
        }
      },
      { withCredentials: true }
    )
    .then(response => {
      if (response.data.status === 'created') {
        console.log("registration res", response)
      }
    })
    .catch(error => {
      console.log("registration error", error)
    })
    /*alert('A name was submitted: ' + this.state.name);*/
    console.log(
      'タイトルは『' + this.state.title + "』です\n",
      '内容は『' + this.state.content + "』です\n"
    );
    event.preventDefault()
  }

  handleChangeFile(event) {
    const createObjectURL = (window.URL || window.webkitURL).createObjectURL || window.createObjectURL;
    // ①イベントからfileの配列を受け取る
    const files = event.target.files;
    // ②createObjectURLで、files[0]を読み込む
    const image_url = createObjectURL(files[0]);
    // ③setStateする！
    this.setState({picture: image_url});
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        {/*
        複数の入力を扱う場合は「name=""」を書く。
        そうすることで、1つのhandleInputValueイベントで複数のstateの値を更新できる。
        */}
        <label>
          タイトル
          <input type="text" name="title" value={this.state.title} onChange={this.handleInputValue} />
        </label>
        <label>
          問題
          <input type="text" name="content" value={this.state.content} onChange={this.handleInputValue} />
        </label>
        <label>
          画像
          <input type="file" onChange={(event) => {this.handleChangeFile(event)}} />
          <img src={this.state.picture} />
        </label>
        <input type="submit" value="投稿する！" />
      </form>
    );
  }
}

export default QuestionCreatForm;
