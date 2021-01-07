Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4482ECDDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbhAGKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:31:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52108 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbhAGKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:31:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107AUhLq013617;
        Thu, 7 Jan 2021 05:30:52 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wsv6gwm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 05:30:51 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 107AUouP023977
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 7 Jan 2021 05:30:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 7 Jan 2021
 05:30:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 7 Jan 2021 05:30:49 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 107AUhsj013109;
        Thu, 7 Jan 2021 05:30:47 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 2/4] hwmon: (ltc2945): clamp values before converting
Date:   Thu, 7 Jan 2021 12:34:15 +0200
Message-ID: <20210107103417.16010-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210107103417.16010-1-alexandru.ardelean@analog.com>
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_05:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can compute the full-scale values for power, voltages and current, and
apply them before conversion.

This way we sanitize the input from userspace a bit.
We can't however clamp the value for power, since that is represented in
micro-Watts. The full-scale power that can be represented is around 10480
Watts, which in micro-Watts ends up being around 10 billion micro-Watts.

Current and voltage is represented in millis, so these can be clamped.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/hwmon/ltc2945.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 42a59170da78..41df2c8b7673 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -58,6 +58,15 @@
 #define CONTROL_MULT_SELECT	(1 << 0)
 #define CONTROL_TEST_MODE	(1 << 4)
 
+/* Full scale ranges (page 4 of the datasheet) */
+
+#define LTC2945_VIN_FULL_SCALE_MV	102375
+#define LTC2945_ADIN_FULL_SCALE_MV	2048
+
+/* Power and current computed assuming a 1mOhm sense resistor */
+#define LTC2945_POWER_FULL_SCALE_UW	10485759375ULL
+#define LTC2945_SENSE_FULL_SCALE_MA	102375
+
 /**
  * struct ltc2945_state - driver instance specific data
  * @regmap:		regmap object to access device registers
@@ -154,6 +163,43 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 	return val;
 }
 
+static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
+{
+	switch (reg) {
+	case LTC2945_POWER_H:
+	case LTC2945_MAX_POWER_H:
+	case LTC2945_MIN_POWER_H:
+	case LTC2945_MAX_POWER_THRES_H:
+	case LTC2945_MIN_POWER_THRES_H:
+		/* No sense in clamping now, LTC2945_POWER_FULL_SCALE_UW is larger than UINT32_MAX */
+		return val;
+	case LTC2945_VIN_H:
+	case LTC2945_MAX_VIN_H:
+	case LTC2945_MIN_VIN_H:
+	case LTC2945_MAX_VIN_THRES_H:
+	case LTC2945_MIN_VIN_THRES_H:
+		return clamp_val(val, 0, LTC2945_VIN_FULL_SCALE_MV);
+	case LTC2945_ADIN_H:
+	case LTC2945_MAX_ADIN_H:
+	case LTC2945_MIN_ADIN_THRES_H:
+	case LTC2945_MAX_ADIN_THRES_H:
+	case LTC2945_MIN_ADIN_H:
+		return clamp_val(val, 0, LTC2945_ADIN_FULL_SCALE_MV);
+	case LTC2945_SENSE_H:
+	case LTC2945_MAX_SENSE_H:
+	case LTC2945_MIN_SENSE_H:
+	case LTC2945_MAX_SENSE_THRES_H:
+	case LTC2945_MIN_SENSE_THRES_H:
+		return clamp_val(val, 0, LTC2945_SENSE_FULL_SCALE_MA);
+	default:
+		/*
+		 * This is unlikely to happen, and if it does, it should
+		 * error out on the next call, we can't return negative here
+		 */
+		return 0;
+	}
+}
+
 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			      unsigned long val)
 {
@@ -257,6 +303,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	val = ltc2945_val_clamp(reg, val);
+
 	/* convert to register value, then clamp and write result */
 	regval = ltc2945_val_to_reg(dev, reg, val);
 	if (is_power_reg(reg)) {
-- 
2.17.1

