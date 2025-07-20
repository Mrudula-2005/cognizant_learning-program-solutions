package com.cognizant.loan.controller;

import com.cognizant.loan.model.Loan;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/loans")
public class LoanController {

    @GetMapping("/{id}")
    public Loan getLoanDetails(@PathVariable String id) {
        // In a real app, you'd look this up from a database
        return new Loan(id, "home-loan", 23000.0);
    }
}
