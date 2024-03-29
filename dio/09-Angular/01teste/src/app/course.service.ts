import { Injectable } from "@angular/core";
import { Course } from "./course";



@Injectable({
    providedIn: 'root'
})
export class CourseService{
    getCourses(): Course[]{
        return [
            {id: 1, name: 'course1'},
            {id: 2, name: 'course2'},
            {id: 3, name: 'course3'},
            {id: 4, name: 'course4'}
        ];
    }
}