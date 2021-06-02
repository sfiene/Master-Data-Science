
  /* SPM version: 8.3.2.001 */
  /* Model: GPS_1 */
  /* Timestamp: 20200630071503000 */
  /* Grove: C:\Users\optim\AppData\Local\Temp\vopo_00409.grv */
  /* Target: ATTRITION$ */

score = -7.12499 + 0.769982 * (BUSINESSTRAVEL = "Non-Travel")
        - 0.825051 * (BUSINESSTRAVEL = "Travel_Frequently")
        + 0.527014 * (EDUCATIONFIELD = "Life Sciences")
        + 0.000455186 * (EDUCATIONFIELD = "Marketing")
        + 0.648636 * (EDUCATIONFIELD = "Medical")
        + 0.581664 * (EDUCATIONFIELD = "Other") + 0.308545 * (GENDER = "Female")
        + 1.27251 * (JOBROLE = "Healthcare Representative")
        - 0.0539476 * (JOBROLE = "Human Resources")
        - 0.107629 * (JOBROLE = "Laboratory Technician")
        + 1.08365 * (JOBROLE = "Manager")
        + 1.08309 * (JOBROLE = "Manufacturing Director")
        + 1.93564 * (JOBROLE = "Research Director")
        + 0.664372 * (JOBROLE = "Research Scientist")
        + 0.42807 * (JOBROLE = "Sales Executive")
        + 1.257 * (MARITALSTATUS = "Divorced")
        + 0.908254 * (MARITALSTATUS = "Married") + 1.73465 * (OVERTIME = "No")
        + 0.0447395 * AGE - 0.0348266 * DISTANCEFROMHOME + 0.369345 * ENVIRONMENTSATISFACTION
        + 0.487385 * JOBINVOLVEMENT + 0.364345 * JOBSATISFACTION - 0.132956 * NUMCOMPANIESWORKED
        + 0.19762 * RELATIONSHIPSATISFACTION + 0.142709 * TRAININGTIMESLASTYEAR
        + 0.285645 * WORKLIFEBALANCE + 0.102269 * YEARSINCURRENTROLE - 0.158552 * YEARSSINCELASTPROMOTION
        + 0.0877449 * YEARSWITHCURRMANAGER;
prob = 1.0 / (1.0 + exp(-score)); /* Response class is ATTRITION$ = "No" */

