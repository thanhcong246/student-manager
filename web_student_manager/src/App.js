import './App.css';
import "../node_modules/bootstrap/dist/css/bootstrap.min.css";
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './layouts/Navbar';
import Home from './pages/Home';
import ViewStudent from './student_manager/ViewStudent';
import AddStudent from './student_manager/AddStudent';
import UpdateStudent from './student_manager/UpdateStudent';

function App() {
  return (
    <div className="App">
      <Router>
        <Navbar />
        <Routes>
          <Route exact path='/' element={<Home />} />
          <Route exact path='/ViewStudent/:id' element={<ViewStudent />} />
          <Route exact path='/AddStudent' element={<AddStudent />} />
          <Route exact path='/EditStudent/:id' element={<UpdateStudent />} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
