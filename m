Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD352ECDD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbhAGKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:31:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57434 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727716AbhAGKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:31:53 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107ATiCK007408;
        Thu, 7 Jan 2021 05:30:55 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wnkjhdte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 05:30:55 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 107AUrdH041849
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 7 Jan 2021 05:30:53 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 7 Jan 2021
 02:30:52 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 7 Jan 2021 02:30:52 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 107AUhsk013109;
        Thu, 7 Jan 2021 05:30:49 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
Date:   Thu, 7 Jan 2021 12:34:16 +0200
Message-ID: <20210107103417.16010-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107103417.16010-1-alexandru.ardelean@analog.com>
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070063
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
Also, the maximum power and current that can be represented by the driver
are scaled with the value of the sense resistor.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/hwmon/ltc2945.c | 60 ++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 41df2c8b7673..e60b15832b0e 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -70,9 +70,15 @@
 /**
  * struct ltc2945_state - driver instance specific data
  * @regmap:		regmap object to access device registers
+ * @max_power_uw:	maximum power that can be represented based on sense resistor
+ * @max_current_ma:	maximum current that can be represented based on sense resistor
+ * @r_sense_mohm:	current sense resistor value
  */
 struct ltc2945_state {
 	struct regmap		*regmap;
+	u32			max_power_uw;
+	u32			max_current_ma;
+	u32			r_sense_mohm;
 };
 
 static inline bool is_power_reg(u8 reg)
@@ -110,9 +116,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
@@ -126,6 +131,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 			/* 0.5 mV * 25 uV = 0.0125 uV resolution. */
 			val = (val * 25LL) >> 1;
 		}
+		val /= st->r_sense_mohm;
 		break;
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
@@ -149,13 +155,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
 		val *= 25;
+		val /= st->r_sense_mohm;
 		break;
 	default:
 		return -EINVAL;
@@ -163,7 +167,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	return val;
 }
 
-static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
+static unsigned long ltc2945_val_clamp(struct ltc2945_state *st, u8 reg,
+				       unsigned long val)
 {
 	switch (reg) {
 	case LTC2945_POWER_H:
@@ -171,8 +176,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
 	case LTC2945_MIN_POWER_H:
 	case LTC2945_MAX_POWER_THRES_H:
 	case LTC2945_MIN_POWER_THRES_H:
-		/* No sense in clamping now, LTC2945_POWER_FULL_SCALE_UW is larger than UINT32_MAX */
-		return val;
+		return clamp_val(val, 0, st->max_power_uw);
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
 	case LTC2945_MIN_VIN_H:
@@ -190,7 +194,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
 	case LTC2945_MIN_SENSE_H:
 	case LTC2945_MAX_SENSE_THRES_H:
 	case LTC2945_MIN_SENSE_THRES_H:
-		return clamp_val(val, 0, LTC2945_SENSE_FULL_SCALE_MA);
+		return clamp_val(val, 0, st->max_current_ma);
 	default:
 		/*
 		 * This is unlikely to happen, and if it does, it should
@@ -215,9 +219,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
@@ -236,6 +239,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			 */
 			val = DIV_ROUND_CLOSEST(val, 25) * 2;
 		}
+		val *= st->r_sense_mohm;
 		break;
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
@@ -259,12 +263,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
+		val *= st->r_sense_mohm;
 		val = DIV_ROUND_CLOSEST(val, 25);
 		break;
 	default:
@@ -303,7 +305,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	val = ltc2945_val_clamp(reg, val);
+	val = ltc2945_val_clamp(st, reg, val);
 
 	/* convert to register value, then clamp and write result */
 	regval = ltc2945_val_to_reg(dev, reg, val);
@@ -512,6 +514,7 @@ static int ltc2945_probe(struct i2c_client *client)
 	struct ltc2945_state *st;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
+	u64 val64;
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -523,7 +526,22 @@ static int ltc2945_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				     &st->r_sense_mohm))
+		st->r_sense_mohm = 1000;
+
+	if (st->r_sense_mohm < 1000) {
+		dev_err(dev, "Value too small for sense resistor, minimum 1000\n");
+		return -EINVAL;
+	}
+	st->r_sense_mohm /= 1000;
+
 	st->regmap = regmap;
+	val64 = LTC2945_POWER_FULL_SCALE_UW / st->r_sense_mohm;
+	/* clamp power to ULONG_MAX, since we represent it on 32 bits */
+	st->max_power_uw = clamp_val(val64, 0, ULONG_MAX);
+
+	st->max_current_ma = LTC2945_SENSE_FULL_SCALE_MA / st->r_sense_mohm;
 
 	/* Clear faults */
 	regmap_write(regmap, LTC2945_FAULT, 0x00);
-- 
2.17.1

