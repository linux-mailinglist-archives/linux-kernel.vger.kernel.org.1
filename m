Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDA2AECB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgKKJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:08:52 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14368 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgKKJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:08:29 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB95FuE017182;
        Wed, 11 Nov 2020 04:08:12 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npaavs8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:08:12 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AB98Avl059536
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Nov 2020 04:08:11 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Nov 2020 01:08:09 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Nov 2020 01:08:09 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AB981gH023509;
        Wed, 11 Nov 2020 04:08:07 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/4] hwmon: (ltc2945): add support for sense resistor
Date:   Wed, 11 Nov 2020 11:12:58 +0200
Message-ID: <20201111091259.46773-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111091259.46773-1-alexandru.ardelean@analog.com>
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sense resistor is a parameter of the board. It should be configured in
the driver via a device-tree / ACPI property, so that the proper current
measurements can be done in the driver.

It shouldn't be necessary that userspace need to know about the value of
the resistor. It makes things a bit harder to make the application code
portable from one board to another.

This change implements support for the sense resistor to be configured from
DT/ACPI and used in current calculations.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/hwmon/ltc2945.c | 53 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 6d4569a25471..909dd92a7a20 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -61,9 +61,11 @@
 /**
  * struct ltc2945_state - driver instance specific data
  * @regmap		regmap object to access device registers
+ * @r_sense_uohm	current sense resistor value
  */
 struct ltc2945_state {
 	struct regmap		*regmap;
+	u32			r_sense_uohm;
 };
 
 static inline bool is_power_reg(u8 reg)
@@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MAX_POWER_THRES_H:
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
-		 * Convert to uW by assuming current is measured with
-		 * an 1mOhm sense resistor, similar to current
-		 * measurements.
+		 * Convert to uW by and scale it with the configured
+		 * sense resistor, similar to current measurements.
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power.
 		 */
@@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 			return ret;
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
-			val *= 625LL;
+			val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
 		} else {
 			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
-			val = (val * 25LL) >> 1;
+			val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	case LTC2945_MAX_SENSE_THRES_H:
 	case LTC2945_MIN_SENSE_THRES_H:
 		/*
-		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
+		 * 25 uV resolution. Convert to current and scale it
+		 * with the value of the sense resistor.
 		 */
-		val *= 25;
+		val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
 		break;
 	default:
 		return -EINVAL;
@@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_POWER_THRES_H:
 	case LTC2945_MIN_POWER_THRES_H:
 		/*
-		 * Convert to register value by assuming current is measured
-		 * with an 1mOhm sense resistor, similar to current
-		 * measurements.
+		 * Convert to register value, scale it with the configured sense
+		 * resistor value, similar to current measurements.
 		 * Control register bit 0 selects if voltage at SENSE+/VDD
 		 * or voltage at ADIN is used to measure power, which in turn
 		 * determines register calculations.
@@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			return ret;
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
-			val = DIV_ROUND_CLOSEST_ULL(val, 625);
+			val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);
 		} else {
-			/*
-			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
-			 * Divide first to avoid overflow;
-			 * accept loss of accuracy.
-			 */
-			val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
+			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
+			val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_SENSE_THRES_H:
 	case LTC2945_MIN_SENSE_THRES_H:
 		/*
-		 * 25 uV resolution. Convert to current as measured with
-		 * an 1 mOhm sense resistor, in mA. If a different sense
-		 * resistor is installed, calculate the actual current by
-		 * dividing the reported current by the sense resistor value
-		 * in mOhm.
+		 * 25 uV resolution. Convert to current and scale it
+		 * with the value of the sense resistor, in mA.
 		 */
-		val = DIV_ROUND_CLOSEST_ULL(val, 25);
+		val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
 		break;
 	default:
 		return -EINVAL;
@@ -475,6 +465,15 @@ static int ltc2945_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				     &st->r_sense_uohm))
+		st->r_sense_uohm = 1000;
+
+	if (st->r_sense_uohm == 0) {
+		dev_err(dev, "Zero value provided for sense resistor in DT");
+		return -EINVAL;
+	}
+
 	st->regmap = regmap;
 
 	/* Clear faults */
-- 
2.17.1

