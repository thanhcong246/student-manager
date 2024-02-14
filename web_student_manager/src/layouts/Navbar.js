import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

export default function Navbar() {

    const [keyword, setKeyword] = useState("");
    const navigate = useNavigate();

    const handleSearch = (e) => {
        e.preventDefault();
        fetch(`http://127.0.0.1:9090/searchStudent?keyword=${keyword}`)
            .then(response => response.json())
            .then(data => {
                navigate("/", { state: { searchResult: data } });
            })
            .catch(error => {
                console.error('error', error);
            });
    };


    const handleChange = (e) => {
        setKeyword(e.target.value);
    }

    return (
        <div className="container">
            <nav className="navbar navbar-expand-lg btn btn-outline-secondary">
                <div className="container-fluid">
                    <Link className="navbar-brand btn btn-outline-primary" to="/">Student manager</Link>
                    <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>
                    <div className="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                            <li className="nav-item">
                                <Link className="nav-link btn btn-success" to="/AddStudent">Add Student</Link>
                            </li>
                        </ul>
                        <form className="d-flex" onSubmit={handleSearch}>
                            <input className="form-control me-2" type="search" placeholder="Search" aria-label="Search" value={keyword} onChange={handleChange} />
                            <button className="btn btn-info" type="submit">Search</button>
                        </form>
                    </div>
                </div>
            </nav>
        </div>
    );
}