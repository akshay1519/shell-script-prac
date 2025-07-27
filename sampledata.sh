#!/bin/bash

# Create sample data file
cat <<EOF > employees.csv
ID,Name,Department,Salary
101,John Doe,Engineering,75000
102,Jane Smith,Marketing,68000
103,Robert Johnson,Sales,72000
104,Emily Davis,Engineering,78000
105,Michael Brown,Marketing,70000
EOF

# View file
echo "Original file:"
cat employees.csv

# Filter data
echo -e "\nEngineering department:"
grep "Engineering" employees.csv

# Extract specific columns
echo -e "\nNames and salaries:"
cut -d',' -f2,4 employees.csv

# Sort by salary
echo -e "\nSorted by salary (descending):"
sort -t',' -k4 -nr employees.csv | head -n 5

# Calculate average salary
echo -e "\nAverage salary:"
awk -F',' 'NR>1 {sum+=$4; count++} END {print "Average: " sum/count}' employees.csv

# Transform data
echo -e "\nAdding bonus:"
awk -F',' 'BEGIN {OFS=","} NR==1 {print $0,"Bonus"} NR>1 {print $0,$4*0.1}' employees.csv
