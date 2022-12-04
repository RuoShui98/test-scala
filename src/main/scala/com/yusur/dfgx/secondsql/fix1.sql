----2
-- INSERT INTO DWA.DWA_V_RT_CUS_CB_OM_DATUM PARTITION ON
--   (ACCT_DATE = '"$v_date"', BATCH_ID = '"$v_batch"')
SELECT A.PROV_ID,
       A.AREA_ID,
       A.COMP_ID,
       A.USER_ID,
       A.SERVICE_TYPE,
       B.BIND_TYPE,
       A.COMP_TYPE,
       A.IF_USER_VALID ,
       A.IF_COMP_VALID ,
       ROW_NUMBER() OVER(PARTITION BY A.USER_ID ORDER BY A.IF_COMP_VALID DESC, A.IF_USER_VALID DESC
--        ,CASE
--            WHEN B.BIND_TYPE = '1' THEN
--             'a'
--            WHEN B.BIND_TYPE = '2' THEN
--             'c'
--            WHEN B.BIND_TYPE = '3' THEN
--             'b'
--            WHEN B.BIND_TYPE = '4' THEN
--             'd'
--            WHEN B.BIND_TYPE = '99' THEN
--             'f'
--            ELSE
--             '999'
--          END
         ) RN,
    1,
       1
FROM (SELECT *
      FROM MID_V_CUS_CB_OM_DATUM_RT T           -- first table
      WHERE ACCT_DATE = 1
        AND BATCH_ID = 1) A
         LEFT JOIN (SELECT T.COMP_ID,
                           T.COMP_TYPE,
--                            CASE
--                                WHEN MB_USER >= 1 AND DS_USER >= 1 THEN
--                                    '1'
--                                WHEN MB_USER >= 1 AND FX_USER >= 1 THEN
--                                    '2'
--                                WHEN MB_USER >= 2 THEN
--                                    '3'
--                                WHEN FX_USER + DS_USER >= 2 THEN
--                                    '4'
--                                ELSE
--                                    '99'
--                                END
                           1    BIND_TYPE
                    FROM (SELECT T.COMP_ID,
                                 T.COMP_TYPE,
                                 COUNT(T.USER_ID
--                                      DISTINCT CASE
--                                                     WHEN T.SERVICE_TYPE IN
--                                                          ('40AAAAAA', '50AAAAAA') THEN --20191201 新增5G业务类型 ZHENGYI
--                                                         T.USER_ID
--                                                     ELSE
--                                                         NULL
--                                      END
                                     ) MB_USER,
                                 COUNT(DISTINCT  T.SERVICE_TYPE
--                                      CASE
--                                                     WHEN T.SERVICE_TYPE LIKE '04%' AND
--                                                          T.SERVICE_TYPE NOT IN
--                                                          ('0402AAAA',
--                                                           '040201AA',
--                                                           '040202AA',
--                                                           '040203AA',
--                                                           '0404AAAA',
--                                                           '040401AA',
--                                                           '040402AA',
--                                                           '040499AA',
--                                                           '0405AAAA',
--                                                           '0499AAAA') THEN
--                                                         T.USER_ID
--                                                     ELSE
--                                                         NULL
--                                      END
                                     ) DS_USER,
                                 COUNT(DISTINCT T.USER_ID
--                                      CASE
--                                                     WHEN T.SERVICE_TYPE LIKE '01%' AND
--                                                          T.SERVICE_TYPE NOT IN ('0105AAAA') THEN
--                                                         T.USER_ID
--                                                     ELSE
--                                                         NULL
--                                      END
                                     ) FX_USER
                          FROM MID_V_CUS_CB_OM_DATUM_RT T           -- second table
                          WHERE ACCT_DATE = 1
                            AND BATCH_ID = 1
                            AND T.END_DATE >= 1
                            AND IS_INNET = 1
                          GROUP BY T.COMP_ID, T.COMP_TYPE) T) B
                   ON A.COMP_ID = B.COMP_ID
                       AND A.COMP_TYPE = B.COMP_TYPE;