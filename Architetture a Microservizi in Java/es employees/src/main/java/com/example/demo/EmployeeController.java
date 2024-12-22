package com.example.demo;

import java.net.URI;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequestMapping(path = "/employees")
public class EmployeeController {

	@Autowired
	private EmployeeDAO employeeDao;

	// Implementing a GET method to get the list of all the employees
	@GetMapping
	public List<Employee> getAllEmployees(){
		return employeeDao.getAllEmployees();
	}

	@GetMapping("/{id}")
	public ResponseEntity<Employee> getEmployee(@PathVariable Integer id){
		Optional<Employee> employee = employeeDao.getEmployee(id);
		return employee.map(ResponseEntity::ok)
				.orElseGet(() -> ResponseEntity.notFound().build());
	}
	
	
	@DeleteMapping("/{id}")
	public void deleteEmployee(@PathVariable int id) {
		employeeDao.delEmployee(id);
	}
	
	@PostMapping
	public void addEmployee(@RequestBody Employee employee) {
		employeeDao.addEmployee(employee);
	}
}
