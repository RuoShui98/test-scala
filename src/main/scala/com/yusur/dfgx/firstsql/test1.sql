-- 最终版本
SELECT C.PROV_ID,
       C.AREA_ID,
       C.AREA_ID_CBSS,
       C.CITY_ID,
       C.CITY_ID_CBSS,
       C.SERVICE_TYPE,
       A.USER_ID_B USER_ID,
       A.USER_ID_A COMP_ID,
       C.DEVICE_NUMBER,
       1 MAIN_DEVICE_NUMBER,
       A.RELATION_TYPE COMP_TYPE,
       A.START_DATE,
       A.END_DATE,
--        CASE
--            WHEN A.RELATION_TYPE IN ('81', '82', '83') AND A.IS_VALID = '1' AND
--                 COALESCE(E.IS_VALID, '0') = '1' THEN
--                '1'
--            WHEN A.RELATION_TYPE NOT IN ('81', '82', '83') AND
--                 A.IS_VALID = '1' THEN
--                '1'
--            ELSE
--                '0'
--            END IF_USER_VALID,
--        CASE
--            WHEN A.RELATION_TYPE IN ('81', '82', '83') AND A.IS_VALID = '1' AND
--                 COALESCE(E.IS_VALID, '0') = '1' THEN
--                '1'
--            WHEN A.RELATION_TYPE NOT IN ('81', '82', '83') AND
--                 A.IS_VALID = '1' THEN
--                '1'
--            ELSE
--                '0'
--            END IF_COMP_VALID,
       C.INNET_DATE,
       1 ACCEPT_CHANNEL_COMP,
       1 ACCEPT_MAN_COMP,
       1 ACCEPT_CHANNEL_USER,
       1 ACCEPT_MAN_USER,
       C.IS_STAT,
       C.IS_INNET,
       C.IS_THIS_DEV,
       1 NEW_FLAG_COMP,
       1 NEW_FLAG_USER,
       1 ACCEPT_DATE_COMP,
       1 ACCEPT_DATE_USER,
       C.CHANNEL_ID,
       1,
       1
FROM (SELECT T.USER_ID_A,
             T.SERIAL_NUMBER_A,
             T.USER_ID_B,
             T.SERIAL_NUMBER_B,
             T.RELATION_TYPE_CBSS,
             T.START_DATE,
             T.END_DATE,
             T.ITEM_ID,
             T.IS_VALID,
             T.RELATION_TYPE
      FROM (SELECT T.USER_ID_A,
                   T.SERIAL_NUMBER_A,
                   T.USER_ID_B,
                   T.SERIAL_NUMBER_B,
                   T.RELATION_TYPE_CBSS,
                   T.START_DATE,
                   T.END_DATE,
                   T.ITEM_ID,
                   T.IS_VALID,
                   T.RELATION_TYPE,
                   ROW_NUMBER() OVER(PARTITION BY T.USER_ID_B, T.RELATION_TYPE_T1 ORDER BY T.IS_VALID DESC, T.START_DATE DESC, T.END_DATE DESC, T.RELATION_TYPE, T.USER_ID_A) RN
            FROM (SELECT T1.USER_ID_A,
                         T1.SERIAL_NUMBER_A,
                         T1.USER_ID_B,
                         T1.SERIAL_NUMBER_B,
                         T1.RELATION_TYPE RELATION_TYPE_CBSS,
                         T1.START_DATE,
                         T1.END_DATE,
                         T1.ITEM_ID,
                         T1.IS_VALID,
                         T2.RELATION_TYPE,
--                          CASE
--                              WHEN T2.RELATION_TYPE IN ('81', '82', '83') THEN
--                                  '999'
--                              ELSE
--                                  T2.RELATION_TYPE
--                              END
                         1 RELATION_TYPE_T1
                  FROM (SELECT T.USER_ID_A,
                               T.SERIAL_NUMBER_A,
                               T.USER_ID_B,
                               T.SERIAL_NUMBER_B,
                               T.RELATION_TYPE,
                               T.START_DATE,
                               T.END_DATE,
                               T.ITEM_ID,
--                                CASE
--                                    WHEN SUBSTR(START_DATE, 1, 8) <=
--                                         1 AND
--                                         SUBSTR(END_DATE, 1, 8) >=
--                                         1 THEN
--                                        '1'
--                                    ELSE
--                                        '0'
--                                    END IS_VALID
                               1 IS_VALID
                        FROM (SELECT USER_ID_A,
                                     SERIAL_NUMBER_A,
                                     USER_ID_B,
                                     SERIAL_NUMBER_B,
                                     RELATION_TYPE,
                                     ROLE_CODE_A,
                                     ROLE_CODE_B,
                                     ORDERNO,
                                     SHORT_CODE,
                                     START_DATE,
                                     END_DATE,
                                     ITEM_ID,
                                     RELATION_ATTR,
                                     RELATION_TYPE_ZB,
                                     PRODUCT_ID,
                                     PRODUCT_CLASS,
                                     PRIMARY_EPARCHY_CODE,
                                     PRIMARY_PROVINCE_CODE,
                                     MEM_EPARCHY_CODE,
                                     MEM_PROVINCE_CODE
                              FROM DWD_PRD_CB_RELATION_UU_RT            -- 第一张表
                              WHERE ACCT_DATE = 1
                                 OR BATCH_ID = 1
                              UNION ALL
                              SELECT USER_ID_A,
                                     SERIAL_NUMBER_A,
                                     USER_ID_B,
                                     SERIAL_NUMBER_B,
                                     RELATION_TYPE,
                                     ROLE_CODE_A,
                                     ROLE_CODE_B,
                                     ORDERNO,
                                     SHORT_CODE,
                                     START_DATE,
                                     END_DATE,
                                     ITEM_ID,
                                     RELATION_ATTR,
                                     RELATION_TYPE_ZB,
                                     PRODUCT_ID,
                                     PRODUCT_CLASS,
                                     PRIMARY_EPARCHY_CODE,
                                     PRIMARY_PROVINCE_CODE,
                                     MEM_EPARCHY_CODE,
                                     MEM_PROVINCE_CODE
                              FROM DWD_D_PRD_CB_RELATION_UU_LX        -- 第二张表
                              WHERE MONTH_ID = 1
                                AND DAY_ID = 1) T) T1
                           JOIN DWA_MAP_CBSS_RELATION_TYPE T2                    -- 2.1张表
                                ON T1.RELATION_TYPE = T2.RELATION_TYPE_CBSS) T) T
      WHERE RN = 1) A
         JOIN (SELECT *
               FROM (SELECT T.*,
                            ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY NVL(IS_STAT,'0') DESC) RN
                     FROM (SELECT T.USER_ID,
                                  T.PROV_ID,
                                  T.DEVICE_NUMBER,
                                  T.SERVICE_TYPE,
                                  T.IS_STAT,
                                  T.IS_INNET,
                                  T.INNET_DATE,
                                  1 IS_THIS_DEV,
                                  T.AREA_ID,
                                  1 AREA_ID_CBSS,
                                  1 CITY_ID,
                                  1 CITY_ID_CBSS,
                                  T.CHANNEL_TYPE CHANNEL_ID
                           FROM DWA_V_RT_CUS_CB_USER_INFO T                -- 第4张表
                           WHERE ACCT_DATE = 1
                              OR (ACCT_DATE = 1 AND BATCH_ID = 1)
                           UNION ALL
                           SELECT T.USER_ID,
                                  T.PROV_ID,
                                  T.DEVICE_NUMBER,
                                  T.SERVICE_TYPE,
                                  T.IS_STAT,
                                  T.IS_INNET,
                                  T.INNET_DATE,
                                  T.IS_THIS_DEV,
                                  T.AREA_ID,
                                  T.AREA_ID_CBSS,
                                  T.CITY_ID,
                                  T.CITY_ID_CBSS,
                                  T.CHANNEL_ID
                           FROM DWA_V_D_CUS_CB_USER_INFO_LX T            -- 第5张表
                           WHERE MONTH_ID =
                                 1
                             AND DAY_ID =
                                 1) T)
               WHERE RN = 1) C
              ON A.USER_ID_B = C.USER_ID
         LEFT JOIN (SELECT MAX(IS_VALID) IS_VALID, USER_ID
                    FROM (SELECT USER_ID,
--                                  CASE
--                                      WHEN T.START_DATE <= 1 AND
--                                           T.END_DATE >= 1 THEN
--                                          1
--                                      ELSE
--                                          0
--                                      END IS_VALID
                                 1 IS_VALID
                          FROM DWD_D_PRD_CB_USER_PRODUCT_LX T        -- 第6张表
                          WHERE PRODUCT_MODE IN (1)
                            AND MONTH_ID = 1
                            AND DAY_ID = 1
                            AND BRAND_ID_CBSS IN (1, 1)
                          UNION ALL
                          SELECT USER_ID,
--                                  CASE
--                                      WHEN REPLACE(START_DATE, 1) <=
--                                           1 AND
--                                           REPLACE(END_DATE, 1) >=
--                                           1 THEN
--                                          1
--                                      ELSE
--                                          0
--                                      END IS_VALID
                                 1 IS_VALID
                          FROM TF_F_USER_PRODUCT                    -- 第7张表
                          WHERE (ACCT_DATE =
                                 1 OR
                                 (ACCT_DATE = 1 AND HOUR_ID <= 1))
                            AND BRAND_CODE IN (1, 1)
                          UNION ALL
                          SELECT USER_ID,
--                                  CASE
--                                      WHEN REPLACE(START_DATE, 1) <=
--                                           1 AND
--                                           REPLACE(END_DATE, 1) >=
--                                           1 THEN
--                                          1
--                                      ELSE
--                                          0
--                                      END IS_VALID
                                 1 IS_VALID
                          FROM TF_F_USER_PRODUCT_IU_NEW            -- 第8张表
                          WHERE (ACCT_DATE =
                                 1 OR
                                 (ACCT_DATE = 1 AND HOUR_ID = 1))
                            AND BRAND_CODE IN (1, 1)) T
                    GROUP BY USER_ID) E
                   ON A.USER_ID_A = E.USER_ID