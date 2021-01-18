import React from 'react'
import DefaultPicture from '../../assets/images/images.png'
import axios from 'axios'
class UserCreatForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
      profile: '',
      picture: ''
    };
    this.handleInputValue = this.handleInputValue.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleInputValue = (event) => {
    this.setState({
      [event.target.name]: event.target.value,
      [event.target.email]: event.target.value,
      [event.target.password]: event.target.value,
      [event.target.password_confirmation]: event.target.value,
      [event.target.profile]: event.target.value
    });
  }

  handleSubmit = (event) => {
    //post処理
    axios.post("http://localhost:3000/signup",
      {
        user: {
          name: this.state.name,
          email: this.state.email,
          password: this.state.password,
          password_confirmation: this.state.password_confirmation,
          profile: this.state.profile,
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
      'ユーザーIDは『' + this.state.name + "』です\n",
      'メールアドレスは『' + this.state.email + "』です\n",
      'パスワードは『' + this.state.password + "』です\n",
      'パスワード確認は『' + this.state.password_confirmation + "』です\n",
      '自己紹介は『' + this.state.profile + "』です\n"
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
    let preview;
    if (this.state.picture === '') {
      preview = (
        <div>
          <img src={DefaultPicture} />
        </div>
      );
    } else {
      preview = (
        <div>
          {this.setPicture}
          <img src={this.state.picture} />
        </div>
      );
    }
    return (
      <form onSubmit={this.handleSubmit}>
        {/*
        複数の入力を扱う場合は「name=""」を書く。
        そうすることで、1つのhandleInputValueイベントで複数のstateの値を更新できる。
        */}
        <label>
          ユーザーID
          <input type="text" name="name" value={this.state.name} onChange={this.handleInputValue} />
        </label>
        <label>
          メールアドレス
          <input type="email" name="email" value={this.state.email} onChange={this.handleInputValue} />
        </label>
        <label>
          パスワード
          <input type="password" name="password" value={this.state.password} onChange={this.handleInputValue} />
        </label>
        <label>
          パスワード確認
          <input type="password" name="password_confirmation" value={this.state.password_confirmation} onChange={this.handleInputValue} />
        </label>
        <label>
          自己紹介
          <input type="text" name="profile" value={this.state.profile} onChange={this.handleInputValue} />
        </label>
        <label>
          プロフィール画像
          <input type="file" onChange={(event) => {this.handleChangeFile(event)}} />
          {preview}
        </label>
        <input type="submit" value="新規登録" />
      </form>
    );
  }
}

export default UserCreatForm;
