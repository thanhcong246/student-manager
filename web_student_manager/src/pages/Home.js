import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link, useLocation } from 'react-router-dom';

export default function Home() {
    const [students, setStudents] = useState([]);
    const location = useLocation();

    useEffect(() => {
        if (location.state && location.state.searchResult) {
            setStudents(location.state.searchResult);
        } else {
            loadStudent();
        }
    }, [location]);

    const loadStudent = async () => {
        const result = await axios.get("http://127.0.0.1:9090/students");
        setStudents(result.data);
    }

    const deleteStudent = async (studentId) => {
        await axios.delete(`http://127.0.0.1:9090/removeStudent/${studentId}`);
        loadStudent();
    }

    return (
        <div className="container">
            <table className="table table-bordered mt-5">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Email</th>
                        <th scope="col">Age</th>
                        <th scope="col">Sex</th>
                        <th scope="col">Address</th>
                        <th scope="col">Functions</th>
                    </tr>
                </thead>
                <tbody>
                    {students.map((student, index) => (
                        <tr key={index}>
                            <th scope="row">{index + 1}</th>
                            <td>{student.name}</td>
                            <td>{student.phone}</td>
                            <td>{student.email}</td>
                            <td>{student.age}</td>
                            <td>{student.sex}</td>
                            <td>{student.address}</td>
                            <td>
                                <Link className='btn btn-primary' to={`/ViewStudent/${student.id}`}>
                                    View
                                </Link>
                                <Link className='btn btn-warning mx-2' to={`/EditStudent/${student.id}`}>
                                    Edit
                                </Link>
                                <button className='btn btn-danger' onClick={() => deleteStudent(student.id)}>
                                    Delete
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    )
}
