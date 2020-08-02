package com.example.mongodbapp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MongodbappApplication /* implements CommandLineRunner */ {
	/*
	 * @Autowired private CustomerRepository customerRepository;
	 * 
	 */
	public static void main(String[] args) {
		SpringApplication.run(MongodbappApplication.class, args);
	}


	/*
	 * @Override public void run(String... args) throws Exception { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 */

	/*
	 * @Override public void run(String... args) throws Exception { Customer c1 =
	 * new Customer("1", "Kindson", "Munoye"); Customer c2 = new Customer("2",
	 * "Saffron", "Lawrence"); Customer c3 = new Customer("3", "Liudmyla",
	 * "Nargona"); Customer c4 = new Customer("4", "Oleander", "Yubas");
	 * 
	 * customerRepository.save(c1); customerRepository.save(c2);
	 * customerRepository.save(c3); customerRepository.save(c4);
	 * 
	 * System.out.println("************************");
	 * 
	 * List<Customer> customers = customerRepository.findAll();
	 * 
	 * for(Customer c : customers) { System.out.println(c.toString()); } }
	 */

}
