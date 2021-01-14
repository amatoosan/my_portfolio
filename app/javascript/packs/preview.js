document.addEventListener('DOMContentLoaded', function(){
  const ImageList = document.getElementById('post-image-prev');

  document.getElementById('picture-select-btn').addEventListener('change', function(e){
		const imageHidden = document.getElementById('user-picture');
		imageHidden.style.display ="none";
		// 画像が表示されている場合のみ、すでに存在している画像を削除する
		const imageContent = document.querySelector('img');
		if (imageContent){
			imageContent.remove();
		}
		const file = e.target.files[0];
		const blob = window.URL.createObjectURL(file);
		// 画像を表示するためのdiv要素を生成
		const imageElement = document.createElement('div');
		// 表示する画像要素を生成し、画像を入れ込む
		const blobImage = document.createElement('img');
		blobImage.setAttribute('src', blob);
		// 生成したHTMLの要素をブラウザに表示させる
		imageElement.appendChild(blobImage);
		ImageList.appendChild(imageElement);
	});
});
