# vlsm_planner

## Currently basic version with only RFC1918 capability

Expected use case:

ruby vlsm_planner.rb plan 10.0.0.0/16 --sizes 500,200,200,50,20,30 --names core,eng,sales,lab,iot,exp

Output:

```
label         | subnet        | prefix        | usable_first  | usable_last   | broadcast     | capacity      | waste         |
core          | 10.0.0.0      | \23           | 10.0.0.1      | 10.0.1.254    | 10.0.1.255    | 510           | 10            |
eng           | 10.0.2.0      | \24           | 10.0.2.1      | 10.0.2.254    | 10.0.2.255    | 254           | 54            |
sales         | 10.0.3.0      | \24           | 10.0.3.1      | 10.0.3.254    | 10.0.3.255    | 254           | 54            |
lab           | 10.0.4.0      | \26           | 10.0.4.1      | 10.0.4.62     | 10.0.4.63     | 62            | 12            |
iot           | 10.0.4.64     | \27           | 10.0.4.65     | 10.0.4.94     | 10.0.4.95     | 30            | 10            |
exp           | 10.0.4.96     | \27           | 10.0.4.97     | 10.0.4.126    | 10.0.4.127    | 30            | 0             |
```
