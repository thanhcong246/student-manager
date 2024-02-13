import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { useParams } from 'react-router-dom'

export default function ViewStudent() {
    const [student, setStudent] = useState({
        name: "",
        phone: "",
        email: "",
        age: 0,
        sex: "",
        address: ""
    });

    const { id } = useParams();

    useEffect(() => {
        const loadStudent = async () => {
            try {
                const result = await axios.get(`http://127.0.0.1:9090/student/${id}`);
                setStudent(result.data);
            } catch (error) {
                console.error("Error loading user: ", error);
            }
        };
        loadStudent();
    }, [id]);

    return (
        <div className="container mt-5">
            <div className="card border-primary mb-3">
                <div className="card-body text-primary">
                    <h5 className="card-title">{student.name}</h5>
                    <ul className="list-group">
                        <li className="list-group-item">{student.phone}</li>
                        <li className="list-group-item">{student.email}</li>
                        <li className="list-group-item">{student.age}</li>
                        <li className="list-group-item">{student.sex}</li>
                        <li className="list-group-item">{student.address}</li>
                    </ul>
                </div>
            </div>
        </div>
    )
}
