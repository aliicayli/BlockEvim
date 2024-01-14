// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/// @title Phone Number Reporting System
contract PhoneNumberReport {

    struct PhoneReport {
        int count; // number of times reported
    }

    // Mapping from phone number (as a string) to its report details.
    mapping(string => PhoneReport) private reports;

    // Event declaration for a phone number report
    event PhoneNumberReported(string phoneNumber, int count);

    /// Report a phone number.
    function reportNumber(string memory phoneNumber) public {
        // Increment the report count for the given phone number.
        reports[phoneNumber].count += 1;

        // Emit an event whenever a phone number is reported.
        emit PhoneNumberReported(phoneNumber, reports[phoneNumber].count);
    }

    /// Check how many times a phone number has been reported.
    /// Returns the number of times the phone number has been reported.
    function checkReports(string memory phoneNumber) public view returns (int) {
        return reports[phoneNumber].count;
    }
}