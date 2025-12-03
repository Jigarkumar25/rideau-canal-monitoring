WITH AGGREGATED AS
(
    SELECT
        location,
        System.Timestamp AS windowEnd,
        AVG(iceThicknessCm) AS avgIceThickness,
        MIN(iceThicknessCm) AS minIceThickness,
        MAX(iceThicknessCm) AS maxIceThickness,
        AVG(surfaceTempC) AS avgSurfaceTemp,
        MIN(surfaceTempC) AS minSurfaceTemp,
        MAX(surfaceTempC) AS maxSurfaceTemp,
        MAX(snowAccumulationCm) AS maxSnowAccumulation,
        AVG(externalTempC) AS avgExternalTemp,
        COUNT(*) AS readingCount
    FROM sensorinput
    TIMESTAMP BY eventTime
    GROUP BY
        location,
        TumblingWindow(minute, 5)
),
SAFETY AS
(
    SELECT
        location,
        windowEnd,
        avgIceThickness,
        minIceThickness,
        maxIceThickness,
        avgSurfaceTemp,
        minSurfaceTemp,
        maxSurfaceTemp,
        maxSnowAccumulation,
        avgExternalTemp,
        readingCount,

        -- REQUIRED FOR COSMOS
        CONCAT(
            CAST(location AS NVARCHAR(MAX)),
            '-',
            CAST(DATEDIFF(second, '1970-01-01', windowEnd) AS NVARCHAR(MAX))
        ) AS id,

        CASE
            WHEN avgIceThickness >= 30 AND avgSurfaceTemp <= -2 THEN 'Safe'
            WHEN avgIceThickness >= 25 AND avgSurfaceTemp <= 0 THEN 'Caution'
            ELSE 'Unsafe'
        END AS safetyStatus

    FROM AGGREGATED
)

SELECT * INTO cosmosoutput FROM SAFETY;
SELECT * INTO bloboutput   FROM SAFETY;
