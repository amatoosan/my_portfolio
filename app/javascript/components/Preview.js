import React from 'react';
import DefaultPicture from '../../assets/images/images.png';

const createObjectURL = (window.URL || window.webkitURL).createObjectURL || window.createObjectURL;

class Preview extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      //default_image: '../assets/images/images.png'
      picture: '',
    };
  }

  handleChangeFile(event) {
    // ①イベントからfileの配列を受け取る
    const files = event.target.files;
    // ②createObjectURLで、files[0]を読み込む
    const image_url = createObjectURL(files[0]);
    // ③setStateする！
    this.setState({picture: image_url});
  }


  render(){
    let preview;

    if (this.state.picture === '') {
    preview = (
      <div>
        <input type="file" ref="file" onChange={(event) => {this.handleChangeFile(event)}} />
        <img src={DefaultPicture} />
      </div>
    );
    } else {
    preview = (
      <div>
        <input type="file" ref="file" onChange={(event) => {this.handleChangeFile(event)}} />
        <img src={this.state.picture} />
      </div>
    );
    }


    return(
      <div>
        {preview}
      </div>
    );
  }
}
export default Preview;