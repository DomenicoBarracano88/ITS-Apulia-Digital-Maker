package com.example.demo;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class EmployeeDAO {

	@Autowired
	private EmployeeRepository employeeRepository;

	// Method to return the list
	public List<Employee> getAllEmployees() {
		return employeeRepository.findAll();
	}

	// Method to add an employee to the employees list
	public void addEmployee(Employee employee) {
		employeeRepository.save(employee);

	}

	// Method to get employee i
	public Optional <Employee> getEmployee(int id) {
		return employeeRepository.findById(id);
	}

	// Method to remove employee
	public void delEmployee(int id) {
		employeeRepository.deleteById(id);
	}

}
