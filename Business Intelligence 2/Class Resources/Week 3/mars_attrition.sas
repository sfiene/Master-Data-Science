
  /* MARS version: 8.3.2.001 */
  /* Model: MARS_1 */
  /* Grove: C:\Users\optim\AppData\Local\Temp\vopo_00471.grv */
  /* Target: ATTRITION$ */

/********
 * MARS_1
 ********/

  /* Data Dictionary, Number Of Variables = 4 */
  /*    Name = MARITALSTATUS, Type = categorical. */
  /*    Name = OVERTIME, Type = categorical. */
  /*    Name = MONTHLYINCOME, Type = continuous. */
  /*    Name = TOTALWORKINGYEARS, Type = continuous. */

 BF1 = max( 0, TOTALWORKINGYEARS - 3);
 BF2 = max( 0, 3 - TOTALWORKINGYEARS);
 BF3 = ( OVERTIME$ in ( "Yes" ) );
 BF6 = max( 0, 4194 - MONTHLYINCOME) * BF3;
 BF7 = ( MARITALSTATUS$ in ( "Single" ) ) * BF3;

 Y = 0.882522 + 0.0025319 * BF1 - 0.100679 * BF2 - 0.000174571 * BF6
              - 0.249327 * BF7;

 MODEL ATTRITION$ = BF1 BF2 BF6 BF7;
