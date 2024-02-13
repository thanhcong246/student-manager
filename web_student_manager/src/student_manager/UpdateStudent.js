import React, { useEffect, useState, useCallback } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import axios from "axios";

export default function UpdateStudent() {
    let navigate = useNavigate();
    const { id } = useParams();

    const [student, setStudent] = useState({
        name: "",
        phone: "",
        email: "",
        age: 0,
        sex: "Male",
        address: ""
    });

    const { name, phone, email, age, sex, address } = student;

    const onInputChange = (e) => {
        setStudent({ ...student, [e.target.name]: e.target.value });
    };

    const onSexChange = (e) => {
        setStudent({ ...student, sex: e.target.value });
    };

    const loadStudent = useCallback(async () => {
        try {
            const result = await axios.get(`http://127.0.0.1:9090/student/${id}`);
            setStudent(result.data);
        } catch (error) {
            console.error("Error loading user:", error);
        }
    }, [id])

    useEffect(() => {
        loadStudent();

    }, [loadStudent])

    const onSubmit = async (e) => {
        e.preventDefault();
        await axios.put(`http://127.0.0.1:9090/updateStudent/${id}`, student);
        navigate("/");
    };

    return (
        <div className='container mt-5 textLeft'>
            <div className="card border-primary mb-3">
                <div className="card-body text-accordion">
                    <form onSubmit={onSubmit}>
                        <div className="row">
                            <div className='col-6'>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputName" className="form-label">Name</label>
                                    <input type="text" className="form-control" id="exampleInputName" name='name' value={name} onChange={onInputChange} />
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputPhone" className="form-label">Phone</label>
                                    <input type="number" className="form-control" id="exampleInputPhone" name='phone' value={phone} onChange={onInputChange} />
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputEmail1" className="form-label">Email</label>
                                    <input type="email" className="form-control" id="exampleInputEmail1" name='email' value={email} onChange={onInputChange} />
                                </div>
                            </div>
                            <div className='col-6'>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputAge" className="form-label">Age</label>
                                    <input type="number" className="form-control" id="exampleInputAge" name='age' value={age} onChange={onInputChange} />
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputAddress" className="form-label">Address</label>
                                    <input type="text" className="form-control" id="exampleInputAddress" name='address' value={address} onChange={onInputChange} />
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="exampleInputSex" className="form-label">Sex</label>
                                    <div>
                                        <div className="form-check form-check-inline">
                                            <input className="form-check-input" type="radio" name="sex" id="male" value="Male" checked={sex === "Male"} onChange={onSexChange} />
                                            <label className="form-check-label" htmlFor='male'>Male</label>
                                        </div>
                                        <div className="form-check form-check-inline">
                                            <input className="form-check-input" type="radio" name="sex" id="female" value="Female" checked={sex === "Female"} onChange={onSexChange} />
                                            <label className="form-check-label" htmlFor='female'>Female</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" className="btn btn-success">Submit</button>
                        <Link className="btn btn-danger mx-2" to={"/"}>Cancel</Link>
                    </form>
                </div>
            </div>
        </div>
    )
}
