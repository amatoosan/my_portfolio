import React from 'react';
import TABs from './TAB';
{/*
import './App.css';
*/}
 
function App() {
  const style = {
    width: "100%",
    margin: "0 auto",
  };
  return (
    <div className="App">
      <div style={style}>
        <TABs />
      </div>
    </div>
  );
}
 
export default App